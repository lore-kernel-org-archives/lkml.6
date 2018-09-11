Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F90C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6841A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6841A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeIKUgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:36:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41327 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeIKUgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:36:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id h138-v6so17013120qke.8;
        Tue, 11 Sep 2018 08:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgI/SnWVjnJB8GyOZXASjRNs9jm3sq4MEmurlkF8b1Y=;
        b=YVDnJKXJ9bxG0TGWH+M4y9agd3n9NTFWkZjlZoMsSVDLH8t2Bmrkd6IAZyrtTP1ZyV
         yg3YMOb/CuW17++3OA6ID/AMl+VObiTUoJtEQYFbyU3etVOgmCmDNg9dAtWjdLSOQrmV
         Y0sF0GrlQ/t9/L9jEozQUP4oFjpdjMEMoEeglylhTrBT51Bmfl5uRc6ij8B0WN8oF/05
         FK4ntlOzJAagELNJAhbZn0MAqF1UgQxFC+WWNSgdyEP5tyXG//lYE5IfMiP8/NfcHn68
         o8YF2xTFfZaX9c+GpnTHwWV+xO+QgZYqn1qY6kFDxtkkn6ixwURAQKVHyrKWyxfvX/5K
         LIew==
X-Gm-Message-State: APzg51BrkzLxK1pS5uuT47nE/qoyt/lAf8IMb3l9ac2+6YzbJ+Pk4RS7
        ywlxV9s/ePqhE44HJnHRFkz5aaUBKsNjQ9l3Ns8=
X-Google-Smtp-Source: ANB0VdbxpxcyWLaB7jQgG2T+2uu73BS+mkCYemrW7xbuifguTjcHs7f2bz/cp8RypTGx5XlU2vaHB+IJgzz0Y8MQNEQ=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr19800907qkc.291.1536680222718;
 Tue, 11 Sep 2018 08:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-11-arnd@arndb.de>
 <20180909043746.GF19965@ZenIV.linux.org.uk>
In-Reply-To: <20180909043746.GF19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Sep 2018 17:36:46 +0200
Message-ID: <CAK8P3a0evhaJGL_XdUjQhJDGyAh01UjLFkKx-Cq21htXmFsY2A@mail.gmail.com>
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

On Sun, Sep 9, 2018 at 6:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 08, 2018 at 04:28:17PM +0200, Arnd Bergmann wrote:
> > MTIOCPOS and MTIOCGET are incompatible between 32-bit and 64-bit user
> > space, and traditionally have been translated in fs/compat_ioctl.c.
> >
> > To get rid of that translation handler, move a corresponding
> > implementation into each of the four drivers implementing those commands.
> >
> > The interesting part of that is now in a new linux/mtio.h header that
> > wraps the existing uapi/linux/mtio.h header and provides an abstraction
> > to let drivers handle both cases easily.
>
> Ugh...  Frankly, this bool compat passed all way down looks wrong.
> I can live with that; the question is whether block folks will be
> OK with that thing...

I have tried to come up with an alternative, but couldn't really find anything
that is less ugly. Since nobody else complained, I'll resend this version
along with the other patches.

       Arnd
