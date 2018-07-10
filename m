Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9F6208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9F6208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeGJGgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:36:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeGJGgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:36:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62971CC9;
        Tue, 10 Jul 2018 06:36:51 +0000 (UTC)
Date:   Tue, 10 Jul 2018 08:36:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 1/7] mhi_bus: core: initial checkin for modem host
 interface bus driver
Message-ID: <20180710063648.GC892@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:08PM -0700, Sujeev Dias wrote:
> +void mhi_driver_unregister(struct mhi_driver *mhi_drv)
> +{
> +	driver_unregister(&mhi_drv->driver);
> +}
> +EXPORT_SYMBOL(mhi_driver_unregister);

As you are just "wrapping" a core symbol here, please use
EXPORT_SYMBOL_GPL().  Actually, you should do that for all of the
exports here in this new bus, right?


> +static int __init mhi_init(void)
> +{
> +	/* parent directory */
> +	debugfs_create_dir(mhi_bus_type.name, NULL);

What do you do with this debugfs directory that you never save the
dentry for?  It looks like you forgot to remove it when this module is
removed from the system :(

> +++ b/drivers/bus/mhi/core/mhi_main.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/mhi.h>
> +#include "mhi_internal.h"
> +
> +void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
> +		     struct db_cfg *db_cfg,
> +		     void __iomem *db_addr,
> +		     dma_addr_t wp)
> +{
> +}

<snip>

You have a lot of empty functions in this file, why?

> +/**
> + * struct mhi_controller - Master controller structure for external modem
> + * @dev: Device associated with this controller
> + * @of_node: DT that has MHI configuration information
> + * @regs: Points to base of MHI MMIO register space
> + * @dev_id: PCIe device id of the external device
> + * @domain: PCIe domain the device connected to
> + * @bus: PCIe bus the device assigned to
> + * @slot: PCIe slot for the modem

Why not just save a pointer to the pci device?  That way you don't have
to duplicate all of these things.

> + * @iova_start: IOMMU starting address for data
> + * @iova_stop: IOMMU stop address for data
> + * @fw_image: Firmware image name for normal booting
> + * @edl_image: Firmware image name for emergency download mode
> + * @fbc_download: MHI host needs to do complete image transfer
> + * @rddm_size: RAM dump size that host should allocate for debugging purpose
> + * @sbl_size: SBL image size
> + * @seg_len: BHIe vector size
> + * @fbc_image: Points to firmware image buffer
> + * @rddm_image: Points to RAM dump buffer
> + * @max_chan: Maximum number of channels controller support
> + * @mhi_chan: Points to channel configuration table
> + * @lpm_chans: List of channels that require LPM notifications
> + * @total_ev_rings: Total # of event rings allocated
> + * @hw_ev_rings: Number of hardware event rings
> + * @sw_ev_rings: Number of software event rings
> + * @msi_required: Number of msi required to operate
> + * @msi_allocated: Number of msi allocated by bus master
> + * @irq: base irq # to request
> + * @mhi_event: MHI event ring configurations table
> + * @mhi_cmd: MHI command ring configurations table
> + * @mhi_ctxt: MHI device context, shared memory between host and device
> + * @timeout_ms: Timeout in ms for state transitions
> + * @pm_state: Power management state
> + * @ee: MHI device execution environment
> + * @dev_state: MHI STATE
> + * @status_cb: CB function to notify various power states to but master
> + * @link_status: Query link status in case of abnormal value read from device
> + * @runtime_get: Async runtime resume function
> + * @runtimet_put: Release votes
> + * @time_get: Return host time in us
> + * @lpm_disable: Request controller to disable link level low power modes
> + * @lpm_enable: Controller may enable link level low power modes again
> + * @priv_data: Points to bus master's private data

You list a lot of the structure's fields here, but not all of them, why?

> + */
> +struct mhi_controller {
> +	struct list_head node;
> +	struct mhi_device *mhi_dev;
> +
> +	/* device node for iommu ops */
> +	struct device *dev;
> +	struct device_node *of_node;
> +
> +	/* mmio base */
> +	void __iomem *regs;
> +
> +	/* device topology */
> +	u32 dev_id;
> +	u32 domain;
> +	u32 bus;
> +	u32 slot;
> +
> +	/* addressing window */
> +	dma_addr_t iova_start;
> +	dma_addr_t iova_stop;
> +
> +	/* fw images */
> +	const char *fw_image;
> +	const char *edl_image;
> +
> +	/* mhi host manages downloading entire fbc images */
> +	bool fbc_download;
> +	size_t rddm_size;
> +	size_t sbl_size;
> +	size_t seg_len;
> +	u32 session_id;
> +	u32 sequence_id;
> +
> +	/* physical channel config data */
> +	u32 max_chan;
> +	struct mhi_chan *mhi_chan;
> +	struct list_head lpm_chans; /* these chan require lpm notification */
> +
> +	/* physical event config data */
> +	u32 total_ev_rings;
> +	u32 hw_ev_rings;
> +	u32 sw_ev_rings;
> +	u32 msi_required;
> +	u32 msi_allocated;
> +	int *irq; /* interrupt table */
> +	struct mhi_event *mhi_event;
> +
> +	/* cmd rings */
> +	struct mhi_cmd *mhi_cmd;
> +
> +	/* mhi context (shared with device) */
> +	struct mhi_ctxt *mhi_ctxt;
> +
> +	u32 timeout_ms;
> +
> +	/* caller should grab pm_mutex for suspend/resume operations */
> +	struct mutex pm_mutex;
> +	bool pre_init;
> +	rwlock_t pm_lock;
> +	u32 pm_state;
> +	u32 ee;
> +	u32 dev_state;
> +	bool wake_set;
> +	atomic_t dev_wake;
> +	atomic_t alloc_size;
> +	struct list_head transition_list;
> +	spinlock_t transition_lock;
> +	spinlock_t wlock;
> +
> +	/* debug counters */
> +	u32 M0, M2, M3;
> +
> +	/* worker for different state transitions */
> +	struct work_struct st_worker;
> +	struct work_struct fw_worker;
> +	struct work_struct syserr_worker;
> +	wait_queue_head_t state_event;
> +
> +	/* shadow functions */
> +	void (*status_cb)(struct mhi_controller *mhi_cntrl, void *priv,
> +			  enum MHI_CB cb);
> +	int (*link_status)(struct mhi_controller *mhi_cntrl, void *priv);
> +	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
> +	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
> +	int (*runtime_get)(struct mhi_controller *mhi_cntrl, void *priv);
> +	void (*runtime_put)(struct mhi_controller *mhi_cntrl, void *priv);
> +	void (*lpm_disable)(struct mhi_controller *mhi_cntrl, void *priv);
> +	void (*lpm_enable)(struct mhi_controller *mhi_cntrl, void *priv);
> +	int (*map_single)(struct mhi_controller *mhi_cntrl,
> +			  struct mhi_buf_info *buf);
> +	void (*unmap_single)(struct mhi_controller *mhi_cntrl,
> +			     struct mhi_buf_info *buf);
> +
> +	/* channel to control DTR messaging */
> +	struct mhi_device *dtr_dev;
> +
> +	/* bounce buffer settings */
> +	bool bounce_buf;
> +	size_t buffer_len;
> +
> +	/* controller specific data */
> +	void *priv_data;
> +	void *log_buf;
> +	struct dentry *dentry;
> +	struct dentry *parent;
> +};
> +
> +/**
> + * struct mhi_device - mhi device structure associated bind to channel
> + * @dev: Device associated with the channels
> + * @mtu: Maximum # of bytes controller support
> + * @ul_chan_id: MHI channel id for UL transfer
> + * @dl_chan_id: MHI channel id for DL transfer
> + * @tiocm: Device current terminal settings
> + * @priv: Driver private data
> + */
> +struct mhi_device {
> +	struct device dev;
> +	u32 dev_id;
> +	u32 domain;
> +	u32 bus;
> +	u32 slot;

Same comment as above, why duplicate this and just not save the pointer
to the pci device?

> +	size_t mtu;
> +	int ul_chan_id;
> +	int dl_chan_id;
> +	int ul_event_id;
> +	int dl_event_id;
> +	u32 tiocm;
> +	const struct mhi_device_id *id;
> +	const char *chan_name;
> +	struct mhi_controller *mhi_cntrl;
> +	struct mhi_chan *ul_chan;
> +	struct mhi_chan *dl_chan;
> +	atomic_t dev_wake;

What is dev_wake for?

> +	enum mhi_device_type dev_type;
> +	void *priv_data;

Why do you need priv_data?  What's wrong with using the space in struct
device instead?

> +	int (*ul_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
> +		       void *buf, size_t len, enum MHI_FLAGS flags);
> +	int (*dl_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
> +		       void *buf, size_t len, enum MHI_FLAGS flags);
> +	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB cb);

Why does a device have function call backs in it?  Shouldn't those
belong to a driver?

> +};
> +
> +/**
> + * struct mhi_result - Completed buffer information
> + * @buf_addr: Address of data buffer
> + * @dir: Channel direction
> + * @bytes_xfer: # of bytes transferred
> + * @transaction_status: Status of last trasnferred
> + */
> +struct mhi_result {
> +	void *buf_addr;
> +	enum dma_data_direction dir;
> +	size_t bytes_xferd;
> +	int transaction_status;
> +};
> +
> +/**
> + * struct mhi_driver - mhi driver information
> + * @id_table: NULL terminated channel ID names
> + * @ul_xfer_cb: UL data transfer callback
> + * @dl_xfer_cb: DL data transfer callback
> + * @status_cb: Asynchronous status callback
> + */
> +struct mhi_driver {
> +	const struct mhi_device_id *id_table;
> +	int (*probe)(struct mhi_device *mhi_dev,
> +		     const struct mhi_device_id *id);
> +	void (*remove)(struct mhi_device *mhi_dev);
> +	void (*ul_xfer_cb)(struct mhi_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*dl_xfer_cb)(struct mhi_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB mhi_cb);

See, they are here in a driver!

> +static inline void mhi_device_set_devdata(struct mhi_device *mhi_dev,
> +					  void *priv)
> +{
> +	mhi_dev->priv_data = priv;

Again, what's wrong with the device's private data pointer?

thanks,

greg k-h
