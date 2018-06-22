Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE545C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9124930
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmRqh6PH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IVG1wUsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD9124930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeFVVv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:51:26 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43590 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeFVVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:51:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so2879206ywc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/I2+lEnClb0G8zFqfbDfDPry7tyx3pjpR0MTIS7iIFU=;
        b=ZmRqh6PH/3xvVHMHLWtWoY4W2SMKhL4kWVgtccGoXJ5HD4j+Vreu0vXbS1R2KD48ZD
         i8NeUPvL16YZ+6gVSgP1wTeWaic/aRUT3eUhpro9F05qgD0b5hg9Ncp5vBJb2S85ZqL+
         XE4ZmnuQX8aZiUnv8OxUAzzU6/oldrsmNznmgIad7647Z8dIXkptuaeWPj7RK46lyLJe
         qXBn2qmz5ZoXnektCfo7cg8UgR2HXxToXvvPF3lJ3v6Xj6ZkGeF5kwTIGkCZCbZK97tI
         738RKZ6IUuPCqRBA4g9RrLyg3++iXvikDg81Xa7ANd+e7/JxQobJamGF4NZvqZmpCKV4
         0n4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/I2+lEnClb0G8zFqfbDfDPry7tyx3pjpR0MTIS7iIFU=;
        b=IVG1wUsHxWnxBpiy+HEEQYUxeVIwHQ2Mc03EKa+bCUts5D4YJFZ9ZmVpiGzBVv/xbZ
         y3lMAJknG/rTDy1t7pFEStBVe6q4vuNzqlR74bJfiJwQIxp6k8sTuLeeFd894WunCAYG
         7sIDr7kCUwskk9qXjDQS3+D2a3rcqy5eI+JLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/I2+lEnClb0G8zFqfbDfDPry7tyx3pjpR0MTIS7iIFU=;
        b=PDJZ46ynRWZatTh+ZO3QSgGcaCi4v8ruEK2GjJT1s3izQK7QMVEkCExcWgCXSx/IIB
         PO1LXYsrgM9QPhlKMSswwbw1FGSgidg2GJV+mhx/e0ndY07bbBd3wECT0w6SFLnQFamt
         K3ChSnKbvdV6OgGR6sfsbFzkb9NXs/46IoHzi4TMQJaTOdFn+E9zwY+rUxmTcEt7mM4V
         8GuG1XvWwZsfI35klp6991qZt8nyZ1z1ZBtfriQQHXatGn2KBtbxeiGhBwy/oTcY4EEJ
         xYUPmxC+6sHl/I+My/gccEmUm/K52jTXJ0BI3hdIc8L6/JCHadr3MxlAhi5PVf5iqAnO
         K30A==
X-Gm-Message-State: APt69E3vueRCoQdS/bawPoF1S5PyolDRG2p09MopbpYgA6aCgjYJnw0C
        gFv1HuyoI/mEDGzG9fcYRscfh0cF2vpWHEIpaF+mXIgz
X-Google-Smtp-Source: ADUXVKJxDUjpx6rC8OeeWMCi47FG2bCvYpARxUusM21ly1NXuBa03+A6r3d7et3fiSU2L0mLXNaVjSxv0a0NMFSYW7g=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr1683810ywf.129.1529704284112;
 Fri, 22 Jun 2018 14:51:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 14:51:23
 -0700 (PDT)
In-Reply-To: <E8029AD7-7009-4CBF-911E-186328237176@amacapital.net>
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com>
 <20180622151514.GM3992@cisco> <E8029AD7-7009-4CBF-911E-186328237176@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 22 Jun 2018 14:51:23 -0700
X-Google-Sender-Auth: 2ViZdDwAPfq3WbwPCCZmxrvg9Mw
Message-ID: <CAGXu5jKWQCDzXPdTz=+bxT9+4enaBvgYfMseUiGti+t1KwZT8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:09 AM, Andy Lutomirski <luto@amacapital.net> wro=
te:
> One possible extra issue: IIRC /proc/.../mem uses FOLL_FORCE, which is no=
t what we want here.
>
> How about just adding an explicit =E2=80=9Cread/write the seccomp-trapped=
 task=E2=80=99s memory=E2=80=9D primitive?  That should be easier than a =
=E2=80=9Copen mem fd=E2=80=9D primitive.

Uuugh. Can we avoid adding another "read/write remote process memory"
interface? The point of this series was to provide a lightweight
approach to what should normally be possible via the existing
seccomp+ptrace interface. I do like Jann's context idea, but I agree
with Andy: it can't be a handle to /proc/$pid/mem, since it's
FOLL_FORCE. Is there any other kind of process context id we can use
for this instead of pid? There was once an idea of pid-fd but it never
landed... This would let us get rid of the "id" in the structure too.
And if that existed, we could make process_vm_*v() safer too (taking a
pid-fd instead of a pid).

-Kees

--=20
Kees Cook
Pixel Security
