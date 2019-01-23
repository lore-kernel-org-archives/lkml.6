Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5481C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9303B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnUWG1Fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfAWI4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:56:37 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45103 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAWI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:56:37 -0500
Received: by mail-pf1-f172.google.com with SMTP id g62so839095pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=OI0t5bWDEsJdv7S188XOnBTvHNBarxIayFMx00OCpcE=;
        b=QnUWG1FhQjDa77EWxaZ2e+/yhr1Xw7g04cyvR0s0uyUALH6vADwt2wIp67rR5FTC1D
         1ivKRJpmzTQXXm7raLpr5u05HV1Vdld6s3O2yxEf4stbHV50t56cGIYpLKpyEVzZhAGk
         mSXX0zCDmvQgUVbgYUb7+gHwdglrLa5TnmH4nfaGP7jMtBL31husdq1nKwl0tCXhxrjQ
         iTYeLD6EbIk6lw2PK2GNiDYW/HYc0p7eDeovvtot1c7end6gjfZWCHEdItz7FSxnywJM
         U8Yyk4uDh05R0m/ffCAjMykv3R6v45S79GJW/hm4VKoVzCDmQ9qef+HC3kjjRaEw3RpX
         0HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=OI0t5bWDEsJdv7S188XOnBTvHNBarxIayFMx00OCpcE=;
        b=m+3ienU87CKMH92jyw2FM2AZKSPZ4wndJSXPDzzH6C0V5q+/4zE/bVMoFhxtnVcluz
         bAYKx5YqrOsCJrkzvctzFJA7gyNrM1b8ZxCbaQWP+KPU6yakwyy3jUsBOJd0Lovn/fJo
         ExfvNoZzvOZmq5mdV2FdwhVDwkXpPgex5ixlP03o4Mg9/a47ZtFYGai/EHFVSlq7egee
         bGM2SQ/gMM+zBJzwA3FLmsujQNrdzcACUABVf5yKe0e+UesuErD033AYwN7dq8kf9S+i
         ePIykBLuF1+A1a2Yeu5TjJiwOhreACZGGmRDp3kC1QxxlQQL7K5MchkUoggPRngFOwJS
         cPHQ==
X-Gm-Message-State: AJcUukcfOmz5Z7xZ1NZaqvYMN9J5eSkf1oaPjHFr68oPQ2P7HnxIUFnn
        UtVAyueNZ8QwU+CzQMRP0+Q=
X-Google-Smtp-Source: ALg8bN5aqenZFChd03ebhJNZnGHXfr787vhuzeKGAgnG/D+Ssbzi4jAGpIvLSpPrAQZQV/dashi2ug==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr1224905pgr.300.1548233796902;
        Wed, 23 Jan 2019 00:56:36 -0800 (PST)
Received: from localhost (193-116-78-72.tpgi.com.au. [193.116.78.72])
        by smtp.gmail.com with ESMTPSA id j73sm24318886pge.13.2019.01.23.00.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 00:56:36 -0800 (PST)
Date:   Wed, 23 Jan 2019 18:56:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/traps: fix recoverability of machine check
 handling on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
In-Reply-To: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1548233155.rsqberso19.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on January 23, 2019 12:11 am:
> Looks like book3s/32 doesn't set RI on machine check, so
> checking RI before calling die() will always be fatal
> allthought this is not an issue in most cases.

Oh good catch, this is a fix for powerpc/64 as well. I think actually=20
the panic was supposed to go in the bail: path, it's missing from
there.

But you may have a point, I don't know if we need to panic the box if=20
we have !RI in process context... Possible we might be able to remove
those panics and just turn them into die.

Thanks,
Nick
=
