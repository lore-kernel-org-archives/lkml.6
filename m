Return-Path: <hamishm@alliedtelesis.co.nz>
X-Google-Smtp-Source: AB8JxZpJiKFHi7c0fNiWNf8AkBhXonkWiaOKAAbpTyQhbl5o1TiGgp9KkGOzSKy4i1aP/oQmGrU3
ARC-Seal: i=1; a=rsa-sha256; t=1526001215; cv=none;
        d=google.com; s=arc-20160816;
        b=T5hov79rbPPckV5Sc/2Cfs3wmf6+/neLgNY7B3pC2uFCEa71SWd57GDqTaWa+yoE8a
         FOKf1jPcalWB67YpOu9EyHDC6xJiWzZ1daevSGoNgKmJP5DGMa4hIpgpFi0mc2zWIcNv
         MXRs5ufHWkik3rNhkg0lC1JZZfhoZgXfNLtwRfFRF5azOt5YLkAC7URwVmbYmWLINCc8
         xEtGHWhv1FPaW5FD9O+jCcZNGDw7QFh+W4yFHHMBnn6ZmPYhe3TIPmrOXduENibt8gt1
         CEcFAUq4xvduBrjfGeuHq2Ma37Ki70xm5hHpJLDX6NSulzlKMuyhjPK5SxVI3Fr/4XGZ
         r6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BSkF42SPyHKgj/CfPPZ5XqUKlAhkAR+04ZGxDTF/oj4=;
        b=dqhkM8oFll0Nm5mVa6qYvC+gnpWb3IhXdMcJFHTZlsDiuo4Rsu9DGw6WuiRGcq3A33
         b1FxJ7n1d3rdl5BeXeykyWwUalM96AD3jyMMZ2eaYBdvIfTtEJukSrFOmrO8h7vEUpVU
         UlaptJhbb5kRUJYrZwBGdeO1E69EDyoepfoIyOfx+rqC5MQ8ZYvXmahuI+tdpGLNIse6
         VOgybKGrzraXYruGeiIE32O3jzcMoSepiwAlKmFONl6+IftLtSKrgzoi3qxdj5XXHWhM
         njPhiqYkyXgIdsYarbE6z8HG0DpzYgOojeg+YG6ZwUZouMn5xixKew1MNZOxnnYdXOCU
         h8vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=cycQxxdA;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 2001:df5:b000:5::4 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
Authentication-Results: mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=cycQxxdA;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 2001:df5:b000:5::4 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH 2/2] uio: Prevent device destruction while fds are open
Date: Fri, 11 May 2018 13:11:05 +1200
Message-Id: <20180511011105.12193-3-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511011105.12193-1-hamish.martin@alliedtelesis.co.nz>
References: <20180511011105.12193-1-hamish.martin@alliedtelesis.co.nz>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600128249528907793?=
X-GMAIL-MSGID: =?utf-8?q?1600128249528907793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Prevent destruction of a uio_device while user space apps hold open
file descriptors to that device. Further, access to the 'info' member
of the struct uio_device is protected by spinlock. This is to ensure
stale pointers to data not under control of the UIO subsystem are not
dereferenced.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/uio/uio.c          | 98 ++++++++++++++++++++++++++++++++++------------
 include/linux/uio_driver.h |  3 +-
 2 files changed, 74 insertions(+), 27 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index dd44df17004d..5473e77c85be 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -270,7 +270,7 @@ static int uio_dev_add_attributes(struct uio_device *idev)
 		if (!map_found) {
 			map_found = 1;
 			idev->map_dir = kobject_create_and_add("maps",
-							&idev->dev->kobj);
+							&idev->dev.kobj);
 			if (!idev->map_dir) {
 				ret = -ENOMEM;
 				goto err_map;
@@ -299,7 +299,7 @@ static int uio_dev_add_attributes(struct uio_device *idev)
 		if (!portio_found) {
 			portio_found = 1;
 			idev->portio_dir = kobject_create_and_add("portio",
-							&idev->dev->kobj);
+							&idev->dev.kobj);
 			if (!idev->portio_dir) {
 				ret = -ENOMEM;
 				goto err_portio;
@@ -342,7 +342,7 @@ static int uio_dev_add_attributes(struct uio_device *idev)
 		kobject_put(&map->kobj);
 	}
 	kobject_put(idev->map_dir);
-	dev_err(idev->dev, "error creating sysfs files (%d)\n", ret);
+	dev_err(&idev->dev, "error creating sysfs files (%d)\n", ret);
 	return ret;
 }
 
@@ -379,7 +379,7 @@ static int uio_get_minor(struct uio_device *idev)
 		idev->minor = retval;
 		retval = 0;
 	} else if (retval == -ENOSPC) {
-		dev_err(idev->dev, "too many uio devices\n");
+		dev_err(&idev->dev, "too many uio devices\n");
 		retval = -EINVAL;
 	}
 	mutex_unlock(&minor_lock);
@@ -433,6 +433,7 @@ static int uio_open(struct inode *inode, struct file *filep)
 	struct uio_device *idev;
 	struct uio_listener *listener;
 	int ret = 0;
+	unsigned long flags;
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
@@ -442,9 +443,11 @@ static int uio_open(struct inode *inode, struct file *filep)
 		goto out;
 	}
 
+	get_device(&idev->dev);
+
 	if (!try_module_get(idev->owner)) {
 		ret = -ENODEV;
-		goto out;
+		goto err_module_get;
 	}
 
 	listener = kmalloc(sizeof(*listener), GFP_KERNEL);
@@ -457,11 +460,13 @@ static int uio_open(struct inode *inode, struct file *filep)
 	listener->event_count = atomic_read(&idev->event);
 	filep->private_data = listener;
 
