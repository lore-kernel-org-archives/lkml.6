Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C81C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2F9208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MTqduOB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2F9208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJCDwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:52:21 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35723 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeJCDwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:52:20 -0400
Received: by mail-yb1-f193.google.com with SMTP id o63-v6so1450213yba.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SlSQfw0xp3O/jily8Cdg5l91uvI7kPLnrpqWdEbMJ5U=;
        b=MTqduOB5dXT6MS/TslnIP5rrSWhnvvrxQ50k+lE6Gf/VSz+oUgYUZMrs47ousOOuFl
         p+tA4UVuq7CJ+RYgBBmF2DRp6VXDwyg2RtM3qpyH7OS9CxaBDC5sPFvP97PQySfD6Yc4
         pwuJZMpWiiDnqNqXrX0pWhjIu/gy8Lgv4yzXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SlSQfw0xp3O/jily8Cdg5l91uvI7kPLnrpqWdEbMJ5U=;
        b=IPLZ4MDXNneoRl6LfX1crEJwdr8tKtuF58zoWo/Dno9oYsilW/m2rqjENEd1pwoitT
         Xwl/2AfGLihTqvt5RyoQs3DAbXrq5ez37Opqp0T83TODU4JduzqexZVGovzInrsdMU9u
         nLO+7tSQ6LTFVNAufOcewAzVNCnAHwThPVTRmW+Kqd0isB9RUkjxBVSd/XdB/IEDbe+A
         LoPWryoeDjmgq9E/GZD4PgSBBi1bx9dRDqSBZP4NURG7SfAcWbf0kZGk/kttdC6YuDAG
         yBfp3/52urrtF7kGo9EAh8agmfTynA8FoC8F+jGaLryw/wg4DNxiS8lVw9MoNVJCPDLJ
         H2iQ==
X-Gm-Message-State: ABuFfohb+DEh2qzGyLK9GJkMc00Ig4DIU0/W06XPtOyJijX8fuYMYvSK
        DsEI5/iuroVd3au+vsXpuYildbWCP3k=
X-Google-Smtp-Source: ACcGV63wmwrWukVsdgM5Hkag4UirBPabWYTq8ynleUW+rCUa1ltqHWOZAUrVUgEAuIfOlRn77YlERQ==
X-Received: by 2002:a25:9705:: with SMTP id d5-v6mr10033921ybo.408.1538514423834;
        Tue, 02 Oct 2018 14:07:03 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id f194-v6sm8581640ywb.53.2018.10.02.14.07.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:07:02 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id x5-v6so1426379ybl.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:07:02 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id j143-v6mr1488663ybj.137.1538514422382;
 Tue, 02 Oct 2018 14:07:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 14:07:01 -0700 (PDT)
In-Reply-To: <20181002205259.GA16090@bombadil.infradead.org>
References: <20181002204722.GA9610@scapa.corsac.net> <20181002205259.GA16090@bombadil.infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 14:07:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJs-FQT93Og6ULiyugOs1nBCvMKXVrM_dnWTMLKj6ORLg@mail.gmail.com>
Message-ID: <CAGXu5jJs-FQT93Og6ULiyugOs1nBCvMKXVrM_dnWTMLKj6ORLg@mail.gmail.com>
Subject: Re: [PATCH] yama: clarify ptrace_scope=2 in Yama documentation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yves-Alexis Perez <corsac@corsac.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 1:52 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Oct 02, 2018 at 10:47:23PM +0200, Yves-Alexis Perez wrote:
>> Current phrasing is ambiguous since it's unclear if attaching to a
>> children through PTRACE_TRACEME requires CAP_SYS_PTRACE. Rephrase the
>> sentence to make that clear.
>
> I disagree that your sentence makes that clear.  How about:
>
>>  2 - admin-only attach:
>> -    only processes with ``CAP_SYS_PTRACE`` may use ptrace
>> -    with ``PTRACE_ATTACH``, or through children calling ``PTRACE_TRACEME``.
>> +    only processes with ``CAP_SYS_PTRACE`` may use ptrace, either with
>> +    ``PTRACE_ATTACH`` or through children calling ``PTRACE_TRACEME``.
>
> +    only processes with ``CAP_SYS_PTRACE`` may use ptrace.  This
> +    restricts both ``PTRACE_ATTACH`` and ``PTRACE_TRACEME``.

PTRACE_TRACEME is done by the child, not the process with
CAP_SYS_PTRACE, so I still think the Yves-Alexis's is clearer. But if
other agree, I'm fine with it. :)

-Kees

-- 
Kees Cook
Pixel Security
