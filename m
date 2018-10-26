Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D8ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4677D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W+CivsH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4677D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeJ0GYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:24:42 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:39122 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeJ0GYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:24:42 -0400
Received: by mail-lf1-f50.google.com with SMTP id p11-v6so1994419lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGFKdQPgiE1MPxeixj4qbzUqAmUsO63g2fKWKdkHi1w=;
        b=W+CivsH44GwxQVN0+5G4EmaRbIhCBK30+b9Zlf7IOLQkK6IFzj9ENP+unVPhfPenrC
         VeWFxmfWwuEGenfsh4x6Ae6supEjQk01JQyHljNIiFaFJPGog/8hA0vgcfvofodccr3z
         WGKyGikKoZFVF5yye/16SVVkRXO2kgXzvPj98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGFKdQPgiE1MPxeixj4qbzUqAmUsO63g2fKWKdkHi1w=;
        b=lWUHofHqwNb3NkjxIQp2L0CpywHa/shJZDkKXdbKERa9xfYx7BzCxSpz4WF03QbQoF
         wFX3B9hGK2fEPkfl1kmUVhOc+gghKD8s+thH8G8m+0XEmUWfw4Xxzq+9f9Z+PHF4tAsz
         2wJ5KKaU+321wwoz7FBoi+8zvIuhsTOj8EFgX+j7u1tsHeKOtMzg67yRj66SqO2YU++V
         Pl7h1wE2LRYCxazkMvdDSNYmRR3AWsjwI+IEa4PFqY8BafxCUycW+VJJ8k8v8eqGmPZj
         W9eo/rWO9OXU2wOt+7gQ2SbAqP6H3FlLXHMmRBRZkdsVfqGYEhLnzKnSadJUv5gMFAJa
         WKJQ==
X-Gm-Message-State: AGRZ1gLsUiSIfM1w5Jf1N81hPzYkYV6pj5oSnVb7Vn+Vg+7OaDRZkfqb
        tePazeNyS1mZb61EXOFtC/OaZ9R5hwGMqQ==
X-Google-Smtp-Source: AJdET5cFekCxuwxN6Mdy9lq/IJbIgc+BYOBPBI+qfsVaxJSYDyPMPpBhvLFP0b1iYS3Pkb2exWpKOg==
X-Received: by 2002:a19:cc46:: with SMTP id c67mr3157665lfg.145.1540590359056;
        Fri, 26 Oct 2018 14:45:59 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 205-v6sm977971ljf.38.2018.10.26.14.45.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 14:45:58 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k11-v6so2477049lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:45:58 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr3374876ljh.59.1540589932213;
 Fri, 26 Oct 2018 14:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <87ftwssg7m.fsf@concordia.ellerman.id.au>
In-Reply-To: <87ftwssg7m.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 14:38:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8hOhDQR61+R2w0YbOnXAmfvWWSvyN9pMsNU8MFF6wvw@mail.gmail.com>
Message-ID: <CAHk-=wj8hOhDQR61+R2w0YbOnXAmfvWWSvyN9pMsNU8MFF6wvw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-1 tag
To:     mpe@ellerman.id.au
Cc:     amodra@gmail.com, andrew.donnellan@au1.ibm.com,
        aneesh.kumar@linux.ibm.com, anton@ozlabs.org, anton@samba.org,
        aravinda@linux.vnet.ibm.com, Arnd Bergmann <arnd@arndb.de>,
        b.zolnierkie@samsung.com, benh@kernel.crashing.org,
        breno.leitao@gmail.com, christophe.leroy@c-s.fr,
        clombard@linux.vnet.ibm.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dja@axtens.net,
        ego@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
        fthain@telegraphics.com.au, geert@linux-m68k.org,
        geoff@infradead.org, hbathini@linux.ibm.com, joel@jms.id.au,
        ldufour@linux.vnet.ibm.com, leitao@debian.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
        mhairgrove@nvidia.com, mikey@neuling.org, msuchanek@suse.de,
        mwb@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        nfont@linux.vnet.ibm.com, Nick Piggin <npiggin@gmail.com>,
        oohall@gmail.com, paulus@ozlabs.org, pvorel@suse.cz,
        rashmica.g@gmail.com, robh@kernel.org, sbobroff@linux.ibm.com,
        sjitindarsingh@gmail.com, vaibhav@linux.ibm.com,
        yamada.masahiro@socionext.com, yuehaibing@huawei.com,
        zhongjiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:42 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Please pull powerpc updates for 4.20:

Pulled,

                       Linus
