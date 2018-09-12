Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB10C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1A1206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1A1206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeILNRy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:17:54 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:42114 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeILNRy (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:2>);
        Wed, 12 Sep 2018 09:17:54 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 12 Sep 2018 02:14:30 -0600
Message-Id: <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Wed, 12 Sep 2018 02:14:26 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Roger Pau Monne" <roger.pau@citrix.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Cc:     "zhong jiang" <zhongjiang@huawei.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h:
 use DIV_ROUND_UP instead of reimplementing its function
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -65,7 +65,7 @@
>  	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
>  
>  #define MAX_INDIRECT_PAGES \
> -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
> +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
>  #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)

My first reaction was to suggest

#define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)

but that wouldn't match what's there currently (note the two different
divisors). I can't really decide whether that's just unfortunate naming
of the two macros, or an actual bug.

Jan


