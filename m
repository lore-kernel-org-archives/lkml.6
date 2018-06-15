Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AD1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F338D208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F338D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756595AbeFOVKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:10:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756434AbeFOVKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:10:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6E60AE64;
        Fri, 15 Jun 2018 21:10:05 +0000 (UTC)
Date:   Fri, 15 Jun 2018 23:10:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Juergen Gross <jgross@suse.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Mike Latimer <mlatimer@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pti: don't report XenPV as vulnerable
In-Reply-To: <37a18a24-7825-9e75-39a7-a66086a5e3a6@suse.com>
Message-ID: <nycvar.YFH.7.76.1806152304400.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806150025220.6203@cbobk.fhfr.pm> <a5bfcabb-827b-fbf7-9395-de9332697c25@suse.com> <nycvar.YFH.7.76.1806150801530.6203@cbobk.fhfr.pm> <ff9f4a24-6e69-cc7b-ba75-e82c9182a805@suse.com> <nycvar.YFH.7.76.1806150815440.6203@cbobk.fhfr.pm>
 <821642fe-775b-e68c-2a66-73b73c810289@suse.com> <nycvar.YFH.7.76.1806150837100.6203@cbobk.fhfr.pm> <37a18a24-7825-9e75-39a7-a66086a5e3a6@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Juergen Gross wrote:

> Like it is possible to switch off PTI in the kernel it is possible to do 
> the same with XPTI in the hypervisor (it is even possible to disable 
> XPTI for dom0 only).
> 
> In case XPTI is disabled for the currently running system it is possible 
> to make use of Meltdown in user programs to read arbitrary physical host 
> memory (i.e. attacking the hypervisor) and this includes the own systems 
> kernel memory.
> 
> So telling a user the system isn't vulnerable regarding Meltdown when
> running as 64-bit pv-guest might not be the truth.

Ok, what a mess.

As I don't think it'd be wise to try to let guest kernel figure out 
whether host has XPTI, I'd suggest at least making the message somehow 
more informative. Something like

+               if (hypervisor_is_type(X86_HYPER_XEN_PV))
+                       return sprintf(buf, "Unknown (XEN PV detected, hypervisor mitigation required\n");

perhaps?

Thanks,

-- 
Jiri Kosina
SUSE Labs

