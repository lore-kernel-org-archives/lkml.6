Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A251BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F5D2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfBEMF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:05:56 -0500
Received: from sauhun.de ([88.99.104.3]:56702 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfBEMFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:05:55 -0500
Received: from localhost (unknown [46.183.103.8])
        by pokefinder.org (Postfix) with ESMTPSA id 938B42C0509;
        Tue,  5 Feb 2019 13:05:46 +0100 (CET)
Date:   Tue, 5 Feb 2019 13:05:45 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Elie Morisse <syniurge@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, helgaas@kernel.org
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <20190205120545.GA1045@kunai>
References: <20181226232258.GA23526@syn-yoga530>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20181226232258.GA23526@syn-yoga530>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for keeping at this driver! And sorry for the long delay, but large
drivers take time. I also have to admit that I am very unfamiliar with PCI
devices.

Here is what my code checkers say. Please check those:

    SPARSE
drivers/i2c/busses/i2c-amd-mp2.h:86:43: error: dubious one-bit signed bitfield
drivers/i2c/busses/i2c-amd-mp2.h:129:43: error: dubious one-bit signed bitfield
    CPPCHECK
drivers/i2c/busses/i2c-amd-mp2-pci.c:25:25: warning: 'mmio' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
 writel(val >> 32, mmio + sizeof(u32));
                        ^
drivers/i2c/busses/i2c-amd-mp2-pci.c:33:20: warning: 'mmio' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
 high = readl(mmio + sizeof(u32));
                   ^
drivers/i2c/busses/i2c-amd-mp2-pci.c:28:0: warning: The function 'read64' is never used. [unusedFunction]
static inline u64 read64(void __iomem *mmio)


> +Description
> +-----------
> +
> +The MP2 is an ARM processor programmed as an I2C controller and communicating
> +with the x86 host through PCI.
> +
> +If you see something like this:
> +
> +03:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD] Device
> +									15e6
> +
> +in your 'lspci -v', then this driver is for your device.

Sidenote: Can't we add something to the pci-ids to make it possible to
identify it correctly/make it more readable to the user?

> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD MP2 PCIe communication driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include "i2c-amd-mp2.h"
> +
> +#define DRIVER_NAME	"i2c_amd_mp2"
> +#define DRIVER_DESC	"AMD(R) PCI-E MP2 I2C Controller Driver"
> +#define DRIVER_VER	"1.0"

Because of other changes I suggest later, some uses of these macros get
removed. And I think the remaining uses can just be hardcoded to make it
more readable. DRIVER_VER can go entirely, we don't use it anymore.

> +static inline void write64(u64 val, void __iomem *mmio)
> +{
> +	writel(val, mmio);
> +	writel(val >> 32, mmio + sizeof(u32));
> +}

Can't you use writeq?

> +
> +static inline u64 read64(void __iomem *mmio)
> +{
> +	u64 low, high;
> +
> +	low = readl(mmio);
> +	high = readl(mmio + sizeof(u32));
> +	return low | (high << 32);
> +}

Unused.

> +
> +static void amd_mp2_c2p_mutex_lock(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	/* there is only one data mailbox for two i2c adapters */
> +	mutex_lock(&privdata->c2p_lock);
> +	privdata->c2p_lock_busid = i2c_common->bus_id;
> +}
> +
> +static void amd_mp2_c2p_mutex_unlock(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	if (unlikely(privdata->c2p_lock_busid != i2c_common->bus_id)) {
> +		dev_warn(ndev_dev(privdata),
> +			 "bus %d attempting to unlock C2P locked by bus %d\n",
> +			 i2c_common->bus_id, privdata->c2p_lock_busid);
> +		return;
> +	}
> +
> +	mutex_unlock(&privdata->c2p_lock);
> +}
> +
> +static int amd_mp2_cmd(struct amd_i2c_common *i2c_common,
> +		       union i2c_cmd_base i2c_cmd_base)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +	void __iomem *reg;
> +
> +	i2c_common->reqcmd = i2c_cmd_base.s.i2c_cmd;
> +
> +	reg = privdata->mmio + ((i2c_cmd_base.s.bus_id == 1) ?
> +				AMD_C2P_MSG1 : AMD_C2P_MSG0);
> +	writel(i2c_cmd_base.ul, reg);
> +
> +	return 0;
> +}
> +
> +int amd_mp2_bus_enable_set(struct amd_i2c_common *i2c_common, bool enable)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +	union i2c_cmd_base i2c_cmd_base;
> +
> +	dev_dbg(ndev_dev(privdata), "%s id: %d\n", __func__,
> +		i2c_common->bus_id);
> +
> +	i2c_cmd_base.ul = 0;
> +	i2c_cmd_base.s.i2c_cmd = enable ? i2c_enable : i2c_disable;
> +	i2c_cmd_base.s.bus_id = i2c_common->bus_id;
> +	i2c_cmd_base.s.i2c_speed = i2c_common->i2c_speed;
> +
> +	amd_mp2_c2p_mutex_lock(i2c_common);
> +
> +	return amd_mp2_cmd(i2c_common, i2c_cmd_base);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_bus_enable_set);
> +
> +static void amd_mp2_cmd_rw_fill(struct amd_i2c_common *i2c_common,
> +				union i2c_cmd_base *i2c_cmd_base,
> +				enum i2c_cmd reqcmd)
> +{
> +	i2c_cmd_base->s.i2c_cmd = reqcmd;
> +	i2c_cmd_base->s.bus_id = i2c_common->bus_id;
> +	i2c_cmd_base->s.i2c_speed = i2c_common->i2c_speed;
> +	i2c_cmd_base->s.slave_addr = i2c_common->msg->addr;
> +	i2c_cmd_base->s.length = i2c_common->msg->len;
> +}
> +
> +static int amd_mp2_rw(struct amd_i2c_common *i2c_common, enum i2c_cmd reqcmd)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +	union i2c_cmd_base i2c_cmd_base;
> +
> +	amd_mp2_cmd_rw_fill(i2c_common, &i2c_cmd_base, reqcmd);
> +	amd_mp2_c2p_mutex_lock(i2c_common);
> +
> +	if (i2c_common->msg->len <= 32) {
> +		i2c_cmd_base.s.mem_type = use_c2pmsg;
> +		if (reqcmd == i2c_write)
> +			memcpy_toio(privdata->mmio + AMD_C2P_MSG2,
> +				    i2c_common->msg->buf,
> +				    i2c_common->msg->len);
> +	} else {
> +		i2c_cmd_base.s.mem_type = use_dram;
> +		write64((u64)i2c_common->dma_addr,
> +			privdata->mmio + AMD_C2P_MSG2);
> +	}
> +
> +	return amd_mp2_cmd(i2c_common, i2c_cmd_base);
> +}
> +
> +int amd_mp2_read(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> +		i2c_common->msg->addr, i2c_common->bus_id);
> +
> +	return amd_mp2_rw(i2c_common, i2c_read);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_read);
> +
> +int amd_mp2_write(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> +		i2c_common->msg->addr, i2c_common->bus_id);
> +
> +	return amd_mp2_rw(i2c_common, i2c_write);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_write);

