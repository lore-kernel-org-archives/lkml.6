Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BCFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7966620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeH3SkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:40:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:22666 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeH3SkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:40:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 07:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="258516227"
Received: from mohren-mobl.ger.corp.intel.com (HELO [10.252.50.18]) ([10.252.50.18])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2018 07:37:48 -0700
Subject: Re: [PATCH][net-next] xdp: remove redundant variable 'headroom'
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830142718.10850-1-colin.king@canonical.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <ec579a7c-345b-f462-95ac-f36de1072614@intel.com>
Date:   Thu, 30 Aug 2018 16:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830142718.10850-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-30 16:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable 'headroom' is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> variable ‘headroom’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   net/core/xdp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 654dbb19707e..4b2b194f4f1f 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -412,7 +412,7 @@ EXPORT_SYMBOL_GPL(xdp_attachment_setup);
>   
>   struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
>   {
> -	unsigned int metasize, headroom, totsize;
> +	unsigned int metasize, totsize;
>   	void *addr, *data_to_copy;
>   	struct xdp_frame *xdpf;
>   	struct page *page;
> @@ -420,7 +420,6 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
>   	/* Clone into a MEM_TYPE_PAGE_ORDER0 xdp_frame. */
>   	metasize = xdp_data_meta_unsupported(xdp) ? 0 :
>   		   xdp->data - xdp->data_meta;
> -	headroom = xdp->data - xdp->data_hard_start;
>   	totsize = xdp->data_end - xdp->data + metasize;
>   
>   	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
> 

This should go via bpf-next. Thanks for the fix!

Acked-by: Björn Töpel <bjorn.topel@intel.com>
