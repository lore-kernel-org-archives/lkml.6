Return-Path: <kernel-hardening-return-12431-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELttCyQ94YQ5o2XTEpsPXmwwV2WlS4+sQbeiSDnVJ0hpgLVDdMJptaMePT1V552QNM82w2eM
ARC-Seal: i=1; a=rsa-sha256; t=1520858631; cv=none;
        d=google.com; s=arc-20160816;
        b=IcXn37aTh+88w592dwRTsuMy3iPfWdz6j3DPTbnsBq+PX+zZZ1+1mZg67EvyLulveK
         Fiv6vRFjKHx1S1ZM4CU7nCmqryilDcT2U504nyYnVtxq+BGCbZU4te8wwHHr9+g5KW1K
         0v3WWml1xPvDKH2qhszm9dDiPXgu1Cv1lUrZR/C7Du63DPjq8vIeEAQuexBRnswx47gI
         HaHpSZIeziJH7JXDw2YuskZ2q9HbEPgUCPO/uF1bWRhDcpFWZHr0vs8w4eGIvsLtQ7+6
         JvstcbsrJYoYuZGA/4OTXSvBupNaxYv06pUn2LtDJhPTMTMk/FatKt4PQqYdGFnd+A+c
         fnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8iiVVTkOzGd0zDPS9DXCBGiYFR98UrHQ7gEYMcbsVFQ=;
        b=Suk8D1rCizzQpGCPIEL9Xd2IdY/F2/2w6k3uTFtlAzBtUbT9v3pNwtSBspKrPN/1TC
         vmbt/QiXldQ34Fy2/2bAXAZRH4Nvb9w2dxCrYc6zJp3M/DC7cpywAI25Qw7F55B4/W05
         SBZPxKGqZ5Ha9rrGzjHp6QIoRFirpndz9AckmrtTcI4UtjMswaH9WwpSlhHNN/5Z/FHa
         44oRrCPRMzQSR/vV7ZSvbQQ8YkJFCTf/eHQJhzgzKcYjwJ9h8FRFjq+bL3JgsXilI264
         wkrQR45NLOWXAle/xFrtKxmr/+2Oy+sJOLgnxUsZnpSHd3fNqVFwfXw41RAD/eDOwgGB
         LH4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ts8cFBLv;
       spf=pass (google.com: domain of kernel-hardening-return-12431-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12431-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ts8cFBLv;
       spf=pass (google.com: domain of kernel-hardening-return-12431-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12431-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [RESEND PATCH] rsi: Remove stack VLA usage
To: "Tobin C. Harding" <me@tobin.cc>, Kalle Valo <kvalo@codeaurora.org>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <ff9309bf-4c3d-b0f9-cdd0-429dacd3177b@lwfinger.net>
Date: Sun, 11 Mar 2018 21:06:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520819022-15238-1-git-send-email-me@tobin.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594735860049738865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/11/2018 08:43 PM, Tobin C. Harding wrote:
> The kernel would like to have all stack VLA usage removed[1].  rsi uses
> a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> is defined using a magic number.  We can use a pre-processor defined
> constant and declare the array to maximum size.  We add a check before
> accessing the array in case of programmer error.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
> 
> RESEND: add wireless mailing list to CC's (requested by Kalle)
> 
>   drivers/net/wireless/rsi/rsi_91x_hal.c  | 13 +++++++------
>   drivers/net/wireless/rsi/rsi_91x_sdio.c |  9 +++++++--
>   2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
> index 1176de646942..839ebdd602df 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_hal.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
> @@ -641,7 +641,7 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
>   	u32 cmd_addr;
>   	u16 cmd_resp, cmd_req;
>   	u8 *str;
> -	int status;
> +	int status, ret;
>   
>   	if (cmd == PING_WRITE) {
>   		cmd_addr = PING_BUFFER_ADDRESS;
> @@ -655,12 +655,13 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
>   		str = "PONG_VALID";
>   	}
>   
> -	status = hif_ops->load_data_master_write(adapter, cmd_addr, size,
> +	ret = hif_ops->load_data_master_write(adapter, cmd_addr, size,
>   					    block_size, addr);
> -	if (status) {
> -		rsi_dbg(ERR_ZONE, "%s: Unable to write blk at addr %0x\n",
> -			__func__, *addr);
> -		return status;
> +	if (ret) {
> +		if (ret != -EINVAL)
> +			rsi_dbg(ERR_ZONE, "%s: Unable to write blk at addr %0x\n",
> +				__func__, *addr);
> +		return ret;
>   	}
>   
>   	status = bl_cmd(adapter, cmd_req, cmd_resp, str);
> diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> index b0cf41195051..b766578b591a 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> @@ -20,6 +20,8 @@
>   #include "rsi_common.h"
>   #include "rsi_hal.h"
>   
> +#define RSI_MAX_BLOCK_SIZE 256
> +
>   /**
>    * rsi_sdio_set_cmd52_arg() - This function prepares cmd 52 read/write arg.
>    * @rw: Read/write
> @@ -362,7 +364,7 @@ static int rsi_setblocklength(struct rsi_hw *adapter, u32 length)
>   	rsi_dbg(INIT_ZONE, "%s: Setting the block length\n", __func__);
>   
>   	status = sdio_set_block_size(dev->pfunction, length);
> -	dev->pfunction->max_blksize = 256;
> +	dev->pfunction->max_blksize = RSI_MAX_BLOCK_SIZE;
>   	adapter->block_size = dev->pfunction->max_blksize;
>   
>   	rsi_dbg(INFO_ZONE,
> @@ -567,9 +569,12 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
>   {
>   	u32 num_blocks, offset, i;
>   	u16 msb_address, lsb_address;
> -	u8 temp_buf[block_size];
> +	u8 temp_buf[RSI_MAX_BLOCK_SIZE];
>   	int status;
>   
> +	if (block_size > RSI_MAX_BLOCK_SIZE)
> +		return -EINVAL;
> +
>   	num_blocks = instructions_sz / block_size;
>   	msb_address = base_address >> 16;

I am not giving this patch a negative review, but my solution to the same 
problem has been to change the on-stack array into a u8 pointer, use kmalloc() 
to assign the space, and then free that space at the end. That way large stack 
allocations are avoided, with a minimum of changes.

Larry

>   
> 
