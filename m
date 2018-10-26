Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A56EECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE562085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="irAVEsgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE562085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJ0ERg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:17:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38407 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeJ0ERg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:17:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so924861ywa.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mXdfZEjoJu02sLfhwsZo7dmcaw5jh/4mpH+k4B3M32M=;
        b=irAVEsgZHcyCQ+8spbLqPx4vUt3bc0RxxuUDUah3myPMqRaDZrGoinxkSwpGDR8+c4
         cVfsLJ9pCMmx4E7nmSAHplDP9+k5xqVGJsiAg0CU1bPTU+Ywmo1l+Iduv6mAtCrQoZlI
         KPWkOSVcFNkzEllcI0VaoupLSBYGZB2PxpkeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mXdfZEjoJu02sLfhwsZo7dmcaw5jh/4mpH+k4B3M32M=;
        b=rAwid65GzS5WuouQiv7xshqA5CjjARLOqSP6elL8D6MqHc1P4CbwEChigZDUAha1ZY
         MI5kklRvShWPUkX49n+tpFEaPG1G5hLGadfhfhdraV2E+DWWbq89MZaBBP/QU7XoPGr6
         Ag14P6PYB084ou5AKkaneloM4CcipS8L2bGfvqNkwH9WndnDcbTJ/IyvZHUfXPkFA3Mh
         KZnXUY0/s6rN3XABb5HpUeKHPhtIvig8q5LTuMdqbskkZ+ZFRhlc9AUNoMKan5LDTJ48
         ItSzOacwyUBHJ3/ZEPctJ8aSKAvieg86AjCwrZcdEhfMkOjXl8M3BlkLLvgwMdRtvJ41
         sdwQ==
X-Gm-Message-State: AGRZ1gK0HlcPfpexAQ3RShj2qUaDGMI+k497Tn7xKQ81IhdLZBtXHQgL
        zVDmSN42hSHG1HxSTnkuPqeYZ4Dc+10KgA==
X-Google-Smtp-Source: AJdET5dmPXizQHh7nDMQptRfZ6CClXbUoS01eHlXOwV9nqLYVNSdqYSmY9SfEXEHBDwZqBBuiKmHLg==
X-Received: by 2002:a81:2bc6:: with SMTP id r189-v6mr5015106ywr.118.1540582756544;
        Fri, 26 Oct 2018 12:39:16 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id v19-v6sm4595585ywv.19.2018.10.26.12.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:39:15 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id x185-v6so932894ywa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:39:14 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr5059785ywd.288.1540582754351;
 Fri, 26 Oct 2018 12:39:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:39:13
 -0700 (PDT)
In-Reply-To: <20181026180042.52199-5-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org> <20181026180042.52199-5-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:39:13 +0100
X-Gmail-Original-Message-ID: <CAGXu5jKtZjZVr=7dAHQPU0OGtBpEKDZBO68-RTvFLbK6qB+cEA@mail.gmail.com>
Message-ID: <CAGXu5jKtZjZVr=7dAHQPU0OGtBpEKDZBO68-RTvFLbK6qB+cEA@mail.gmail.com>
Subject: Re: [RFC 5/6] pstore: donot treat empty buffers as valid
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> pstore currently calls persistent_ram_save_old even if a buffer is
> empty. While this appears to work, it is simply not the right thing to
> do and could lead to bugs so lets avoid that. It also prevent misleading
> prints in the logs which claim the buffer is valid.

I need to be better convinced that a present zero length record is the
same as a non-present record. This seems true, but there is
potentially still metadata available from a backend. What were the
misleading prints in logs?

-Kees

>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/pstore/ram_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 0792595ebcfb..1299aa3ea734 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -495,7 +495,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>
>         sig ^= PERSISTENT_RAM_SIG;
>
> -       if (prz->buffer->sig == sig) {
> +       if (prz->buffer->sig == sig && buffer_size(prz)) {
>                 if (buffer_size(prz) > prz->buffer_size ||
>                     buffer_start(prz) > buffer_size(prz))
>                         pr_info("found existing invalid buffer, size %zu, start %zu\n",
> --
> 2.19.1.568.g152ad8e336-goog
>



-- 
Kees Cook
