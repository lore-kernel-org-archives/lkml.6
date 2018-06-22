Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963AFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488E0244D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="swqtMrb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488E0244D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeFVPbB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933304AbeFVPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:30:57 -0400
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com [209.85.128.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F05244D8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529681457;
        bh=hiDtg/g/QICZ/JxkJsp2HYRKlr8DqYPDPcpGh5aRDNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=swqtMrb8Ie9PYnq37vlWMDX4ukF+z40n5+rZKzKMyyU4NRYbZwX3pE79eNQRPcYh6
         hDm/CObamJ4IB5FXUDIVWm7M9niBb287jFzTY4rTOFcgJFAQFynLzRGKqhR/D3YznK
         qEIO/5q4AI9XH17iik+vv2DMGpPzCe1EfItfskyk=
Received: by mail-wr0-f177.google.com with SMTP id d2-v6so7080677wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:30:57 -0700 (PDT)
X-Gm-Message-State: APt69E12l9Ds5ynJB8HIm+jJ+QfyTZWYfhG6MAIyfDcxW+ZolNhuzdqz
        8hOAchdbAhwKPOf5v5ePfszd4Ofdbhml7DelLEZmeg==
X-Google-Smtp-Source: AAOMgpdeCLjpihL4RImxhPmChaZhPe665mBfxnqM5+MjQK6a9KhzgsQrWW944SmCIIHua2PKXclxAF4emmDLxD0UtAE=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr1967688wrd.67.1529681455599;
 Fri, 22 Jun 2018 08:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
 <20180621211754.12757-8-h.peter.anvin@intel.com> <CALCETrVNGjdLv4zde=qz6kJW55yZxXvLqoHxbRpQCr==gW6gBQ@mail.gmail.com>
 <8991CF11-DDE0-4E93-B913-82968DCFB661@zytor.com>
In-Reply-To: <8991CF11-DDE0-4E93-B913-82968DCFB661@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 08:30:43 -0700
X-Gmail-Original-Message-ID: <CALCETrUdNZ9xUBi7116uU5dvufH9TcBTzcq5MvLoG7M7rcqLOg@mail.gmail.com>
Message-ID: <CALCETrUdNZ9xUBi7116uU5dvufH9TcBTzcq5MvLoG7M7rcqLOg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] x86/ldt,ptrace: provide regset access to the LDT
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 8:06 AM <hpa@zytor.com> wrote:
>
> On June 22, 2018 7:49:13 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
> >On Thu, Jun 21, 2018 at 2:18 PM H. Peter Anvin, Intel
> ><h.peter.anvin@intel.com> wrote:
> >>
> >> From: "H. Peter Anvin" <hpa@linux.intel.com>
> >>
> >> Provide ptrace/regset access to the LDT, if one exists.  This
> >> interface provides both read and write access. The write code is
> >> unified with modify_ldt(); the read code doesn't have enough
> >> similarity so it has been kept made separate.
> >
> >For this and for the GDT, you've chosen to use struct user_desc as
> >your format instead of using a native hardware descriptor format.  Any
> >particular reason why?  If nothing else, it will bloat core files a
> >bit more than needed.
>
> I did because REGSET_TLS was implemented that way, and that is simply a subset of the GDT (which made the same code trivially applicable to both.) modify_ldt() does it *both* ways for extra fun (one for reading, and one for writing.)
>
> ->active is defined as "beyond this point the regset contains only the default value", which seemed appropriate in this case.

I saw that definition too.  But I'm still very unclear as to what, if
anything, the code actually does :)

--Andy
