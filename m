Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbeBOKVF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:21:05 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37356 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755324AbeBOKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:21:03 -0500
X-Google-Smtp-Source: AH8x226rrLrFnAKZ7PgC0UtY1geZopApHEka1jzRIAtTZ+9qfiooaTLxozbSK8FaIUwXLqdI+lojyg==
Subject: Re: [PATCH 3/8] lightnvm: add support for 2.0 address format
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
 <1518530768-20956-4-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <45cb1863-9f23-fffd-82ee-4ce37e6625d7@lightnvm.io>
Date: Thu, 15 Feb 2018 11:21:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1518530768-20956-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 03:06 PM, Javier González wrote:
> Add support for 2.0 address format. Also, align address bits for 1.2 and 2.0 to
> align.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   include/linux/lightnvm.h | 45 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 6a567bd19b73..e035ae4c9acc 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -16,12 +16,21 @@ enum {
>   	NVM_IOTYPE_GC = 1,
>   };
>   
> -#define NVM_BLK_BITS (16)
> -#define NVM_PG_BITS  (16)
> -#define NVM_SEC_BITS (8)
> -#define NVM_PL_BITS  (8)
> -#define NVM_LUN_BITS (8)
> -#define NVM_CH_BITS  (7)
> +/* 1.2 format */
> +#define NVM_12_CH_BITS  (8)
> +#define NVM_12_LUN_BITS (8)
> +#define NVM_12_BLK_BITS (16)
> +#define NVM_12_PG_BITS  (16)
> +#define NVM_12_PL_BITS  (4)
> +#define NVM_12_SEC_BITS (4)
> +#define NVM_12_RESERVED (8)
> +
> +/* 2.0 format */
> +#define NVM_20_CH_BITS  (8)
> +#define NVM_20_LUN_BITS (8)
> +#define NVM_20_CHK_BITS (16)
> +#define NVM_20_SEC_BITS (24)
> +#define NVM_20_RESERVED (8)
>   
>   enum {
>   	NVM_OCSSD_SPEC_12 = 12,
> @@ -31,16 +40,26 @@ enum {
>   struct ppa_addr {
>   	/* Generic structure for all addresses */
>   	union {
> +		/* 1.2 device format */
>   		struct {
> -			u64 blk		: NVM_BLK_BITS;
> -			u64 pg		: NVM_PG_BITS;
> -			u64 sec		: NVM_SEC_BITS;
> -			u64 pl		: NVM_PL_BITS;
> -			u64 lun		: NVM_LUN_BITS;
> -			u64 ch		: NVM_CH_BITS;
> -			u64 reserved	: 1;
> +			u64 ch		: NVM_12_CH_BITS;
> +			u64 lun		: NVM_12_LUN_BITS;
> +			u64 blk		: NVM_12_BLK_BITS;
> +			u64 pg		: NVM_12_PG_BITS;
> +			u64 pl		: NVM_12_PL_BITS;
> +			u64 sec		: NVM_12_SEC_BITS;
> +			u64 reserved	: NVM_12_RESERVED;
>   		} g;
>   
> +		/* 2.0 device format */
> +		struct {
> +			u64 ch		: NVM_20_CH_BITS;
> +			u64 lun		: NVM_20_LUN_BITS;
> +			u64 chk		: NVM_20_CHK_BITS;
> +			u64 sec		: NVM_20_SEC_BITS;
> +			u64 reserved	: NVM_20_RESERVED;
> +		} m;
> +
>   		struct {
>   			u64 line	: 63;
>   			u64 is_cached	: 1;
> 

You can fold this into the next patch.