I am not strict about it: but what about dropping the dev_dbg and only
export amd_mp2_rw()? The I2C core has alerady debug to print which
adapter accesses which client.

> +
> +static void amd_mp2_pci_check_rw_event(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +	int len = i2c_common->eventval.r.length;
> +	u32 slave_addr = i2c_common->eventval.r.slave_addr;
> +	bool err = false;
> +
> +	if (unlikely(len != i2c_common->msg->len)) {
> +		dev_err(ndev_dev(privdata),
> +			"length %d in event doesn't match buffer length %d!\n",
> +			len, i2c_common->msg->len);
> +		err = true;
> +	}
> +
> +	if (unlikely(slave_addr != i2c_common->msg->addr)) {
> +		dev_err(ndev_dev(privdata),
> +			"unexpected slave address %x (expected: %x)!\n",
> +			slave_addr, i2c_common->msg->addr);
> +		err = true;
> +	}
> +
> +	if (!err)
> +		i2c_common->cmd_success = true;
> +}
> +
> +static void __amd_mp2_process_event(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +	enum status_type sts = i2c_common->eventval.r.status;
> +	enum response_type res = i2c_common->eventval.r.response;
> +	int len = i2c_common->eventval.r.length;
> +
> +	if (res != command_success) {
> +		if (res == command_failed)
> +			dev_err(ndev_dev(privdata), "i2c command failed!\n");
> +		else
> +			dev_err(ndev_dev(privdata), "invalid response to i2c command!\n");
> +		return;
> +	}
> +
> +	switch (i2c_common->reqcmd) {
> +	case i2c_read:
> +		if (sts == i2c_readcomplete_event) {
> +			amd_mp2_pci_check_rw_event(i2c_common);
> +			if (len <= 32)
> +				memcpy_fromio(i2c_common->msg->buf,
> +					      privdata->mmio + AMD_C2P_MSG2,
> +					      i2c_common->msg->len);
> +		} else if (sts == i2c_readfail_event) {
> +			dev_err(ndev_dev(privdata), "i2c read failed!\n");
> +		} else {
> +			dev_err(ndev_dev(privdata),
> +				"invalid i2c status after read (%d)!\n", sts);
> +		}
> +		break;
> +	case i2c_write:
> +		if (sts == i2c_writecomplete_event)
> +			amd_mp2_pci_check_rw_event(i2c_common);
> +		else if (sts == i2c_writefail_event)
> +			dev_err(ndev_dev(privdata), "i2c write failed!\n");
> +		else
> +			dev_err(ndev_dev(privdata),
> +				"invalid i2c status after write (%d)!\n", sts);
> +		break;
> +	case i2c_enable:
> +		if (sts == i2c_busenable_failed)
> +			dev_err(ndev_dev(privdata), "i2c bus enable failed!\n");
> +		else if (sts != i2c_busenable_complete)
> +			dev_err(ndev_dev(privdata),
> +				"invalid i2c status after bus enable (%d)!\n",
> +				sts);
> +		else
> +			i2c_common->cmd_success = true;
> +		break;
> +	case i2c_disable:
> +		if (sts == i2c_busdisable_failed)
> +			dev_err(ndev_dev(privdata), "i2c bus disable failed!\n");
> +		else if (sts != i2c_busdisable_complete)
> +			dev_err(ndev_dev(privdata),
> +				"invalid i2c status after bus disable (%d)!\n",
> +				sts);
> +		else
> +			i2c_common->cmd_success = true;
> +		break;
> +	default:
> +		break;
> +	}
> +}

