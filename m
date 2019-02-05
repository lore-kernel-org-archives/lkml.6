Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693B6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311DC2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sYilpRpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfBEGKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:10:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfBEGKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:10:38 -0500
Received: from zn.tnic (p200300EC2BCB6B0090E35794C198FCB8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:90e3:5794:c198:fcb8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F8501EC0911;
        Tue,  5 Feb 2019 07:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549347036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FS1NZ57H9XxpM8Jtc9/abDtkZb9ZYO5xIb5YyrKWT8c=;
        b=sYilpRpR4kr+R+7t8qi/zEHDhIYGTJek1ELJ0z5Oslia0JUcasRHkoOrFOdS+oltpIU21f
        ZHpJiEPjozFdbQW1kdh4Sn/HlYveKwaw82e6cOdz9YTFjBrZYQHs/iqPVlijpFV6S94oRL
        4iZN/aqvTk8Zcwy21o1urja/o5LcN1I=
Date:   Tue, 5 Feb 2019 07:10:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190205061026.GB21801@zn.tnic>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190204214044.GN29639@zn.tnic>
 <20190204221430.GA70667@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204221430.GA70667@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 02:14:30PM -0800, Fenghua Yu wrote:
> With "setcpuid=", there is no additional code to add as long as
> enumeration code is available.

Wait, are you saying that all the other enablement of new features is
easy and the only problem is patching {early_,}init_intel() so you'd
prefer not to patch it each time and use a cmdline param instead which
is error prone and really user-unfriendly?!

Usually, the patch adding the CPUID flag and checking is the easiest
one.

Also, you do realize that even if it gets applied, it will need
to sanity-check everything passed in, which means, it will accept
*only* the leafs which you guys don't have in CPUID?! It won't be a
lets-enable-this-random-cpuid-bits-and-see-what-happens deal.

Because I don't think anyone will be willing to debug reports from such
random enablements. The qemu+kvm "experiments" are already painful
enough.

By then you're better off simply patching {early_,}init_intel() I'd say.

> Every time a new feature like this case, the early_init_intel() needs
> to be changed for FMS etc.

Yes, as part of the enablement. You really seldomly - if ever at all -
have a new feature which only needs CPUID enablement. Unless it is some
feature flag to show support for new insns but that gets applied almost
immediately and I doubt userspace even uses it through /proc/cpuinfo -
they do their own querying of CPUID.

Because if they do the latter, setcpuid= will give you nothing unless we
enforce CPUID faulting. Except *that* is not present everywhere...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
