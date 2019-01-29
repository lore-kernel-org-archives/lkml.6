Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A89C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB972087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfA2Uhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:37:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfA2Uhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:37:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3BDB13AC10;
        Tue, 29 Jan 2019 20:37:37 +0000 (UTC)
Received: from treble (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D36175C239;
        Tue, 29 Jan 2019 20:37:36 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:37:35 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
        Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM
Message-ID: <20190129203734.zzhw2koob4hdrrr7@treble>
References: <92bb3175ad0fa9200baae41707ad39a56c05732d.1548694307.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92bb3175ad0fa9200baae41707ad39a56c05732d.1548694307.git.jpoimboe@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 29 Jan 2019 20:37:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:52:56AM -0600, Josh Poimboeuf wrote:
> With the following commit:
> 
>   73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
> 
> ... the hotplug code attempted to detect when SMT was disabled by BIOS,
> in which case it reported SMT as permanently disabled.  However, that
> code broke a virt hotplug scenario, where the guest is booted with only
> primary CPU threads, and a sibling is brought online later.
> 
> The problem is that there doesn't seem to be a way to reliably
> distinguish between the HW "SMT disabled by BIOS" case and the virt
> "sibling not yet brought online" case.  So the above-mentioned commit
> was a bit misguided, as it permanently disabled SMT for both cases,
> preventing future virt sibling hotplugs.
> 
> Going back and reviewing the original problems which were attempted to
> be solved by that commit, when SMT was disabled in BIOS:
> 
>   1) /sys/devices/system/cpu/smt/control showed "on" instead of
>      "notsupported"; and
> 
>   2) vmx_vm_init() was incorrectly showing the L1TF_MSG_SMT warning.
> 
> I'd propose that we instead consider #1 above to not actually be a
> problem.  Because, at least in the virt case, it's possible that SMT
> wasn't disabled by BIOS and a sibling thread could be brought online
> later.  So it makes sense to just always default the smt control to "on"
> to allow for that possibility (assuming cpuid indicates that the CPU
> supports SMT).
> 
> The real problem is #2, which has a simple fix: change vmx_vm_init() to
> query the actual current SMT state -- i.e., whether any siblings are
> currently online -- instead of looking at the SMT "control" sysfs value.
> 
> So fix it by:
> 
>   a) reverting the original "fix" and its followup fix:
> 
>      73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
>      bc2d8d262cba ("cpu/hotplug: Fix SMT supported evaluation")
> 
>      and
> 
>   b) changing vmx_vm_init() to query the actual current SMT state --
>      instead of the sysfs control value -- to determine whether the L1TF
>      warning is needed.
> 
> Fixes: 73d5e2b47264 ("cpu/hotplug: detect SMT disabled by BIOS")
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

NACK - Need to export "sched_smt_present" so KVM can call
sched_smt_active().

-- 
Josh
