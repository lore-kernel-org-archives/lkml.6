Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB43C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E38208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X8WI43Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E38208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeJBDOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:14:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40378 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJBDOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:14:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id l79-v6so1978365ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=khTebGVL9i62T+Xj8yjXJ0sI8LTNTIeX+GszD8f48Nk=;
        b=X8WI43Zraz3OLHepdEtcK4ArMQLLsKAMf+HrUAsW8NA3cCC6Poebvan28Uyc8wY9Ir
         jW3+STc6+BoHFTm4u/hEEhaTLIEq+/vxBUsFEoaRQPHbHp8/WAQKo4IC9kklghyuHdrT
         h5cUPZMvzvko1/h8XlVthyh3PU1+Z1LvPGeX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=khTebGVL9i62T+Xj8yjXJ0sI8LTNTIeX+GszD8f48Nk=;
        b=Y2VM8wTzapZ1fwY+RM2IVlcFbIMRRLzsIZxhxN9b1NSzNmbDfF9BZ9lchSGUIuquuW
         bdyCB8x+JJPiWgE+eABpc8/b3bGUrA8m8Ag6oBKopwvp834fnoC7kjLWEs0TvKv+t2hJ
         a3nl+XVCdK65L7N2g76jBklddxH/CAISIAhx80tNE+bOok4kQlbJ+2UvVFI8qQFjVqwg
         qvVxgRmWelmmUCcpQ27IQyJEHU6jWEKPGt84Sg9dqc8nz+9vRFKcL7fQWSrlCTJyB7gA
         IrHlOFN6lchHA6hr5EigkC8Qj50CiZJuV0qu0wvzCYGHu3KelnNxtd8lvtVQmzCI71nb
         di3g==
X-Gm-Message-State: ABuFfoiROJLLlmrY4zp8HZBTkO/0/ahhdIeqJSWmkT3cPSI7w576ratO
        e1asal5cdp4b6GV2fzXe2bdBPV6X+kM=
X-Google-Smtp-Source: ACcGV61JRN9nblCzgAEliW1Q0AIHu9WAMLbUXtO8U+8yB9QYFAp5LVx5yvxuK+Hzcperh1dwaHxx7g==
X-Received: by 2002:a81:160d:: with SMTP id 13-v6mr6669036yww.489.1538426075621;
        Mon, 01 Oct 2018 13:34:35 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id r5-v6sm14064268ywr.80.2018.10.01.13.34.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:34:35 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id y14-v6so6096757ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:34:35 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr7000601ywr.168.1538425766274;
 Mon, 01 Oct 2018 13:29:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 13:29:25 -0700 (PDT)
In-Reply-To: <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 13:29:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLrvuhGonjCxUxMXi+HeEb8yWina=31OCvEqOeBBu1pkw@mail.gmail.com>
Message-ID: <CAGXu5jLrvuhGonjCxUxMXi+HeEb8yWina=31OCvEqOeBBu1pkw@mail.gmail.com>
Subject: Re: [PATCH v4 20/19] LSM: Correct file blob free empty blob check
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

On Wed, Sep 26, 2018 at 2:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Instead of checking if the kmem_cache for file blobs
> has been initialized check if the blob is NULL. This
> allows non-blob using modules to do other kinds of
> clean up in the security_file_free hooks.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

This looks like it should get folded into "LSM: Infrastructure
management of the file security".

-Kees


> ---
>  security/security.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index e7c8506041f1..76f7dc49b63c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1202,14 +1202,13 @@ void security_file_free(struct file *file)
>  {
>         void *blob;
>
> -       if (!lsm_file_cache)
> -               return;
> -
>         call_void_hook(file_free_security, file);
>
>         blob = file->f_security;
> -       file->f_security = NULL;
> -       kmem_cache_free(lsm_file_cache, blob);
> +       if (blob) {
> +               file->f_security = NULL;
> +               kmem_cache_free(lsm_file_cache, blob);
> +       }
>  }
>
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> --
> 2.17.1
>
>



-- 
Kees Cook
Pixel Security
