Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA11C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B412081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lp6GYxHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B412081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLKMeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:34:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36962 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKMeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:34:16 -0500
Received: from zn.tnic (p200300EC2BCD2B00C44E50A76C8F50EC.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:c44e:50a7:6c8f:50ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E66511EC0B6D;
        Tue, 11 Dec 2018 13:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544531654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6r0gRe2JnrBWxBqnxct9gmZ2JjTAbHKPYqnAiXk53g4=;
        b=lp6GYxHYKg6Kav3DeFHAYl4Ttjr+fdjMG3nW/WQ2k75aziM2KCEwXqE/I85l/b3oTnd9KZ
        iX4d5WWHE03mgIgYHjKosjMh4hKmApYpT+FdQq2AgUOI/d/y2HZeviKOAl6BzTSTTQGAg/
        KepBNP0tWt+HZ3p2EVG/SNrJoWsHljE=
Date:   Tue, 11 Dec 2018 13:34:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while
 needed
Message-ID: <20181211123404.GC27375@zn.tnic>
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 01:21:54PM -0800, Reinette Chatre wrote:
> The user triggers the creation of a pseudo-locked region when writing
> the requested schemata to the schemata resctrl file. The pseudo-locking
> of a region is required to be done on a CPU that is associated with the
> cache on which the pseudo-locked region will reside. In order to run the
> locking code on a specific CPU the needed CPU has to be selected and
> ensured to remain online during the entire locking sequence.
> 
> At this time the cpu_hotplug_lock is not taken during the pseudo-lock
> region creation and it is thus possible for a CPU to be selected to run
> the pseudo-locking code and then that CPU to go offline before the
> thread is able to run on it.
> 
> Fix this by ensuring that the cpu_hotplug_lock is taken while the CPU on
> which code has to run needs to be controlled. Since the cpu_hotplug_lock
> is always taken before rdtgroup_mutex the lock order is maintained.
> 
> Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: stable@vger.kernel.org
> ---
> V2:
> - Rebase against tip/x86/urgent
> - Modify subject from x86/resctrl to x86/intel_rdt to match subject used
>   before the code reorganization.
> 
>  arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++++
>  1 file changed, 4 insertions(+)

I took it but changed the subject to the more straight-forward:

"x86/intel_rdt: Disable CPU hotplug while modifying schemata"

Now, your second patch:

  Subject: [PATCH V2] x86/resctrl: Fix rdt_find_domain() return value and checks
  Message-Id: <b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com>

has the new file paths, has Fixes: tags but no CC:stable.

I'm guessing it needs to go in the next merge window with the rest of
the new stuff and not now, with the urgent pile?

I'm thinking that because it is not really a bug now, as the negative ID
happens to work.

Right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
