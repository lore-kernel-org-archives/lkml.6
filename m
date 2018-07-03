Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC5BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2213824DE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2213824DE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933719AbeGCHy3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:54:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeGCHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:54:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BF2DBC97;
        Tue,  3 Jul 2018 07:54:26 +0000 (UTC)
Date:   Tue, 3 Jul 2018 09:54:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/4] misc: Add bmc-misc-ctrl
Message-ID: <20180703075424.GC27649@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-4-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703070413.28756-4-andrew@aj.id.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:04:12PM +1000, Andrew Jeffery wrote:
> bmc-misc-ctrl is used to expose miscellaneous Baseboard
> Management Controller (BMC) hardware features described in the devicetree
> to userspace.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/misc/Kconfig         |   8 +
>  drivers/misc/Makefile        |   1 +
>  drivers/misc/bmc-misc-ctrl.c | 363 +++++++++++++++++++++++++++++++++++
>  4 files changed, 373 insertions(+)
>  create mode 100644 drivers/misc/bmc-misc-ctrl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9766d7832d8b..30d39440b6f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2741,6 +2741,7 @@ R:	Andrew Jeffery <andrew@aj.id.au>
>  L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> +F:	drivers/misc/bmc-misc-ctrl.c
>  
>  BPF (Safe dynamic programs and tools)
>  M:	Alexei Starovoitov <ast@kernel.org>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3726eacdf65d..f46bc8208b50 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -513,6 +513,14 @@ config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
>  
> +config BMC_MISC_CTRL
> +	tristate "Miscellaneous BMC Control Interfaces"
> +	depends on REGMAP && MFD_SYSCON
> +	help
> +	  Say yes to expose scratch registers used to communicate between the
> +	  host and BMC along with other miscellaneous control interfaces
> +	  provided by BMC SoCs
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index af22bbc3d00c..4fb2fac7a486 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-$(CONFIG_BMC_MISC_CTRL)     += bmc-misc-ctrl.o
> diff --git a/drivers/misc/bmc-misc-ctrl.c b/drivers/misc/bmc-misc-ctrl.c
> new file mode 100644
> index 000000000000..ff907029163f
> --- /dev/null
> +++ b/drivers/misc/bmc-misc-ctrl.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2018 IBM Corp.
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/kobject.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +struct bmc_ctrl {
> +	struct device *dev;
> +	struct regmap *map;
> +	bool ro;
> +	u32 shift;
> +	u32 mask;
> +	struct kobj_attribute mask_attr;
> +	const char *label;
> +	struct kobj_attribute label_attr;
> +	union {
> +		struct {
> +			u32 value;
> +			struct kobj_attribute value_attr;
> +		};
> +		struct {
> +			u32 read;
> +			u32 set;
> +			u32 clear;
> +			struct kobj_attribute read_attr;
> +			struct kobj_attribute set_attr;
> +			struct kobj_attribute clear_attr;
> +		};

What is this crazy union for?  Why are you messing around with "raw"
kobject attributes?  This is a device, you should never have to mess
with sysfs calls or kobject calls or structures directly.  If you do,
that's a huge hint something is wrong here.


> +	};
> +};
> +
> +static ssize_t bmc_misc_rmw_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	struct bmc_ctrl *ctrl;
> +	unsigned int val;
> +	int rc;
> +
> +	ctrl = container_of(attr, struct bmc_ctrl, value_attr);
> +	rc = regmap_read(ctrl->map, ctrl->value, &val);
> +	if (rc)
> +		return rc;
> +
> +	val = (val & ctrl->mask) >> ctrl->shift;
> +
> +	return sprintf(buf, "%u\n", val);
> +}
> +
> +static ssize_t bmc_misc_rmw_store(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct bmc_ctrl *ctrl;
> +	long val;
> +	int rc;
> +
> +	rc = kstrtol(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ctrl = container_of(attr, struct bmc_ctrl, value_attr);
> +	val <<= ctrl->shift;
> +	if (val & ~ctrl->mask)
> +		return -EINVAL;
> +	rc = regmap_update_bits(ctrl->map, ctrl->value, ctrl->mask, val);
> +
> +	return rc < 0 ? rc : count;
> +}
> +
> +static void bmc_misc_add_rmw_attrs(struct bmc_ctrl *ctrl,
> +				   struct attribute *attrs[6])
> +{
> +	sysfs_attr_init(&ctrl->attr.attr);
> +	ctrl->value_attr.attr.name = "value";
> +	ctrl->value_attr.attr.mode = 0664;
> +	ctrl->value_attr.show = bmc_misc_rmw_show;
> +	ctrl->value_attr.store = bmc_misc_rmw_store;
> +	attrs[2] = &ctrl->value_attr.attr;
> +	attrs[3] = NULL;

You aren't "adding" any attributes here, you are only setting them up
(in an odd way, see below...)

> +}
> +
> +static int bmc_misc_init_rmw(struct bmc_ctrl *ctrl, struct device_node *node,
> +			     struct attribute *attrs[6])

That's an oddly-hard-coded array size for no good reason :(


> +{
> +	u32 val;
> +	int rc;
> +
> +	rc = of_property_read_u32(node, "offset", &ctrl->value);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!of_property_read_u32(node, "default-value", &val)) {
> +		val <<= ctrl->shift;
> +		if (val & ~ctrl->mask)
> +			return -EINVAL;
> +		val &= ctrl->mask;
> +		regmap_update_bits(ctrl->map, ctrl->value, ctrl->mask, val);
> +	}
> +
> +	bmc_misc_add_rmw_attrs(ctrl, attrs);
> +
> +	return 0;
> +}
> +
> +static ssize_t bmc_misc_sc_read_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	struct bmc_ctrl *ctrl;
> +	unsigned int val;
> +	int rc;
> +
> +	ctrl = container_of(attr, struct bmc_ctrl, read_attr);
> +	rc = regmap_read(ctrl->map, ctrl->read, &val);
> +	if (rc)
> +		return rc;
> +
> +	val = (val & ctrl->mask) >> ctrl->shift;
> +
> +	return sprintf(buf, "%u\n", val);
> +
> +}
> +
> +static ssize_t bmc_misc_sc_set_store(struct kobject *kobj,
> +					    struct kobj_attribute *attr,
> +					    const char *buf, size_t count)
> +{
> +	struct bmc_ctrl *ctrl;
> +	long val;
> +	int rc;
> +
> +	rc = kstrtol(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ctrl = container_of(attr, struct bmc_ctrl, set_attr);
> +	val <<= ctrl->shift;
> +	if (val & ~ctrl->mask)
> +		return -EINVAL;
> +	val &= ctrl->mask;
> +	rc = regmap_write(ctrl->map, ctrl->set, val);
> +
> +	return rc < 0 ? rc : count;
> +}
> +
> +static ssize_t bmc_misc_sc_clear_store(struct kobject *kobj,
> +					      struct kobj_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct bmc_ctrl *ctrl;
> +	long val;
> +	int rc;
> +
> +	rc = kstrtol(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ctrl = container_of(attr, struct bmc_ctrl, clear_attr);
> +	val <<= ctrl->shift;
> +	if (val & ~ctrl->mask)
> +		return -EINVAL;
> +	val &= ctrl->mask;
> +	rc = regmap_write(ctrl->map, ctrl->clear, val);
> +
> +	return rc < 0 ? rc : count;
> +}
> +
> +static void bmc_misc_add_sc_attrs(struct bmc_ctrl *ctrl,
> +				  struct attribute *attrs[6])
> +{
> +	sysfs_attr_init(&ctrl->read_attr.attr);
> +	ctrl->read_attr.attr.name = "value";
> +	ctrl->read_attr.attr.mode = 0444;
> +	ctrl->read_attr.show = bmc_misc_sc_read_show;
> +	attrs[2] = &ctrl->read_attr.attr;
> +
> +	sysfs_attr_init(&ctrl->set_attr.attr);
> +	ctrl->set_attr.attr.name = "set";
> +	ctrl->set_attr.attr.mode = 0200;
> +	ctrl->set_attr.store = bmc_misc_sc_set_store;
> +	attrs[3] = &ctrl->set_attr.attr;
> +
> +	sysfs_attr_init(&ctrl->clear_attr.attr);
> +	ctrl->clear_attr.attr.name = "clear";
> +	ctrl->clear_attr.attr.mode = 0200;
> +	ctrl->clear_attr.store = bmc_misc_sc_clear_store;
> +	attrs[4] = &ctrl->clear_attr.attr;
> +
> +	attrs[5] = NULL;
> +}
> +
> +static int bmc_misc_init_sc(struct bmc_ctrl *ctrl, struct device_node *node,
> +			    struct attribute *attrs[6])
> +{
> +	int rc;
> +
> +	rc = of_property_read_u32_array(node, "offset", &ctrl->read, 3);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (of_property_read_bool(node, "default-set"))
> +		regmap_write(ctrl->map, ctrl->set, ctrl->mask);
> +	else if (of_property_read_bool(node, "default-clear"))
> +		regmap_write(ctrl->map, ctrl->clear, ctrl->mask);
> +
> +	bmc_misc_add_sc_attrs(ctrl, attrs);
> +
> +	return 0;
> +}
> +
> +static ssize_t bmc_misc_label_show(struct kobject *kobj,
> +				   struct kobj_attribute *attr, char *buf)
> +{
> +	struct bmc_ctrl *ctrl = container_of(attr, struct bmc_ctrl, label_attr);
> +
> +	return sprintf(buf, "%s\n", ctrl->label);
> +}
> +
> +static ssize_t bmc_misc_mask_show(struct kobject *kobj,
> +				   struct kobj_attribute *attr, char *buf)
> +{
> +	struct bmc_ctrl *ctrl = container_of(attr, struct bmc_ctrl, mask_attr);
> +
> +	return sprintf(buf, "0x%x\n", ctrl->mask >> ctrl->shift);
> +}
> +
> +static int bmc_misc_init_dt(struct bmc_ctrl *ctrl, struct device_node *node,
> +			    struct attribute *attrs[6])
> +{
> +	int rc;
> +
> +	/* Example children:
> +	 *
> +	 * field@80.6 {
> +	 *      compatible = "bmc-misc-control";
> +	 *      reg = <0x80>;
> +	 *      bit-mask = <0x1>;
> +	 *      bit-shift = <6>;
> +	 *      label = "ilpc2ahb-disable";
> +	 * };
> +	 *
> +	 * field@70.6 {
> +	 *      compatible = "bmc-misc-control";
> +	 *      // Write-1-set/Write-1-clear semantics
> +	 *      set-clear;
> +	 *      default-set;
> +	 *      reg = <0x70 0x70 0x7c>
> +	 *      bit-mask = <0x1>;
> +	 *      bit-shift = <6>;
> +	 *      label = "lpc-sio-decode-disable";
> +	 * };
> +	 *
> +	 * field@50.0 {
> +	 *	compatible = "bmc-misc-control";
> +	 *	read-only;
> +	 *	reg = <0x50>;
> +	 *	bit-mask = <0xffffffff>;
> +	 *	bit-shift = <0>;
> +	 *	label = "vga-scratch-1";
> +	 * };
> +	 */
> +	rc = of_property_read_u32(node, "mask", &ctrl->mask);
> +	if (rc < 0)
> +		return rc;
> +
> +	ctrl->shift = __ffs(ctrl->mask);
> +	ctrl->ro = of_property_read_bool(node, "read-only");
> +
> +	rc = of_property_read_string(node, "label", &ctrl->label);
> +	if (rc < 0)
> +		return rc;
> +
> +	ctrl->label_attr.attr.name = "label";
> +	ctrl->label_attr.attr.mode = 0444;
> +	ctrl->label_attr.show = bmc_misc_label_show;
> +	attrs[0] = &ctrl->label_attr.attr;

This works?  You normally have to manually initialize a dynamic
attribute.  Why are you doing it this way and not using an attribute
group?

> +	ctrl->mask_attr.attr.name = "mask";
> +	ctrl->mask_attr.attr.mode = 0444;
> +	ctrl->mask_attr.show = bmc_misc_mask_show;
> +	attrs[1] = &ctrl->mask_attr.attr;
> +
> +	if (of_property_read_bool(node, "set-clear"))
> +		return bmc_misc_init_sc(ctrl, node, attrs);
> +
> +	return bmc_misc_init_rmw(ctrl, node, attrs);
> +}
> +
> +static struct class bmc_class = {
> +	.name =		"bmc",
> +};

Why are you using a custom device class for a single device?

you need to document the heck out of this in the changelog to help
explain all of these odd design decisions.

thanks,

greg k-h
