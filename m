Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8BC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AC4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bx4gPVm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AC4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeK0QbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:31:13 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44223 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbeK0QbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:31:12 -0500
Received: by mail-yw1-f67.google.com with SMTP id h138-v6so6824556ywa.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 21:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/omSkAw6P4Rj7FKfx5WJTuN6rcUIqdUCq/wshJQTtw0=;
        b=Bx4gPVm9X1ZbEiUOLyAtfukRlonEjTcdM86nr32HpuBEtfrZiKkmk2U6iQTUB/v/H7
         2uhOzByMV8JAEvAyQf6cX4xhGOXWWaGPIn3/4GqcW2e7HVDu6PFZa5rV3N3pWIAsKjYi
         GEd0s5BXK1pk0hb3GsA0NmgH7GM0p6FikQ+hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/omSkAw6P4Rj7FKfx5WJTuN6rcUIqdUCq/wshJQTtw0=;
        b=sOYeFN5pi2egaIqfjvDiXUF/kdcmda41wEZUZAchHoNcFqeMX2d1hcZAgq9tFndr//
         OkPGRDfggQQhZ3lCCeYEMM7jQUUMqlxRxk2RwKqDHnSf2FDrV0kwF3CfIQdKJ7Yk9/VD
         3U0xZCx+GCeHXGUY5oBpITchxvEf1N7G6Rm+p3Yhd/3Fb9N2Avmo00EwO9WJiJSUgYkg
         8a7yFxMtds/enKzpPrwuaUORiE0GnyhFQ9OAPbWmAvcbXUarIoyEYVnB0cyEOrOuBUjH
         ohZkCsQFkM0K2U2o9qDbRh89Vr9AgFtzHZRuthTdrT/cDQOj3WCVLyPDPUjzRDc5jqrE
         gf9w==
X-Gm-Message-State: AGRZ1gLKmGfnGZCnWlECshZLo99Jm2h2duDGMQYGdIWzcfqxwSVislv/
        RwMhZWc5Fp7BMzIOnzojquknSmlJxpo=
X-Google-Smtp-Source: AJdET5fMA+g0qHPl86vMloWAR6NkK/Qv9TC74c/Ass0kFCHrv7RK89tRKcUYSMlvG1j1le4ZEvQTiA==
X-Received: by 2002:a81:4d42:: with SMTP id a63mr32615217ywb.189.1543296869995;
        Mon, 26 Nov 2018 21:34:29 -0800 (PST)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id r188sm689059ywb.30.2018.11.26.21.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 21:34:27 -0800 (PST)
Received: by mail-yw1-f47.google.com with SMTP id f65so8633724ywc.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 21:34:27 -0800 (PST)
X-Received: by 2002:a81:760b:: with SMTP id r11-v6mr30130739ywc.353.1543296866988;
 Mon, 26 Nov 2018 21:34:26 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com> <ecb10f5c-7bbd-fb2e-4148-63290bc9a7ff@schaufler-ca.com>
In-Reply-To: <ecb10f5c-7bbd-fb2e-4148-63290bc9a7ff@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 26 Nov 2018 21:34:15 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJxjJoQmdsjy18z6N0fcSfpNTx60YnRESbOToHQG_2mdQ@mail.gmail.com>
Message-ID: <CAGXu5jJxjJoQmdsjy18z6N0fcSfpNTx60YnRESbOToHQG_2mdQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/38] LSM: Introduce LSM_FLAG_LEGACY_MAJOR
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

Hmmm... the "From: Kees..." in the body is missing. Are you using "git
send-email"?

>
> This adds a flag for the current "major" LSMs to distinguish them when
> we have a universal method for ordering all LSMs. It's called "legacy"
> since the distinction of "major" will go away in the blob-sharing world.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  include/linux/lsm_hooks.h  | 3 +++
>  security/apparmor/lsm.c    | 1 +
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  security/tomoyo/tomoyo.c   | 1 +
>  5 files changed, 7 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index aaeb7fa24dc4..63c0e102de20 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2039,8 +2039,11 @@ extern char *lsm_names;
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>                                 char *lsm);
>
> +#define LSM_FLAG_LEGACY_MAJOR  BIT(0)
> +
>  struct lsm_info {
>         const char *name;       /* Required. */
> +       unsigned long flags;    /* Optional: flags describing LSM */
>         int (*init)(void);      /* Required. */
>  };
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 42446a216f3b..2edd35ca5044 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1728,5 +1728,6 @@ static int __init apparmor_init(void)
>
>  DEFINE_LSM(apparmor) = {
>         .name = "apparmor",
> +       .flags = LSM_FLAG_LEGACY_MAJOR,
>         .init = apparmor_init,
>  };
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce683259357..56c6f1849c80 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7209,6 +7209,7 @@ void selinux_complete_init(void)
>     all processes and objects when they are created. */
>  DEFINE_LSM(selinux) = {
>         .name = "selinux",
> +       .flags = LSM_FLAG_LEGACY_MAJOR,
>         .init = selinux_init,
>  };
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 81fb4c1631e9..3639e55b1f4b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4891,5 +4891,6 @@ static __init int smack_init(void)
>   */
>  DEFINE_LSM(smack) = {
>         .name = "smack",
> +       .flags = LSM_FLAG_LEGACY_MAJOR,
>         .init = smack_init,
>  };
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 1b5b5097efd7..09f7af130d3a 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -552,5 +552,6 @@ static int __init tomoyo_init(void)
>
>  DEFINE_LSM(tomoyo) = {
>         .name = "tomoyo",
> +       .flags = LSM_FLAG_LEGACY_MAJOR,
>         .init = tomoyo_init,
>  };
> --
> 2.14.5
>
>


-- 
Kees Cook
