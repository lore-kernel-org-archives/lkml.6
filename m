Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C69820842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="hhubx0oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C69820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeGMKDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:03:40 -0400
Received: from 8bytes.org ([81.169.241.247]:37296 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbeGMKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:03:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0BDFE377; Fri, 13 Jul 2018 11:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531475383; bh=NLcxiq8C7Uy6pxc84r00LyCyDjN7Yo1Hg8KyVrivt68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhubx0oR1uL/GLOVLHnul9mLVDpYADmraw6fh04TP5e5EG335H8km5UHaoubSuqgZ
         TpPN2DrMtjobJSeoE8saXGXr0r8JiOR01hINgcKg8aA6eauSaCEHUNdmJ6QNDwgGWg
         /WHbUB09w7FueQpLzRUD/IdOj5Pz9iifdHtRErLefKJuKjig+LM5h/KOttC2BVUc+f
         l5o++RGXYHFk1+7DAGTXxXlrRWAKVmgKljUXVZ2nrsxuqlBzxTh1RYjodR4SUH2krT
         yMlJVOzzM5IXcHex0KFQmytCobKaBLBqXCbgZ4xGGxtvimswjrK5TWxAI2xw+ciAGJ
         K3X6COS4IFc+Q==
Date:   Fri, 13 Jul 2018 11:48:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Subject: Re: [PATCH 03/39] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
Message-ID: <20180713094849.5bsfpwhxzo5r5exk@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-4-git-send-email-joro@8bytes.org>
 <823BAA9B-FACA-4E91-BE56-315FF569297C@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <823BAA9B-FACA-4E91-BE56-315FF569297C@amacapital.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:49:13PM -0700, Andy Lutomirski wrote:
> > On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> >    /* Offset from the sysenter stack to tss.sp0 */
> > -    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
> > +    DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
> >           offsetofend(struct cpu_entry_area, entry_stack_page.stack));
> > 
> 
> The code reads differently. Did you perhaps mean TSS_task_stack?

Well, the offset name came from TSS_sysenter_sp0, which was the offset
from the sysenter_sp0 (==sysenter-stack) to the task stack in TSS, now
sysenter_sp0 became entry_stack, because its used for all entry points
and not only sysenter. So with the old convention the naming makes still
sense, no?

> Also, the “top of task stack” is a bit weird on 32-bit due to vm86.
> Can you document *exactly* what goes in sp1?

Will do, thanks for your feedback!


	Joerg
