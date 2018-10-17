Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A49BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B88F214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8daB+WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B88F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJQNA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeJQNA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:00:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29ADD214C4;
        Wed, 17 Oct 2018 05:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539752827;
        bh=SuhloOmjwJ4wOWtmIje6UPGKlZmRvcqmgwSjIyaT1PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8daB+WNP+QBstbinZZH3i2dbau1pAyba/2l3/6Vip7xsKzooPOb/vNdH2x2mFvSO
         PqAEQ4XMqCh2+D37Vv3khIp4JJxsL//yjCfYIsXKlVzf0P0V9hr7j3emMafBlG2TEt
         lbq7v3wmiGZI5G8vwhLLgFlygk5q8kbjpbQIOPaU=
Date:   Wed, 17 Oct 2018 07:07:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com, Haiyang Zhang <haiyangz@microsoft.com>,
        Stable@vger.kernel.org
Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Message-ID: <20181017050705.GE22447@kroah.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017031406.773-3-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:14:04AM +0000, kys@linuxonhyperv.com wrote:
> From: Dexuan Cui <decui@microsoft.com>
> 
> In kvp_send_key(), we do need call process_ib_ipinfo() if
> message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
> the userland hv_kvp_daemon needs the info of operation, adapter_id and
> addr_family. With the incorrect fc62c3b1977d, the host can't get the
> VM's IP via KVP.
> 
> And, fc62c3b1977d added a "break;", but actually forgot to initialize
> the key_size/value in the case of KVP_OP_SET, so the default key_size of
> 0 is passed to the kvp daemon, and the pool files
> /var/lib/hyperv/.kvp_pool_* can't be updated.
> 
> This patch effectively rolls back the previous fc62c3b1977d, and
> correctly fixes the "this statement may fall through" warnings.
> 
> This patch is tested on WS 2012 R2 and 2016.
> 
> Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall through" warnings")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index a7513a8a8e37..9fbb15c62c6c 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
>  
>  		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
>  
> +		__attribute__ ((fallthrough));

The comment should be sufficient for this, right?  I haven't seen many
uses of this attribute before, how common is it?


> +
> +	case KVP_OP_GET_IP_INFO:
>  		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
>  				MAX_ADAPTER_ID_SIZE,
>  				UTF16_LITTLE_ENDIAN,
> @@ -405,7 +408,11 @@ kvp_send_key(struct work_struct *dummy)
>  		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
>  		break;
>  	case KVP_OP_GET_IP_INFO:
> -		/* We only need to pass on message->kvp_hdr.operation.  */
> +		/*
> +		 * We only need to pass on the info of operation, adapter_id
> +		 * and addr_family to the userland kvp daemon.
> +		 */
> +		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
>  		break;
>  	case KVP_OP_SET:
>  		switch (in_msg->body.kvp_set.data.value_type) {
> @@ -446,9 +453,9 @@ kvp_send_key(struct work_struct *dummy)
>  
>  		}
>  
> -		break;
> -
> -	case KVP_OP_GET:
> +		/*
> +		 * The key is always a string - utf16 encoding.
> +		 */
>  		message->body.kvp_set.data.key_size =
>  			utf16s_to_utf8s(
>  			(wchar_t *)in_msg->body.kvp_set.data.key,
> @@ -456,6 +463,17 @@ kvp_send_key(struct work_struct *dummy)
>  			UTF16_LITTLE_ENDIAN,
>  			message->body.kvp_set.data.key,
>  			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
> +
> +		break;
> +
> +	case KVP_OP_GET:
> +		message->body.kvp_get.data.key_size =
> +			utf16s_to_utf8s(
> +			(wchar_t *)in_msg->body.kvp_get.data.key,
> +			in_msg->body.kvp_get.data.key_size,
> +			UTF16_LITTLE_ENDIAN,
> +			message->body.kvp_get.data.key,
> +			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;

Worst indentation ever :(

Yeah, I know it follows the others above it, but you should reconsider
it in the future...

thanks,

greg k-h
