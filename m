Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A14F216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpuENIgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A14F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeI1EC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:02:26 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39397 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeI1EC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:02:26 -0400
Received: by mail-yb1-f195.google.com with SMTP id c4-v6so1781171ybl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DthDTGdMLTcGhr9eBo4H5+DKllqHMisL3jYtwX7sWUk=;
        b=OpuENIgJhpy1iC0U2Ws/eK6ttY9NoZU8/aQ04C4CSt2qZ0bmHn3m2A2Ogc1ER3Mu9P
         KAUvs9n6nN3Q45IqRz6ZtHSLdKCkDzXlMGBYFm4BzW6eW/qPeQmxL3jlwyenmwZ2xCYH
         16BLZCnQpQ/WbiYKTTvacCRiHs6mugbgTmCG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DthDTGdMLTcGhr9eBo4H5+DKllqHMisL3jYtwX7sWUk=;
        b=dsUv6h2X5PEHOBcp2pkQgAkojMnr4l2UnsqTl2pk9yRLeAn1EvM6S+G3JLcIH1fTfu
         SaBiUY9jkFDV4fvU/u6fpDHjOjRrSURlCnlRBx6BPpUO5Jt+1ZyXbNH3TFFDTw4HtGct
         qSg9X2Miltfyd4ECFJyCzlG18sz0UrVp+a/7KkY9KgR8L9Ea5u5+9AWKUVAOqGJuRBni
         LoX13TTf0QR8ZTkFwOf/ztMo7Qqsgijd7KI3phhRiQq6MsiV6D5p9e+RDzsJa/tFtKnA
         FNJQ4y5bV0qOpL5n9BBUyIXnKG/3+GZD6kSV17s4Ip2w3Yvg98bNSH+cmfwiDQvMdXkv
         x85A==
X-Gm-Message-State: ABuFfojPrpXagQ4F26fsOusqM/cEvfMBdofNTx/8gxeMaILLq3ZbQgEy
        gJsWYUEJUsiJc/8OXSZSNk4Q3bgNGpE=
X-Google-Smtp-Source: ACcGV626kF79liPcUH3V5CBq3qnXtwf7ow8h50Q/yP0oZ9s0I+cQF5CTvkSye8ergoi4nT/7IwLPmw==
X-Received: by 2002:a25:e90b:: with SMTP id n11-v6mr6848461ybd.456.1538084526397;
        Thu, 27 Sep 2018 14:42:06 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id p190-v6sm1192878ywe.83.2018.09.27.14.42.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:42:03 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id y14-v6so1758675ywa.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:42:03 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr7145484ywi.288.1538084522922;
 Thu, 27 Sep 2018 14:42:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 14:42:02
 -0700 (PDT)
In-Reply-To: <20180927151119.9989-3-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-3-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 14:42:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKdKYmF-gmUyBSGaZw3Jhc9HMXOiNRpSRRhLNcyBZEPSw@mail.gmail.com>
Message-ID: <CAGXu5jKdKYmF-gmUyBSGaZw3Jhc9HMXOiNRpSRRhLNcyBZEPSw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> In the next commit we'll use this same mnemonic to get a listener for the
> nth filter, so we need it available outside of CHECKPOINT_RESTORE in the
> USER_NOTIFICATION case as well.
>
> v2: new in v2
> v3: no changes
> v4: no changes
> v5: switch to CHECKPOINT_RESTORE || USER_NOTIFICATION to avoid warning when
>     only CONFIG_SECCOMP_FILTER is enabled.
> v7: drop USER_NOTIFICATION bits
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  kernel/seccomp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index fa6fe9756c80..44a31ac8373a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1158,7 +1158,7 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
>         return do_seccomp(op, 0, uargs);
>  }
>
> -#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> +#if defined(CONFIG_SECCOMP_FILTER)
>  static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>                                              unsigned long filter_off)
>  {
> @@ -1205,6 +1205,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>         return filter;
>  }
>
> +#if defined(CONFIG_CHECKPOINT_RESTORE)
>  long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
>                         void __user *data)
>  {
> @@ -1277,7 +1278,8 @@ long seccomp_get_metadata(struct task_struct *task,
>         __put_seccomp_filter(filter);
>         return ret;
>  }
> -#endif
> +#endif /* CONFIG_CHECKPOINT_RESTORE */
> +#endif /* CONFIG_SECCOMP_FILTER */
>
>  #ifdef CONFIG_SYSCTL

Yup, looks fine.

-Kees

-- 
Kees Cook
Pixel Security
