Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ABDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF7A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="C4EgATer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF7A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeKSA2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:28:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46136 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbeKSA2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:28:07 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542550061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FCblXy1zfGJ9TMDbST/OhBpEJBWfMNzg0mu49obGrk4=;
        b=C4EgATerKrET+s1qknL0Mdub0tZOk3iHdPLnfmQEBv+b8PGOk7GUlIoiZ1XAFECmCuCZ8O
        oK15I5ZL7+Bj2reIsVcx4p0vMLAnJNKEeHXToff0ro6y5WuIAs3ahlXWy2p7Tp5b6MlmCA
        pijAvPHrQvoNxE86H3B+lIxdogldxH4=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s-IcNytAh2i0; Sun, 18 Nov 2018 15:07:41 +0100 (CET)
Received: from zn.tnic (p200300EC2BE2B7004D130AD2F34E6DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:4d13:ad2:f34e:6de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 564BC1EC00E8;
        Sun, 18 Nov 2018 15:07:41 +0100 (CET)
Date:   Sun, 18 Nov 2018 15:07:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 01/13] arch/resctrl: Start renaming the rdt files to
 more generic names
Message-ID: <20181118140735.GC19380@zn.tnic>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-2-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116205407.10457-2-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to state it here on the thread: prefix should be "x86/resctrl" as
we said earlier. But that will be addressed in the next iteration, as we
agreed offlist.

On Fri, Nov 16, 2018 at 08:54:22PM +0000, Moger, Babu wrote:
> New generation of AMD processors start supporting RDT(or QOS) features.
> With more than one vendors supporting these features, it seems more
> appropriate to rename these files.
> 
> Changed intel_rdt to resctrl where applicable.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} | 0
>  arch/x86/kernel/cpu/Makefile                                | 6 +++---
>  arch/x86/kernel/cpu/{intel_rdt.c => resctrl.c}              | 4 ++--
>  arch/x86/kernel/cpu/{intel_rdt.h => resctrl.h}              | 6 +++---
>  .../cpu/{intel_rdt_ctrlmondata.c => resctrl_ctrlmondata.c}  | 2 +-
>  .../kernel/cpu/{intel_rdt_monitor.c => resctrl_monitor.c}   | 2 +-
>  .../cpu/{intel_rdt_pseudo_lock.c => resctrl_pseudo_lock.c}  | 6 +++---
>  ..._rdt_pseudo_lock_event.h => resctrl_pseudo_lock_event.h} | 2 +-
>  .../kernel/cpu/{intel_rdt_rdtgroup.c => resctrl_rdtgroup.c} | 4 ++--
>  arch/x86/kernel/process_32.c                                | 2 +-
>  arch/x86/kernel/process_64.c                                | 2 +-
>  11 files changed, 18 insertions(+), 18 deletions(-)
>  rename arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} (100%)
>  rename arch/x86/kernel/cpu/{intel_rdt.c => resctrl.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt.h => resctrl.h} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c => resctrl_ctrlmondata.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_monitor.c => resctrl_monitor.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c => resctrl_pseudo_lock.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h => resctrl_pseudo_lock_event.h} (95%)
>  rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => resctrl_rdtgroup.c} (99%)

Ok, looking at this more, it looks like this:

ls -l arch/x86/kernel/cpu/resctrl*
 arch/x86/kernel/cpu/resctrl.c
 arch/x86/kernel/cpu/resctrl_ctrlmondata.c
 arch/x86/kernel/cpu/resctrl.h
 arch/x86/kernel/cpu/resctrl_monitor.c
 arch/x86/kernel/cpu/resctrl_pseudo_lock.c
 arch/x86/kernel/cpu/resctrl_pseudo_lock_event.h
 arch/x86/kernel/cpu/resctrl_rdtgroup.c

Now, it looks to me like the whole resctrl thing begs for its own dir:

 arch/x86/kernel/cpu/resctrl/core.c
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c
 arch/x86/kernel/cpu/resctrl/internal.h
 arch/x86/kernel/cpu/resctrl/monitor.c
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c
 arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
 arch/x86/kernel/cpu/resctrl/rdtgroup.c

This way, the whole RDT machinery will be confined to its own directory.

Hmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