In general, I have the feeling that there are too many dev_err. I2C read/writes
can fail if the client is busy. This should be reported with an ERRNO to the
upper layers so they can decide to resend or not. But no need to inform the
user about it. Please review these and include only the necessary ones. You can
check other I2C drivers for an inspiration.

> +
> +void amd_mp2_process_event(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	if (unlikely(i2c_common->reqcmd == i2c_none)) {
> +		dev_warn(ndev_dev(privdata),
> +			 "received msg but no cmd was sent (bus = %d)!\n",
> +			 i2c_common->bus_id);
> +		return;
> +	}
> +
> +	__amd_mp2_process_event(i2c_common);
> +
> +	i2c_common->reqcmd = i2c_none;
> +	amd_mp2_c2p_mutex_unlock(i2c_common);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_process_event);
> +
> +static irqreturn_t amd_mp2_irq_isr(int irq, void *dev)
> +{
> +	struct amd_mp2_dev *privdata = dev;
> +	struct amd_i2c_common *i2c_common;
> +	u32 val;
> +	unsigned int bus_id;
> +	void __iomem *reg;
> +	enum irqreturn ret = IRQ_NONE;
> +
> +	for (bus_id = 0; bus_id < 2; bus_id++) {
> +		i2c_common = privdata->busses[bus_id];
> +		if (!i2c_common)
> +			continue;
> +
> +		reg = privdata->mmio + ((bus_id == 0) ?
> +					AMD_P2C_MSG1 : AMD_P2C_MSG2);
> +		val = readl(reg);
> +		if (val != 0) {
> +			writel(0, reg);
> +			writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +			i2c_common->eventval.ul = val;
> +			i2c_common->cmd_completion(i2c_common);
> +
> +			ret = IRQ_HANDLED;
> +		}
> +	}
> +
> +	if (ret != IRQ_HANDLED) {
> +		val = readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> +		if (unlikely(val != 0)) {
> +			writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +			dev_warn(ndev_dev(privdata),
> +				 "received irq without message\n");
> +			ret = IRQ_HANDLED;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +void amd_mp2_rw_timeout(struct amd_i2c_common *i2c_common)
> +{
> +	i2c_common->reqcmd = i2c_none;
> +	amd_mp2_c2p_mutex_unlock(i2c_common);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_rw_timeout);
> +
> +int amd_mp2_register_cb(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	if (i2c_common->bus_id > 1)
> +		return -EINVAL;
> +
> +	if (privdata->busses[i2c_common->bus_id]) {
> +		dev_err(ndev_dev(privdata),
> +			"Bus %d already taken!\n", i2c_common->bus_id);
> +		return -EINVAL;
> +	}
> +
> +	privdata->busses[i2c_common->bus_id] = i2c_common;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_register_cb);
> +
> +int amd_mp2_unregister_cb(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_mp2_dev *privdata = i2c_common->mp2_dev;
> +
> +	privdata->busses[i2c_common->bus_id] = NULL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_unregister_cb);
> +
> +#ifdef CONFIG_DEBUG_FS
> +static const struct file_operations amd_mp2_debugfs_info;
> +static struct dentry *debugfs_root_dir;
> +
> +static ssize_t amd_mp2_debugfs_read(struct file *filp, char __user *ubuf,
> +				    size_t count, loff_t *offp)
> +{
> +	struct amd_mp2_dev *privdata = filp->private_data;
> +	size_t buf_size = min_t(size_t, count, 0x800);
> +	u8 *buf;
> +	ssize_t ret, off = 0;
> +	u32 v32;
> +	int i;
> +
> +	buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "MP2 Device Information:\n"
> +			 "========================\n"
> +			 "\tMP2 C2P Message Register Dump:\n\n");
> +
> +	for (i = 0; i < 10; i++) {
> +		v32 = readl(privdata->mmio + AMD_C2P_MSG0 + i * 4);
> +		off += scnprintf(buf + off, buf_size - off,
> +				 "AMD_C2P_MSG%d -\t\t\t%#06x\n", i, v32);
> +	}
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			"\n\tMP2 P2C Message Register Dump:\n\n");
> +
> +	for (i = 0; i < 3; i++) {
> +		v32 = readl(privdata->mmio + AMD_P2C_MSG1 + i * 4);
> +		off += scnprintf(buf + off, buf_size - off,
> +				 "AMD_P2C_MSG%d -\t\t\t%#06x\n", i + 1, v32);
> +	}
> +
> +	v32 = readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_P2C_MSG_INTEN -\t\t%#06x\n", v32);
> +
> +	v32 = readl(privdata->mmio + AMD_P2C_MSG_INTSTS);
> +	off += scnprintf(buf + off, buf_size - off,
> +			"AMD_P2C_MSG_INTSTS -\t\t%#06x\n", v32);
> +
> +	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static const struct file_operations amd_mp2_debugfs_info = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = amd_mp2_debugfs_read,
> +};
> +
> +static void amd_mp2_init_debugfs(struct amd_mp2_dev *privdata)
> +{
> +	if (!debugfs_root_dir)
> +		return;
> +
> +	privdata->debugfs_dir = debugfs_create_dir(ndev_name(privdata),
> +						   debugfs_root_dir);
> +	if (!privdata->debugfs_dir) {
> +		privdata->debugfs_info = NULL;
> +	} else {
> +		privdata->debugfs_info = debugfs_create_file
> +			("info", 0400, privdata->debugfs_dir,
> +			 privdata, &amd_mp2_debugfs_info);
> +	}
> +}
> +#endif /* CONFIG_DEBUG_FS */

Please remove this debugfs interface. There must be generic ways to read out
PCI memory?

> +static void amd_mp2_clear_reg(struct amd_mp2_dev *privdata)
> +{
> +	int reg;
> +
> +	for (reg = AMD_C2P_MSG0; reg <= AMD_C2P_MSG9; reg += 4)
> +		writel(0, privdata->mmio + reg);
> +
> +	for (reg = AMD_P2C_MSG1; reg <= AMD_P2C_MSG2; reg += 4)
> +		writel(0, privdata->mmio + reg);
> +}
> +
> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata,
> +			    struct pci_dev *pci_dev)
> +{
> +	int rc;
> +
> +	pci_set_drvdata(pci_dev, privdata);
> +
> +	rc = pcim_enable_device(pci_dev);
> +	if (rc) {
> +		dev_err(ndev_dev(privdata), "Failed to enable MP2 PCI device\n");
> +		goto err_pci_enable;
> +	}
> +
> +	rc = pcim_iomap_regions(pci_dev, 1 << 2, pci_name(pci_dev));
> +	if (rc) {
> +		dev_err(ndev_dev(privdata), "I/O memory remapping failed\n");
> +		goto err_pci_enable;
> +	}
> +	privdata->mmio = pcim_iomap_table(pci_dev)[2];
> +
> +	pci_set_master(pci_dev);
> +
> +	rc = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64));
> +	if (rc) {
> +		rc = pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
> +		if (rc)
> +			goto err_dma_mask;
> +	}
> +
> +	/* Set up intx irq */
> +	writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +	pci_intx(pci_dev, 1);
> +	rc = devm_request_irq(&pci_dev->dev, pci_dev->irq, amd_mp2_irq_isr,
> +			      IRQF_SHARED, dev_name(&pci_dev->dev), privdata);
> +	if (rc)
> +		dev_err(&pci_dev->dev, "Failure requesting irq %i: %d\n",
> +			pci_dev->irq, rc);
> +
> +	return rc;
> +
> +err_dma_mask:
> +	pci_clear_master(pci_dev);
> +err_pci_enable:
> +	pci_set_drvdata(pci_dev, NULL);
> +	return rc;
> +}
> +
> +static int amd_mp2_pci_probe(struct pci_dev *pci_dev,
> +			     const struct pci_device_id *id)
> +{
> +	struct amd_mp2_dev *privdata;
> +	int rc;
> +	static bool first_probe = true;
> +
> +	if (first_probe) {
> +		pr_info("%s: %s Version: %s\n", DRIVER_NAME,
> +			DRIVER_DESC, DRIVER_VER);
> +		first_probe = false;
> +	}
> +
> +	dev_info(&pci_dev->dev, "MP2 device found [%04x:%04x] (rev %x)\n",
> +		 pci_dev->vendor, pci_dev->device, pci_dev->revision);
> +

The kernel prints already too much during boot. So, please remove this.
It will also get rid of the static variable which is not so good style.

> +	privdata = devm_kzalloc(&pci_dev->dev, sizeof(*privdata), GFP_KERNEL);
> +	if (!privdata)
> +		return -ENOMEM;
> +
> +	rc = amd_mp2_pci_init(privdata, pci_dev);
> +	if (rc)
> +		return rc;
> +
> +	mutex_init(&privdata->c2p_lock);
> +	privdata->pci_dev = pci_dev;
> +
> +	pm_runtime_set_autosuspend_delay(&pci_dev->dev, 1000);
> +	pm_runtime_use_autosuspend(&pci_dev->dev);
> +	pm_runtime_put_autosuspend(&pci_dev->dev);
> +	pm_runtime_allow(&pci_dev->dev);
> +
> +	amd_mp2_init_debugfs(privdata);
> +	dev_info(&pci_dev->dev, "MP2 device registered.\n");
> +	return 0;
> +}
> +
> +static bool amd_mp2_pci_is_probed(struct pci_dev *pci_dev)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +
> +	if (!privdata)
> +		return false;
> +	return privdata->pci_dev != NULL;
> +}
> +
> +static void amd_mp2_pci_remove(struct pci_dev *pci_dev)
> +{
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +
> +	pm_runtime_forbid(&pci_dev->dev);
> +	pm_runtime_get_noresume(&pci_dev->dev);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove_recursive(privdata->debugfs_dir);
> +#endif /* CONFIG_DEBUG_FS */
> +
> +	pci_intx(pci_dev, 0);
> +	pci_clear_master(pci_dev);
> +
> +	amd_mp2_clear_reg(privdata);
> +}
> +
> +#ifdef CONFIG_PM
> +static int amd_mp2_pci_suspend(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +	struct amd_i2c_common *i2c_common;
> +	unsigned int bus_id;
> +	int ret = 0;
> +
> +	for (bus_id = 0; bus_id < 2; bus_id++) {
> +		i2c_common = privdata->busses[bus_id];
> +		if (i2c_common)
> +			i2c_common->suspend(i2c_common);
> +	}
> +
> +	ret = pci_save_state(pci_dev);
> +	if (ret) {
> +		dev_err(ndev_dev(privdata),
> +			"pci_save_state failed = %d\n", ret);
> +		return ret;
> +	}
> +
> +	pci_disable_device(pci_dev);
> +	return ret;
> +}
> +
> +static int amd_mp2_pci_resume(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
> +	struct amd_i2c_common *i2c_common;
> +	unsigned int bus_id;
> +	int ret = 0;
> +
> +	pci_restore_state(pci_dev);
> +	ret = pci_enable_device(pci_dev);
> +	if (ret < 0) {
> +		dev_err(ndev_dev(privdata),
> +			"pci_enable_device failed = %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (bus_id = 0; bus_id < 2; bus_id++) {
> +		i2c_common = privdata->busses[bus_id];
> +		if (i2c_common) {
> +			ret = i2c_common->resume(i2c_common);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(amd_mp2_pci_pm_ops, amd_mp2_pci_suspend,
> +			    amd_mp2_pci_resume, NULL);
> +#endif /* CONFIG_PM */
> +
> +static const struct pci_device_id amd_mp2_pci_tbl[] = {
> +	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> +
> +static struct pci_driver amd_mp2_pci_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= amd_mp2_pci_tbl,
> +	.probe		= amd_mp2_pci_probe,
> +	.remove		= amd_mp2_pci_remove,
> +#ifdef CONFIG_PM
> +	.driver = {
> +		.pm	= &amd_mp2_pci_pm_ops,
> +	},
> +#endif
> +};
> +
> +static int amd_mp2_device_match(struct device *dev, void *data)
> +{
> +	return 1;
> +}
> +
> +struct amd_mp2_dev *amd_mp2_find_device(void)
> +{
> +	struct device *dev;
> +	struct pci_dev *pci_dev;
> +
> +	dev = driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL,
> +				 amd_mp2_device_match);
> +	if (!dev)
> +		return NULL;
> +
> +	pci_dev = to_pci_dev(dev);
> +	if (!amd_mp2_pci_is_probed(pci_dev))
> +		return NULL;
> +	return (struct amd_mp2_dev *)pci_get_drvdata(pci_dev);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_find_device);

Can't you just share a common flag when the PCI driver is successfully
probed and let the platform driver defer until this flag is set?

Reading this, I also don't think there should be two seperate Kconfig
and Makefile entries. You need both to have working I2C, so one Kconfig
entry should compile both files.

> +
> +static int __init amd_mp2_drv_init(void)
> +{
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +#endif /* CONFIG_DEBUG_FS */
> +
> +	return pci_register_driver(&amd_mp2_pci_driver);
> +}
> +module_init(amd_mp2_drv_init);
> +
> +static void __exit amd_mp2_drv_exit(void)
> +{
> +	pci_unregister_driver(&amd_mp2_pci_driver);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove_recursive(debugfs_root_dir);
> +#endif /* CONFIG_DEBUG_FS */
> +}
> +module_exit(amd_mp2_drv_exit);

Without debugfs stuff, you could probably use module_pci_driver.

> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_VERSION(DRIVER_VER);
> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> +MODULE_AUTHOR("Elie Morisse <syniurge@gmail.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
> new file mode 100644
> index 000000000000..06cf2b6658e5
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD MP2 platform driver
> + *
> + * Setup the I2C adapters enumerated in the ACPI namespace.
> + * MP2 controllers have 2 separate busses, up to 2 I2C adapters may be listed.
> + *
> + * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "i2c-amd-mp2.h"
> +
> +#define AMD_MP2_I2C_MAX_RW_LENGTH ((1 << 12) - 1)
> +#define AMD_I2C_TIMEOUT (msecs_to_jiffies(250))
> +
> +/**
> + * struct amd_i2c_dev - MP2 bus/i2c adapter context
> + * @common: shared context with the MP2 PCI driver
> + * @pdev: platform driver node
> + * @adap: i2c adapter
> + * @cmd_complete: xfer completion object
> + */
> +struct amd_i2c_dev {
> +	struct amd_i2c_common common;
> +	struct platform_device *pdev;
> +	struct i2c_adapter adap;
> +	struct completion cmd_complete;
> +};
> +
> +#define amd_i2c_dev_common(__common) \
> +	container_of(__common, struct amd_i2c_dev, common)
> +
> +static int i2c_amd_dma_map(struct amd_i2c_common *i2c_common)
> +{
> +	struct device *dev_pci = &i2c_common->mp2_dev->pci_dev->dev;
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +	enum dma_data_direction dma_direction =
> +			i2c_common->msg->flags & I2C_M_RD ?
> +			DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +	i2c_common->dma_buf = i2c_get_dma_safe_msg_buf(i2c_common->msg, 0);
> +	i2c_common->dma_addr = dma_map_single(dev_pci, i2c_common->dma_buf,
> +					      i2c_common->msg->len,
> +					      dma_direction);
> +
> +	if (unlikely(dma_mapping_error(dev_pci, i2c_common->dma_addr))) {
> +		dev_err(&i2c_dev->pdev->dev,
> +			"Error while mapping dma buffer %p\n",
> +			i2c_common->dma_buf);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

There is too much unlikely() in these drivers. It is suggested to use it
only carefully in selected hot paths, these days.

> +
> +static void i2c_amd_dma_unmap(struct amd_i2c_common *i2c_common)
> +{
> +	struct device *dev_pci = &i2c_common->mp2_dev->pci_dev->dev;
> +	enum dma_data_direction dma_direction =
> +			i2c_common->msg->flags & I2C_M_RD ?
> +			DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +	dma_unmap_single(dev_pci, i2c_common->dma_addr,
> +			 i2c_common->msg->len, dma_direction);
> +
> +	i2c_put_dma_safe_msg_buf(i2c_common->dma_buf, i2c_common->msg, true);
> +}
> +
> +static const char *i2c_amd_cmd_name(enum i2c_cmd cmd)
> +{
> +	switch (cmd) {
> +	case i2c_read:
> +		return "i2c read";
> +	case i2c_write:
> +		return "i2c write";
> +	case i2c_enable:
> +		return "bus enable";
> +	case i2c_disable:
> +		return "bus disable";
> +	case number_of_sensor_discovered:
> +		return "'number of sensors discovered' cmd";
> +	case is_mp2_active:
> +		return "'is mp2 active' cmd";
> +	default:
> +		return "invalid cmd";
> +	}
> +}
> +
> +static void i2c_amd_start_cmd(struct amd_i2c_dev *i2c_dev)
> +{
> +	struct amd_i2c_common *i2c_common = &i2c_dev->common;
> +
> +	reinit_completion(&i2c_dev->cmd_complete);
> +	i2c_common->cmd_success = false;
> +}
> +
> +static void i2c_amd_cmd_completion(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +	union i2c_event *event = &i2c_common->eventval;
> +
> +	if (event->r.status == i2c_readcomplete_event)
> +		dev_dbg(&i2c_dev->pdev->dev, "%s readdata:%*ph\n",
> +			__func__, event->r.length,
> +			i2c_common->msg->buf);
> +
> +	complete(&i2c_dev->cmd_complete);
> +}
> +
> +static int i2c_amd_check_cmd_completion(struct amd_i2c_dev *i2c_dev)
> +{
> +	struct amd_i2c_common *i2c_common = &i2c_dev->common;
> +	unsigned long timeout;
> +
> +	timeout = wait_for_completion_timeout(&i2c_dev->cmd_complete,
> +					      i2c_dev->adap.timeout);
> +	if (unlikely(timeout == 0)) {
> +		dev_err(&i2c_dev->pdev->dev, "%s timed out\n",
> +			i2c_amd_cmd_name(i2c_common->reqcmd));
> +		amd_mp2_rw_timeout(i2c_common);
> +	}

Again, timeouts can happen in I2C, so no need to inform the user.

> +
> +	if ((i2c_common->reqcmd == i2c_read ||
> +	     i2c_common->reqcmd == i2c_write) &&
> +	    i2c_common->msg->len > 32)
> +		i2c_amd_dma_unmap(i2c_common);
> +
> +	if (unlikely(timeout == 0))
> +		return -ETIMEDOUT;
> +
> +	amd_mp2_process_event(i2c_common);
> +
> +	if (!i2c_common->cmd_success)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int i2c_amd_enable_set(struct amd_i2c_dev *i2c_dev, bool enable)
> +{
> +	struct amd_i2c_common *i2c_common = &i2c_dev->common;
> +
> +	i2c_amd_start_cmd(i2c_dev);
> +	amd_mp2_bus_enable_set(i2c_common, enable);
> +
> +	return i2c_amd_check_cmd_completion(i2c_dev);
> +}
> +
> +static int i2c_amd_xfer_msg(struct amd_i2c_dev *i2c_dev, struct i2c_msg *pmsg)
> +{
> +	struct amd_i2c_common *i2c_common = &i2c_dev->common;
> +
> +	i2c_amd_start_cmd(i2c_dev);
> +	i2c_common->msg = pmsg;
> +
> +	if (pmsg->len > 32)
> +		if (i2c_amd_dma_map(i2c_common))
> +			return -EIO;
> +
> +	if (pmsg->flags & I2C_M_RD)
> +		amd_mp2_read(i2c_common);
> +	else
> +		amd_mp2_write(i2c_common);
> +
> +	return i2c_amd_check_cmd_completion(i2c_dev);
> +}
> +
> +static int i2c_amd_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct amd_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> +	int i;
> +	struct i2c_msg *pmsg;
> +	int err;
> +
> +	/* the adapter might have been deleted while waiting for the bus lock */
> +	if (unlikely(!i2c_dev->common.mp2_dev))
> +		return -EINVAL;
> +
> +	amd_mp2_pm_runtime_get(i2c_dev->common.mp2_dev);
> +
> +	for (i = 0; i < num; i++) {
> +		pmsg = &msgs[i];
> +		err = i2c_amd_xfer_msg(i2c_dev, pmsg);
> +		if (err)
> +			break;
> +	}
> +
> +	amd_mp2_pm_runtime_put(i2c_dev->common.mp2_dev);
> +	return err ? err : num;
> +}
> +
> +static u32 i2c_amd_func(struct i2c_adapter *a)
> +{
> +	return I2C_FUNC_I2C;
> +}

Why not emulated SMBUS?

> +
> +static const struct i2c_algorithm i2c_amd_algorithm = {
> +	.master_xfer = i2c_amd_xfer,
> +	.functionality = i2c_amd_func,
> +};
> +
> +#ifdef CONFIG_PM
> +static int i2c_amd_suspend(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +
> +	i2c_amd_enable_set(i2c_dev, false);
> +	return 0;
> +}
> +
> +static int i2c_amd_resume(struct amd_i2c_common *i2c_common)
> +{
> +	struct amd_i2c_dev *i2c_dev = amd_i2c_dev_common(i2c_common);
> +
> +	return i2c_amd_enable_set(i2c_dev, true);
> +}
> +#endif
> +
> +static enum speed_enum i2c_amd_get_bus_speed(struct platform_device *pdev)
> +{
> +	u32 acpi_speed;
> +	int i;
> +	static const u32 supported_speeds[] = {
> +		0, 100000, 400000, 1000000, 1400000, 3400000
> +	};
> +
> +	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> +	/* round down to the lowest standard speed */
> +	for (i = 1; i < ARRAY_SIZE(supported_speeds); i++) {
> +		if (acpi_speed < supported_speeds[i])
> +			break;
> +	}
> +	acpi_speed = supported_speeds[i - 1];
> +
> +	switch (acpi_speed) {
> +	case 100000:
> +		return speed100k;
> +	case 400000:
> +		return speed400k;
> +	case 1000000:
> +		return speed1000k;
> +	case 1400000:
> +		return speed1400k;
> +	case 3400000:
> +		return speed3400k;
> +	default:
> +		return speed400k;
> +	}
> +}
> +
> +static const struct i2c_adapter_quirks amd_i2c_dev_quirks = {
> +	.max_read_len = AMD_MP2_I2C_MAX_RW_LENGTH,
> +	.max_write_len = AMD_MP2_I2C_MAX_RW_LENGTH,
> +};
> +
> +static int i2c_amd_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct amd_i2c_dev *i2c_dev;
> +	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +	struct acpi_device *adev;
> +	struct amd_mp2_dev *mp2_dev;
> +	const char *uid;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return -ENODEV;
> +
> +	/* The ACPI namespace doesn't contain information about which MP2 PCI
> +	 * device an AMDI0011 ACPI device is related to, so assume that there's
> +	 * only one MP2 PCI device per system.
> +	 */
> +	mp2_dev = amd_mp2_find_device();
> +	if (!mp2_dev)
> +		/* The MP2 PCI device might get probed later */
> +		return -EPROBE_DEFER;
> +
> +	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev)
> +		return -ENOMEM;
> +
> +	i2c_dev->common.mp2_dev = mp2_dev;
> +	i2c_dev->pdev = pdev;
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	i2c_dev->common.cmd_completion = &i2c_amd_cmd_completion;
> +#ifdef CONFIG_PM
> +	i2c_dev->common.suspend = &i2c_amd_suspend;
> +	i2c_dev->common.resume = &i2c_amd_resume;
> +#endif
> +
> +	uid = adev->pnp.unique_id;
> +	if (!uid) {
> +		dev_err(&pdev->dev, "missing UID/bus id!\n");
> +		return -EINVAL;
> +	} else if (strcmp(uid, "0") == 0) {
> +		i2c_dev->common.bus_id = 0;
> +	} else if (strcmp(uid, "1") == 0) {
> +		i2c_dev->common.bus_id = 1;
> +	} else {
> +		dev_err(&pdev->dev, "incorrect UID/bus id \"%s\"!\n", uid);
> +		return -EINVAL;
> +	}
> +	dev_dbg(&pdev->dev, "bus id is %u\n", i2c_dev->common.bus_id);
> +
> +	/* Register the adapter */
> +	amd_mp2_pm_runtime_get(mp2_dev);
> +
> +	i2c_dev->common.reqcmd = i2c_none;
> +	if (amd_mp2_register_cb(&i2c_dev->common))
> +		return -EINVAL;
> +	device_link_add(&i2c_dev->pdev->dev, &mp2_dev->pci_dev->dev,
> +			DL_FLAG_AUTOREMOVE_CONSUMER);
> +
> +	i2c_dev->common.i2c_speed = i2c_amd_get_bus_speed(pdev);
> +
> +	/* Setup i2c adapter description */
> +	i2c_dev->adap.owner = THIS_MODULE;
> +	i2c_dev->adap.algo = &i2c_amd_algorithm;
> +	i2c_dev->adap.quirks = &amd_i2c_dev_quirks;
> +	i2c_dev->adap.dev.parent = &pdev->dev;
> +	i2c_dev->adap.algo_data = i2c_dev;
> +	i2c_dev->adap.nr = pdev->id;
> +	i2c_dev->adap.timeout = AMD_I2C_TIMEOUT;
> +	ACPI_COMPANION_SET(&i2c_dev->adap.dev, ACPI_COMPANION(&pdev->dev));
> +	i2c_dev->adap.dev.of_node = pdev->dev.of_node;
> +	snprintf(i2c_dev->adap.name, sizeof(i2c_dev->adap.name),
> +		 "AMD MP2 i2c bus %u", i2c_dev->common.bus_id);
> +	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
> +
> +	init_completion(&i2c_dev->cmd_complete);
> +
> +	/* Enable the bus */
> +	if (i2c_amd_enable_set(i2c_dev, true))
> +		dev_err(&pdev->dev, "initial bus enable failed\n");
> +
> +	/* Attach to the i2c layer */
> +	ret = i2c_add_numbered_adapter(&i2c_dev->adap);

I'd think i2c_add_adapter is much better here. This doesn't look like a
'fixed' embedded device, so the bus numbers you require might be taken
by e.g. a graphics card.

> +
> +	amd_mp2_pm_runtime_put(mp2_dev);
> +
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "i2c add adapter failed = %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int i2c_amd_remove(struct platform_device *pdev)
> +{
> +	struct amd_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> +	struct amd_i2c_common *i2c_common = &i2c_dev->common;
> +
> +	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> +
> +	i2c_amd_enable_set(i2c_dev, false);
> +	amd_mp2_unregister_cb(i2c_common);
> +	i2c_common->mp2_dev = NULL;
> +
> +	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> +
> +	i2c_del_adapter(&i2c_dev->adap);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id i2c_amd_acpi_match[] = {
> +	{ "AMDI0011" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, i2c_amd_acpi_match);
> +
> +static struct platform_driver i2c_amd_plat_driver = {
> +	.probe = i2c_amd_probe,
> +	.remove = i2c_amd_remove,
> +	.driver = {
> +		.name = "i2c_amd_mp2",
> +		.acpi_match_table = ACPI_PTR(i2c_amd_acpi_match),
> +	},
> +};
> +module_platform_driver(i2c_amd_plat_driver);
> +
> +MODULE_DESCRIPTION("AMD(R) MP2 I2C Platform Driver");
> +MODULE_VERSION("1.0");
> +MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
> +MODULE_AUTHOR("Elie Morisse <syniurge@gmail.com>");
> +MODULE_LICENSE("Dual BSD/GPL");

So much for now. I might have missed some things due to the complexity
here, but I think the review is good enough to get going.

Thanks again and regards,

   Wolfram


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZfBUACgkQFA3kzBSg
KbbvRA//WtmZQ5VBbieAOq/UhEZ7+CaerH/DmWvK6S4xAno+MAmiNg/FiSCiq735
iPAyiebgcVEqZe/abmIf2XeLIpC6ZtvvsZKI1I3O+qWquQXXLbqplbVVsfu+kHMN
KJ3dSNc7J6IPF66qdD3na6c1kTAbB3TEUuucAP60VlN/tULvDfiqDj4u+S54wiFw
D9PRvlsVvQ3kW/V/QWvTuJC4fI37n4Qo9AxhUpSFJa+mzwCIQbb+FC9klwQ2JAcc
LNkiU8DzhJJ2CCCFqij6gK1kUs5AiQQ2XOY2KnHp4VPxap1GOKwmpZv9EP2maSux
mhe1UC5PNMcxNxdiUY+mOQ9egp8/zojJ/oetDqqGp8M6oLpPyYubqnwBGC+mSxh+
FFpZBcCwlBM/D3OSmcYZ/xXh65s5Y5hIALqY0YN3GiGogE0Iyli2GftboJ2OuhUk
B49Ghilcqp5TGubv6oUA/vpmWxSzn2RmHsVLnwilVq+157MdlG/5/OQq4M1RS++H
5YJiNVhp0A2IxorTv1v0wgb0G9smdR27JgJ47jbQXo9JIKN7XtYJcit8RN0fHHSB
Y/ilwc6x9IKqebT3urE7O/d+799nON2sXUFy7qtFHJPwbeO5ZyTjGVlqTdle4Cbm
oUnmfkjIMQ6HaYNfgf1jBnfjO6ukVX4UpkdcZLFSov3fXY0qLyY=
=pHh2
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
