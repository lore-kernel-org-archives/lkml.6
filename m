Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B96C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0F2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wuEst96b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE0F2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392062AbeHPSlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:41:51 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43726 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392044AbeHPSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:41:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9A5938EE171;
        Thu, 16 Aug 2018 08:42:34 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g3Rt6T3ljyrx; Thu, 16 Aug 2018 08:42:34 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D68FD8EE092;
        Thu, 16 Aug 2018 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534434154;
        bh=2Zr48lJMbqw+f2UZgU/RP/HEif+3uWgvVMgQgvOyIoE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wuEst96bxFRrUDJLh4lh0wQwxa1Ft3cDY/hDj2RsI3Tj00KuARmuGkt0JclRrtu1y
         IoaSv5GBQqYqpyIAKNGG6QuShTIGAMjypstlgqD4KF+Nhv9FaQO61oVAeEAHCl1kDZ
         URUA0pAslfh2Ub0el19+rxV6PphXu84W3Be1KS7I=
Message-ID: <1534434152.3166.7.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 08:42:32 -0700
In-Reply-To: <1534432615.3166.5.camel@HansenPartnership.com>
References: <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <20628.1534427487@warthog.procyon.org.uk>
         <1534432615.3166.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 08:16 -0700, James Bottomley wrote:
> So your lawyers tell you if you sign a third party module for your
> kernel then you could get blamed for the damage it causes?  So this
> whole escapade is about Red Hat trying to evade legal responsibility
> for allowing customers to load third party modules.
> 
> Firstly, your lawyers are wrong: Microsoft took a lot of legal advice
> before they agreed to become the third party signing authority for
> UEFI.  They definitely believe they can't be sued if they sign
> something that later breaches UEFI security.  However, I realise
> trying to overcome overly cautious legal advice is a no win
> situation, so lets move on.

Let me give you some advice from an old hand on this: You definitely
can't overcome a lawyer with a legal argument (well, unless you're
really good, pig headed and come spoiling for a fight), but you
definitely can with a business case.  Once you present a business case
for doing whatever it is the lawyer's have said no to, the next
instruction a good executive will issue is "quantify the legal risk so
we can balance it against the business benefit".  That's where a "no"
based on over caution usually gets overruled because the risks look
minor when exposed to scrutiny.

To generate that business case, why not merge Mehmet's patches?  If
other distributions start using them successfully, then you'll have
both direct and indirect business pressures for Red Hat to do the same
and it will force the re-evaluation you need.  If no-one uses them
there'll be no additional pressure and you'll be no worse off.

James

