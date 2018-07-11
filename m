Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C806CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1C520881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVBmdlrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1C520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbeGKPmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:42:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40647 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbeGKPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:42:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so18632811wrn.7;
        Wed, 11 Jul 2018 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6KaHoyRfapWfv24HPjm98LVoPSFIMB1vsxt03M8b8Ck=;
        b=qVBmdlrho6fWsNgxRoU0wb9Xerog+HXJER6GP2X8axp5AbqLYWHC3RpBjqoPNTlfLp
         +uQwgDM7UETjcrVgEKbd21a/O/l7fl5AeouE/rcRC8L9FJVtiYaUBkYdEaaypf80tVUZ
         zH7ucFiLA+pRR0jmtVSaNvwlp+7bpwFtT651+WwLQvYTbWEAOL1K8mYgBD9WjYACKIEw
         B2wcZfaaY8KfkszdS8+AL4UmZk200b0wQJyszTCR2chE06QEAA5uCmJi+ZTIreLyEfta
         QhyMZzUioMAZX3Gkn3LkefgxMwnjm60Edlakj+wEqqNJ/3UzZBrRsTVv+vWWkx3pyp2X
         E/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6KaHoyRfapWfv24HPjm98LVoPSFIMB1vsxt03M8b8Ck=;
        b=EhxOGRXJ2Bp1+43L3/n3HRYPT7Nt3bTtbRYWMzRGy7+X6fWdksap3/OsCYIYybI+p/
         2rxfufAgjDtsmRsrTyTgsCfaMPPBJpjapiJdKJMpYS3Q0jOoBAemuzj8Z8g2QTjHkWD4
         AzFV6FjQsHkihigHoHgfK3TRBPcTh0f78U5X+ziRnYFpTiTYraF7qEynB+KBqqGr8kGw
         g1DrWbpVgqhcnWe+5go+0O1CW/gRvTpYI69NlAj2la98LqJ2TNHr9Wji0IYALjxYFNP4
         HZMEf2LBsv3Bghn5kWNzknPMwgQiC4VoyUMfjL4QQzUA6HPrlDVGBuGViT50QqKAVleJ
         gFdQ==
X-Gm-Message-State: AOUpUlEH2iMdAP793TB6QLnpwF5tXr4R61Xpu58TAsMPuJoafZLh5q8l
        8zIN3BVtpmhPpEvPyWNzzAEvaA==
X-Google-Smtp-Source: AAOMgpfDEbMiFD3tRxsf9bLsSfEaheZo9c9XJFTqFlaeCDheLCyM2/gAbnwImj8b2zuRo94m/sfcSg==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr13450316wro.264.1531323459699;
        Wed, 11 Jul 2018 08:37:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s10-v6sm3727088wmb.12.2018.07.11.08.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:37:39 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:37:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Subject: Re: [GIT PULL 0/1] EFI mixed mode fix for v4.18
Message-ID: <20180711153736.GA4500@gmail.com>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
 <20180711101303.GA8574@gmail.com>
 <CAKv+Gu8m4UgL0GyYDuu5z+dzEF=N--H4PkqoO_xqwyW2_A+RMA@mail.gmail.com>
 <20180711111427.GA27216@gmail.com>
 <CAKv+Gu_LJEu11NV5CVTPV9ieZ=XKkgW2qdkFJ+1iWk+F2jNPww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_LJEu11NV5CVTPV9ieZ=XKkgW2qdkFJ+1iWk+F2jNPww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 11 July 2018 at 13:14, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> >> On 11 July 2018 at 12:13, Ingo Molnar <mingo@kernel.org> wrote:
> >> >
> >> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> >
> >> >> The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:
> >> >>
> >> >>   Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)
> >> >>
> >> >> are available in the Git repository at:
> >> >>
> >> >>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
> >> >>
> >> >> for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:
> >> >>
> >> >>   efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)
> >> >>
> >> >> ----------------------------------------------------------------
> >> >> A single fix for the x86 PCI I/O protocol handling code that got
> >> >> broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
> >> >> fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.
> >> >
> >> > Just curious, because it's unclear from the changelog, what was the symptom, a
> >> > boot hang, instant reboot, or some other misbehavior?
> >>
> >> Hans reported that his mixed mode tablet would not boot at all any
> >> more, but enter a reboot loop without any logs printed by the kernel.
> >>
> >> > Also, what's the scope of
> >> > the fix: were all 64-bit on 32-bit UEFI mixed-mode bootups affected, or only a
> >> > certain subset?
> >> >
> >>
> >> Any mixed mode system with PCI is likely to be affected. I have added
> >> a QEMU mixed mode config to my boot test environment to catch errors
> >> like this one.
> >
> > Ok, I've added this information to the commit - will be useful to backporters,
> > to judge the severity of the bug fixed.
> >
> 
> Perhaps it wasn't clear from the commit log that only v4.18-rc2 and
> later is affected by the mixed mode issue, since that is when a fix
> for ordinary 64-bit x86 was applied that affected v4.18-rc1.

Ah, ok. Still, if for whatever reason the commit that introduced the problem is 
backported, this one will be too. The chain of sha1's seemed rather long, so 
there's a chance for that.

> However, the EFI stub code is not expected to expand that much, and so for the 
> time being, I'm fine with a combination of review and rigorous testing

Fair enough!

Thanks,

	Ingo
