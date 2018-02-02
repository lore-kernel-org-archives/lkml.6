Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeBBCsL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:48:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbeBBCsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:48:02 -0500
Date: Fri, 2 Feb 2018 04:47:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, slp@redhat.com, bhe@redhat.com,
        somlo@cmu.edu, xiaolong.ye@intel.com
Subject: Re: [PATCH v11 2/4] fw_cfg: do DMA read operation
Message-ID: <20180202044433-mutt-send-email-mst@kernel.org>
References: <20180201130300.9962-1-marcandre.lureau@redhat.com>
 <20180201130300.9962-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180201130300.9962-3-marcandre.lureau@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:02:58PM +0100, Marc-André Lureau wrote:
> Modify fw_cfg_read_blob() to use DMA if the device supports it.
> Return errors, because the operation may fail.
> 
> The DMA operation is expected to run synchronously with today qemu,
> but the specification states that it may become async, so we run
> "control" field check in a loop for eventual changes.
> 
> We may want to switch all the *buf addresses to use only kmalloc'ed
> buffers (instead of using stack/image addresses with dma=false).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

This seems to cause no end of pain. I see no reason to keep
pushing this patch until it's all much more stable.

Something like the below would disable it temporarily.


commit 05054fca8b96900f6b54ab0056458f92b616d74c
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Fri Feb 2 04:29:59 2018 +0200

    fixup! fw_cfg: do DMA read operation

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index d86ad92..33e0256 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -41,6 +41,9 @@ MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
 MODULE_LICENSE("GPL");
 
+/* enable DMA for all accesses */
+#define FW_CFG_DMA_READ_ENABLE 0
+
 /* selector key values for "well-known" fw_cfg entries */
 #define FW_CFG_SIGNATURE  0x00
 #define FW_CFG_ID         0x01
@@ -171,7 +174,7 @@ static ssize_t fw_cfg_read_blob(struct device *dev, u16 key,
 	}
 
 	mutex_lock(&fw_cfg_dev_lock);
-	if (dma && fw_cfg_dma_enabled()) {
+	if (FW_CFG_DMA_READ_ENABLE && dma && fw_cfg_dma_enabled()) {
 		if (pos == 0) {
 			ret = fw_cfg_dma_transfer(dev, buf, count, key << 16
 						  | FW_CFG_DMA_CTL_SELECT
