Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DEC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C015F2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C015F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeJLXSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:18:38 -0400
Received: from foss.arm.com ([217.140.101.70]:53476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJLXSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:18:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6765BF;
        Fri, 12 Oct 2018 08:45:34 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3824A3F5BC;
        Fri, 12 Oct 2018 08:45:34 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A668E1AE09F2; Fri, 12 Oct 2018 16:45:34 +0100 (BST)
Date:   Fri, 12 Oct 2018 16:45:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: livelock with hrtimer cpu_base->lock
Message-ID: <20181012154534.GA11387@arm.com>
References: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
 <20181010164919.GA16512@arm.com>
 <63fae7b2ef8dc4cc67928329cf7fcb60@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fae7b2ef8dc4cc67928329cf7fcb60@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:55:28AM -0700, Sodagudi Prasad wrote:
> On 2018-10-10 09:49, Will Deacon wrote:
> >On Tue, Oct 09, 2018 at 01:56:14PM -0700, Sodagudi Prasad wrote:
> >>This is regarding - thread "try to fix contention between expire_timers
> >>and
> >>try_to_del_timer_sync".
> >>https://lkml.org/lkml/2017/7/28/172
> >>
> >>I think this live lockup issue was discussed earlier but the final set
> >>of
> >>changes were not concluded.
> >
> >Well we basically need a way to pick a value for CPU_RELAX_WFE_THRESHOLD.
> >Do you have any ideas? It could be determined at runtime if necessary.
> >
> 
> Please share what are values need to be tried for CPU_RELAX_WFE_THRESHOLD.
> 
>  It would be great if it can be determined from runtime.  Please let me know
> if any testing need to be done with dynamic detection patch.

I was actually hoping you'd have some ideas about how to write the patch. I
don't have a good feel for how to determine this threshold, and you have
hardware that needs it...

One avenue of exploration might be to tune the fallback to WFE based on
what percentage of the eventstream period we've been polling, e.g. 50%.

Will
