Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152D2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TZaGu0+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4152D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeIRMqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:46:55 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38942 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:46:54 -0400
Received: by mail-it0-f68.google.com with SMTP id h1-v6so1741973itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2YMxDF7+AE1gCn1zhaZyneij8DexxE4cDYgVMlG1SP8=;
        b=TZaGu0+hryWweu2C0DgLrEvFZrErOsFN59KPmf2T3YU4WHJegNVNyXAzZvbXfBBBsl
         02IjMNnxP/VOPf9NOFDNudu405YgJ0H1kaL1R5WGyQx9PKnP2jjpA5Ad1aTRlFU6Pr/b
         4SdeQlkGYcRP2KL7TzS0MRjwml+vetngHI4sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2YMxDF7+AE1gCn1zhaZyneij8DexxE4cDYgVMlG1SP8=;
        b=Ya1f9A4fmlDbuYdBCCoNAOm+2Nf+p8xZdMIDFTe+618mSiW9dBqnqr0eKkRqBz7p7+
         Bpm9/IS4HGcTprtTS4XtRQLDP39TSVKvoROBJxS3XsAao7OS+DQ3JTkaKW6LLOOKhoc6
         7Om1/Hu07kZZNkhuxW0kObdfVGCVCWK/27tzJuYBYjwtLi3kp3hgZNEFQ6p9ObJtb3fu
         PVsXHDuesruc+qRVt2IVtJdv3bR3klo+jNZyBv7z+3ucXbrEFGjsZPc+03yhsrEqw8XA
         7AP209rFljo5PU1pvdinUdfV/eB5PVTjntcPjIzS8EVO8LeTHl9bmrr7S9fQJf1VnsP8
         QfFw==
X-Gm-Message-State: APzg51A+MwMNjoQ7gICOwBSLvpLVNYAgy7ye8CpcIV0WWClB9cL5wejo
        TjJv59O8gE44PRralg9EuqpAQ2w3CYPSISIbNT9bPw==
X-Google-Smtp-Source: ANB0VdZVKfEMyTR9Ty+pcbu2ezA7OMFlhRxlxTsxQt/Od40Be0YPn4p3OwhYwP1aJLgLRJuhRlx+Y9c3nVJAdVaE1+s=
X-Received: by 2002:a24:aa08:: with SMTP id b8-v6mr15704926itf.49.1537254938086;
 Tue, 18 Sep 2018 00:15:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:996e:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 00:15:37
 -0700 (PDT)
In-Reply-To: <20180907074640.27348-1-linux@rasmusvillemoes.dk>
References: <20180907074640.27348-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Tue, 18 Sep 2018 09:15:37 +0200
Message-ID: <CAKwiHFh9rcY1UZiTy1z+SXJ1gkdrZ2M6BA438fdGeqfBvagDyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] string: make kmemdup_nul take and return void*, not char*
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 September 2018 at 09:46, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> This allows kmemdup_nul to be used in cases where the source pointer is
> not a char* or const char*, but the result should nevertheless have a
> nul char after the memcpy'ed data.

ping
