Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D85FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1CB213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551296517;
	bh=B/pACBME5+TmdAB6Uv6JZ2U8XhfeAokR8MKwV/WCTn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GEfaXn3sMtgd2rO4SfdWM/PkYfAGEly2QUN+ocx+9Eo8K1wJ1+GFF3NuUvSHn08GO
	 ZIDMNPvXB84MXwZ1ycL7uX5jHhZGqAnc95p377RMDFge1FxAueJsooqWlmzvvrJu2o
	 zQQMgXK2AXRECuP4VyFCVTEk//T7ETdFt7jJy8DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfB0Tlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:41:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39191 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfB0Tlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:41:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so14944884ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xqe2zMbYiAkTKlFCFXZmmeSMKIqYYEknpfYA8gFkP1g=;
        b=D57g2CxdEJ85nXDPVDx3bpoKJtGLRjTj4JJJ871Hu2Gg8IbCAx7/50/Y0DtMKvNDAP
         vebrZT6sJezPSwiIX6GSk5i07eFRaEQsfqlJMqcuB/cP7UDDA8GPJCRhiMo4dezXafGY
         Tyw9WL2Apa+bNaqvG3pt5g9xzNjo2q1GJF/xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xqe2zMbYiAkTKlFCFXZmmeSMKIqYYEknpfYA8gFkP1g=;
        b=kbN5DNBC5pWa0JiPrnm9yFDXzjvU1qTCcFaUq55Tk6EpqSi1l7qqe0/B+/ayAN4lSx
         PVAHA44WdQo1+lntFIm10+rkifmKS72bguRT1gtG0jLV6Q/OHHoZr8Bu402EbtLQNqn2
         ws7s/TF9w9NGcb6A06dfGxg6C+lr3pav99xWHiYm9VtW0trgNypOnZtJ4peJ/z3LOtEQ
         oniQeiUkcniTAkPycWTPnRBKw05WfaA2fjcVpxzCrfmgpx0M6yZbnO80dvne2wGYpsN+
         J8BzsQyDQ5xDr5KnZgV6Oo729kC4WtPtftCvFyBArYXqLY+5Z+CvaxtJPjYC8ODlU0RH
         Gb5A==
X-Gm-Message-State: APjAAAVplLaooak5VnICMfOk7SGnHN0vNwfLB+Rj3mv5Gi4yCAVusYCg
        /FVQtRpiTcmm8NUStONNuPo9yyDulUI=
X-Google-Smtp-Source: AHgI3IYTEEhubB/524B5pJjl74cAXT7dQ9B+A9dBiYoSe1q5XhP6wRKy697E9Mu2P6cksPfkHALmhA==
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr2432348ljb.182.1551296508716;
        Wed, 27 Feb 2019 11:41:48 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w69sm3386747lff.22.2019.02.27.11.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:41:47 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z23so1315437lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:41:47 -0800 (PST)
X-Received: by 2002:a19:40c2:: with SMTP id n185mr1835315lfa.67.1551296507367;
 Wed, 27 Feb 2019 11:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20190227101252.413192716@infradead.org> <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com> <06F1CFAA-DD80-4DA7-A97C-E57814149CC4@vmware.com>
In-Reply-To: <06F1CFAA-DD80-4DA7-A97C-E57814149CC4@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 11:41:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfx6rUXpH16A9OAyEEh9nf18pk9mL7Wkz5b6eDc9dPpA@mail.gmail.com>
Message-ID: <CAHk-=wgfx6rUXpH16A9OAyEEh9nf18pk9mL7Wkz5b6eDc9dPpA@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:57 AM Nadav Amit <namit@vmware.com> wrote:
>
> I=E2=80=99ll have a look at some specific function assembly, but overall,=
 the =E2=80=9C+m=E2=80=9D
> approach might prevent even more code optimizations than the =E2=80=9Cvol=
atile=E2=80=9D one.

Ok, that being the case, let's forget that patch.

I still wonder about the added volatiles to the xadd/cmpxchg cases,
which already had the "memory" clobber which should make the volatile
immaterial..

                 Linus
