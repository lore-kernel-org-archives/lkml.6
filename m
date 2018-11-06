Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C57C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EDA20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQ8HiaGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EDA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbeKGBjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:39:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41987 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeKGBjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:39:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id f3-v6so11950935ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/sfBUN9oq/ACtKQGaMCwUT4bflC4Ee4I2BULVFNlJo=;
        b=RQ8HiaGEBNEOQOV4tUSTOfQmsbCVx1buRV095v0IyjulLtVBaAqqJu+wUmwp86AyDX
         ZnvgeCj+MCDwTID8RqkViaiLuPpRo9bQZzZPxCripmq9IPM31aU9BwT30nB4JB+807NC
         FMeSTVWZI8yOKOvOEHdoLP4ei4lF+2yoSEgnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/sfBUN9oq/ACtKQGaMCwUT4bflC4Ee4I2BULVFNlJo=;
        b=juywOiEAvmWD2rTp5fCD4YQA5snGBIDQNtmpLp/cfhxhSaMYXw8yCv4+R5y8IlNTxd
         Capd4Fah+0Z7rx09x0ROst9WeK88RuZpqw+1yd+uGBoRx4wYeZzZfHGZskRmjZv2Bg8/
         iuYaHx3XkebwNCLm49lton+b0CXB9T5bDlZbWenY6/GdRjzsWTOG5gdewpZ4xDksGEKU
         xKu4qMu0P+9bC0nj1RWcErK4/Hp2uIR0H03HGVlePMAdtJKwdKw0K2AIsF16TULfNiuV
         096jEdEo3KIxST4Tmu/fSbz08Vdu9lDdi/y52De4lSk+XmU4S67PyI/qeSujMd+1Ev59
         51jA==
X-Gm-Message-State: AGRZ1gJYasrTDUinRlT39SdnVqPMcS8o1bWEI5x/9rFEqpyFsbNpWctB
        kALg16VED8f5vU5fCy6u8Ck0W9awCkImSA==
X-Google-Smtp-Source: AJdET5eYmIFDngiv/lB1ofYEOzHkpS4fIxwK7gg7wB9ellopv0dvByV5U1Fr4s/11CFxjiSsbH1dEQ==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr16711323lja.24.1541520802652;
        Tue, 06 Nov 2018 08:13:22 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x16sm4625571lff.26.2018.11.06.08.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 08:13:21 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u6-v6so11980444ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:13:21 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr12636201ljk.80.1541520801186;
 Tue, 06 Nov 2018 08:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20181106091156.1a373d76@gandalf.local.home>
In-Reply-To: <20181106091156.1a373d76@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Nov 2018 08:13:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOtftm5XpCbwR75YkGTKf1ccazZCHvUxHohF95deVJ7g@mail.gmail.com>
Message-ID: <CAHk-=whOtftm5XpCbwR75YkGTKf1ccazZCHvUxHohF95deVJ7g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/kprobes: Fix strpbrk() argument order
To:     rostedt@goodmis.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Masami found a slight bug in his code where he transposed the arguments of a
> call to strpbrk.

Pulled,

                  Linus
