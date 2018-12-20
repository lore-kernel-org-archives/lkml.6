Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BD7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0270D218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LorXMnM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeLTSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:45:49 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38494 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbeLTSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:45:49 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EC90710C077C;
        Thu, 20 Dec 2018 10:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545331548; bh=+ERcZePNK455JOPXp+ZcSDyrH72ZZlwmHqmUQ9/dDoA=;
        h=From:To:CC:Subject:Date:References:From;
        b=LorXMnM2xmOl89Uu6iC91MVyxlGM0dP7483O708zNiPb23CQ7nfjiy0LBNdbfqrP3
         OqTGwpnRO5PW9TqjWGj09mx0FuxqIoNw81ayDvBGEmx08d1OYfrVB4Pf4rCZKEdlDX
         rrHdD4GO2SZzc7RMkL6I4sm3H1kB9y0AUzY/2HIdjbpZtrmnKv5B9FEqsT7W0sro/S
         LLm6dG2VzGGyitCon0MdviCbb9Pa0163ua4zizO+y8wzNYUhr/w/SpLWonK3Jgr9O0
         SdT4YNx1cHSnac47GfG/823O8NSnQaRFarw6bhm7QA8pMnWFyRHIVNgvzQh3E6GErP
         Xem5+axSMFmFg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id D21CF55F5;
        Thu, 20 Dec 2018 10:45:48 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 20 Dec 2018 10:45:48 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Thread-Topic: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Thread-Index: AQHUlwMTcvVhAsUv7ki7z5FuF+I3DA==
Date:   Thu, 20 Dec 2018 18:45:48 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 5:04 AM, Michal Hocko wrote:=0A=
> On Tue 18-12-18 10:53:59, Vineet Gupta wrote:=0A=
>> signal handling core calls ARCH show_regs() with preemption disabled=0A=
>> which causes __might_sleep functions such as mmput leading to lockdep=0A=
>> splat.  Workaround by re-enabling preemption temporarily.=0A=
>>=0A=
>> This may not be as bad as it sounds since the preemption disabling=0A=
>> itself was introduced for a supressing smp_processor_id() warning in x86=
=0A=
>> code by commit 3a9f84d354ce ("signals, debug: fix BUG: using=0A=
>> smp_processor_id() in preemptible code in print_fatal_signal()")=0A=
> The commit you are referring to here sounds dubious in itself.=0A=
=0A=
Indeed that was my thought as well, but it did introduce the preemption dis=
abling=0A=
logic aroung core calling show_regs() !=0A=
=0A=
> We do not=0A=
> want to stick a preempt_disable just to silence a warning.=0A=
=0A=
I presume you are referring to original commit, not my anti-change in ARC c=
ode,=0A=
which is actually re-enabling it.=0A=
=0A=
> show_regs is=0A=
> called from preemptible context at several places (e.g. __warn).=0A=
=0A=
Right, but do we have other reports which show this, perhaps not too many d=
istros=0A=
have CONFIG__PREEMPT enabled ?=0A=
=0A=
> Maybe=0A=
> this was not the case in 2009 when the change was introduced but this=0A=
> seems like a relict from the past. So can we fix the actual problem=0A=
> rather than build on top of it instead?=0A=
=0A=
The best/correct fix is to remove the preempt diabling in core code, but th=
at=0A=
affects every arch out there and will likely trip dormant land mines, neede=
d=0A=
localized fixes like I'm dealing with now.=0A=
=0A=
-Vineet=0A=
