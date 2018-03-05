Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AG47ELuZj0mstmCrfgOT/x0OPnM0G7B3ZXik1P1Uk/KLgEYlnNOKMZ4gZuuAc/hVFVDYe2SK9dOa
ARC-Seal: i=1; a=rsa-sha256; t=1520259823; cv=none;
        d=google.com; s=arc-20160816;
        b=GjniPgnU7bU2Y1ZA3K+29CW/q06X0QVPqkjbSTO6grs6t4LDRi+z01ZaEw6juWcrjP
         146pUKpVMbJ6rugQv3cdd7zbXJwQfdFFiVU+mxB/PmerZ/uXA2xnaTX6p1+GH/q9sX6Z
         FEd704Q+Mt/WCR1Eo9TpWGGSyA4MmtxaNoCFufZkYWZNw2c2GSy3V3E5Df8FlPpxRIIe
         iQ+vS3mcpujmLT0aN2eJHgNjn/Z9knZd9jLe3Zhyb3WAQvPcTJ695tDzwvc74ZUp4aj+
         Bs2ZKkpB5ajqVfrQKqdAcO76fwaoSzY0kggnoSUtN1zCY+lLf2JHCTCraMjaFUVvEZju
         qkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=O9yEu+bixwVRtqdTJENkGldZy6qiGIi1FHz7qLJNTGQ=;
        b=Cpi94tTKbZSVZ1V8ir6f6tnZtnIwNHd5ewH1jPEtwiLa4k+AYhPnhpUauAqURkwTaL
         HrJSKKH61PQTowTzV20j3A+TkpgpaLvrp6hCMolmAAh/JadMAB8HW/81ykadHWOKjVAw
         MtNaHly+7K1/qEyfxtkSxQKVh2hGFoNkAudK6yu/c0kDu3RCOw6JsA8cJFzzK9lh29/T
         OxqdeBf99Z+OpbcOg1Nyl3ogeJFYf0bLsMP+FTvI91gIrugpAbOvpc6GWsR9IoXP3zWp
         yw7Yu9r34ApUtHaav1iByleScO4zLi/AIiRC33QJOYfyV2ytk1N+1cvMCyPtqhn8h62Y
         EAvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Mon, 5 Mar 2018 14:23:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: ALKML <linux-arm-kernel@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "Alexey
 Klimov" <klimov.linux@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 05/20] firmware: arm_scmi: add scmi protocol bus to
 enumerate protocol devices
Message-ID: <20180305152319.00005877@huawei.com>
In-Reply-To: <1519403030-21189-6-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
	<1519403030-21189-6-git-send-email-sudeep.holla@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209579971217250?=
X-GMAIL-MSGID: =?utf-8?q?1594107964325663640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 16:23:35 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> The SCMI specification encompasses various protocols. However, not every
> protocol has to be present on a given platform/implementation as not
> every protocol is relevant for it.
> 
> Furthermore, the platform chooses which protocols it exposes to a given
> agent. The only protocol that must be implemented is the base protocol.
> The base protocol is used by an agent to discover which protocols are
> available to it.
> 
> In order to enumerate the discovered implemented protocols, this patch
> adds support for a separate scmi protocol bus. It also adds mechanism to
> register support for different protocols.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Comments inline.

Jonathan

