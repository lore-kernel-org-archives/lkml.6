Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80E6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4962083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jf9no08e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfBEIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:07:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38988 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfBEIHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:07:24 -0500
Received: from zn.tnic (p200300EC2BCB6B008896F3D5E1C66173.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:8896:f3d5:e1c6:6173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 238E51EC0911;
        Tue,  5 Feb 2019 09:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549354043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bZH0hwcxylYiWABftVjvc9RMFQYk7djFeIQ0vgm4+CM=;
        b=Jf9no08eWupVfMtwI+XrCQM340KFqwRtSOOKUVx6W9AM7J+nPDqxB1QnYL/DU311XDLRoJ
        hSu8HZl1GUyBxGcztdKwULk+b8OUh+ZjHaZpNaY6catiWbQ3GkFdPKUSTYcr7Zu7KUeExy
        Dtr1+111wi+tAQAXA5eTinUjTYZNssU=
Date:   Tue, 5 Feb 2019 09:07:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 03/28] x86/asm/suspend: use SYM_DATA for data
Message-ID: <20190205080712.GF21801@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-4-jslaby@suse.cz>
 <20190204201831.GK29639@zn.tnic>
 <975ba79b-5a3d-b244-7d00-869b1da246b9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <975ba79b-5a3d-b244-7d00-869b1da246b9@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 08:34:09AM +0100, Jiri Slaby wrote:
> I also suggest noticing the size 0 -> 8 change ;).

Ha!

And one would think that binutils would've seen the ".quad 0" in the
previous definition and do a proper size but that wouldn't have worked
most likely, because before it was a simple label with alignment:

.globl saved_magic ; .p2align 4, 0x90 ; saved_magic: .quad 0

which didn't have a size probably because it didn't have an associated
type (or an implicit default type or so, no clue how binutils handles
labels).

VS now:

.globl saved_magic ; ; saved_magic: ; .quad 0 ; .type saved_magic STT_OBJECT ; .size saved_magic, .-saved_magic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
