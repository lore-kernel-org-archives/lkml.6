Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFBR44 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:56:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44437 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFBR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:56:55 -0400
X-Originating-IP: 96.22.60.141
Date: Sat, 2 Jun 2018 13:56:49 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: [PATCH v2] staging: pi433: add mutex fixing concurrency issues.
Message-ID: <20180602175649.GA2816@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a mutex fixing a potential NULL pointer dereference in the pi433
driver.

If pi433_release and pi433_ioctl are concurrently called,
pi433_release might set filp->private_data to NULL while pi433_ioctl
is still accessing it, leading to NULL pointer dereference. This issue
might also affect pi433_write and pi433_read.

The newly introduced mutex makes sure that instance data
will not be modified simultaneously by pi433_release, pi433_write,
pi433_read or pi433_ioctl.

The mutex is stored in a newly introduced struct pi433_data, which
wraps struct pi433_instance and its mutex.

Make filp->private_data point to a struct pi433_data, allowing to
acquire the lock before accessing the struct pi433_instance.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v2:
 	- Use mutex instead of rw semaphore.=20
 	- Introduce struct pi433_data in order to allow functions to lock
 	  before dereferencing instance pointer.
 	- Make filp->private_data point to a struct pi433_data.
 	- Add missing braces.
---
 drivers/staging/pi433/pi433_if.c | 77 +++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433=
_if.c
index d1e0ddbc79ce..b56dac27e7f1 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -118,6 +118,11 @@ struct pi433_instance {
 	struct pi433_tx_cfg	tx_cfg;
 };
=20
+struct pi433_data {
+	struct pi433_instance	*instance;
+	struct mutex		instance_lock; /* guards instance removal */
+};
+
 /*------------------------------------------------------------------------=
-*/
=20
 /* GPIO interrupt handlers */
@@ -769,6 +774,7 @@ pi433_tx_thread(void *data)
 static ssize_t
 pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 {
+	struct pi433_data	*data;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	int			bytes_received;
@@ -778,13 +784,16 @@ pi433_read(struct file *filp, char __user *buf, size_=
t size, loff_t *f_pos)
 	if (size > MAX_MSG_SIZE)
 		return -EMSGSIZE;
=20
-	instance =3D filp->private_data;
+	data =3D filp->private_data;
+	mutex_lock(&data->instance_lock);
+	instance =3D data->instance;
 	device =3D instance->device;
=20
 	/* just one read request at a time */
 	mutex_lock(&device->rx_lock);
 	if (device->rx_active) {
 		mutex_unlock(&device->rx_lock);
+		mutex_unlock(&data->instance_lock);
 		return -EAGAIN;
 	}
=20
@@ -804,10 +813,13 @@ pi433_read(struct file *filp, char __user *buf, size_=
t size, loff_t *f_pos)
 	/* if read was successful copy to user space*/
 	if (bytes_received > 0) {
 		retval =3D copy_to_user(buf, device->rx_buffer, bytes_received);
-		if (retval)
+		if (retval) {
+			mutex_unlock(&data->instance_lock);
 			return -EFAULT;
+		}
 	}
=20
+	mutex_unlock(&data->instance_lock);
 	return bytes_received;
 }
=20
@@ -815,17 +827,22 @@ static ssize_t
 pi433_write(struct file *filp, const char __user *buf,
 	    size_t count, loff_t *f_pos)
 {
+	struct pi433_data	*data;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	int                     retval;
 	unsigned int		copied;
=20
-	instance =3D filp->private_data;
+	data =3D filp->private_data;
+	mutex_lock(&data->instance_lock);
+	instance =3D data->instance;
 	device =3D instance->device;
=20
 	/* check, whether internal buffer (tx thread) is big enough for requested=
 size */
-	if (count > MAX_MSG_SIZE)
+	if (count > MAX_MSG_SIZE) {
+		mutex_unlock(&data->instance_lock);
 		return -EMSGSIZE;
+	}
=20
 	/* write the following sequence into fifo:
 	 * - tx_cfg
@@ -851,6 +868,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	/* start transfer */
 	wake_up_interruptible(&device->tx_wait_queue);
 	dev_dbg(device->dev, "write: generated new msg with %d bytes.", copied);
+	mutex_unlock(&data->instance_lock);
=20
 	return copied;
=20
@@ -858,6 +876,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	dev_dbg(device->dev, "write to fifo failed: 0x%x", retval);
 	kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to dis=
card already stored, valid entries
 	mutex_unlock(&device->tx_fifo_lock);
+	mutex_unlock(&data->instance_lock);
 	return -EAGAIN;
 }
=20
@@ -865,6 +884,7 @@ static long
 pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int			retval =3D 0;
+	struct pi433_data	*data;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 	void __user *argp =3D (void __user *)arg;
@@ -873,30 +893,37 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsi=
gned long arg)
 	if (_IOC_TYPE(cmd) !=3D PI433_IOC_MAGIC)
 		return -ENOTTY;
