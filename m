Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F1DC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287120664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hn8LJPg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5287120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJ2DgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:36:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37044 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJ2DgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:36:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id a82-v6so4389666lfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwydJ8zBSHlKkzgFfKP/H2jGnlwMuS6U9Ndk0koVSXE=;
        b=hn8LJPg4xRcDGfnfrNWNQdS5lLlWtZ3YUZSHaf9CmmXz0mbIqYQ2nW60QZsEYiWLcF
         b+SIBdmDb+fcRCqvHPTBExQSA1OExgp8aAdF4aO2g/69DPKhnkoo/LDKFIZqYwBvZ4uE
         R6ZkkXZ/0eKACQVXfnyE8Dc1vZWOdOarHpRzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwydJ8zBSHlKkzgFfKP/H2jGnlwMuS6U9Ndk0koVSXE=;
        b=gJ08zCEAK60AYKLBxF0270SEuSilJYUd2OYcV9LNrgbA+zt04JfCls3XRwrHNg6EOW
         C0JDRndTT8eEaARLTpBALVg6cgNwJrBdD83KPpFdQNE72W9SmTnx0gJFlaHbJwS/qu82
         87GTPW6Auj9CXsbMgLFKjxNwk0SmmfOwoEGTAvVdFuRuLpwNNDEPFGlUCHOXbj6BD5ws
         VvCo96epdAGzPVeH+2011FrvzVt2+FIjQlR2OhJdy17qegU8ZJ6nutRYl7X/Whl6Hdnh
         QH3zX3iXjaLy28N2lF1PHAiMDH4Vz6OiF4oXtzXSZe5AJ9paywSwwtkO2Ivv8NQ4oMXK
         zqCA==
X-Gm-Message-State: AGRZ1gJhwlmt1KlKDkfFOah2zsrI+jEZ9KTjQwrhTO7mUyesBD4UyMgc
        R7XM1513/pBfWvdGykGLCA95wRFyhKY=
X-Google-Smtp-Source: AJdET5fwXj6P/JktUMIzNTOmdEmwoNhTbeh1tf+E0Hu6VYgBqsSt4dI5LM9AMYkfS3cbnGokdrO67w==
X-Received: by 2002:a19:c203:: with SMTP id l3mr6195857lfc.113.1540752637745;
        Sun, 28 Oct 2018 11:50:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h79-v6sm1293755ljf.67.2018.10.28.11.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 11:50:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p86so2187557lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 11:50:36 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr6102807lfj.16.1540752635838;
 Sun, 28 Oct 2018 11:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181023200825.GA25444@bombadil.infradead.org>
In-Reply-To: <20181023200825.GA25444@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 11:50:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whquhQQY38WRKYsi-_a2vD=_22EPEnfVj4+APEjZPAkMw@mail.gmail.com>
Message-ID: <CAHk-=whquhQQY38WRKYsi-_a2vD=_22EPEnfVj4+APEjZPAkMw@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.20
To:     willy@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 1:08 PM Matthew Wilcox <willy@infradead.org> wrote:
<
> Please consider pulling the XArray patch set.

Pulled.

I took the more recent version of yours, because by the time I
actually had time to review this thing for pulling, even the recent
version had been in linux-next for a week.

Of course, I don't think linux-next has been updated, so it's all
moot, but the point is that I didn't get the feeling that it was all
some very recent code.

I do like how the conversions look, with the code in some cases
notably simpler. And it looks like at least one of the conflicts
(fs/dax.c) was due to a bug-fix to the old code where your simpler
xarray replacement didn't have the problem.

NOTE! I did get some conflicts with other stuff, and while the
conflict resolution all looked pretty straightforward, this does want
looking at.

Particularly the mm/workingset.c code.

It's still undergoing my build tests to verify my merge, but that
should be completed soon. I'll do a basic boot test too due to the
core nature of these changes, but assuming it all passes I'll push
this out within the next 30 minutes and would appreciate people giving
it a second look for verification.

Thanks,

                      Linus
