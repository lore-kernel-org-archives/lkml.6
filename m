Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D33C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8921A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8921A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeK3Cip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:38:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbeK3Cip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:38:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E0F33098491;
        Thu, 29 Nov 2018 15:33:01 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E3C8183F6;
        Thu, 29 Nov 2018 15:32:59 +0000 (UTC)
Date:   Thu, 29 Nov 2018 09:32:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tools/relocs: fix big section header tables
Message-ID: <20181129153258.cutmesclgfadc5gu@treble>
References: <20181129135133.31369-1-asavkov@redhat.com>
 <20181129142312.kz2l5gm33yeaglnn@treble>
 <20181129152200.GA1776@shodan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129152200.GA1776@shodan.usersys.redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 29 Nov 2018 15:33:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:22:00PM +0100, Artem Savkov wrote:
> On Thu, Nov 29, 2018 at 08:23:12AM -0600, Josh Poimboeuf wrote:
> > On Thu, Nov 29, 2018 at 02:51:33PM +0100, Artem Savkov wrote:
> > > In case when the number of entries in the section header table is larger
> > > then or equal to SHN_LORESERVE the size of the table is held in the sh_size
> > > member of the initial entry in section header table instead of e_shnum.
> > > Same with the string table index which is located in sh_link instead of
> > > e_shstrndx.
> > > 
> > > This case is easily reproducible with KCFLAGS="-ffunction-sections",
> > > bzImage build fails with "String table index out of bounds" error.
> > > 
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > > ---
> > >  arch/x86/tools/relocs.c | 58 +++++++++++++++++++++++++++++------------
> > >  1 file changed, 41 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> > > index b629f6992d9f..5275ea0a0d13 100644
> > > --- a/arch/x86/tools/relocs.c
> > > +++ b/arch/x86/tools/relocs.c
> > > @@ -11,7 +11,9 @@
> > >  #define Elf_Shdr		ElfW(Shdr)
> > >  #define Elf_Sym			ElfW(Sym)
> > >  
> > > -static Elf_Ehdr ehdr;
> > > +static Elf_Ehdr	ehdr;
> > 
> > I think there's a tab missing here, it doesn't line up with the other
> > variables.
> 
> This seems to be a vim bug. It aligns perfectly in
> cat/less/lore.kernel.org which all seem to use tabstop=8 by default, but
> it does not align in vim, but it does align with tabstop=7 in vim.

Are you looking at the patch?  Or the file itself?

"less arch/x86/tools/relocs.c" shows the same issue.

-- 
Josh
