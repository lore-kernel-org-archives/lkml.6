Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02CEC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A5E21903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAZVME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:12:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35059 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAZVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:12:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so14501979qtc.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 13:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqDPi4evcw9cuSy8c7Vrx3CedcR00yuJYOpWb6GGvJo=;
        b=KUeF5lMG+QiG3/oLQ4v3lvblfAPFKv5HK7Hk+pHik+FrDC0A8Yh8rCjdfAO9czfmYV
         r6P122d7X/ZAJWKEsLR4IMpVg3nADz4pAAac5Z+oKZNqiLs2wM/x8CNkLLjoQsttT0ls
         +FObQp8U8hJVKpEfmSLb+k4E5/A3pKJbYid3Hj8oEO6c4n5ds6lEMwsm+8DyzeTD0FoM
         RP3nGsvQLTvTc+BCmBMqkI/SG1niRW8JLk8o/Ro0047R5dl/48UX+zlQvwcZ2kPbjBmA
         0L1gsirH/mSn64aKjuIINIVZaPbqou/O4AxB2L46aO3Uc8gR73wtlwaUaMefwRPRYvT5
         hm7A==
X-Gm-Message-State: AJcUukcvqwkcAJpFl85hqGDd25eu0VMG8kaMyQPYnGQwDOPW9D7bpxAr
        2Davdm/7TGmUs3NQeXech/usHJ4Eodi+uhWBiRo=
X-Google-Smtp-Source: ALg8bN5FBV5Wa93THkfk/pEuvg8K0RtwIx2+/RhM7pdZoq1EEXYn+9Ec4WU1RpJp4yko/YjtxV1z1LTPKLaUgRwdRj4=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr15308628qtm.96.1548537122672;
 Sat, 26 Jan 2019 13:12:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
In-Reply-To: <20190125181616.62609-1-olof@lixom.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Jan 2019 22:11:46 +0100
Message-ID: <CAK8P3a09qVNyCOMzuQgaivyWeOUY6d6kYGKFEAa7ertu-dUBdQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] HW accel subsystem
To:     Olof Johansson <olof@lixom.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, Dave Airlie <airlied@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 7:17 PM Olof Johansson <olof@lixom.net> wrote:
>
> Per discussion in on the Habana Labs driver submission
> (https://lore.kernel.org/lkml/20190123000057.31477-1-oded.gabbay@gmail.com/),
> there seems to be time to create a separate subsystem for hw accellerators
> instead of letting them proliferate around the tree (and/or in misc).
>
> There's difference in opinion on how stringent the requirements are for
> a fully open stack for these kind of drivers. I've documented the middle
> road approach in the first patch (requiring some sort of open low-level
> userspace for the kernel interaction, and a way to use/test it).
>
> Comments and suggestions for better approaches are definitely welcome.

We probably want to move drivers/misc/mic together with the others
as well. We could even move arch/powerpc/platforms/cell/spu*/
for another historic example.

        Arnd
