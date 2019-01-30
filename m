Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECD22086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qAEPMEDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfA3Qqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:46:30 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33868 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfA3Qqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:46:30 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so86150ywb.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSD7YXidw3iawgUDKrAXxDkF0R5OJ1Ym0U1KeCRbTdI=;
        b=qAEPMEDjoTqJqoU7WhK3r3PCecjoG7egw1ildOLrV4tjkWHHKmIyxqeYmOsqepYsEs
         8bmuXRQOEcnO8TzSeK9UaKJI8jWuI/6Q8wSRZI+Lq5S8tQ4NondNiN8ASDIE/Qz2Rbiq
         bAb8GWpLAGvapSKLP36EX7VnTPvAOMWWHaTRt3m4q0GUIN+NiRESJt/47qLJTtT77L28
         qa53gnBy0JJ6FYr3PCmxDoP+72zMUFgERLIJo5DEnByhFuHxMMkRpMk+h7dHackaPUg1
         pKlzQ1YlnqKAg2VG5I8li6fmBtW1BrrWMTO8KyAen1OAkoeIg2u27663LJYVtY7lQYkT
         WgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSD7YXidw3iawgUDKrAXxDkF0R5OJ1Ym0U1KeCRbTdI=;
        b=CCgHQQMr0EeRsFrYtf1JrHjq2cLGaBAGzC15SuY6BPSR9wpmat32L8bGaUYmCHOrAS
         Re+622tqwcFXqOpw3sKZh/yYqhWzuuzUshsW/cnSsH/buInzEPaqujdr8WlztoZJXDCX
         YUsmsxjAO8H0wsn1rhICrMtfhaQp+3gLhfOpsN8ALGMtT73+SYL53bCk9YLxpJzNiZ7d
         t8c42A+Q5+3FUPPkmN3xPRfqZ9NfQKCjZAKaA5xrFxBDBvZdmEnX2Y4k+nv6C9VS/WJP
         SJ6bIzRZQW38Si5SO2ATUWLnFCMFw/sCtDWFa3iVR+/4cG0R5dpSVvNnw8SkhIxPMJCl
         21ng==
X-Gm-Message-State: AJcUukfuKhrItNmbSZPvjQHKJGdcyCAAOYzOHtYir2PBMiORs+nuZ4JY
        fjLoDUh2Vw/AJ8bwykAWdQdCXg==
X-Google-Smtp-Source: ALg8bN4naL04qrwNabwXYb3Ab6nM8ZXvnWWhuEkztAYmMS0bUaQArY/MCxgrGIO7z0KmNi3cC8fVYA==
X-Received: by 2002:a81:99d6:: with SMTP id q205mr30090628ywg.106.1548866788585;
        Wed, 30 Jan 2019 08:46:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6c95])
        by smtp.gmail.com with ESMTPSA id y63sm1043684ywy.1.2019.01.30.08.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:46:27 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:46:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Message-ID: <20190130164626.GA17841@cmpxchg.org>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
 <20190129230845.GG28773@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129230845.GG28773@zn.tnic>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:08:45AM +0100, Borislav Petkov wrote:
> On Tue, Jan 29, 2019 at 05:52:18PM -0500, Johannes Weiner wrote:
> > "Resource Control" is a very broad term for this CPU feature, and a
> > term that is also associated with containers, cgroups etc. This can
> > easily cause confusion.
> > 
> > Make the user prompt more specific.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  arch/x86/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > As somebody who works in "resource control", this prompt in oldconfig
> > certainly had me go wtf. Can we do something more specific?
> 
> Well, since this is an interface to a hardware feature, we could call it
> 
> Hardware Resource Control
> 
> for example. I.e., HW_RESCTRL.
> 
> Linus had another suggestion - CPU_RESCTRL - which sounds ok to me too.
> 
> > Not insisting on this name, and I haven't renamed all the config
> > symbols yet, but we should probably fix this before 5.0 is released.
> > 
> > Thanks!
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 26387c7bf305..426677b759c0 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -447,11 +447,11 @@ config RETPOLINE
> >  	  support for full protection. The kernel may run slower.
> >  
> >  config X86_RESCTRL
> > -	bool "Resource Control support"
> > +	bool "x86 cache control support"
> 
> Except that it is not only cache but memory (bandwidth) control too. So I guess
> 
> 	bool "CPU Resource Control support"

This is still awefully close to the cgroup CPU resource
controller. Since it's more hardware-specific, and the config symbol
also has the x86 in it, how about "x86 CPU resource control support"?

---

From 2a24f6e30ed9dbc0abb96c73ec0e205e07034383 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Tue, 29 Jan 2019 17:44:36 -0500
Subject: [PATCH] x86: avoid confusion over the new RESCTRL config prompt

"Resource Control" is a very broad term for this CPU feature, and a
term that is also associated with containers, cgroups etc. This can
easily cause confusion.

Make the user prompt more specific.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..ac432379df11 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -447,11 +447,11 @@ config RETPOLINE
 	  support for full protection. The kernel may run slower.
 
 config X86_RESCTRL
-	bool "Resource Control support"
+	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Enable Resource Control support.
+	  Enable x86 CPU resource control support.
 
 	  Provide support for the allocation and monitoring of system resources
 	  usage by the CPU.
-- 
2.20.1

