Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4917ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C532086C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cw6dr+7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C532086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJ0EBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:01:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39929 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJ0EBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:01:15 -0400
Received: by mail-yw1-f67.google.com with SMTP id v1-v6so901268ywv.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H5/lGFkybpU7XwHBFpQN5l9sD9arVHPcGsmxTGmk2iU=;
        b=Cw6dr+7WpTQ4rBUJF6mWoq1O4fQ4K/N9EN3cX/e5KOhkL5B6mdkOeX51Ww46KGHxRP
         2huLvlIUBxv7niBo/03WSk6YgzfBOG5j4wYmIft0UfwyGLKB5JL0eQzAeNi/otpjZ6Pd
         OXaDrUuV7V7OyTo45/PvH7DCwptGmNubjnB2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H5/lGFkybpU7XwHBFpQN5l9sD9arVHPcGsmxTGmk2iU=;
        b=dXiTuLnuHtW2LXrmtaJLZ+r5S1mHTeBWoHy4e6fB5zcn2KrHtm0D23OdhVNUpp56Nf
         mprSrP+768bISFOsbh8AG4d4BRs1FpPOwVJgO8iDnYM1ApLiUkK+VQwf5KPepas98ump
         vVbLxcNAZikYhSWH0407Yzs/MZQ+0usS+3m8mKs+SvaTtM9AOWSyLL4T1bNC2Ge3+rOE
         TinIlzuqKMoYeKUp6rhzVl67880d+tMltIbtOIWZOUn7whJS7NE1PF0lySYixee7sRk3
         rySAJRliDP/8fdKc5fQiGn2gZMXXbN1Dwy6rgcIlH2ImLZAQSIiIGoVI831mb9YZAHR9
         WTog==
X-Gm-Message-State: AGRZ1gK3ejosnRYaEbX15Gcd6Mln9do9ARW0Pi21z/JAPPsGZkpxoCR9
        XqFwlwQ2Dql8mP1GAuBzgULPurEjsxARqg==
X-Google-Smtp-Source: AJdET5cF0Rqn/+oyXsxgm7gWeiWEBgnDjz/AE/nbbon9zytxY6zNNSOP5hEvf/9cVkDcQfdHXeUzXQ==
X-Received: by 2002:a81:90f:: with SMTP id 15-v6mr2956229ywj.70.1540581778465;
        Fri, 26 Oct 2018 12:22:58 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id f68-v6sm2173413ywh.60.2018.10.26.12.22.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:22:57 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id v199-v6so910348ywg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:22:56 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr5051360ywd.124.1540581776272;
 Fri, 26 Oct 2018 12:22:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:22:55
 -0700 (PDT)
In-Reply-To: <20181026180042.52199-3-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org> <20181026180042.52199-3-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:22:55 +0100
X-Gmail-Original-Message-ID: <CAGXu5jKqVJeCeOkBsEjjc5ZzieW-N1iRZ7Qjt7KL_NWLiPLaGg@mail.gmail.com>
Message-ID: <CAGXu5jKqVJeCeOkBsEjjc5ZzieW-N1iRZ7Qjt7KL_NWLiPLaGg@mail.gmail.com>
Subject: Re: [RFC 3/6] pstore: remove max argument from ramoops_get_next_prz
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
> From the code flow, the 'max' checks are already being done on the prz
> passed to ramoops_get_next_prz. Lets remove it to simplify this function
> and reduce its arguments.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/pstore/ram.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index cbfdf4b8e89d..3055e05acab1 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -124,14 +124,14 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>  }
>
>  static struct persistent_ram_zone *
> -ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
> +ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
>                      u64 *id, enum pstore_type_id *typep, bool update)
>  {
>         struct persistent_ram_zone *prz;
>         int i = (*c)++;
>
>         /* Give up if we never existed or have hit the end. */
> -       if (!przs || i >= max)
> +       if (!przs)
>                 return NULL;
>
>         prz = przs[i];
> @@ -254,8 +254,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>         /* Find the next valid persistent_ram_zone for DMESG */
>         while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
>                 prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
> -                                          cxt->max_dump_cnt, &record->id,
> -                                          &record->type, 1);
> +                                          &record->id, &record->type, 1);
>                 if (!prz_ok(prz))
>                         continue;
>                 header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
> @@ -271,17 +270,17 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
> -                                          1, &record->id, &record->type, 0);
> +                                          &record->id, &record->type, 0);
>
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
> -                                          1, &record->id, &record->type, 0);
> +                                          &record->id, &record->type, 0);
>
>         /* ftrace is last since it may want to dynamically allocate memory. */
>         if (!prz_ok(prz)) {
>                 if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
>                         prz = ramoops_get_next_prz(cxt->fprzs,
> -                                       &cxt->ftrace_read_cnt, 1, &record->id,
> +                                       &cxt->ftrace_read_cnt, &record->id,
>                                         &record->type, 0);
>                 } else {
>                         /*
> @@ -299,7 +298,6 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>                         while (cxt->ftrace_read_cnt < cxt->max_ftrace_cnt) {
>                                 prz_next = ramoops_get_next_prz(cxt->fprzs,
>                                                 &cxt->ftrace_read_cnt,
> -                                               cxt->max_ftrace_cnt,
>                                                 &record->id,
>                                                 &record->type, 0);
>
> --
> 2.19.1.568.g152ad8e336-goog
>

Yup, looks good.

-- 
Kees Cook
