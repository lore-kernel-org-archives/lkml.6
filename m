Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9879C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8F9208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8F9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeK0KZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:25:16 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:41218 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbeK0KZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:25:16 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 8D2CD988B4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:29:27 +0000 (UTC)
Received: (qmail 798 invoked from network); 26 Nov 2018 23:29:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2018 23:29:27 -0000
Date:   Mon, 26 Nov 2018 23:29:26 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: Hackbench pipes regression bisected to PSI
Message-ID: <20181126232926.GS23260@techsingularity.net>
References: <20181126133420.GN23260@techsingularity.net>
 <20181126160724.GA21268@cmpxchg.org>
 <20181126165446.GQ23260@techsingularity.net>
 <20181126173218.GA22640@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181126173218.GA22640@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:32:18PM -0500, Johannes Weiner wrote:
> > 
> > Bit late to notice but this switch should be in
> > Documentation/admin-guide/kernel-parameters.txt. If you really want to
> > match the automatic numa balancing switch then it also should be
> > psi=[enable|disable] instead of psi_enable=[1|0]
> 
> Done and done, thanks. Updated patch:
> 

The following is a comparision using CONFIG_PSI=n as a baseline against
your patch and a vanilla kernel

                         4.20.0-rc4             4.20.0-rc4             4.20.0-rc4
                kconfigdisable-v1r1                vanilla        psidisable-v1r1
Amean     1       1.3100 (   0.00%)      1.3923 (  -6.28%)      1.3427 (  -2.49%)
Amean     3       3.8860 (   0.00%)      4.1230 *  -6.10%*      3.8860 (  -0.00%)
Amean     5       6.8847 (   0.00%)      8.0390 * -16.77%*      6.7727 (   1.63%)
Amean     7       9.9310 (   0.00%)     10.8367 *  -9.12%*      9.9910 (  -0.60%)
Amean     12     16.6577 (   0.00%)     18.2363 *  -9.48%*     17.1083 (  -2.71%)
Amean     18     26.5133 (   0.00%)     27.8833 *  -5.17%*     25.7663 (   2.82%)
Amean     24     34.3003 (   0.00%)     34.6830 (  -1.12%)     32.0450 (   6.58%)
Amean     30     40.0063 (   0.00%)     40.5800 (  -1.43%)     41.5087 (  -3.76%)
Amean     32     40.1407 (   0.00%)     41.2273 (  -2.71%)     39.9417 (   0.50%)

It's showing that the vanilla kernel takes a hit (as the bisection
indicated it would) and that disabling PSI by default is reasonably
close in terms of performance for this particular workload on this
particular machine so;

Tested-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!

-- 
Mel Gorman
SUSE Labs
