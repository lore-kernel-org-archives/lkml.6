Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E01C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AAE20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbeLQSML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733076AbeLQSMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:12:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C178E41A5B;
        Mon, 17 Dec 2018 18:12:09 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 519065D9C6;
        Mon, 17 Dec 2018 18:12:09 +0000 (UTC)
Date:   Mon, 17 Dec 2018 11:12:08 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev/samples: Use u8 instead of char for handle
 functions
Message-ID: <20181217111208.3251aa42@x1.home>
In-Reply-To: <20181019180427.1386-1-natechancellor@gmail.com>
References: <20181019180427.1386-1-natechancellor@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 17 Dec 2018 18:12:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 11:04:27 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> samples/vfio-mdev/mtty.c:592:39: warning: implicit conversion from 'int'
> to 'char' changes value from 162 to -94 [-Wconstant-conversion]
>                 *buf = UART_MSR_DSR | UART_MSR_DDSR | UART_MSR_DCD;
>                      ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> 1 warning generated.
> 
> Turns out that all uses of buf in this function ultimately end up stored
> or cast to an unsigned type. Just use u8, which has the same number of
> bits but can store this larger number so Clang no longer warns.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  samples/vfio-mdev/mtty.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Applied to vfio next branch for v4.21.  Thanks,

Alex

> 
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index 7abb79d8313d..f6732aa16bb1 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -171,7 +171,7 @@ static struct mdev_state *find_mdev_state_by_uuid(uuid_le uuid)
>  	return NULL;
>  }
>  
> -void dump_buffer(char *buf, uint32_t count)
> +void dump_buffer(u8 *buf, uint32_t count)
>  {
>  #if defined(DEBUG)
>  	int i;
> @@ -250,7 +250,7 @@ static void mtty_create_config_space(struct mdev_state *mdev_state)
>  }
>  
>  static void handle_pci_cfg_write(struct mdev_state *mdev_state, u16 offset,
> -				 char *buf, u32 count)
> +				 u8 *buf, u32 count)
>  {
>  	u32 cfg_addr, bar_mask, bar_index = 0;
>  
> @@ -304,7 +304,7 @@ static void handle_pci_cfg_write(struct mdev_state *mdev_state, u16 offset,
>  }
>  
>  static void handle_bar_write(unsigned int index, struct mdev_state *mdev_state,
> -				u16 offset, char *buf, u32 count)
> +				u16 offset, u8 *buf, u32 count)
>  {
>  	u8 data = *buf;
>  
> @@ -475,7 +475,7 @@ static void handle_bar_write(unsigned int index, struct mdev_state *mdev_state,
>  }
>  
>  static void handle_bar_read(unsigned int index, struct mdev_state *mdev_state,
> -			    u16 offset, char *buf, u32 count)
> +			    u16 offset, u8 *buf, u32 count)
>  {
>  	/* Handle read requests by guest */
>  	switch (offset) {
> @@ -650,7 +650,7 @@ static void mdev_read_base(struct mdev_state *mdev_state)
>  	}
>  }
>  
> -static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
> +static ssize_t mdev_access(struct mdev_device *mdev, u8 *buf, size_t count,
>  			   loff_t pos, bool is_write)
>  {
>  	struct mdev_state *mdev_state;
> @@ -698,7 +698,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  #if defined(DEBUG_REGS)
>  			pr_info("%s: BAR%d  WR @0x%llx %s val:0x%02x dlab:%d\n",
>  				__func__, index, offset, wr_reg[offset],
> -				(u8)*buf, mdev_state->s[index].dlab);
> +				*buf, mdev_state->s[index].dlab);
>  #endif
>  			handle_bar_write(index, mdev_state, offset, buf, count);
>  		} else {
> @@ -708,7 +708,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  #if defined(DEBUG_REGS)
>  			pr_info("%s: BAR%d  RD @0x%llx %s val:0x%02x dlab:%d\n",
>  				__func__, index, offset, rd_reg[offset],
> -				(u8)*buf, mdev_state->s[index].dlab);
> +				*buf, mdev_state->s[index].dlab);
>  #endif
>  		}
>  		break;
> @@ -827,7 +827,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		if (count >= 4 && !(*ppos % 4)) {
>  			u32 val;
>  
> -			ret =  mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret =  mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					   *ppos, false);
>  			if (ret <= 0)
>  				goto read_err;
> @@ -839,7 +839,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		} else if (count >= 2 && !(*ppos % 2)) {
>  			u16 val;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, false);
>  			if (ret <= 0)
>  				goto read_err;
> @@ -851,7 +851,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		} else {
>  			u8 val;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, false);
>  			if (ret <= 0)
>  				goto read_err;
> @@ -889,7 +889,7 @@ ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  			if (copy_from_user(&val, buf, sizeof(val)))
>  				goto write_err;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, true);
>  			if (ret <= 0)
>  				goto write_err;
> @@ -901,7 +901,7 @@ ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  			if (copy_from_user(&val, buf, sizeof(val)))
>  				goto write_err;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, true);
>  			if (ret <= 0)
>  				goto write_err;
> @@ -913,7 +913,7 @@ ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  			if (copy_from_user(&val, buf, sizeof(val)))
>  				goto write_err;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, true);
>  			if (ret <= 0)
>  				goto write_err;

