Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA78EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9025320671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9025320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeGYXdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:33:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:39236 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbeGYXdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:33:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 15:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,402,1526367600"; 
   d="scan'208";a="57177188"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2018 15:20:04 -0700
Date:   Wed, 25 Jul 2018 15:18:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Hongjiu Lu <hongjiu.lu@intel.com>
Subject: Re: [PATCH 5/7] x86/vdso: Add vDSO functions for direct store
 instructions
Message-ID: <20180725221844.GC245659@romley-ivt3.sc.intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-6-git-send-email-fenghua.yu@intel.com>
 <10870309-993a-0abc-635a-92c05bbad140@kernel.org>
 <20180724034205.GA245659@romley-ivt3.sc.intel.com>
 <CALCETrX6oiYMvhsnttSFLuSSdOdG3+SyM0PQvBEVHHqZMXZGsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX6oiYMvhsnttSFLuSSdOdG3+SyM0PQvBEVHHqZMXZGsQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:27:34PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 23, 2018 at 8:42 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > On Mon, Jul 23, 2018 at 06:48:00PM -0700, Andy Lutomirski wrote:
> >> On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> >> >The instructions can be implemented in intrinsic functions in future
> >> >GCC. But the vDSO interfaces are available to user without the
> >> I'm not convinced that any of this belongs in the vDSO at all.  You could
> >> just add AT_HWCAP (or AT_HWCAP2) flags for the new instructions. Or user
> >
> > Thomas asked to use vDSO. Please see the discussion thread:
> > https://lkml.org/lkml/2018/6/19/316
> 
> I think he meant that, if these helpers belong in the kernel at all,
> then they belong in the vDSO.  But I think they mostly don't belong in
> the kernel.

I think both you and Thomas are right. I misunderstood Thomas's comments.

I will remove the APIs/functions from next version of patch set. They
don't belong to kernel and will be implemented in either GCC or glibc.

GCC8 already implemented movdiri and movdir64b instruction intrinsics.
GCC9 will implement user wait instruction intrinsics.
If user wants to use those instinsics now, this GCC link has them:
https://gcc.gnu.org/git/?p=gcc.git;a=summary

If user wants to use the intrinsics in native code, the user needs to
check availability of the features (i.e. movdiri, movdir64b, waitpkg)
by running cpuid or a glibc interface that is going to be available in
newer glibc.

Thank you for  your comments!

-Fenghua
