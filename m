Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA37C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7BB20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7BB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIEKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:50:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:32822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbeIEKur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:50:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AD28AF05;
        Wed,  5 Sep 2018 06:22:09 +0000 (UTC)
Date:   Wed, 5 Sep 2018 08:22:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
In-Reply-To: <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm> <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com> <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm> <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Tim Chen wrote:

> I think STIBP should be an opt in option as it will have significant
> impact on performance.  The attack from neighbor thread is pretty
> difficult to pull off considering you have to know what the sibling
> thread is running and its address allocation.

In many scenarios the attacker can just easily taskset itself to the 
correct sibling.

> We could also use a security module to opt in the STIBP policy.

I am a bit afraid that we are offloading to sysadmins decisions that are 
very hard for them to make, as they require deep understanding of both the 
technical details of the security issue in the CPU, and the mitigation.

I surely understand that Intel is doing what they could to minimize the 
performance effect, but achieving that by making it a rocket science to 
configure it properly doesn't feel right.

So, after giving it a bit more thought, I still believe "I want spectre V2 
protection" vs. "I do not care about spectre V2 on my system 
(=nospectre_v2)" are the sane options we should provide; so I'll respin v4 
of my patchset, including the ptrace check in switch_mm() (statically 
patched out on !IBPB-capable systems), and we can then later see whether 
the LSM implementation, once it exists, should be used instead.

Thanks,

-- 
Jiri Kosina
SUSE Labs

