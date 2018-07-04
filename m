Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4192064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dgVjYSAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4192064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGDVPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:15:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37849 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbeGDVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:15:03 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so9550707itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9kqd1S/PiFevDjlzOlGHXrLAo0MxQ5cZn2QqwVHYNuU=;
        b=dgVjYSAoj6nl2pzgQ6jVIPNET+/tBOzP6KIpM94xIaG8SmatPurcXh1bsND32gP1WK
         f675RVEZIxGf7CEjfV10QLypb+du3UzUO2nFO7itQ8sQ67j0qWEUNM3qXEN22pONOG+N
         7XgodRrDCAkAIAcOWpmeAWu6TK2DSTKbi1j2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9kqd1S/PiFevDjlzOlGHXrLAo0MxQ5cZn2QqwVHYNuU=;
        b=tm502gXgUHS34o9yBMYx4b7PV1b2QgmxxC/MgKX1KOb0N6/R3/BIT51sdSfRvoTSHo
         tJEhJAJ1H2XVQgl3eOLBiXL5qAElcllLVcHSqwoLy3g/yL3c+T3koldDShqNm7ZuZ9sI
         DNfAzuE749q3UNUBx0xQojPZ930R9q01RCLWs0mHbrP+4yaEkAUff0SFN9sC7TVNk607
         wa0Stc4mZd/xADC9+++B3YCAKvaxpfRvshurpNZCTtJEhUx1U2hKjqdmuipCh8CyOwoJ
         gxjxihcyZFrRQcwA/ltYvdYqZn6I09CetlxHONItvlcL2TFCPTy4LTejiL4J9wMILuP+
         4XIw==
X-Gm-Message-State: APt69E18yOBB6jc9Ee8AnTmIhGQLs+ay9dp/pK2COd2xBGz3YM1f3rcH
        3Z1rUXdj6vNB2uTOjzjXCHlWhVxIEc54iSwrem0=
X-Google-Smtp-Source: AAOMgpdzE4iXCrP6VxV+x3gAvKaUDDFQlHRLQekTX/pr4Yl8BOjdWLhNtVV2DmmhLkOKrw2kx15x6QF3J2HeCSKCYpI=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr2821625itm.113.1530738902482;
 Wed, 04 Jul 2018 14:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180704065414.GD23907@yexl-desktop> <CA+55aFwSD8T1dusD_Q14MhAxQcYG===ZTdS+CXuT-odj88xWkA@mail.gmail.com>
 <E0E9D986-A638-4863-B49A-33B5B0B77352@amacapital.net>
In-Reply-To: <E0E9D986-A638-4863-B49A-33B5B0B77352@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Jul 2018 14:14:51 -0700
Message-ID: <CA+55aFy2H-W5pW2tp75yhgBi0LPKn0gCjid9uw+n8GSd=b=ChQ@mail.gmail.com>
Subject: Re: [lkp-robot] [x86/entry/64/compat] 8bb2610bc4: kernel_selftests.x86.test_syscall_vdso_32.fail
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 11:30 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> Nah, it=E2=80=99s a legit error.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/arch/x86/entry?id=3D22cd978e598618e82c3c3348d2069184f6884182

Ahh. I looked at the patch and it looked "obviously correct", but only
tested my current tree (which had the above fix), not that actual
tree.

> I blame git apply for being a bit overzealous.

Heh. git apply is actually very careful and refuses to apply with
fuzz, but yes, it will apply with a big offset if the original place
has changed and it can find another place that is an exact match (why?
Think "somebody moved code around").

But yeah, apparently that _right_ point had changed, and there was an
exact match at the wrong spot. Duplicate code is bad, hmm.

And I was then confused because I was looking at an *old* dmesg
report, and saw the old kernel version from there, rather than the
right one, so I incorrectly blamed "you're running the wrong kernel".

              Linus
