Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CABC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B86C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B86C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeH2MCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:02:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39865 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2MCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:02:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so7612880oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnuMX/Hh+r5PIRx1kibpxvbhPvdjleFnYNrxHYlVerU=;
        b=Y19loSsFws0BknX0uKFPihiBNg6jLWJHpP7GKDlJ8iG3SFX6v4YWf63J78NDVNEFAo
         javHuhIJPXGc3vra7NXXM4qgWUJ8+tSccV5rIVR44589Apow1jUdt5dwY7C8sYWNAWUi
         frbo4Yy48OsgTl3e4woiu58tapKOh8GtWFBTaHOnOLbw9dIZ0fCCpDs3Yao/x/6nAtgD
         UNQfI1q3IB2kaSCesyDlzF/Rb2Y2m/yNOB2ZQQbutzVKcNrN+afNrVzph4ybihAiDc7M
         npwymcTyJpVefukJTZcf44I3f5gsKT+Lr1PXLhWGqDIAH0R4694dWjoMvWLEaKdoNxCH
         N4MA==
X-Gm-Message-State: APzg51CdLJIfwHwF9j0wdIyWc2+wBATd2iHg/FDs55tjVcj620xBoGPP
        ckSnCs0KI2epGB6EkWPBKgprMROheGOI82x8wqU=
X-Google-Smtp-Source: ANB0VdZG1lMhZW8wrJzm/0l9GJXg5wM79koeYOCJHV3qlmgaxwmQFA9MsX3lctegHUYReLAzHHf1SN4smhn40njQIbg=
X-Received: by 2002:aca:3744:: with SMTP id e65-v6mr1822109oia.12.1535530017695;
 Wed, 29 Aug 2018 01:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <1535527943-32566-1-git-send-email-krzk@kernel.org> <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
In-Reply-To: <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 29 Aug 2018 10:06:46 +0200
Message-ID: <CA+7wUsxE5gUXuUzkZ5bjz_d5WXab8RQxF3bre_DAMpUW=QpKTg@mail.gmail.com>
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with KERNEL_XZ
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, mkubecek@suse.cz,
        Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 29 Aug 2018 at 09:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > After commit faa16bc404d7 ("lib: Use existing define with
> > polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> > directory thus any other user of this code should define proper include
> > path.
> >
> > This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
> >
> >     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
> >                      from ../arch/powerpc/boot/decompress.c:42:
> >     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
> >
> > Reported-by: Michal Kubecek <mkubecek@suse.cz>
>
> Reported earlier by Kbuild:
> https://lkml.org/lkml/2018/8/23/47
>
> for the credits:
> Reported-by: kbuild test robot <lkp@intel.com>

Technically Meelis reported it earlier:

https://lkml.org/lkml/2018/8/22/365

;)
