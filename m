Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00705258E6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00705258E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbeFYMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:24:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:4645 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbeFYMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:24:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 05:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="67042660"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 05:24:20 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Keith Busch <keith.busch@linux.intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-gfx] [BUG] cc5b114dcf bpf, i40e: add meta data support
In-Reply-To: <dc3176ae-5b16-ffa8-c8c8-595a0ede57f4@iogearbox.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180612161739.GA3303@localhost.localdomain> <dc3176ae-5b16-ffa8-c8c8-595a0ede57f4@iogearbox.net>
Date:   Mon, 25 Jun 2018 15:24:09 +0300
Message-ID: <878t73uk9i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, the list you're looking for is likely intel-wired-lan (added), not
intel-gfx (removed).

BR,
Jani.


On Tue, 12 Jun 2018, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/12/2018 06:17 PM, Keith Busch wrote:
>> My server's i40e no longer obtains an IP address on linux
>> mainline. Bisected to the following:
>> 
>> commit cc5b114dcf986bfd8e4c37bf65d1b7b1e5290ac6
>> Author: Daniel Borkmann <daniel@iogearbox.net>
>> Date:   Mon May 28 11:07:20 2018 +0200
>> 
>>     bpf, i40e: add meta data support
>> 
>> Reverting on mainline resolves the issue.
>> 
>> Is there something wrong with my i40e adapter, or is the patch possibly
>> doing something wrong? Or any other information I can get to help
>> understand why it's stopped working with this feature?
>> 
>> An excert from "journalctl -xe" on on the failing network adapter
>> is below.
>
> Thanks for the report & sorry for the issue, Keith! Instead of revert,
> could you give the below fix a try?
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 8ffb745..ed6dbcf 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2103,9 +2103,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>  	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
>  #else
>  	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
> -				SKB_DATA_ALIGN(I40E_SKB_PAD +
> -					       (xdp->data_end -
> -						xdp->data_hard_start));
> +				SKB_DATA_ALIGN(xdp->data_end -
> +					       xdp->data_hard_start);
>  #endif
>  	struct sk_buff *skb;
>
> @@ -2124,7 +2123,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>  		return NULL;
>
>  	/* update pointers within the skb to store the data */
> -	skb_reserve(skb, I40E_SKB_PAD + (xdp->data - xdp->data_hard_start));
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>  	__skb_put(skb, xdp->data_end - xdp->data);
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>
> Thanks,
> Daniel
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Graphics Center
