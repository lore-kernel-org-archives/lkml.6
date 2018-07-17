Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3437320693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KBrf/51L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3437320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeGQRM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:12:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55239 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbeGQRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:12:26 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so32207itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqX32k3468kJHVo/iFUUdiOoqcgtev4FePQlWkQg9ek=;
        b=KBrf/51LxzWzeyx78s0k78V8qsHm3r/ju94taO3n/FarE1ZIt6sfMWHRBI3mR1ik5t
         ho6TOguoMZQ2HAqgWCjKKXe+ss1qvGLg2ECsvLczhB0JRXruxtkRYX60MgNgWUfuSjt+
         xSN6luIDz1+uyPs23L2dd33NRDu0l4+rLFGH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqX32k3468kJHVo/iFUUdiOoqcgtev4FePQlWkQg9ek=;
        b=djW9LOwpIlHCuoC8BG3lNAPqWnZh2CDPEaWz+wX0fp/xFxihsxBw3uuC1UtB15MdN5
         rTjs4xif+DzzlBhWs+BywykaZOvVK2mPzHiHcskSd6kcc3AJl+PzOmblSrGNZgxukJYC
         B28sy3WPDArjcBdw479eCi3L+itcar5Gf17YoEUUiK8+W3Sf3/m14wyYYegKscAx7fLs
         6DPuJmHFCTjoDare0ZBqo+M1v3KmIrMNWmL8G+GN76rS8LRu5xjtez9TN292kDHOiALe
         vY6hQekDhwFXR6U1KJWbkEwsaPvb4X6GswKrIJPN/kKoEfloByFBAuXCgo6F/Bf/Nsmi
         T6Fw==
X-Gm-Message-State: AOUpUlGa7HKs+/3sEha6zXFDrnU13b8iE+NQw8EsjY64O/0dFcGJ/+z6
        Kry1m4AjTUqiNGFC97W4ifUeJLPToLPLF3j2V8Y=
X-Google-Smtp-Source: AAOMgpdQMcMjmMh1H+swg7TtBs5xftvC6Ef918e0otEjuI+1ZBmTyI1VdPHYiFwisAwXtSPhBYuOWZVUeebMv253/Yc=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr2162570itg.1.1531845536509;
 Tue, 17 Jul 2018 09:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <877em2jxyr.fsf_-_@xmission.com> <20180711024459.10654-7-ebiederm@xmission.com>
 <20180716125144.GA18262@redhat.com> <8736wjtetv.fsf@xmission.com>
In-Reply-To: <8736wjtetv.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 09:38:44 -0700
Message-ID: <CA+55aFx5gP+1coJ92v4jYgTVfatnOoN3mqrerPEGxadZE2rKNg@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID
 not PIDTYPE_PID
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> In practice since glibc does not make thread id's available I don't
> expect anyone relies on this behavior.  Since no one relies on it we
> can change it without creating a regression.

Actually, there's a really obvious case where this simply isn't true.

Just imagine you're a MIS person or a developer, doing "ps -eLf" to
see what's going on, and want to kill one thread. Either because you
see that one thread using all CPU, or because you are the developer
and you know what's up.

Those thread ID's are exported trivially.

               Linus
