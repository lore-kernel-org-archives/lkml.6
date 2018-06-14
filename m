Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B681EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6208F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EuFajCPq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YY1Pcp3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6208F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965194AbeFNX6K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:58:10 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41004 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965096AbeFNX6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:58:08 -0400
Received: by mail-yb0-f193.google.com with SMTP id u11-v6so2894852ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=b9Y57Zcw0NoW8SSCQPbfjQuVqgilhOQhSYXtSwp/X1s=;
        b=EuFajCPqsh/77tWQn1RL4/Qjh5fsKcsKdhyd1kPqyCA9DHSud0qClhENFidPdGzs6L
         G+9O0WNAxBvGC3LcGWYDoNe3zpzCzMEvCujSXjdfPYe2shsQpFTs19SI6qy2RnWgmaYk
         jZ/Iv7Gde3l455rZ0m46UZkIJZC2LVhMMFv6TNhih/6gTap4ClSIXTFnY8pogdXvC4sE
         NcDdoqMGYE14X8CEeeNoWEiniaw2zvtT5r3SnWljhQqvydiuT9ZQa0IJCB/Qvh+7qClD
         ao3fovZ8sD8Keo/9Ig6vNi4/wfC6AZx7qCJMQTwM0pY+CVuercMSkt2YqAl6ayazb3Ls
         WA+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=b9Y57Zcw0NoW8SSCQPbfjQuVqgilhOQhSYXtSwp/X1s=;
        b=YY1Pcp3zuL3j91MIMPKlDVxn1bzJ3DuO3dnHCzaZT4zz6hpW8SBYlCCMsYJ6n14X8e
         hT/a1fvM/4lSWcg2Lxsmi0CoKGPHxi4CxQxEJuQNFpTLi5r6N+2T9bsjaYxBZoGq0uN+
         ez6eqQm9b3ggWEM9wo+nyRySZhKJIZkc6PZ7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=b9Y57Zcw0NoW8SSCQPbfjQuVqgilhOQhSYXtSwp/X1s=;
        b=V/fxdU1FJi1eT/TAFwSMQVtEvCRkD/ph1as0Yaj4+t0hQXQ23fyEB7guEKGrwkhCAW
         JXjX7E6UQbMj0T1oPRgE5g27PB1NMbkCvHMN2eD5Iw/jGJjND29HVb7Kuf7ovVdBaC++
         iKlgNbJygz9g3sn1701v5A47xDzXJHABtTOQdd41A35nUlBl50Z3ce8NAteYrAYRA/57
         76OpE8QCf0AJM7qtUGFxjfK68myD74TCvr6lGKqcrGWNKzqn+QfL1rA87UDVx+Wg3Pki
         MktgCIMeUfNDt+qcO+2ArRBGtp5olL2JX/zbtYDqnz/FxxMHRxTZKHonv46OTjywebkm
         MRfQ==
X-Gm-Message-State: APt69E211PNlLDTFSXEGivsWtVgvHAnDYq9o5pekT57vTSPURs3xio6D
        +ZYS3aGCys+6zumJVJ2OazwgJ04R0MCJdU4qzeMilQ==
X-Google-Smtp-Source: ADUXVKJrkowFR+xQQW3uKZZTWIrTrfvmdLWnjiEGIicaULGtrz2JSO/nmurTXapX9YY8IMV/UUl+FxVFMyxpaGTuy14=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr2712981ybi.193.1529020687876;
 Thu, 14 Jun 2018 16:58:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 16:58:07
 -0700 (PDT)
In-Reply-To: <1504258820-2122-1-git-send-email-elena.reshetova@intel.com>
References: <1504258820-2122-1-git-send-email-elena.reshetova@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Jun 2018 16:58:07 -0700
X-Google-Sender-Auth: Q_qwhs3sQtZ3P5COMDUu0WbKk_U
Message-ID: <CAGXu5jK-6fNvaEiX1Wvp98BKv+uF17KdFyPQKi5hgE-Jz3-+Tg@mail.gmail.com>
Subject: Re: [PATCH] Coccinelle: add atomic_as_refcounter script
To:     Elena Reshetova <elena.reshetova@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <mmarek@suse.com>,
        Hans Liljestrand <ishkamiel@gmail.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2017 at 2:40 AM, Elena Reshetova