-	if (idev->info->open) {
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (idev->info && idev->info->open)
 		ret = idev->info->open(idev->info, inode);
-		if (ret)
-			goto err_infoopen;
-	}
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+	if (ret)
+		goto err_infoopen;
+
 	return 0;
 
 err_infoopen:
@@ -470,6 +475,9 @@ static int uio_open(struct inode *inode, struct file *filep)
 err_alloc_listener:
 	module_put(idev->owner);
 
+err_module_get:
+	put_device(&idev->dev);
+
 out:
 	return ret;
 }
@@ -487,12 +495,16 @@ static int uio_release(struct inode *inode, struct file *filep)
 	int ret = 0;
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
+	unsigned long flags;
 
-	if (idev->info->release)
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (idev->info && idev->info->release)
 		ret = idev->info->release(idev->info, inode);
+	spin_unlock_irqrestore(&idev->info_lock, flags);
 
 	module_put(idev->owner);
 	kfree(listener);
+	put_device(&idev->dev);
 	return ret;
 }
 
@@ -500,9 +512,16 @@ static __poll_t uio_poll(struct file *filep, poll_table *wait)
 {
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
+	__poll_t ret = 0;
+	unsigned long flags;
 
-	if (!idev->info->irq)
-		return -EIO;
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (!idev->info || !idev->info->irq)
+		ret = -EIO;
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+
+	if (ret)
+		return ret;
 
 	poll_wait(filep, &idev->wait, wait);
 	if (listener->event_count != atomic_read(&idev->event))
@@ -516,11 +535,17 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t retval;
+	ssize_t retval = 0;
 	s32 event_count;
+	unsigned long flags;
 
-	if (!idev->info->irq)
-		return -EIO;
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (!idev->info || !idev->info->irq)
+		retval = -EIO;
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+
+	if (retval)
+		return retval;
 
 	if (count != sizeof(s32))
 		return -EINVAL;
@@ -567,8 +592,10 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	struct uio_device *idev = listener->dev;
 	ssize_t retval;
 	s32 irq_on;
+	unsigned long flags;
 
-	if (!idev->info->irq) {
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (!idev->info || !idev->info->irq) {
 		retval = -EIO;
 		goto out;
 	}
@@ -591,6 +618,7 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
 out:
+	spin_unlock_irqrestore(&idev->info_lock, flags);
 	return retval ? retval : sizeof(s32);
 }
 
@@ -803,6 +831,13 @@ static void release_uio_class(void)
 	uio_major_cleanup();
 }
 
+static void uio_device_release(struct device *dev)
+{
+	struct uio_device *idev = dev_get_drvdata(dev);
+
+	kfree(idev);
+}
+
 /**
  * uio_register_device - register a new userspace IO device
  * @owner:	module that creates the new device
@@ -823,13 +858,14 @@ int __uio_register_device(struct module *owner,
 
 	info->uio_dev = NULL;
 
-	idev = devm_kzalloc(parent, sizeof(*idev), GFP_KERNEL);
+	idev = kzalloc(sizeof(*idev), GFP_KERNEL);
 	if (!idev) {
 		return -ENOMEM;
 	}
 
 	idev->owner = owner;
 	idev->info = info;
+	spin_lock_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
 
@@ -837,14 +873,19 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		return ret;
 
-	idev->dev = device_create(&uio_class, parent,
-				  MKDEV(uio_major, idev->minor), idev,
-				  "uio%d", idev->minor);
-	if (IS_ERR(idev->dev)) {
-		printk(KERN_ERR "UIO: device register failed\n");
-		ret = PTR_ERR(idev->dev);
+	idev->dev.devt = MKDEV(uio_major, idev->minor);
+	idev->dev.class = &uio_class;
+	idev->dev.parent = parent;
+	idev->dev.release = uio_device_release;
+	dev_set_drvdata(&idev->dev, idev);
+
+	ret = dev_set_name(&idev->dev, "uio%d", idev->minor);
+	if (ret)
+		goto err_device_create;
+
+	ret = device_register(&idev->dev);
+	if (ret)
 		goto err_device_create;
-	}
 
 	ret = uio_dev_add_attributes(idev);
 	if (ret)
@@ -872,7 +913,7 @@ int __uio_register_device(struct module *owner,
 err_request_irq:
 	uio_dev_del_attributes(idev);
 err_uio_dev_add_attributes:
-	device_destroy(&uio_class, MKDEV(uio_major, idev->minor));
+	device_unregister(&idev->dev);
 err_device_create:
 	uio_free_minor(idev);
 	return ret;
@@ -887,6 +928,7 @@ EXPORT_SYMBOL_GPL(__uio_register_device);
 void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
+	unsigned long flags;
 
 	if (!info || !info->uio_dev)
 		return;
@@ -900,7 +942,11 @@ void uio_unregister_device(struct uio_info *info)
 	if (info->irq && info->irq != UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
 
-	device_destroy(&uio_class, MKDEV(uio_major, idev->minor));
+	spin_lock_irqsave(&idev->info_lock, flags);
+	idev->info = NULL;
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+
+	device_unregister(&idev->dev);
 
 	return;
 }
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 3c85c81b0027..42b3d7cd7413 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -68,12 +68,13 @@ struct uio_port {
 
 struct uio_device {
         struct module           *owner;
-        struct device           *dev;
+	struct device		dev;
         int                     minor;
         atomic_t                event;
         struct fasync_struct    *async_queue;
         wait_queue_head_t       wait;
         struct uio_info         *info;
+	spinlock_t		info_lock;
         struct kobject          *map_dir;
         struct kobject          *portio_dir;
 };
-- 
2.16.2
