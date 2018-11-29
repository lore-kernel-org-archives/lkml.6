Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B517FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E722146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kEPeLPO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E722146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK3JNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:13:49 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34544 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3JNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:13:49 -0500
Received: by mail-yb1-f195.google.com with SMTP id a67-v6so1427369ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2V5q1RZhIAgk2y8PFh917I/PmTMC8nPJHHRYBZqgcx0=;
        b=kEPeLPO3yIbXBbGpec+rpkoXwlrpPoRSRWxGMkrfD/Q6zm83lnca5n9Cq7GDW7mqNw
         hSV1yTXH8rvo85dQMw9Oph0qN31CqqmrSRCXBIwusnghwaccs9hSJbjKuYfVHTJtaK3Z
         CF2llBa2vDEIFTpNkKWNkMFstm/bByg22GdPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2V5q1RZhIAgk2y8PFh917I/PmTMC8nPJHHRYBZqgcx0=;
        b=DCmq7XAMlpGU+dw83AtHvGC1Sl0RAfnAhopUmrCii7WKuaWhC0EHfQzncRp0uzu77f
         EyFVuM/0Xx3bXGPqCyrLhijWnDASXxOrXl3tZgsJVzFmZ8Yhr7bgkvSCRQDErfDiYgmD
         8OVEF9ssMheB1KyDWoOm16lOB5M4zwU/pWO+V65m1tnkIFRCo2P4rHpUiZ25efCRDQvV
         bAvlSZFrawrm2EAmL+4xf9cP4EcZwt/NHuAQ9rE+iPlX8yILd8eC42qhedMmv58ZU3UM
         /8Gi/p3oNNh2FCvYK2y1fmcsG1bkLO8+VAMFkOPsZz+xVZGHpjIL3iO14OH/kxsJ7Gao
         HxDw==
X-Gm-Message-State: AA+aEWZB5Ya+/j2PIi4wC4ypSgi0Ej2ac+Mgy5gYw54GcOcWdyAXUvMn
        LcyRmRR1e11sgFyRfEmwP1QMP1tJXDM=
X-Google-Smtp-Source: AFSGD/WyrcG2QhiDCu0Jni6VqUwgAmAzwikfHT6i6Yp3UWDTANWt0nkOw+ql9NNp3honGoCfeplFAQ==
X-Received: by 2002:a25:4e82:: with SMTP id c124-v6mr3183701ybb.481.1543529212476;
        Thu, 29 Nov 2018 14:06:52 -0800 (PST)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id i2sm922046ywc.59.2018.11.29.14.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:06:51 -0800 (PST)
Received: by mail-yw1-f52.google.com with SMTP id h32so1450989ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:06:50 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr3431193ywo.168.1543529210469;
 Thu, 29 Nov 2018 14:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20181101235200.28584-1-keescook@chromium.org> <20181101235200.28584-3-keescook@chromium.org>
 <20181102182454.GB14942@google.com> <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
In-Reply-To: <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 14:06:39 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJdPz70kHUmTxOEo3Kp20HCOpGEX3_ECqN6TV3qBwxjEA@mail.gmail.com>
Message-ID: <CAGXu5jJdPz70kHUmTxOEo3Kp20HCOpGEX3_ECqN6TV3qBwxjEA@mail.gmail.com>
Subject: Re: [PATCH 2/8] pstore: Do not use crash buffer for decompression
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:56 PM Kees Cook <keescook@chromium.org> wrote:
> On Fri, Nov 2, 2018 at 1:24 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Thu, Nov 01, 2018 at 04:51:54PM -0700, Kees Cook wrote:
> >> +     workspace = kmalloc(unzipped_len + record->ecc_notice_size,
> >
> > Should tihs be unzipped_len + record->ecc_notice_size + 1. The extra byte
> > being for the NULL character of the ecc notice?
> >
> > This occurred to me when I saw the + 1 in ram.c. It could be better to just
> > abstract the size as a macro.
>
> Ooh, yes, good catch. I'll get this fixed.

I spent more time looking at this, and it seems that only the initial
creation of this string needs the +1, since all other operations are
byte-based not NUL-terminated string based. It's a big odd, and I
might try to clean it up differently, but as it stands, this is okay.
(See inode.c which doesn't include the trailing NUL byte.)

-Kees

-- 
Kees Cook
