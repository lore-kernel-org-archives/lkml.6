Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E1DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3894D20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+m7GGMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAWMMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:12:39 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40035 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfAWMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:12:39 -0500
Received: by mail-io1-f68.google.com with SMTP id k2so1473630iog.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7CuKdBNpc7lIzSxWikvoBf9wcEakd+B812ZHSpJjJVY=;
        b=H+m7GGMjF6744xT1D2UwyNiY/KMpTtbRw5bi2y+pCDduRAgSAvhW2ZIPfnH2kOOExh
         3Su0JFmxMJMowRT9N2wYUjrjYvuBsgKmxpYbizh11PtffeWo9FwZbrdMYunm9gcvYSN7
         D7CAGGUmeHybx5kZaQ1Zx2WU51V6DvtSTJ2bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7CuKdBNpc7lIzSxWikvoBf9wcEakd+B812ZHSpJjJVY=;
        b=qQ653MXo/8qnxL+VvFSfWAGJTQjs0vWDAVfdsx1LBdYB/HhGJosUMplhwoSS7YbQDv
         L3amboo1SPD0lHmqDn6EOegdm/f1uwOKeaEIHjDkMc7qRcRAScFLHj3I/Bjs9kFfThvT
         rHBLhsIGVQ57fbTAWguPqXjeTHZA++eRGrLx3scUV3XxbEl7enlRP5Ck1ewGh1wsnxEh
         V3Xd77weAseaVbWT4++S6Aw5FrRKxXObKwyr/nwPKWJoKUi7UlXsbLm7o+Nj9BsP5Krd
         5CF/6apXDgJgeuFUiTBpProipKIUBlqfSSpo44p8ROknZBiicuJvmTg3aXOHT529Uajv
         8Y+g==
X-Gm-Message-State: AHQUAuYV9idQpCRoX/u5Kv/+JLN/N825jWV7iTm8YFFl+6tVg0ZZjMGE
        nz0s+fZMroO6F4plPuqiXjZOAVez+V6eqghZCBPBHg==
X-Google-Smtp-Source: ALg8bN4sFH3iEczabalnBNhAFEjMavAEqGBGd/B710UVgMJuAnz9dDSdLnQkCrtIxakuPDjbIn3RSmgeu7Pdts1qkOs=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr1019729ion.173.1548245557818;
 Wed, 23 Jan 2019 04:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
In-Reply-To: <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 23 Jan 2019 13:12:26 +0100
Message-ID: <CAKv+Gu-ECKNy+nmnbsetkOg28VR1YkFgnRsu+u9mN4DC_poBwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] treewide: Lift switch variables out of switches
To:     Jann Horn <jannh@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        dev@openvswitch.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 13:09, Jann Horn <jannh@google.com> wrote:
>
> On Wed, Jan 23, 2019 at 1:04 PM Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> > > Variables declared in a switch statement before any case statements
> > > cannot be initialized, so move all instances out of the switches.
> > > After this, future always-initialized stack variables will work
> > > and not throw warnings like this:
> > >
> > > fs/fcntl.c: In function =E2=80=98send_sigio_to_task=E2=80=99:
> > > fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitc=
h-unreachable]
> > >    siginfo_t si;
> > >              ^~
> >
> > That's a pain, so this means we can't have any new variables in { }
> > scope except for at the top of a function?
>
> AFAICS this only applies to switch statements (because they jump to a
> case and don't execute stuff at the start of the block), not blocks
> after if/while/... .
>

I guess that means it may apply to other cases where you do a 'goto'
into the middle of a for() loop, for instance (at the first
iteration), which is also a valid pattern.

Is there any way to tag these assignments so the diagnostic disregards them=
?
