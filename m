Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFDDC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F33C2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUojoPHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F33C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLAPkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 10:40:40 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42780 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLAPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 10:40:40 -0500
Received: by mail-yb1-f194.google.com with SMTP id s8so977350ybe.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 20:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KyNy40w++dlOJxJZqsTwDufOR/T3RFR2sKzGh4yWLAQ=;
        b=QUojoPHwTd/DRQEoc0DIBuhbhlRqAPOFOaDiAKasxJPWSfubTDV8029DvkEspbOuzo
         oTDnB2P/r+elgAtrcFoYR90eP/efbsEQYLMwRel1uVSQ4YMzr263LVe0hynHDwZjEL8f
         oO1/HdjvDQOOiuvvjAWx2cI1NfakStBRo8/iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KyNy40w++dlOJxJZqsTwDufOR/T3RFR2sKzGh4yWLAQ=;
        b=bjrggZHnQgVPOZ+TaWcqf2YyOFDzfUvenSWpynNPuyF1WSPFo07WUMEszNi3R2Lb32
         X9vokUUc+RmnybKpBoDXtmdfyDzPyzENqRbEi/FQ5SU+0GY7y7NYPuty+ceXQ1cINLp8
         jNmGW9Yd59vbIXIbjKWOjdKhlFn4TMMMM7xjAlDUSbHDZQlo1NGAzsY1TC6ZnB1RiWGb
         KPdYLNiU9EwIhoPkDd1q/MAHHUS1dPJilbHdTK1H525WaRdQGYX7AJgfk2fEIzxD1Dp0
         t9uhpyPq4eEF5oQIm7kpScJpcEqy4dtGvzkk6NYPb1dX/dnB9L0ZF/dINbawwBwl/GYp
         Uk4w==
X-Gm-Message-State: AA+aEWZ9a4FM016b39TLX/fCVvgy1yDU9RBtA27VRwTEY+sVCT7frF1f
        DW+jEbUJ4RdjuxxeEDEnIKKz5W2KIt4=
X-Google-Smtp-Source: AFSGD/WvQXhOVtq4qorT8Uqr4RHjdGQAOqJskxyaH9tpgZVual2vzhtMCVjak7L8Wmig0hFcsHlfbg==
X-Received: by 2002:a25:ab8a:: with SMTP id v10-v6mr8162711ybi.127.1543638544323;
        Fri, 30 Nov 2018 20:29:04 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id m66sm2193066ywc.37.2018.11.30.20.29.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 20:29:03 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id z2-v6so3139876ybj.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 20:29:02 -0800 (PST)
X-Received: by 2002:a25:3502:: with SMTP id c2-v6mr8232917yba.410.1543638542467;
 Fri, 30 Nov 2018 20:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20181127225408.7553-1-j@bitron.ch> <20181127225408.7553-2-j@bitron.ch>
 <20181128144230.GG30395@redhat.com> <87r2f5gr9g.fsf@xmission.com>
 <20181129123409.GA10645@redhat.com> <f55261dbc41544363b4348820f67fb01c6d7aaec.camel@bitron.ch>
 <20181130103329.GB23670@redhat.com>
In-Reply-To: <20181130103329.GB23670@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 30 Nov 2018 20:28:50 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKmz+zDH9nmYo=dwxWRNh=gYxb--Qy4x+KrFuBaT+L31w@mail.gmail.com>
Message-ID: <CAGXu5jKmz+zDH9nmYo=dwxWRNh=gYxb--Qy4x+KrFuBaT+L31w@mail.gmail.com>
Subject: Re: [PATCH] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     j@bitron.ch, "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:33 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/29, J=C3=BCrg Billeter wrote:
> >
> > On Thu, 2018-11-29 at 13:34 +0100, Oleg Nesterov wrote:
> > > So I think the patch is mostly fine, the only problem I can see is th=
at
> > > PR_SET_KILL_DESCENDANTS_ON_EXIT can race with PR_SET_CHILD_SUBREAPER,=
 they both
> > > need to update the bits in the same word.
> >
> > Good point. I'll make it a regular bool instead of a bitfield for v2,
>
> Agreed,

Is it worth doing something for singal_struct like we did for
task_struct with the TASK_PFA_* and atomic_flags?

--=20
Kees Cook
