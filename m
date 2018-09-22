Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C881C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2C621569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YH3li2Oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2C621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeIVIfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:35:33 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34392 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeIVIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:35:33 -0400
Received: by mail-yb1-f193.google.com with SMTP id 184-v6so6270092ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4H2845ZspKAH8gWdgPFGWB56howBj5MwyJO1qZgaUB0=;
        b=YH3li2OeqotmOB0x8a2PjOg633WBkuYurMsexYpSJQOVHHP52AOzku6nTaG2TxVfLd
         qpyQWhk38AfHczvMNnkQZE36VlXxjqknoZaMr1ONkTODjvPqcSFh/UlEAbvEAJtJA0IT
         NQK7aT43vsf3/lwtarV3e9xyQNOfhhvFUerj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4H2845ZspKAH8gWdgPFGWB56howBj5MwyJO1qZgaUB0=;
        b=B0ioks4vy4NiX+wiPiHOgYeyVv08PsbrvWoMgwcHtw+IsOJ4LJq0uCFwqVfzo1sH5c
         gLcukSQUNyQmgSu/Qat1csffh+U0IvnCoKdNGZcuuqK4DOM8+tOLfj3aOsufATfUjA3/
         JhGvjHmfJ2HUfWy23pgcbxA8jWfu1OiM1ROyzHPoqoj1oWu3gF9HEc5dlQ/TAHRr6PRc
         IbRIpJPG50U5U6Hn3XzFQkgxTxyO6GtMra9JdV0O1MM1VVqavNOtrq3aGyIJ8EDELwVy
         cJ9IJu5vtva6S+NLJwSxXcgcEZXx+uzHX2sF9ozjCU5zsYsN4b++4zQCcxy/scrKiU2d
         e2PQ==
X-Gm-Message-State: ABuFfojLOLfqDq+J/6WxdVF2l04eY87aXq4PXwd/faZttS3HPWKcSV3b
        Zqq2Pvr3aTSOwSw80LxAepugjrM/E6U=
X-Google-Smtp-Source: ACcGV61EbE4ytMSMtaTmDitZvpM9kqH20JIoxxgXNld1uEiDZZKBPHjz3IYEXLvbrDLQIAPvGbctkw==
X-Received: by 2002:a5b:d0d:: with SMTP id y13-v6mr220558ybp.24.1537584224514;
        Fri, 21 Sep 2018 19:43:44 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id l20-v6sm4539118ywk.29.2018.09.21.19.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:43:43 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id d9-v6so6243342ybr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:43:42 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr209267ybz.410.1537584222571;
 Fri, 21 Sep 2018 19:43:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:43:41
 -0700 (PDT)
In-Reply-To: <c7a864e4-1297-2973-9d4c-7c855a20a06d@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <c7a864e4-1297-2973-9d4c-7c855a20a06d@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:43:41 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLaS++iur+Pwnjr8qMFgsAun9mV5O43OiKEy-bAF3gG9A@mail.gmail.com>
Message-ID: <CAGXu5jLaS++iur+Pwnjr8qMFgsAun9mV5O43OiKEy-bAF3gG9A@mail.gmail.com>
Subject: Re: [PATCH v4 05/19] SELinux: Remove unused selinux_is_enabled
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

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> There are no longer users of selinux_is_enabled().
> Remove it. As selinux_is_enabled() is the only reason
> for include/linux/selinux.h remove that as well.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
