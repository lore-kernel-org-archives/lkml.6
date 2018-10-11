Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD5520658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mYn4NMYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD5520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbeJLAq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:46:29 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44208 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeJLAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:46:29 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5-v6so3892867ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mTgrcAld5DBNLCnX4hucNcGbD9Lq+8ApstFoKxZjgb0=;
        b=mYn4NMYZhW54vwSc2gyScQ2FQyRFync6P3krEYGBxoq7KMEqg4blViEQf1GUqcQsTn
         shzYXLROu5OV8KHiW7MQmR35dp6ADpuOXNOtWaYPIGOcRbZ+8YrNegFI+RdMo0CxI0C4
         RSxN0+aB8Bz4R6W1yhk6OdiImcVH45selJ0jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mTgrcAld5DBNLCnX4hucNcGbD9Lq+8ApstFoKxZjgb0=;
        b=hDdBbN7QWrrk9Av0Fq0Xb9I4Im7qdNWxIMpYXgV5KvB7/6sOwl7gjtwk/XXeoxz7xs
         hN3qLrKMGTj48J1aHQvN3DLGT/fkA0nnQPcLTuvl4k6oo9XtepCbldQLkqjrOAdgxfMV
         RK5n+cCLF32/cUdIvBJYlOKlMR95E8Crc8qSCDavZMYEZnA7dJUHjuh3qHlmTKLkP3iI
         0MBTI6PcCdaTD3xciZaanBLRVWpfVyfW3/MeU5O7jKgR802XiARq0UcMYvOy72kQ+ltF
         817k//G/CrrtRqk317nYzAKqLBHpkk8YYrR5bf7/U8l0zmxw/2n3w9iUdUX8tch8vOT5
         9dSg==
X-Gm-Message-State: ABuFfogR9kTvQOBWPF7TOFpxwXa5VEU2C6iAX0civ51btmxJlJxN9Q7F
        KgIGyEDE1hgE6GAxUZ301EnAuAMwpwc=
X-Google-Smtp-Source: ACcGV630Cyl2hGmv40FImLio6f4uZTyOhHDSWBXx8mp7lia2Bj9LOoAgvkhORruWczSBWzSAQavgpw==
X-Received: by 2002:a25:1103:: with SMTP id 3-v6mr1391693ybr.106.1539278298937;
        Thu, 11 Oct 2018 10:18:18 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id l138-v6sm8461283ywe.50.2018.10.11.10.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 10:18:17 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id o63-v6so3909022yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:18:17 -0700 (PDT)
X-Received: by 2002:a25:5987:: with SMTP id n129-v6mr1366097ybb.50.1539278296810;
 Thu, 11 Oct 2018 10:18:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf05:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 10:18:15
 -0700 (PDT)
In-Reply-To: <20181011141014.4big6jogmsnx25z5@brauner.io>
References: <20181011141014.4big6jogmsnx25z5@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 10:18:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK0nbBrJF4Vp3yzhwBgGo3vKh8FVo2ZQJMA+Ph3NaGh+Q@mail.gmail.com>
Message-ID: <CAGXu5jK0nbBrJF4Vp3yzhwBgGo3vKh8FVo2ZQJMA+Ph3NaGh+Q@mail.gmail.com>
Subject: Re: overflow on proc_nr_files
To:     Christian Brauner <christian@brauner.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 7:10 AM, Christian Brauner <christian@brauner.io> wrote:
> Hey,
>
> I've just got pinged by Lennart who discovered that you can get your
> system into an unuseable state by writing something that exceeds a s64
> into /proc/sys/fs/file-max. Say,
>
> echo 20000000000000000000 > /proc/sys/fs/file-max
>
> which will trigger an overflow and percpu_counter_read_positive() will
> return 0 and cat /proc/sys/fs/file-max will return 0.
>
> That effectively means you write that number and it succeeds and all is
> well and a few seconds/minutes later your system just dies or gets into
> an unuseable state pretty quickly
>
> I wonder if we shouldn't accept overflows or - if we have no way in this
> codepath to detect them - set it to some pre-defined hard-coded value.
>
> Or maybe this is even a known issue and by design but before I work on a
> patch here I just wanted to check.

There was work done recently to keep proc_dointvec_minmax from
wrapping, but it seems that the problem here is that file-max uses
proc_doulongvec_minmax, so it explicitly thinks it can be larger than
s64. (And max_files itself is unsigned long...)

It looks like the counter is expected to be a long, not unsigned:

static long get_nr_files(void)
{
        return percpu_counter_read_positive(&nr_files);
}

And there are places where this goes weird:

                if (percpu_counter_sum_positive(&nr_files) >=
files_stat.max_files)

etc.

It seems like maybe the sysctl needs to be explicitly capped in
kernel/sysctl.c to S64_MAX?

-Kees

-- 
Kees Cook
Pixel Security
