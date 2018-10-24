Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A45ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EF5207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UCl6oCYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EF5207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYBKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:10:25 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:44078 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJYBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:10:24 -0400
Received: by mail-lj1-f178.google.com with SMTP id v6-v6so5398452ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxFyRWVbciaBJWTK7enllxkooTq1Y6PMMZfOI+hBz7w=;
        b=UCl6oCYmRaK+M1suHc3Ia+yCrp6flTUnbpki07P5hdsOCRPfH2lqlufNcFKdT7tRDO
         rzYfDhQ+UMtrDxrKEr6I353QQVHBkHFdPWPj4JG956na9tmP04zvyQ30iKJay4Iobzs2
         BQAd0LfbYzkJSvETPTrjF+6aBZ1Hr6aU68i+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxFyRWVbciaBJWTK7enllxkooTq1Y6PMMZfOI+hBz7w=;
        b=gjeIjoaO56kdjbZwvuYfeCBv/fByPomCGnBgUL/9FXV6+UQ+v6+Q7Qkml8WRj/aHvM
         chL3mAktpiC+hAZaiIJmhqPCWW+tdnTxtrwiwYiTqWoRx5gWM//TCcSB6Bd3Mi62h77a
         89WFuT76QABMnRnHfUfSo+ZmaiDbMcftMi7GNqvt1miUPeHhGqgGPYkZzApA6VSlUHDm
         SEfw1NVQ7Yk9qa6imNAJkYOLSu6eG5TwV+CBm9imSK/ZPpXb+zbFHtNkeTfw23W3Kbbl
         kMiGk+v3VXW7QUU+yTTAcjMncCyfoy2L6GxGEtEdcj71rAqczX6GQXsfAFdG0196EEkK
         z8tQ==
X-Gm-Message-State: AGRZ1gJ0hJVsgcDqAbwC88jYixamIagDxN/vXAkMRGDafItP8TZ+bBS8
        W2I3qjq2sje4VR8Heh5ijRDVTUs4zpUBJnjJ
X-Google-Smtp-Source: AJdET5eeLYxTLLTlMajtd0fjgMkFz6/lisjV+XUerV4GhZ570z6ntHgBPLmoI+gQPsfXRou7jKMvlA==
X-Received: by 2002:a2e:21d2:: with SMTP id h79-v6mr2302112lji.46.1540399295903;
        Wed, 24 Oct 2018 09:41:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k10-v6sm63073ljc.70.2018.10.24.09.41.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 09:41:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id j4-v6so5385758ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:41:35 -0700 (PDT)
X-Received: by 2002:a2e:9e56:: with SMTP id g22-v6mr2074473ljk.120.1540399294715;
 Wed, 24 Oct 2018 09:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181024020504.GA31877@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20181024020504.GA31877@jaegeuk-macbookpro.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 17:41:18 +0100
X-Gmail-Original-Message-ID: <CAHk-=whLxYn2iXNhwcZ8mtdxZvNyQmQ4j9AsEbFXxhvJT6F8HQ@mail.gmail.com>
Message-ID: <CAHk-=whLxYn2iXNhwcZ8mtdxZvNyQmQ4j9AsEbFXxhvJT6F8HQ@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 4.20-rc1
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 3:05 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.20-rc1

Pulled,

                 Linus
