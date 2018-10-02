Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D639C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88B72082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cw39HMQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88B72082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeJCDhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:37:48 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38329 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJCDhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:37:48 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so1377426ywa.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BigXsjJ8GKcX1ae9N+3KGnasaCrYsrBiqtxqVJKV8aA=;
        b=cw39HMQC1S6WK+5O5QLOBKHlI8qBLqR9uBkLnY0VLw6bvQ+jWSEHaXjZ8ynnU3ezAi
         jTDuob2JlwViYgMrSFMjH0iyJHVpPe+nIFN8ip6VIktHONuJx1od4sULQgpzFXZi/qty
         dlnTX9SWERJmLEqqImq5YAA7ZylbFpLghGWUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BigXsjJ8GKcX1ae9N+3KGnasaCrYsrBiqtxqVJKV8aA=;
        b=WD28M0zcjS0TOXC694YrKa5r8hnbglbrzxPysTC1OY+Lf3VLjwFNLw8gcS3+ZlStSc
         oO8lWQfjOyukilvvLajl0qIAxsc3aX5hcF1PnicZ8v4t7G9X0JvDFpnVVtNwHCcMBXS4
         m6VhiXpHSHFWOboBDC/nA+CKEohlWFtjqZpASigud5Yguw/bOklSl+BoO/GzoMWIqRLx
         Uo5nwreLa3TaFzMDoFcGZ+TQvZBogcVgr8UntplTchjRbNVgiUat8KtcoyiXYLeGpu2o
         bQHg8a7cumiawUgM92HMRoWg+dVAv2AFJ4+dTxCiqUX8uq+iIsncXJ9G0z/kvqqf1all
         So5Q==
X-Gm-Message-State: ABuFfogDINQ8/C2Iw4UYz0XjvQMFzhpubZvWLBlyMzOl96VP+RtT13yl
        zOwuDUUtAVzzgh16+DFwjVBcMpnNoOc=
X-Google-Smtp-Source: ACcGV62riehF2CJhTggXkDOX7SIm2NiiDER3CqM9ArHlrXNH7T4YXa3myVtLSLP3KzWKumQGkxTXjg==
X-Received: by 2002:a81:c845:: with SMTP id k5-v6mr9943412ywl.376.1538513554537;
        Tue, 02 Oct 2018 13:52:34 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d127-v6sm2719577ywb.84.2018.10.02.13.52.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 13:52:33 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id u88-v6so1432728ybi.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:52:33 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr9471213ybg.171.1538513552785;
 Tue, 02 Oct 2018 13:52:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 13:52:32 -0700 (PDT)
In-Reply-To: <20181002204722.GA9610@scapa.corsac.net>
References: <20181002204722.GA9610@scapa.corsac.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 13:52:32 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKLaYxP81FYp_=Vc8GZWVGs_TAzjw5m2CBm0sNKwohXCg@mail.gmail.com>
Message-ID: <CAGXu5jKLaYxP81FYp_=Vc8GZWVGs_TAzjw5m2CBm0sNKwohXCg@mail.gmail.com>
Subject: Re: [PATCH] yama: clarify ptrace_scope=2 in Yama documentation
To:     Yves-Alexis Perez <corsac@corsac.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 1:47 PM, Yves-Alexis Perez <corsac@corsac.net> wrote:
> Current phrasing is ambiguous since it's unclear if attaching to a
> children through PTRACE_TRACEME requires CAP_SYS_PTRACE. Rephrase the
> sentence to make that clear.
>
> Signed-off-by: Yves-Alexis Perez <corsac@corsac.net>

Thanks! Yes, this makes things more clear.

Acked-by: Kees Cook <keescook@chromium.org>

Jon, can you take this in your tree?

-Kees

> ---
>  Documentation/admin-guide/LSM/Yama.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
> index 13468ea696b7..d0a060de3973 100644
> --- a/Documentation/admin-guide/LSM/Yama.rst
> +++ b/Documentation/admin-guide/LSM/Yama.rst
> @@ -64,8 +64,8 @@ The sysctl settings (writable only with ``CAP_SYS_PTRACE``) are:
>      Using ``PTRACE_TRACEME`` is unchanged.
>
>  2 - admin-only attach:
> -    only processes with ``CAP_SYS_PTRACE`` may use ptrace
> -    with ``PTRACE_ATTACH``, or through children calling ``PTRACE_TRACEME``.
> +    only processes with ``CAP_SYS_PTRACE`` may use ptrace, either with
> +    ``PTRACE_ATTACH`` or through children calling ``PTRACE_TRACEME``.
>
>  3 - no attach:
>      no processes may use ptrace with ``PTRACE_ATTACH`` nor via
> --
> 2.19.0
>
>
> --
> Yves-Alexis



-- 
Kees Cook
Pixel Security
