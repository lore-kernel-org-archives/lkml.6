Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B51C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A60F20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A60F20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeILBOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:14:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38172 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeILBO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:14:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id g197-v6so17640096qke.5;
        Tue, 11 Sep 2018 13:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1GBRmA4/IEKBFZdUX8kqXiwNtIxV8BkEEJ+V4/1vEc=;
        b=rRjS/uj271mkRuucVLr+Em3G4uExBlshSxqjilK7g3QXUoJpx8UrMCqUVXAZFevFmA
         ucwlrrMh1yA/CbwlPeTdfIjVSsyNx1BFeuoWUTXAoXj1xviKEB37NIjKXZxJKU5wvVKp
         3neBnYawiOphPL1VurvXFO1AksyP7zI0oDMaRN24Rz30BAZCJ7e7L7TIw1r40arNXEVP
         9ldPq1g8hB2whbbpk5NIkUOGswIc7UtkyrUbKFiRXh+Yo4lK7Q97yGETxaUr1vANglgJ
         C0iUF2gGYLb9FGU7jQGFnk4YrqPB2glNvidN9A+eYSwT5c7I7XYn5ft8nchZDp5n5nJJ
         Pgxg==
X-Gm-Message-State: APzg51CpNKmP1GyRR15K8YdjK2PNOLVcMPaBPUsfiemyaqhLV3dBqLLg
        FJUZVrEE1IbdO8UQkMc9RDBFfN9TwQz7YgeQTW0=
X-Google-Smtp-Source: ANB0VdaMIGJdWo5+c0069mKGguh3xQU+tFq895aB5DmGOA50IiFAxs/09+/HLdCVfH+95EyOgWQIUQ5URRgvKREiyio=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr85655qkc.291.1536696814333;
 Tue, 11 Sep 2018 13:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-11-arnd@arndb.de>
 <20180909043746.GF19965@ZenIV.linux.org.uk> <CAK8P3a0evhaJGL_XdUjQhJDGyAh01UjLFkKx-Cq21htXmFsY2A@mail.gmail.com>
In-Reply-To: <CAK8P3a0evhaJGL_XdUjQhJDGyAh01UjLFkKx-Cq21htXmFsY2A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Sep 2018 22:13:18 +0200
Message-ID: <CAK8P3a0nrNUpcYZiV7T14HXPfoiR4LyMM6E+8fP6AWgRMgDpxA@mail.gmail.com>
Subject: Re: [PATCH 11/11] compat_ioctl: move tape handling into drivers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, osst@riede.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kai.Makisara@kolumbus.fi,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        osst-users@lists.sourceforge.net,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 5:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Sep 9, 2018 at 6:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Sep 08, 2018 at 04:28:17PM +0200, Arnd Bergmann wrote:
> > > MTIOCPOS and MTIOCGET are incompatible between 32-bit and 64-bit user
> > > space, and traditionally have been translated in fs/compat_ioctl.c.
> > >
> > > To get rid of that translation handler, move a corresponding
> > > implementation into each of the four drivers implementing those commands.
> > >
> > > The interesting part of that is now in a new linux/mtio.h header that
> > > wraps the existing uapi/linux/mtio.h header and provides an abstraction
> > > to let drivers handle both cases easily.
> >
> > Ugh...  Frankly, this bool compat passed all way down looks wrong.
> > I can live with that; the question is whether block folks will be
> > OK with that thing...
>
> I have tried to come up with an alternative, but couldn't really find anything
> that is less ugly. Since nobody else complained, I'll resend this version
> along with the other patches.

Actually, there was one idea that Deepa mentioned for another subsystem
with a similar issue: instead of passing down the fact that we come from
a compat syscall through multiple function calls, the lowest ones
(put_user_mtpos, put_user_mtget) could call in_compat_syscall().

Would you prefer that?

      Arnd
