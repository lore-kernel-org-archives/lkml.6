Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924942151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924942151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeHBQpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:45:31 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:4889 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732555AbeHBQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:45:31 -0400
Received: from localhost (varun.asicdesigners.com [10.193.191.126])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id w72Erfi7015319;
        Thu, 2 Aug 2018 07:53:42 -0700
Date:   Thu, 2 Aug 2018 20:23:41 +0530
From:   Varun Prakash <varun@chelsio.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: avoid null pointer dereference on
 card_fw allocation failure
Message-ID: <20180802145339.GA1671@chelsio.com>
References: <20180801161743.22301-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801161743.22301-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:17:43PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if card_fw fails to be allocated then a null pointer
> dereference occurs on card_fd when calling csio_hw_prep_fw. Fix this
> by checking for a failed allocation and returning -ENOMEM.
> 
> Detected by CoverityScan, CID#1271213 ("Dereference null return value")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/csiostor/csio_hw.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_hw.c b/drivers/scsi/csiostor/csio_hw.c
> index a10cf25ee7f9..aa637e9ea9ba 100644
> --- a/drivers/scsi/csiostor/csio_hw.c
> +++ b/drivers/scsi/csiostor/csio_hw.c
> @@ -2275,8 +2275,8 @@ static int csio_hw_prep_fw(struct csio_hw *hw, struct fw_info *fw_info,
>  }
>  
>  /*
> - * Returns -EINVAL if attempts to flash the firmware failed
> - * else returns 0,
> + * Returns -EINVAL if attempts to flash the firmware failed,
> + * -ENOMEM if allocation failed, else returns 0,
>   * if flashing was not attempted because the card had the
>   * latest firmware ECANCELED is returned
>   */
> @@ -2321,6 +2321,8 @@ csio_hw_flash_fw(struct csio_hw *hw, int *reset)
>  	 * card
>  	 */
>  	card_fw = kmalloc(sizeof(*card_fw), GFP_KERNEL);
> +	if (!card_fw)
> +		return -ENOMEM;
>  
>  	/* upgrade FW logic */
>  	ret = csio_hw_prep_fw(hw, fw_info, fw_data, fw_size, card_fw,

There is a call to release_firmware() after csio_hw_prep_hw()

        /* upgrade FW logic */
        ret = csio_hw_prep_fw(hw, fw_info, fw_data, fw_size, card_fw,
                         hw->fw_state, reset);

        /* Cleaning up */
        if (fw != NULL)
                release_firmware(fw);

In case of memory allocation failure csio_hw_flash_fw() will return without
calling release_firmware() with this patch.

Following patch fixes this issue  

csio_hw_flash_fw(struct csio_hw *hw, int *reset)
                return -EINVAL;
        }

+       /* allocate memory to read the header of the firmware on the
+        * card
+        */
+       card_fw = kmalloc(sizeof(*card_fw), GFP_KERNEL);
+       if (!card_fw)
+               return -ENOMEM;
+
        if (csio_is_t5(pci_dev->device & CSIO_HW_CHIP_MASK))
                fw_bin_file = FW_FNAME_T5;
        else
csio_hw_flash_fw(struct csio_hw *hw, int *reset)
                fw_size = fw->size;
        }

-       /* allocate memory to read the header of the firmware on the
-        * card
-        */
-       card_fw = kmalloc(sizeof(*card_fw), GFP_KERNEL);
-
        /* upgrade FW logic */
        ret = csio_hw_prep_fw(hw, fw_info, fw_data, fw_size, card_fw,
                         hw->fw_state, reset);
