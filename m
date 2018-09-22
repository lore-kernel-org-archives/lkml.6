Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470D6ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC621569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SY7wIEjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FC621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeIVIsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:48:51 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41327 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeIVIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:48:50 -0400
Received: by mail-yb1-f195.google.com with SMTP id d14-v6so1173691ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7S/M4Zp7l+UoPx8TVhrS6bceL5qB3bGgwOhQYLLk0ZQ=;
        b=SY7wIEjxYf/6UKpXXD9LwyPCUbx3itIUFcdP2rZoFo/Bk5CDamWMwoDrd3mi9MRkp7
         xjmcMtujYnOw/+/dwZ+OmBYfFQE4CZNxXY/WGPKmGBPAbeSBbO1R+C8vmxg1KCAIuHnF
         z5V/HGdtFbsGtd/FPA7hMr+9v7C5mMcq38WeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7S/M4Zp7l+UoPx8TVhrS6bceL5qB3bGgwOhQYLLk0ZQ=;
        b=Nr++sIg51j3NvQ6gnGkX+PDvjLrNSqLGr8JcBONwm+MdOBvs+9M345TpoSIk7bWp3o
         PzqpV+ykomQ9ikMaTk7Hkni8HAfylqPqYFFJzKnFru2a0jXhRq+8V7Z+GVd7JrTFvc/c
         hB0mDp8ZdzlLnvvHYjt6WsVVz4tdCwV1hbUDbMUrdiu287e/tjiMSipcVNbbFLHW8lrb
         qrJGkBZ5cRKxB/lAuI2clJfj3bIzk49u03l3TR2BBk/mOoEgclbNrbWiUBhfKGQFsngN
         dnGR7tDfgGWPI006qoj3VJ8bJREoTCAQtiRkvb8nDPcR5D0fcojtuTipIXjqRPWQW2sp
         AXEw==
X-Gm-Message-State: ABuFfoiK5FJaEMYMtzuGsHUI3fDjBGKyLr+sr3FVVCfqHzWc5zoPGlDW
        RIIPRy/NK16pYFfMBKqE0AqQrrNPsec=
X-Google-Smtp-Source: ACcGV62SuQ488OFGjddBlz2BNesovhERZEj9eiVNCLsJgZUBMw2Bqs7+eEKb2ACJvQseBG+wvmMsqw==
X-Received: by 2002:a25:bc92:: with SMTP id e18-v6mr230193ybk.182.1537585018970;
        Fri, 21 Sep 2018 19:56:58 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v34-v6sm22745ywh.45.2018.09.21.19.56.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:56:56 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y20-v6so6242445ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:56:56 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr219248yba.141.1537585016189;
 Fri, 21 Sep 2018 19:56:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:56:55
 -0700 (PDT)
In-Reply-To: <383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:56:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ1dNrxLetD=t=PX3pJNKigjdj+CSHMfNF6cePQmYYwag@mail.gmail.com>
Message-ID: <CAGXu5jJ1dNrxLetD=t=PX3pJNKigjdj+CSHMfNF6cePQmYYwag@mail.gmail.com>
Subject: Re: [PATCH v4 16/19] SELinux: Abstract use of ipc security blobs
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

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the ipc->security pointer directly.
> Don't use the msg_msg->security pointer directly.
> Provide helper functions that provides the security blob pointers.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
