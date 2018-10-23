Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C83C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA120651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Np4taQbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EA120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeJXDyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:54:13 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38489 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:54:13 -0400
Received: by mail-yb1-f193.google.com with SMTP id v92-v6so1070072ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iISPVQgqSXIoQN8CzV3IwJaOfFETIsNivH72gPWa6iE=;
        b=Np4taQbOHkgFgssaefO1bmT37EZdkS8NKax57gzJ4rFvK8jwIIQ4o2W2NfVEQWmsD6
         Xia7CcGhNlj+Rc4g9V/G21hTr50zsW0TdmXxmS5YUSmyIOaWgWnoGpyiad+MRBQevhJM
         wL/ocziVhY8c7eP1MtkGYuomr4VYw+NKoypts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iISPVQgqSXIoQN8CzV3IwJaOfFETIsNivH72gPWa6iE=;
        b=SgrT0XBQcLzpF8Gmcre6h7PCOy53BHJ9Bk/OD1COWcJRXS2X8Tj0MGfL1RCRHL8IS7
         waazExfHPiCpsWLKMbyAVLk5l7gDPQdpzweAYNQ+tmjx90qhjIj6g8iYQ0t9KfCZiort
         PMWMD/1Z7R1+ooGQ2eXF9DtsBIYsWPoQYEQKG82A/+g4/z7Cpjw144lfi8sq1W+j2ODf
         36n1CreKoBL5/9iXm70vR+mRsiujf+h+bpFGww7JNOF02QK8UA+cCUjR3KrnqXEDi1Zf
         8WoHJ2HTF4FP8rv0ILvv5NChQwF6vqOj9MLwc0v6f+/9wje0nSWJbL/Lh6KzJnaWKccY
         t4UQ==
X-Gm-Message-State: ABuFfohwcxd8wBHxnmsKYK6BpOWVly04p+XKi6LhruQuCpkcs7ip9eJu
        +GDVoS0tqUgECs9NHqgYqX60l77EFxE=
X-Google-Smtp-Source: ACcGV60m3qlFiMBF0lQ5q2MT/bYFpZy/MhOlmPIK9iJqJmoXuevz7OyoRYQ4F2s8dp2FJuTsL6xIcQ==
X-Received: by 2002:a25:e04:: with SMTP id 4-v6mr36605304ybo.152.1540322966740;
        Tue, 23 Oct 2018 12:29:26 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id x3-v6sm440949ywc.56.2018.10.23.12.29.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:29:25 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id y76-v6so1051871ywd.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:29:25 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr38317625yws.168.1540322964624;
 Tue, 23 Oct 2018 12:29:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 12:29:23
 -0700 (PDT)
In-Reply-To: <20181023111633.490-1-efremov@linux.com>
References: <20181023111633.490-1-efremov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 12:29:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+wOjprJ2DJSSXyWOkUAH8F=g84gvv0JFCJ3F81Q212Ww@mail.gmail.com>
Message-ID: <CAGXu5j+wOjprJ2DJSSXyWOkUAH8F=g84gvv0JFCJ3F81Q212Ww@mail.gmail.com>
Subject: Re: [PATCH] security: fix documentation for the path_chmod hook
To:     efremov@linux.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:16 AM,  <efremov@linux.com> wrote:
> From: Denis Efremov <efremov@linux.com>
>
> The path_chmod hook was changed in the commit
> "switch security_path_chmod() to struct path *" (cdcf116d44e7).
> The argument @mnt was removed from the hook, @dentry was changed
> to @path. This patch updates the documentation accordingly.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a598e601ccb3..596351f7c3d1 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -304,8 +304,7 @@
>   *     Return 0 if permission is granted.
>   * @path_chmod:
>   *     Check for permission to change DAC's permission of a file or directory.
> - *     @dentry contains the dentry structure.
> - *     @mnt contains the vfsmnt structure.
> + *     @path contains the path structure.
>   *     @mode contains DAC's mode.
>   *     Return 0 if permission is granted.
>   * @path_chown:
> --
> 2.17.2
>



-- 
Kees Cook