=20
-	/* TODO? guard against device removal before, or while,
-	 * we issue this ioctl. --> device_get()
-	 */
-	instance =3D filp->private_data;
+	data =3D filp->private_data;
+	mutex_lock(&data->instance_lock);
+	instance =3D data->instance;
 	device =3D instance->device;
=20
-	if (!device)
+	if (!device) {
+		mutex_unlock(&data->instance_lock);
 		return -ESHUTDOWN;
+	}
=20
 	switch (cmd) {
 	case PI433_IOC_RD_TX_CFG:
 		if (copy_to_user(argp, &instance->tx_cfg,
-				 sizeof(struct pi433_tx_cfg)))
+				 sizeof(struct pi433_tx_cfg))) {
+			mutex_unlock(&data->instance_lock);
 			return -EFAULT;
+		}
 		break;
 	case PI433_IOC_WR_TX_CFG:
 		if (copy_from_user(&instance->tx_cfg, argp,
-				   sizeof(struct pi433_tx_cfg)))
+				   sizeof(struct pi433_tx_cfg))) {
+			mutex_unlock(&data->instance_lock);
 			return -EFAULT;
+		}
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
-				 sizeof(struct pi433_rx_cfg)))
+				 sizeof(struct pi433_rx_cfg))) {
+			mutex_unlock(&data->instance_lock);
 			return -EFAULT;
+		}
 		break;
 	case PI433_IOC_WR_RX_CFG:
 		mutex_lock(&device->rx_lock);
@@ -904,21 +931,26 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsi=
gned long arg)
 		/* during pendig read request, change of config not allowed */
 		if (device->rx_active) {
 			mutex_unlock(&device->rx_lock);
+			mutex_unlock(&data->instance_lock);
 			return -EAGAIN;
 		}
=20
 		if (copy_from_user(&device->rx_cfg, argp,
 				   sizeof(struct pi433_rx_cfg))) {
 			mutex_unlock(&device->rx_lock);
+			mutex_unlock(&data->instance_lock);
 			return -EFAULT;
 		}
=20
 		mutex_unlock(&device->rx_lock);
+		mutex_unlock(&data->instance_lock);
 		break;
 	default:
+		mutex_unlock(&data->instance_lock);
 		retval =3D -EINVAL;
 	}
=20
+	mutex_unlock(&data->instance_lock);
 	return retval;
 }
=20
@@ -936,6 +968,7 @@ pi433_compat_ioctl(struct file *filp, unsigned int cmd,=
 unsigned long arg)
=20
 static int pi433_open(struct inode *inode, struct file *filp)
 {
+	struct pi433_data	*data;
 	struct pi433_device	*device;
 	struct pi433_instance	*instance;
=20
@@ -954,20 +987,30 @@ static int pi433_open(struct inode *inode, struct fil=
e *filp)
 	}
=20
 	device->users++;
+	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		kfree(device->rx_buffer);
+		device->rx_buffer =3D NULL;
+		return -ENOMEM;
+	}
+	mutex_init(&data->instance_lock);
+
 	instance =3D kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
+		kfree(data);
 		kfree(device->rx_buffer);
 		device->rx_buffer =3D NULL;
 		return -ENOMEM;
 	}
=20
 	/* setup instance data*/
+	data->instance =3D instance;
 	instance->device =3D device;
 	instance->tx_cfg.bit_rate =3D 4711;
 	// TODO: fill instance->tx_cfg;
=20
-	/* instance data as context */
-	filp->private_data =3D instance;
+	/* instance data wrapper as context */
+	filp->private_data =3D data;
 	nonseekable_open(inode, filp);
=20
 	return 0;
@@ -975,12 +1018,16 @@ static int pi433_open(struct inode *inode, struct fi=
le *filp)
=20
 static int pi433_release(struct inode *inode, struct file *filp)
 {
+	struct pi433_data	*data;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
=20
-	instance =3D filp->private_data;
+	data =3D filp->private_data;
+	mutex_lock(&data->instance_lock);
+	instance =3D data->instance;
 	device =3D instance->device;
 	kfree(instance);
+	kfree(data);
 	filp->private_data =3D NULL;
=20
 	/* last close? */
--=20
2.17.1

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsS2lgACgkQLVy48vb3
khlMzggApmHkFus5d9dRlOtjwsR/hXm/JfTGH3pYdExVijOIlGaP2aTl3eFwgCnd
YGxlGpfg/qCJ+78COWBxEcP6NHDvkSIobctLYJ461+OOPOwLFyP+P7jzyxKHsLSw
Sz9dgtrNMiqboVWHLcSn7E8Gl6QhnsKE5Er5NRXMa/zBW5e2qz12mzlRf+B0DKIh
3kLAsRlwaCUZpGARhBJXBI7iTZSGZMaNieqUCyloATxQn9BK4g7nkZBUeXdv/IDM
6ufgiXk6EInQwwySj/fMajMGtKoMd0tQe69D1BDR/xmkSAZCncopqtWKIsXrM1Lg
cMMKWe3E6aAGdxOjDXUikwSSPM3x4Q==
=1C06
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