<elena.reshetova@intel.com> wrote:
> atomic_as_refcounter.cocci script allows detecting
> cases when refcount_t type and API should be used
> instead of atomic_t.
>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

Oops, I think this got lost. Who can take this patch? I thought Julia
ran the scripts/coccinelle/ tree, but looking at git log, it looks
more like it's Masahiro? Either way, let's get this in the tree. Who
can take it?

Thanks!

-Kees

> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 131 ++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
>
> diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> new file mode 100644
> index 0000000..bfa880d
> --- /dev/null
> +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> @@ -0,0 +1,131 @@
> +// Check if refcount_t type and API should be used
> +// instead of atomic_t type when dealing with refcounters
> +//
> +// Copyright (c) 2016-2017, Elena Reshetova, Intel Corporation
> +//
> +// Confidence: Moderate
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --include-headers --very-quiet
> +
> +virtual report
> +
> +@r1 exists@
> +identifier a, x;
> +position p1, p2;
> +identifier fname =~ ".*free.*";
> +identifier fname2 =~ ".*destroy.*";
> +identifier fname3 =~ ".*del.*";
> +identifier fname4 =~ ".*queue_work.*";
> +identifier fname5 =~ ".*schedule_work.*";
> +identifier fname6 =~ ".*call_rcu.*";
> +
> +@@
> +
> +(
> + atomic_dec_and_test@p1(&(a)->x)
> +|
> + atomic_dec_and_lock@p1(&(a)->x, ...)
> +|
> + atomic_long_dec_and_lock@p1(&(a)->x, ...)
> +|
> + atomic_long_dec_and_test@p1(&(a)->x)
> +|
> + atomic64_dec_and_test@p1(&(a)->x)
> +|
> + local_dec_and_test@p1(&(a)->x)
> +)
> +...
> +(
> + fname@p2(a, ...);
> +|
> + fname2@p2(...);
> +|
> + fname3@p2(...);
> +|
> + fname4@p2(...);
> +|
> + fname5@p2(...);
> +|
> + fname6@p2(...);
> +)
> +
> +
> +@script:python depends on report@
> +p1 << r1.p1;
> +p2 << r1.p2;
> +@@
> +msg = "atomic_dec_and_test variation before object free at line %s."
> +coccilib.report.print_report(p1[0], msg % (p2[0].line))
> +
> +@r4 exists@
> +identifier a, x, y;
> +position p1, p2;
> +identifier fname =~ ".*free.*";
> +
> +@@
> +
> +(
> + atomic_dec_and_test@p1(&(a)->x)
> +|
> + atomic_dec_and_lock@p1(&(a)->x, ...)
> +|
> + atomic_long_dec_and_lock@p1(&(a)->x, ...)
> +|
> + atomic_long_dec_and_test@p1(&(a)->x)
> +|
> + atomic64_dec_and_test@p1(&(a)->x)
> +|
> + local_dec_and_test@p1(&(a)->x)
> +)
> +...
> +y=a
> +...
> +fname@p2(y, ...);
> +
> +
> +@script:python depends on report@
> +p1 << r4.p1;
> +p2 << r4.p2;
> +@@
> +msg = "atomic_dec_and_test variation before object free at line %s."
> +coccilib.report.print_report(p1[0], msg % (p2[0].line))
> +
> +@r2 exists@
> +identifier a, x;
> +position p1;
> +@@
> +
> +(
> +atomic_add_unless(&(a)->x,-1,1)@p1
> +|
> +atomic_long_add_unless(&(a)->x,-1,1)@p1
> +|
> +atomic64_add_unless(&(a)->x,-1,1)@p1
> +)
> +
> +@script:python depends on report@
> +p1 << r2.p1;
> +@@
> +msg = "atomic_add_unless"
> +coccilib.report.print_report(p1[0], msg)
> +
> +@r3 exists@
> +identifier x;
> +position p1;
> +@@
> +
> +(
> +x = atomic_add_return@p1(-1, ...);
> +|
> +x = atomic_long_add_return@p1(-1, ...);
> +|
> +x = atomic64_add_return@p1(-1, ...);
> +)
> +
> +@script:python depends on report@
> +p1 << r3.p1;
> +@@
> +msg = "x = atomic_add_return(-1, ...)"
> +coccilib.report.print_report(p1[0], msg)
> +
> +
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
