Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C487208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cw2i8suf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C487208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGKCrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:47:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39997 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:47:12 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so12316554iob.7;
        Tue, 10 Jul 2018 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CC1qHwhhNsKP8HGJC9AKv5XNFKDCx8HfgP9hQA4O+eo=;
        b=cw2i8sufnltn+jm59dN504wtxA2sHzpQ8y/YhzhMP2xVCLoQi8uwVkWkpochvCn3ug
         qgBbEdtAgiuTtpv/QuGpKA7qlUK6eoWniKSvQ2eRz/Lrr67XqTXIknKeWhPb+gGcX5LC
         N8kUe8A+RKJkahhvRJPNpK9GYl680F0CFlb0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CC1qHwhhNsKP8HGJC9AKv5XNFKDCx8HfgP9hQA4O+eo=;
        b=Wv20RF5xbZkwx/ESgrOkptgrl16m3BfQ+r4KbM1AzKkwrZHvhtfiIn6xukzJySs+zV
         PrsRoS89Y4BiSDwTHiu7Tr4HW0v4uAbrKfn6tByI3RLwt6ezv9aSPgLU5iiThxDOlXkS
         mV6ksOo7KmN11HfCn1kPqigzZA+WWyazA/rp2xNZsteZfwFXtGi3JG8IYm2/EByEXpbh
         HqF2UQ/OtCrjWCq/YRJenpLM5G9Ic6U5nxKi1HK26skU2jjrWnw1tgapQ4L7AnR7h9Vs
         fwuNzimxKZyfyrOp1Oejshq9meR0HPicvKwPRL4px6rBQDvM55ZFZXX2bvx+O9U7+61F
         fqSg==
X-Gm-Message-State: APt69E3LL8jLlE4h5XXuHsVxRbIFAgty84s7Tkgp8kO9uZTpGaEXobZp
        AnX4vGcX6quCkulYiE6tMU525+0zOeYJhdmk/No=
X-Google-Smtp-Source: AAOMgpcQtSKhTgW+ZUycf8SCrLPE9tzWXSr20HXspDsDOtB5Fkcb9XXoUXCy2wxACzJAxOKQs7zQL60FLOdS5h+xQz0=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7829536iom.238.1531277110747;
 Tue, 10 Jul 2018 19:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-16-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180711022206.12571-16-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 19:44:59 -0700
Message-ID: <CA+55aFyoQkoRm5sGaXpxtrr8au1mgr1_+khY=St0o7NRd5qw8w@mail.gmail.com>
Subject: Re: [RFC][PATCH 16/42] now we can fold open_check_o_direct() into do_dentry_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like the patch, I hate the commit message.

It makes sense right now in this sequence, but I'd really like the
commit message to say _why_ this sequence led up to this point.

Right now I still remember you trying this, and having to revert it
because it didn't work before all the fput/put_filp issues. But a year
from now? Five years from now?

So at least a "now that fput() works regardless of how far the open
got.." kind of explanation, ok?

              Linus
