Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E8DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B98620664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B98620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJaGCe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:02:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:31636 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeJaGCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:02:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 14:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="103899361"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 14:07:28 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.124]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 14:07:28 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [Patch v4 16/18] x86/speculation: Enable STIBP to protect
 security sensitive tasks
Thread-Topic: [Patch v4 16/18] x86/speculation: Enable STIBP to protect
 security sensitive tasks
Thread-Index: AQHUcIX0DdysJO4kRU6iUAh/q6Lda6U4Rdfw
Date:   Tue, 30 Oct 2018 21:07:28 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732148DC8C@ORSMSX110.amr.corp.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
 <26ec186930a8fb33033743997bd56e5ce44050ec.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <26ec186930a8fb33033743997bd56e5ce44050ec.1540923609.git.tim.c.chen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzgzN2Y5YTMtNDYyNC00YjQ4LWE2ZjktMzgwMjQ0ODkzZGZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnhSd2pVTUJYd0trWTlJcGl1WXZLaFU3XC9NQXVyNmFBcEZ1OWNGZm5DQ3NYVUlEVmlzY0RpTEhMaUV3TjRMM2wifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tim Chen [mailto:tim.c.chen@linux.intel.com]
> Sent: Tuesday, October 30, 2018 11:49 AM
> To: Jiri Kosina <jikos@kernel.org>; Thomas Gleixner <tglx@linutronix.de>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>; Tom Lendacky
> <thomas.lendacky@amd.com>; Ingo Molnar <mingo@redhat.com>; Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@redhat.com>;
> Andrea Arcangeli <aarcange@redhat.com>; David Woodhouse
> <dwmw@amazon.co.uk>; Andi Kleen <ak@linux.intel.com>; Hansen, Dave
> <dave.hansen@intel.com>; Schaufler, Casey <casey.schaufler@intel.com>;
> Mallick, Asit K <asit.k.mallick@intel.com>; Arjan van de Ven
> <arjan@linux.intel.com>; Jon Masters <jcm@redhat.com>; Waiman Long
> <longman9394@gmail.com>; linux-kernel@vger.kernel.org; x86@kernel.org
> Subject: [Patch v4 16/18] x86/speculation: Enable STIBP to protect security
> sensitive tasks
> 
> Enable STIBP defense on high security tasks.
> 
> For normal tasks, STIBP is unused so they are not impacted by overhead
> from STIBP in lite protection mode.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 54f4675..b402b96 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  #include <linux/nospec.h>
>  #include <linux/prctl.h>
> +#include <linux/sched/coredump.h>
> +#include <linux/security.h>
> 
>  #include <asm/spec-ctrl.h>
>  #include <asm/cmdline.h>
> @@ -770,6 +772,37 @@ static int ssb_prctl_set(struct task_struct *task,
> unsigned long ctrl)
>  	return 0;
>  }
> 
> +static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
> +{
> +	bool update = false;
> +
> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
> +		return;
> +
> +	if (stibp_on)
> +		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
> +	else
> +		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
> +
> +	if (!update)
> +		return;
> +
> +	if (tsk == current)
> +		speculation_ctrl_update_current();
> +}
> +
> +void arch_set_security(struct task_struct *tsk, unsigned int value)

In this context "security" isn't descriptive. arch_set_stibp_defenses()
would be better.

Since "value" should only ever have one of two values, and those
map directly to "true" or "false" this should be a bool, making the
code trivial:

void arch_set_stibp_defenses(struct task_struct *task, bool stibp)
{
	set_task_stibp(task, stibp);
}

Or perhaps arch_set_security() should go away, and the calling
code would call set_task_stibp() directly. Unless there is some compelling
reason for the abstractions.

> +{
> +	if (value > SECURITY_HIGH)
> +		return;
> +
> +	/* Update STIBP defenses */
> +	if (value == SECURITY_HIGH)
> +		set_task_stibp(tsk, true);
> +	else
> +		set_task_stibp(tsk, false);
> +}
> +
>  int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>  			     unsigned long ctrl)
>  {
> --
> 2.9.4

