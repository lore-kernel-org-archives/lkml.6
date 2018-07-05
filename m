Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27772C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CE424052
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CE424052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeGELnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:43:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:28911 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753635AbeGELnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:43:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 04:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="62456804"
Received: from jrissane-mobl.ger.corp.intel.com ([10.237.67.31])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2018 04:42:56 -0700
Message-ID: <1530790975.5103.16.camel@linux.intel.com>
Subject: Re: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix
 panic
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     Michael Scott <michael@opensourcefoundries.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Jul 2018 14:42:55 +0300
In-Reply-To: <20180619234406.8217-1-michael@opensourcefoundries.com>
References: <20180619234406.8217-1-michael@opensourcefoundries.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 16:44 -0700, Michael Scott wrote:
> After decompression of 6lowpan socket data, an IPv6 header is
> inserted
> before the existing socket payload.  After this, we reset the
> network_header value of the skb to account for the difference in
> payload
> size from prior to decompression + the addition of the IPv6 header.
> 
> 
> Signed-off-by: Michael Scott <michael@opensourcefoundries.com>
> ---
>  net/6lowpan/iphc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 6b1042e21656..52fad5dad9f7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb,
> const struct net_device *dev,
>  		hdr.hop_limit, &hdr.daddr);
>  
>  	skb_push(skb, sizeof(hdr));
> +	skb_reset_mac_header(skb);
>  	skb_reset_network_header(skb);
>  	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
>  

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka



