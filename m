Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C689C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F9520851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F9520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeLJRyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:54:00 -0500
Received: from foss.arm.com ([217.140.101.70]:60016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeLJRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:54:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EE1EBD;
        Mon, 10 Dec 2018 09:53:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60E13F6A8;
        Mon, 10 Dec 2018 09:53:57 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:53:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] locking/atomics: build atomic headers as required
Message-ID: <20181210175355.brnmlzj5g5mbhuz2@lakrids.cambridge.arm.com>
References: <20181128085455.1164-1-mark.rutland@arm.com>
 <20181206161344.GA110430@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206161344.GA110430@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, Dec 06, 2018 at 05:13:44PM +0100, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Andrew and Ingo report that the check-atomics.sh script is simply too
> > slow to run for every kernel build, and it's impractical to make it
> > faster without rewriting it in something other than shell.
> > 
> > Rather than committing the generated headers, let's regenerate these
> > as-required, if we change the data or scripts used to generate the
> > atomic headers, or when building from a pristine tree.
> > 
> > That ensures they're always up-to-date, allows them to be built in
> > parallel, and avoid redundant rebuilds, which is a 2-8s saving per
> > incremental build. Since the results are not committed, it's very
> > obvious that they should not be modified directly. If we need to
> > generate more headers in future, it's easy to extend Makefile.genheader
> > to permit this.

> So these 'automatically generated' headers are actual and important code, 
> and I think it's bad practice to remove these from the git grep search 
> space and history as well.
> 
> Really, this whole notion of auto-generating the headers should be 
> implemented correctly, instead of working around deficiencies in a 
> short-term fashion that introduces other deficiencies.
> 
> I never got any replies to my previous comments about this:
> 
>   <20181128083057.GA7879@gmail.com>

As I've just mentioned in another thread, I've sent out a couple of patches
attempting to address this while leaving the headers checked-in:

https://lkml.kernel.org/r/20181210175035.45096-1-mark.rutland@arm.com

Thanks,
Mark.
