Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5444FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C1A2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l3RBSBNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C1A2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeITW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:57:49 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40775 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeITW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:57:49 -0400
Received: by mail-yb1-f194.google.com with SMTP id w7-v6so4230935ybm.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NrLYSG67EdJPDusxGzhdCo0g0X54fMhXdzXZX8dMiD8=;
        b=l3RBSBNUGk6F4RFZ4T3u8EmnLnD46ohZhgWhGgavcdDMdut/TbZ63Ef1wf7UDsJNhk
         Vf5GOQZ04+yLq4mM7RwlulmFBGYHSCkpgMsKO3aCSarzXbOqqErAMOz6A1t3LDqXf2kT
         qNfBSvctazbZfmu/AkdUEaqZhnl9ReDTrxl4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NrLYSG67EdJPDusxGzhdCo0g0X54fMhXdzXZX8dMiD8=;
        b=ozN7zqzStng3xFs0IYo0Li3tuB8nlO2YVqiiZDZVTS9e8apFsyQsfxi+2CO+nj8yGb
         LMRbRrVVBRmVcs24Nq81eXK+uEPoFdEUIv9BwKzQpRCZT8qzcTIrk4WMUtYuK2iRfxHX
         jTtL1kIyCg2sUmaRO3eDjpjjdx1PC4WQOkU+TcKtSHlTARvUeF4TJzP2RwVrKfR52Vfn
         h2tvLenUEktLA4JJlZnlxqAq3tzrDAKV+0Rn7+A17h1gdUAWoacv9FaaD0+KB9j3K5Bm
         BvEihdZy6N+EM4qXYLM3EdBUnTCWGrqzct5QQuHee96bxTD/HhB0Mb29MG1MK0V4PSlA
         Lmzw==
X-Gm-Message-State: APzg51DPWMBbv5J++go5q0lZ+vGkfAhGHwW0SnGUobbPYw/9xy17GlMw
        VXNmWf7El2r3IvRaRFNX0PZFwmMNvdo=
X-Google-Smtp-Source: ANB0VdYKMHcjVVPWjRX2rDUjeMuGCGMkadufbtyvALzX2r9PP81PWdsWQ/QcBlsWJgx7uCIAeVRgRQ==
X-Received: by 2002:a25:27c5:: with SMTP id n188-v6mr18271068ybn.225.1537463600217;
        Thu, 20 Sep 2018 10:13:20 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id 12-v6sm3299179yww.77.2018.09.20.10.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:13:19 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id q129-v6so4052746ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:13:18 -0700 (PDT)
X-Received: by 2002:a0d:d347:: with SMTP id v68-v6mr1595791ywd.124.1537463598256;
 Thu, 20 Sep 2018 10:13:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 10:13:17
 -0700 (PDT)
In-Reply-To: <ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com> <ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 10:13:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ0xB+Zh7oUAzk9kDMaFTOcNXFzOxL6mwqsw8KaQ0Ks-g@mail.gmail.com>
Message-ID: <CAGXu5jJ0xB+Zh7oUAzk9kDMaFTOcNXFzOxL6mwqsw8KaQ0Ks-g@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] TOMOYO: Abstract use of cred security blob
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

On Wed, Sep 19, 2018 at 5:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> @@ -539,13 +557,16 @@ DEFINE_SRCU(tomoyo_ss);
>  static int __init tomoyo_init(void)
>  {
>         struct cred *cred = (struct cred *) current_cred();
> +       struct tomoyo_domain_info **blob;
>
>         if (!security_module_enable("tomoyo"))
>                 return 0;
> +
>         /* register ourselves with the security framework */
>         security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>         printk(KERN_INFO "TOMOYO Linux initialized\n");
> -       cred->security = &tomoyo_kernel_domain;
> +       blob = tomoyo_cred(cred);
> +       *blob = &tomoyo_kernel_domain;
>         tomoyo_mm_init();
>         return 0;
>  }

This is missing "tomoyo_enabled = true;" which is included in the next
patch but should be here.

-Kees

-- 
Kees Cook
Pixel Security
