Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7452C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04DF21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hry1MCgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04DF21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeIVItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:49:21 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37151 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIVItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:49:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id b3-v6so5208509yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7S/M4Zp7l+UoPx8TVhrS6bceL5qB3bGgwOhQYLLk0ZQ=;
        b=hry1MCgHTB7ILA40NiC/QJLqtmq7pZoQuh73k1jMY8paDoTcIV12Lkj2otK/9GFTxo
         uBbO/ILWuEGD+QNfoidd2WTc5slC3vpPcONv9Z0raOPnH33CWqHsbuVxn/HeUjWcuTVd
         BR4w+FkEQ/z0nDlHRtbBUpT5nV7OKUuRVEL90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7S/M4Zp7l+UoPx8TVhrS6bceL5qB3bGgwOhQYLLk0ZQ=;
        b=RxFLtLq6SfClGFhVBtHU7VT419ioAMwLu7KrHhU0ugcK7eLSDy4JP5VGOM8ZgsuaQZ
         qxWkI6hJHL6LZY0rhPE7nTBrYXWfmwkTWx8PgfNY7GmUvyvlZHqzCw1h1DQqvEsUZ+Sw
         la7tAojg6+YupqOw8cdWcrjfB3xm3QMEYhUBPL8Mw7Yw7equ44sgfY7MOCEnGZeaitQ2
         z/klUZ1euo9q+sRRI+etBLczJ9Af2oqmU9gbUTtvmDubXT8fvxSTi6bIL+Wbah0I7seC
         50vQ9NJtVCM/26hDAIh5rAN9bTEvuZC36BLmtLhMK645oZUAX+AAyQujjdjAaV/3zsPG
         ZdFQ==
X-Gm-Message-State: ABuFfogu4Ti5UBE7lAfb9I71zM91xDYf4D0wT52dWT907J7uw77KC7V/
        HPO1EBGRS3rzo7TRdl9myI6AKQj9uzo=
X-Google-Smtp-Source: ACcGV62Hd9nmwZ67IKVk+ESGTKWPGBRuG7zr4udiCBLQlvDfxMAWvRNhyyhzo7s+iaOjn6vneTHUJA==
X-Received: by 2002:a5b:d07:: with SMTP id y7-v6mr200668ybp.357.1537585049956;
        Fri, 21 Sep 2018 19:57:29 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id b6-v6sm2699970ywe.71.2018.09.21.19.57.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:57:28 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id z143-v6so5974884ywa.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:57:28 -0700 (PDT)
X-Received: by 2002:a0d:fe87:: with SMTP id o129-v6mr208462ywf.237.1537585048314;
 Fri, 21 Sep 2018 19:57:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:57:27
 -0700 (PDT)
In-Reply-To: <f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:57:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL6GAWmCAt1aXdVvr9HqdUUOynJ4Ma1VBGjjdTkyNb+qQ@mail.gmail.com>
Message-ID: <CAGXu5jL6GAWmCAt1aXdVvr9HqdUUOynJ4Ma1VBGjjdTkyNb+qQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/19] Smack: Abstract use of ipc security blobs
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
