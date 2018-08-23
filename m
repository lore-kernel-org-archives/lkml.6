Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71BC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bop/eTwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71BC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbeHWRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:51:09 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46266 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbeHWRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:51:08 -0400
Received: by mail-yb0-f196.google.com with SMTP id y20-v6so2050648ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oziJ4mbphPSx+/W9I5RJWNVfgGLODCCGOHMNdePKfoI=;
        b=Bop/eTwDKZuHRXe61BerRKKtSUVfB7yoiso6wCrKSmsfSgpWsIu5q5dq+pYhMSPKk+
         l6c150WfRdTJyNJMYoL/rEpHg8QpExMYGZynatAOD0oQUO0qkls3Y9/Jmy4le1ao9Al9
         GdXOAL1kyCtesl1m6dUf3pNEbbrNU0cAdvwmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oziJ4mbphPSx+/W9I5RJWNVfgGLODCCGOHMNdePKfoI=;
        b=Jcczlg/Tj+1ToLdUTd3om8PAVKjNBZt4rXyC0jqmafTxVSSwDTlP1eQ/f+vMvXwa/A
         sFtlqeb9xw7uF3G+DC/Ysa78Yys7wlrsNNxIhdnLNHtXckCdjkyNa6bujer6P7vtATBq
         wmKLWLOM5UtDqjE3TkClm6UDSGC0scdzkJKSj9AXiVsiAhxkbwJbqZuyyvd3IpN21BcI
         s2pawLCKEow3YkJwhhtT2fdwk7k2wx6vv3HZQcykwQtc8zU9JLJ/MuN5bRT/J9/JHGTr
         s3UYwvmDIz9wubleHG68IrYUpyJwGGYmcKvUoOCPbB28wOBjVhqhlY55ZCSD+/Psdxq9
         JoZA==
X-Gm-Message-State: AOUpUlF/5Wh3RMWNZ2D73S7y2jd4NXwm0CpiXuDS93ghvK9n+EY4akoK
        v42Nzdq2H3ZFax8dTT2BZ8aihy5uC6o=
X-Google-Smtp-Source: AA+uWPxm+zy4JZ1gNj0pmPSYr3hPrhsscP7/DY39tkkZ+aBmQi21lMIl+izkeUQ6v7gCIrWt5BQf2Q==
X-Received: by 2002:a25:3d2:: with SMTP id 201-v6mr14692895ybd.160.1535034073744;
        Thu, 23 Aug 2018 07:21:13 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 138-v6sm119229ywj.30.2018.08.23.07.21.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 07:21:12 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id 14-v6so2023183ywe.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:21:12 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr2779347ywg.353.1535034071767;
 Thu, 23 Aug 2018 07:21:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 07:21:10
 -0700 (PDT)
In-Reply-To: <20180823140917.3060915-1-arnd@arndb.de>
References: <20180823140917.3060915-1-arnd@arndb.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 07:21:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJpuPuu+QYhzGc3MbVU7zL0kWfGMOQRf7zg++8WX4TMgw@mail.gmail.com>
Message-ID: <CAGXu5jJpuPuu+QYhzGc3MbVU7zL0kWfGMOQRf7zg++8WX4TMgw@mail.gmail.com>
Subject: Re: [PATCH] apparmor: remove unused label
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 7:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> After the corresponding 'goto' was removed, we get a warning
> for the 'fail' label:
>
> security/apparmor/policy_unpack.c: In function 'unpack_dfa':
> security/apparmor/policy_unpack.c:426:1: error: label 'fail' defined but not used [-Werror=unused-label]
>
> Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/apparmor/policy_unpack.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 3647b5834ace..96d8cf68ce65 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -423,7 +423,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>
>         return dfa;
>
> -fail:
>         aa_put_dfa(dfa);
>         return ERR_PTR(-EPROTO);
>  }
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
