Date: Wed, 25 Apr 2018 10:56:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] gnss: add GNSS receiver subsystem
Message-ID: <20180425085649.GB13295@kroah.com>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424163458.11947-2-johan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 06:34:52PM +0200, Johan Hovold wrote:
> +#define GNSS_MINORS	16

Why only 16?  Just have to start somewhere?

> +static DEFINE_IDA(gnss_minors);
> +static dev_t gnss_first;
> +
> +/* FIFO size must be a power of two */
> +#define GNSS_READ_FIFO_SIZE	4096
> +#define GNSS_WRITE_BUF_SIZE	1024
> +
> +#define to_gnss_device(d) container_of((d), struct gnss_device, dev)
> +
> +static int gnss_open(struct inode *inode, struct file *file)
> +{
> +	struct gnss_device *gdev;
> +	int ret = 0;
> +
> +	gdev = container_of(inode->i_cdev, struct gnss_device, cdev);
> +
> +	get_device(&gdev->dev);
> +
> +	nonseekable_open(inode, file);
> +	file->private_data = gdev;
> +
> +	down_write(&gdev->rwsem);

Just curious, why a rwsem?  They can be slower than a normal semaphore,
is this really a contentious lock?

> +	if (gdev->disconnected) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	if (gdev->count++ == 0) {
> +		ret = gdev->ops->open(gdev);
> +		if (ret)
> +			gdev->count--;

Why do we care about the opens here?  Do you only want the "child
driver" to have open called once, like a tty driver?  Does it matter?

Again, just curious.


> +	}
> +unlock:
> +	up_write(&gdev->rwsem);
> +
> +	if (ret)
> +		goto err_put_device;
> +
> +	return 0;
> +
> +err_put_device:
> +	put_device(&gdev->dev);
> +
> +	return ret;

Those last 9 lines can be rewritten as just:

	if (!ret)
		put_device(&gdev->dev);

	return ret;

> +}
> +
> +static int gnss_release(struct inode *inode, struct file *file)
> +{
> +	struct gnss_device *gdev = file->private_data;
> +
> +	down_write(&gdev->rwsem);
> +	if (gdev->disconnected)
> +		goto unlock;
> +
> +	if (--gdev->count == 0) {
> +		gdev->ops->close(gdev);
> +		kfifo_reset(&gdev->read_fifo);
> +	}
> +unlock:
> +	up_write(&gdev->rwsem);
> +
> +	put_device(&gdev->dev);
> +
> +	return 0;
> +}
> +
> +static ssize_t gnss_read(struct file *file, char __user *buf,
> +		size_t count, loff_t *pos)
> +{
> +	struct gnss_device *gdev = file->private_data;
> +	unsigned int copied;
> +	int ret;
> +
> +	mutex_lock(&gdev->read_mutex);
> +	while (kfifo_is_empty(&gdev->read_fifo)) {
> +		mutex_unlock(&gdev->read_mutex);
> +
> +		if (gdev->disconnected)
> +			return 0;
> +
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret = wait_event_interruptible(gdev->read_queue,
> +				gdev->disconnected ||
> +				!kfifo_is_empty(&gdev->read_fifo));
> +		if (ret)
> +			return -ERESTARTSYS;
> +
> +		mutex_lock(&gdev->read_mutex);
> +	}
> +
> +	ret = kfifo_to_user(&gdev->read_fifo, buf, count, &copied);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = copied;
> +
> +	dev_dbg(&gdev->dev, "%s - count = %zu\n", __func__, copied);
> +
> +out_unlock:
> +	mutex_unlock(&gdev->read_mutex);
> +
> +	return ret;
> +}
> +
> +static ssize_t gnss_write(struct file *file, const char __user *buf,
> +		size_t count, loff_t *pos)
> +{
> +	struct gnss_device *gdev = file->private_data;
> +	size_t written = 0;
> +	int ret;
> +
> +	dev_dbg(&gdev->dev, "%s - count = %zu\n", __func__, count);

Nit, some of these initial dev_dbg() calls might be able to be removed,
as ftrace should handle the tracing code now, right?

> +
> +	if (gdev->disconnected) {
> +		dev_dbg(&gdev->dev, "%s - disconnected\n", __func__);
> +		return -EIO;
> +	}
> +
> +	if (!count)
> +		return 0;
> +
> +	if (!gdev->ops->write_raw)
> +		return -EIO;
> +
> +	/* Ignoring O_NONBLOCK, write_raw() is synchronous. */
> +
> +	ret = mutex_lock_interruptible(&gdev->write_mutex);
> +	if (ret)
> +		return -ERESTARTSYS;
> +
> +	for (;;) {
> +		size_t n = count - written;
> +
> +		if (n > GNSS_WRITE_BUF_SIZE)
> +			n = GNSS_WRITE_BUF_SIZE;
> +
> +		if (copy_from_user(gdev->write_buf, buf, n)) {
> +			ret = -EFAULT;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Assumes write_raw can always accept GNSS_WRITE_BUF_SIZE
> +		 * bytes.
> +		 *
> +		 * FIXME: revisit
> +		 */
> +		down_read(&gdev->rwsem);
> +		if (!gdev->disconnected)
> +			ret = gdev->ops->write_raw(gdev, gdev->write_buf, n);
> +		else
> +			ret = -EIO;
> +		up_read(&gdev->rwsem);
> +
> +		if (ret < 0)
> +			break;
> +
> +		written += ret;
> +		buf += ret;
> +
> +		if (written == count)
> +			break;
> +	}
> +
> +	if (written)
> +		ret = written;
> +out_unlock:
> +	mutex_unlock(&gdev->write_mutex);
> +
> +	return ret;
> +}
> +
> +static __poll_t gnss_poll(struct file *file, poll_table *wait)
> +{
> +	struct gnss_device *gdev = file->private_data;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &gdev->read_queue, wait);
> +
> +	if (!kfifo_is_empty(&gdev->read_fifo))
> +		mask |= EPOLLIN | EPOLLRDNORM;
> +	if (gdev->disconnected)
> +		mask |= EPOLLHUP;
> +
> +	dev_dbg(&gdev->dev, "%s - mask = 0x%04x\n", __func__, mask);
> +
> +	return mask;
> +}
> +
> +static const struct file_operations gnss_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= gnss_open,
> +	.release	= gnss_release,
> +	.read		= gnss_read,
> +	.write		= gnss_write,
> +	.poll		= gnss_poll,
> +	.llseek		= no_llseek,
> +};
> +
> +static struct class *gnss_class;
> +
> +static void gnss_device_release(struct device *dev)
> +{
> +	struct gnss_device *gdev = to_gnss_device(dev);
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	kfree(gdev->write_buf);
> +	kfifo_free(&gdev->read_fifo);
> +	ida_simple_remove(&gnss_minors, gdev->id);
> +	kfree(gdev);
> +}
> +
> +struct gnss_device *gnss_allocate_device(struct device *parent)
> +{
> +	struct gnss_device *gdev;
> +	struct device *dev;
> +	int id;
> +	int ret;
> +
> +	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
> +	if (!gdev)
> +		return NULL;
> +
> +	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
> +	if (id < 0) {
> +		kfree(gdev);
> +		return ERR_PTR(id);
> +	}
> +
> +	gdev->id = id;
> +
> +	dev = &gdev->dev;
> +	device_initialize(dev);
> +	dev->devt = gnss_first + id;
> +	dev->class = gnss_class;
> +	dev->parent = parent;
> +	dev->release = gnss_device_release;
> +	dev_set_drvdata(dev, gdev);
> +	dev_set_name(dev, "gnss%d", id);
> +
> +	init_rwsem(&gdev->rwsem);
> +	mutex_init(&gdev->read_mutex);
> +	mutex_init(&gdev->write_mutex);
> +	init_waitqueue_head(&gdev->read_queue);
> +
> +	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
> +	if (ret)
> +		goto err_put_device;
> +
> +	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);
> +	if (!gdev->write_buf)
> +		goto err_put_device;
> +
> +	cdev_init(&gdev->cdev, &gnss_fops);
> +	gdev->cdev.owner = THIS_MODULE;

This protects this module from being unloaded, but how do you pass on
the module reference counts to the "child" gnss driver?  Am I just
missing that logic here somewhere?

Anyway, minor things, this looks really clean, nice job.

greg k-h