> ---
>  drivers/firmware/arm_scmi/Makefile |   3 +-
>  drivers/firmware/arm_scmi/bus.c    | 232 +++++++++++++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/common.h |   1 +
>  include/linux/scmi_protocol.h      |  64 ++++++++++
>  4 files changed, 299 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/arm_scmi/bus.c
> 
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 5d9c7ef35f0f..5f4ec2613db6 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -1,3 +1,4 @@
> -obj-y	= scmi-driver.o scmi-protocols.o
> +obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
> +scmi-bus-y = bus.o
>  scmi-driver-y = driver.o
>  scmi-protocols-y = base.o
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> new file mode 100644
> index 000000000000..58bb4f46fde1
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -0,0 +1,232 @@
> +/*
> + * System Control and Management Interface (SCMI) Message Protocol bus layer
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +
> +#include "common.h"
> +
> +static DEFINE_IDA(scmi_bus_id);
> +static DEFINE_IDR(scmi_protocols);
> +static DEFINE_SPINLOCK(protocol_lock);
> +
> +static const struct scmi_device_id *
> +scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
> +{
> +	const struct scmi_device_id *id = scmi_drv->id_table;
> +
> +	if (!id)
> +		return NULL;
> +
> +	for (; id->protocol_id; id++)
> +		if (id->protocol_id == scmi_dev->protocol_id)
> +			return id;
> +
> +	return NULL;
> +}
> +
> +static int scmi_dev_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct scmi_driver *scmi_drv = to_scmi_driver(drv);
> +	struct scmi_device *scmi_dev = to_scmi_dev(dev);
> +	const struct scmi_device_id *id;
> +
> +	id = scmi_dev_match_id(scmi_dev, scmi_drv);
> +	if (id)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
> +{
> +	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
> +
> +	if (unlikely(!fn))
> +		return -EINVAL;
> +	return fn(handle);
> +}
> +
> +static int scmi_dev_probe(struct device *dev)
> +{
> +	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
> +	struct scmi_device *scmi_dev = to_scmi_dev(dev);
> +	const struct scmi_device_id *id;
> +	int ret;
> +
> +	id = scmi_dev_match_id(scmi_dev, scmi_drv);
> +	if (!id)
> +		return -ENODEV;
> +
> +	if (!scmi_dev->handle)
> +		return -EPROBE_DEFER;
> +
> +	ret = scmi_protocol_init(scmi_dev->protocol_id, scmi_dev->handle);
> +	if (ret)
> +		return ret;
> +
> +	return scmi_drv->probe(scmi_dev);
> +}
> +
> +static int scmi_dev_remove(struct device *dev)
> +{
> +	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
> +	struct scmi_device *scmi_dev = to_scmi_dev(dev);
> +
> +	if (scmi_drv->remove)
> +		scmi_drv->remove(scmi_dev);
> +
> +	return 0;
> +}
> +
> +static struct bus_type scmi_bus_type = {
> +	.name =	"scmi_protocol",
> +	.match = scmi_dev_match,
> +	.probe = scmi_dev_probe,
> +	.remove = scmi_dev_remove,
> +};
> +
> +int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
> +			 const char *mod_name)
> +{
> +	int retval;
> +
> +	driver->driver.bus = &scmi_bus_type;
> +	driver->driver.name = driver->name;
> +	driver->driver.owner = owner;
> +	driver->driver.mod_name = mod_name;
> +
> +	retval = driver_register(&driver->driver);
> +	if (!retval)
> +		pr_debug("registered new scmi driver %s\n", driver->name);
> +
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(scmi_driver_register);
> +
> +void scmi_driver_unregister(struct scmi_driver *driver)
> +{
> +	driver_unregister(&driver->driver);
> +}
> +EXPORT_SYMBOL_GPL(scmi_driver_unregister);
> +
> +struct scmi_device *
> +scmi_device_create(struct device_node *np, struct device *parent, int protocol)
> +{
> +	int id, retval;
> +	struct scmi_device *scmi_dev;
> +
> +	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
> +	if (id < 0)
> +		return NULL;
> +
> +	scmi_dev = kzalloc(sizeof(*scmi_dev), GFP_KERNEL);
> +	if (!scmi_dev)
> +		goto no_mem;
> +
> +	scmi_dev->id = id;
> +	scmi_dev->protocol_id = protocol;
> +	scmi_dev->dev.parent = parent;
> +	scmi_dev->dev.of_node = np;
> +	scmi_dev->dev.bus = &scmi_bus_type;
> +	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
> +
> +	retval = device_register(&scmi_dev->dev);
> +	if (!retval)
> +		return scmi_dev;
This approach of the good path being the indented
return is not that common in kernel code. Personally
I would have found this a lot more readable with a
goto used for the error path. (This was true in
various earlier places, but here it is really
nasty so I thought I'd raise it).

> +
> +	put_device(&scmi_dev->dev);
> +	kfree(scmi_dev);
> +no_mem:
> +	ida_simple_remove(&scmi_bus_id, id);
> +	return NULL;
> +}
> +
> +void scmi_device_destroy(struct scmi_device *scmi_dev)
> +{
> +	scmi_handle_put(scmi_dev->handle);
> +	device_unregister(&scmi_dev->dev);
> +	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
Why not reorder the create function to do the alloc
then the ida_simple get - that way you could avoid
making reviewers wonder why you have different ordering
in the two functions.

> +	kfree(scmi_dev);
> +}
> +
> +void scmi_set_handle(struct scmi_device *scmi_dev)
> +{
> +	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
> +}
> +
> +int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
> +{
> +	int ret;
> +
> +	spin_lock(&protocol_lock);
> +	ret = idr_alloc(&scmi_protocols, fn, protocol_id, protocol_id + 1,
> +			GFP_ATOMIC);
> +	if (ret != protocol_id)
> +		pr_err("unable to allocate SCMI idr slot, err %d\n", ret);

Error check and print could be outside the lock.

> +	spin_unlock(&protocol_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(scmi_protocol_register);
> +
> +void scmi_protocol_unregister(int protocol_id)
> +{
> +	spin_lock(&protocol_lock);
> +	idr_remove(&scmi_protocols, protocol_id);
> +	spin_unlock(&protocol_lock);
> +}
> +EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
> +
> +static int __scmi_devices_unregister(struct device *dev, void *data)
> +{
> +	struct scmi_device *scmi_dev = to_scmi_dev(dev);
> +
> +	scmi_device_destroy(scmi_dev);
> +	return 0;
> +}
> +
> +static void scmi_devices_unregister(void)
> +{
> +	bus_for_each_dev(&scmi_bus_type, NULL, NULL, __scmi_devices_unregister);
> +}
> +
> +static int __init scmi_bus_init(void)
> +{
> +	int retval;
> +
> +	retval = bus_register(&scmi_bus_type);
> +	if (retval)
> +		pr_err("scmi protocol bus register failed (%d)\n", retval);
> +
> +	return retval;
> +}
> +subsys_initcall(scmi_bus_init);
> +
> +static void __exit scmi_bus_exit(void)
> +{
> +	scmi_devices_unregister();
> +	bus_unregister(&scmi_bus_type);
> +	ida_destroy(&scmi_bus_id);
> +}
> +module_exit(scmi_bus_exit);
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index bc767f4997e0..f1eeacaef57b 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -107,6 +107,7 @@ int scmi_one_xfer_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
>  		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
>  int scmi_handle_put(const struct scmi_handle *handle);
>  struct scmi_handle *scmi_handle_get(struct device *dev);
> +void scmi_set_handle(struct scmi_device *scmi_dev);
>  int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
>  void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>  				     u8 *prot_imp);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 664da3d763f2..db995126134d 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -15,6 +15,7 @@
>   * You should have received a copy of the GNU General Public License along with
>   * this program. If not, see <http://www.gnu.org/licenses/>.
>   */
> +#include <linux/device.h>
>  #include <linux/types.h>
>  
>  #define SCMI_MAX_STR_SIZE	16
> @@ -62,3 +63,66 @@ enum scmi_std_protocol {
>  	SCMI_PROTOCOL_CLOCK = 0x14,
>  	SCMI_PROTOCOL_SENSOR = 0x15,
>  };
> +
> +struct scmi_device {
> +	u32 id;
> +	u8 protocol_id;
> +	struct device dev;
> +	struct scmi_handle *handle;
> +};
> +
> +#define to_scmi_dev(d) container_of(d, struct scmi_device, dev)
> +
> +struct scmi_device *
> +scmi_device_create(struct device_node *np, struct device *parent, int protocol);
> +void scmi_device_destroy(struct scmi_device *scmi_dev);
> +
> +struct scmi_device_id {
> +	u8 protocol_id;
> +};
> +
> +struct scmi_driver {
> +	const char *name;
> +	int (*probe)(struct scmi_device *sdev);
> +	void (*remove)(struct scmi_device *sdev);
> +	const struct scmi_device_id *id_table;
> +
> +	struct device_driver driver;
> +};
> +
> +#define to_scmi_driver(d) container_of(d, struct scmi_driver, driver)
> +
> +#ifdef CONFIG_ARM_SCMI_PROTOCOL
> +int scmi_driver_register(struct scmi_driver *driver,
> +			 struct module *owner, const char *mod_name);
> +void scmi_driver_unregister(struct scmi_driver *driver);
> +#else
> +static inline int
> +scmi_driver_register(struct scmi_driver *driver, struct module *owner,
> +		     const char *mod_name)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
> +#endif /* CONFIG_ARM_SCMI_PROTOCOL */
> +
> +#define scmi_register(driver) \
> +	scmi_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
> +#define scmi_unregister(driver) \
> +	scmi_driver_unregister(driver)
> +
> +/**
> + * module_scmi_driver() - Helper macro for registering a scmi driver
> + * @__scmi_driver: scmi_driver structure
> + *
> + * Helper macro for scmi drivers to set up proper module init / exit
> + * functions.  Replaces module_init() and module_exit() and keeps people from
> + * printing pointless things to the kernel log when their driver is loaded.
> + */
> +#define module_scmi_driver(__scmi_driver)	\
> +	module_driver(__scmi_driver, scmi_register, scmi_unregister)
> +
> +typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
> +int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
> +void scmi_protocol_unregister(int protocol_id);
