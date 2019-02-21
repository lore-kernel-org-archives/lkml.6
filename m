Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80134C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE620838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBUHWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:22:40 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:40403 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfBUHWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:22:40 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id A48025C044A; Thu, 21 Feb 2019 08:22:10 +0100 (CET)
Date:   Thu, 21 Feb 2019 08:22:10 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtlwifi: Use proper enum for return in
 halmac_parse_psd_data_88xx
Message-ID: <20190221072210.GB1044@osadl.at>
References: <20190221052524.16064-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221052524.16064-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:25:24PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c:2472:11:
> warning: implicit conversion from enumeration type 'enum
> halmac_cmd_process_status' to different enumeration type 'enum
> halmac_ret_status' [-Wenum-conversion]
>                         return HALMAC_CMD_PROCESS_ERROR;
>                         ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
yup - my bad I somehow managed to end up in halmac_cmd_process_status
rather than halmac_ret_status - HALMAC_RET_MALLOC_FAIL makes sense here.

interesting that gcc did not fuss at this.

thx!
hofrat

> Fix this by using the proper enum for allocation failures,
> HALMAC_RET_MALLOC_FAIL, which is used in the rest of this file.
> 
> Fixes: e4b08e16b7d9 ("staging: r8822be: check kzalloc return or bail")
> Link: https://github.com/ClangBuiltLinux/linux/issues/375
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>

> ---
>  drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
> index ec742da030db..ddbeff8224ab 100644
> --- a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
> +++ b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
> @@ -2469,7 +2469,7 @@ halmac_parse_psd_data_88xx(struct halmac_adapter *halmac_adapter, u8 *c2h_buf,
>  	if (!psd_set->data) {
>  		psd_set->data = kzalloc(psd_set->data_size, GFP_KERNEL);
>  		if (!psd_set->data)
> -			return HALMAC_CMD_PROCESS_ERROR;
> +			return HALMAC_RET_MALLOC_FAIL;
>  	}
>  
>  	if (segment_id == 0)
> -- 
> 2.21.0.rc1
> 
