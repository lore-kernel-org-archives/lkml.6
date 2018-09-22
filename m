Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E9CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F5521569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Natt60Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F5521569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeIVIng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:43:36 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36934 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeIVIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:43:34 -0400
Received: by mail-yb1-f193.google.com with SMTP id b3-v6so5205555yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/bCVzE+z4dYf3wj5e2EkaX0VB9eT0yZaoPf7lxF+jyQ=;
        b=Natt60Hq3UKoxm7qfPUP/ZmWi6PH6GhB3yrgiug56+k/CxwpiaGCkmFMdOWpUsp8/6
         Nr94RVW5q3cXpKEfYeMfcI8L08c7S5KGQXG6cBUOOzlvxFkoDL6d8UL6UMoRKvzE58tw
         Y7wBEy3ELbovhVsq0RwQgsNhOFxB0j6BNcb84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/bCVzE+z4dYf3wj5e2EkaX0VB9eT0yZaoPf7lxF+jyQ=;
        b=W1lZHM0eQVSGShcXw2Z6RiHi9hd9LXxCgMsNNvM7IQbKZJD3lT1k9wHONLKc9BR8YY
         5EFeBGzpVtIymqz1g+CB263VtebiJ9feO27GL/+fG/oZMjNGL0+qM2Bm+C2qZPAK/YXR
         kPJig7C8Q3xPh1bMf2LsXOHE9ogmv5uRNAor8uyQAwuKp9MvdBj83HWX04l5NMMlSt1W
         ibumPkUxhZTZn21tDiP0hpcwhMx1RwDZNzqUhFsXr7jVGQJTklgugiPV+O4jbrKror5z
         /3qhL1lQ3VwWOHLC5tUJcFRISOlK/bk0wpmmkKWXKdRTLeadjMpztBmacggPNB7A/5rl
         pf3A==
X-Gm-Message-State: ABuFfoijiUnyU6zNZGwQTPK1VD+2L5sLBOvpeVjZLwQ9K9a/jmd1zkXG
        6oqLoAwehcvssE1jKpbRcDZnRribIzc=
X-Google-Smtp-Source: ACcGV60uOrVaeghiTcwkCuSdPTlQWVvPnj+NDxnfwLaU+uxeXAt2SYG//o3CXx5tLum8s+Z0ISy8bg==
X-Received: by 2002:a25:49c1:: with SMTP id w184-v6mr217218yba.10.1537584704109;
        Fri, 21 Sep 2018 19:51:44 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id p124-v6sm1012453ywc.42.2018.09.21.19.51.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:51:40 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 5-v6so6261566ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:51:39 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr199890ybh.209.1537584699536;
 Fri, 21 Sep 2018 19:51:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:51:38
 -0700 (PDT)
In-Reply-To: <bd7c5604-ebb1-b42b-cf29-589494dbb1c5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <bd7c5604-ebb1-b42b-cf29-589494dbb1c5@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:51:38 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL6YoxzA18dL7zG3YDefAQTX5jh6=VDRGv536AotZdh+A@mail.gmail.com>
Message-ID: <CAGXu5jL6YoxzA18dL7zG3YDefAQTX5jh6=VDRGv536AotZdh+A@mail.gmail.com>
Subject: Re: [PATCH v4 10/19] Smack: Abstract use of file security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the file->f_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
