Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F242C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 03:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320B521569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 03:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGXVvx2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320B521569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeIVIyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:54:54 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40330 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeIVIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:54:53 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so5977786ywa.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 20:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ifYGFE/SJTrUClmE32z/2vk7nXHuTFIbSPM2rJsRxU=;
        b=CGXVvx2oDdSerIHN+EQGbi1aXks4x/l8aY4Qw5wcPlRgT+t0SJ0t17hqvYj1XY1fOg
         gmiLRjzXc5d8e3zUNEz1Ti+J4WAG+JvbsXkImOmWfLjNYTTNp0sy1rrGVqy0BM01ppS9
         oODjldWm/QPB/rBHH5aBsNMIMTA8lbRuM30VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ifYGFE/SJTrUClmE32z/2vk7nXHuTFIbSPM2rJsRxU=;
        b=iMd4L9md5FGIvkNgW8Xxktr6wsYbx7NDUoSYjDWKV/OUe7ODBGnrma9L6k4W1CWPnW
         woWl4ZBx3woHbL6Xze+tQYJAvOPXbZOihe4sa+yzIFohytvr/leZ24GZ101NYZgI4/LR
         x5MrSgixQoVkPXJwulIbrGrMfISJxSWNb731LL3O1SyaddIMgyJaGJi919Iu8uuUi06G
         6GK5f0YhadOk8o2BtGsf1wSwUyaCIdsTkxq9GuvwVy/bfhqOuJqXOirS9dt57/w3wVNt
         FlROdEiJLT7WKgDnB/M7+wVpM/iquIDy69b5TWqdsoCbm1eogtgKEv08zcDFxeajiApp
         Vz/w==
X-Gm-Message-State: APzg51BqAumJMgaxAPQdCkjTRnHkslk7j2F2oWoy9QZsqM1nGgjofPWe
        Sd52kAEsRoS4VopyebVey63Qjkk+aVo=
X-Google-Smtp-Source: ANB0VdZ4geUD69GuAOaaAjrePea3lEA75SL1TssbCoeUFtlQPFw4xn9MXKwxPR0m3V3Hp9BL1shVeA==
X-Received: by 2002:a0d:f801:: with SMTP id i1-v6mr224729ywf.160.1537585380184;
        Fri, 21 Sep 2018 20:03:00 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id r84-v6sm7748745ywe.10.2018.09.21.20.02.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 20:02:58 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id d193-v6so3106798ywb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 20:02:58 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr206651ywg.47.1537585377975;
 Fri, 21 Sep 2018 20:02:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 20:02:57
 -0700 (PDT)
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 20:02:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
Message-ID: <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
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

On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> v4: Finer granularity in the patches and other
>     cleanups suggested by Kees Cook.
>     Removed dead code created by the removal of SELinux
>     credential blob poisoning.

Thanks for the splitting, this really does make it easier to review
(at least for me). I think this looks really good, though obviously
I'd like to refactor it slightly on top of my series. :)

One additional thought I had was about the blobs allocations: some are
separate kmem caches, and some are kmalloc. I'm thinking it might make
sense to use separate kmem caches for two reasons:

- they're going to always be the same size and are regularly
allocated/freed, so it may offer a performance benefit.

- they're explicitly not supposed to be exposed to userspace, so
hardened usercopy would protect them if they were not kmalloc()ed.

I'm excited about getting this landed!

-Kees

-- 
Kees Cook
Pixel Security
