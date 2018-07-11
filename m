Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01852208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9dfZlAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01852208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeGKFqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:46:05 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42641 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeGKFqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:46:05 -0400
Received: by mail-yw0-f196.google.com with SMTP id y203-v6so8720981ywd.9;
        Tue, 10 Jul 2018 22:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l2No6tSj48x0AWopEeL0oE6Zucdx1uJQ1cUyW1NUfg0=;
        b=e9dfZlAr4VOWFiacnPlTBzbggbEoROfUjJP3jWspmN5r9cjM74els7rz1wcZQ+UZQa
         iiuo++T2sckKWBvdXYsIHeuWFtR0ZH0sM+3ejRDUqA9mba7JQ5PZMLcqNqBHRgpHqE9j
         bn+nTYrBvgVpl/uMuz1jyCjByFmsireTcASnMP987H+0yjtBMWdfmrEMFH1N5Mx3uGIB
         OXo+2C56JarIcSeI+s4UgeM3Y1GK2aXOtqGPrsRyexLZNliT0DQ73CZMpuKL6GoXlQ0j
         R7n1b65ccDGMTmI5zypG3SPmxv984+pZQK/YVS8P0WAhiaC7bllRbYxOxwDVqcl7EBKc
         5lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l2No6tSj48x0AWopEeL0oE6Zucdx1uJQ1cUyW1NUfg0=;
        b=bF75XRlfUeHH7vmg9DbPKmv2rKptNbutP3he+aIa53sLFucREru86ZtyWWAR/tb9fu
         sBniwbuYX+tjeICpT/IEyLaWoFEVRCHHL8vGZvIbCgF1EwmInFJNGfd+uvF9OxCuc1i8
         PrEVv/pP9Os/G0O8WBXuTdvd2JOgcaTTlUncvqdILT7xZrVJZUDBgp2TAa83wcJVO5Kc
         lvC+v6HpFEsG13TP0ZKnpDTvEK28HYEqH57QaOqhdxyB/btt5C3jKwy8An5M9E6nxwQf
         jYErLJUtd1UHFUKnn+QmQJQ24pYiTS8uxMX3pAYtEBSa0ZdoG4lgSoiFFRMQmeHEF+r8
         QYwg==
X-Gm-Message-State: APt69E0BY997YEdNOVoY9Bg3+xAMfcofn2oPWlEpmpF4ZknzcKrHjBl6
        9U02/zSdO4rXZzzkMbO5BlY+yqFVexu5wBsa9Q7b1g==
X-Google-Smtp-Source: AAOMgpcIe8Yes1T0M4NenNa+rxxwu78y7/CHex+/vM5Wduq3zrhJN5bB5uepTnUUcWuJ8gTbFeJaewzzHiEIFVxR/aQ=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr13105116ywn.88.1531287811491;
 Tue, 10 Jul 2018 22:43:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:7dc5:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 22:43:31
 -0700 (PDT)
In-Reply-To: <20180711022206.12571-15-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-15-viro@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Jul 2018 08:43:31 +0300
Message-ID: <CAOQ4uxgQs3D+2wDjB8F8EotWwJx5MayYBjSe11DpHWbAO_5Tfg@mail.gmail.com>
Subject: Re: [RFC][PATCH 15/42] lift fput() on late failures into path_openat()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 5:21 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
[...]
> @@ -3407,8 +3407,6 @@ static int do_last(struct nameidata *nd,
>         if (!error && will_truncate)
>                 error = handle_truncate(file);
>  out:
> -       if (unlikely(error) && (*opened & FILE_OPENED))
> -               fput(file);
>         if (unlikely(error > 0)) {
>                 WARN_ON(1);

Another opportunity to squash WARN_ON(1) with condition.

>                 error = -EINVAL;
> @@ -3484,8 +3482,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
>         if (error)
>                 goto out2;
>         error = open_check_o_direct(file);
> -       if (error)
> -               fput(file);
>  out2:
>         mnt_drop_write(path.mnt);
>  out:
> @@ -3547,20 +3543,20 @@ static struct file *path_openat(struct nameidata *nd,
>         }
>         terminate_walk(nd);
>  out2:
> -       if (!(opened & FILE_OPENED)) {
> -               BUG_ON(!error);
> -               fput(file);
> +       if (likely(!error)) {
> +               if (likely(opened & FILE_OPENED))
> +                       return file;
> +               WARN_ON(1);

This style may be open for debate but:

               if (!WARN_ON(!(opened & FILE_OPENED)))
                       return file;

Maybe we need WARN_UNLESS() or WARN_ASSERT()

Thanks,
Amir.
