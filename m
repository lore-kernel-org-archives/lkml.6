Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D5C43147
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3F827594
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3F827594
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966847AbeF1Ovd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:51:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966458AbeF1Ova (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:51:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72DE040201D3;
        Thu, 28 Jun 2018 14:51:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEBA82026D69;
        Thu, 28 Jun 2018 14:51:27 +0000 (UTC)
Date:   Thu, 28 Jun 2018 16:51:25 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
Message-ID: <20180628145125.2psdmymtuueiv4xn@kamzik.brq.redhat.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
 <20180628115748.kprobde6c3joc6ll@kamzik.brq.redhat.com>
 <f9376e47-e2ae-b2f4-db23-07698364f1bb@arm.com>
 <b9b537e7-8f7b-07cc-a99d-bcaa8f5d60d5@arm.com>
 <e5b44e41-6d5b-2587-2628-3bcfbee4e00b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b44e41-6d5b-2587-2628-3bcfbee4e00b@arm.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 14:51:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 28 Jun 2018 14:51:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:09:19PM +0100, Sudeep Holla wrote:
> 
> 
> On 28/06/18 14:19, Jeremy Linton wrote:
> > Hi,
> > 
> > On 06/28/2018 07:12 AM, Sudeep Holla wrote:
> 
> [...]
> 
> >>
> >> OK sure. I liked the approach in Shunyong's patch. I was thinking if we
> >> can avoid the list and dynamic allocation on each addition and make it
> >> more simpler.
> >>
> > 
> > This one reads simpler, but yes I agree we should try to avoid the
> > dynamic allocation.
> > 
> > OTOH, I think that dropping the dynamic allocation leads to an algorithm
> > that picks a value and replaces all the matches. Which of course is
> > Andrew's patch, although I did have to read it a couple times to get a
> > grasp how it works. I'm guessing that is due to the fact that he seems
> > to have optimized 3 double loops into a single loop with two individual
> > nested loops. AKA its probably more efficient than the naive
> > implementation, but readability seems to have suffered a bit in the
> > initial version he posted. I'm not sure the optimization is worth it,
> > but I'm guessing there is a middle ground which makes it more readable.
> > 
> 
> Completely agree. RFC from Andrew is not so readable and easy to understand.

Middle ground coming up. At the expense of a triple-nested loop (which
will never be N^3 iterations due to conditions at the start of each loop),
we can avoid dynamic allocations and list iterations and still gain
readability.

Thanks,
drew
