Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C35C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5482075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5482075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757138AbeFSKaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:30:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53231 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756569AbeFSKaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:30:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8CDBAC03;
        Tue, 19 Jun 2018 10:30:21 +0000 (UTC)
Date:   Tue, 19 Jun 2018 12:30:17 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from
 unknown source" message
Message-ID: <20180619103016.GC31750@zn.tnic>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic>
 <20180529161549.GB935@agluck-desk>
 <20180529174105.GF19870@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D31E24F@ORSMSX110.amr.corp.intel.com>
 <20180529175313.GG19870@zn.tnic>
 <20180529185425.GA4174@agluck-desk>
 <20180530092631.GA2599@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530092631.GA2599@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:26:32AM +0200, Borislav Petkov wrote:
> > In "x86/mce: Exit properly when no banks to poll" you
> > leap right to the end.  I'm wondering whether this can
> > ever happen? I mean, if there are no machine check banks,
> > then how did we get a machine check?
> 
> Right, so this looks like some remnant from old times, lemme do some
> archeology...
> 
> /me goes and dusts off the full history linux repo...
> 
> I found this:
> 
> commit 7dd1e1d805d15ca63d05badf40026629ba75cbc8
> Author: Andi Kleen <ak@suse.de>
> Date:   Tue Feb 24 17:58:41 2004 -0800
> 
>     [PATCH] New machine check handler for x86-64
> 
> and there's no mention why the !banks check is there.
> 
> I'm wondering if we should simply remove it. I mean, as you say, if
> there are no MCA banks, we won't be running in here in the first
> place...
> 
> > Both the original, and your new code, skip the:
> > 
> > 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> > 
> > which seems bad. That leaves MCG_STATUS.MCIP set ... so a second
> > machine check would just reset the machine.
> 
> That's a good point. It goes away as an issue if we simply drop the
> check.

...and gone it is.

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 19 Jun 2018 12:27:02 +0200
Subject: [PATCH] x86/mce: Remove !banks check

If we don't have MCA banks, we won't see machine checks anyway. Drop the
check.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index ea1521ec7e5b..05d2d15a95bd 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1185,9 +1185,6 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 
 	this_cpu_inc(mce_exception_count);
 
-	if (!cfg->banks)
-		goto out;
-
 	mce_gather_info(&m, regs);
 	m.tsc = rdtsc();
 
@@ -1327,7 +1324,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	if (worst > 0)
 		mce_report_event(regs);
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-out:
+
 	sync_core();
 
 	if (worst != MCE_AR_SEVERITY && !kill_it)
-- 
2.17.0.582.gccdcbd54c

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
