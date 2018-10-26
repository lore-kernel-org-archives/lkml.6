Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA846ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23622085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RK4BCBIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23622085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJ0Dn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:43:57 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46398 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ0Dn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:43:57 -0400
Received: by mail-yb1-f194.google.com with SMTP id f15-v6so407893ybq.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cQ5zmK7UPObCKq4wrScdRKEZSIqXacdwba9c0yEd0ag=;
        b=RK4BCBINZO76aRc2tUYd2adUGdOrOy3CcXKRDLfpWGhaFoZhSMpF7f5bC1kGwgyvQr
         qaFW0ExJkPFyPeVOZq5DyWweF9cxpxIlXpfQcyZovl3YFydo6EmTEia74B0f6COYioPo
         clqMZ0x6pq81TGn4PHRO3zDBoE+RbBcIsO1Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cQ5zmK7UPObCKq4wrScdRKEZSIqXacdwba9c0yEd0ag=;
        b=FHFqKxBXuM9UqPmDu5bCJP9L3aSvMkSyyFXw+3JlXHfMvZXzbIWCOYjfWrouUUON+Q
         fYceaFI2NS7IN9NvYeXeI/guwrUkSEKFqtTx4mQVwFda8iwZrEPqD8nglk/i//Mfl7pz
         GYQYkF1bK/KNTFzA4rzHS1uj508u7CQNvlvTLcWShhgbodhj14TBRCChdwbIcecP9M7H
         34Y9dQtjRCuL9ojAAf+aKrSMd4oAzhyVTN2VEMhU9+/seHQPpEDc2nrAwkdBMS3SFIg0
         qv4oecR2cTS5jbRdc/51I9lqvSceILMPhmBPrh27t/YN3jgPL+hhS1uY9kiT+2WpHFCa
         uGsA==
X-Gm-Message-State: AGRZ1gIgWK6zfU2rF3VjJmGZ8w5coG43lFNnhEtQHnHO9SJkiCmnO0ye
        Ob5dBw7wqVq1TW2yy5bIFciRBhQflzJcFQ==
X-Google-Smtp-Source: AJdET5evPKS1xtrWqZ/VWQmhZrYQ6u9/QvyTOg7RzXZz7adlKk9f0IJeJzGCihIbCNrPdZph1kOqYQ==
X-Received: by 2002:a25:200b:: with SMTP id g11-v6mr4984397ybg.390.1540580743124;
        Fri, 26 Oct 2018 12:05:43 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g66-v6sm3972104ywg.22.2018.10.26.12.05.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:05:41 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id j9-v6so905986ybj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:05:41 -0700 (PDT)
X-Received: by 2002:a25:2386:: with SMTP id j128-v6mr4832820ybj.137.1540580740794;
 Fri, 26 Oct 2018 12:05:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:05:40
 -0700 (PDT)
In-Reply-To: <20181026180042.52199-2-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org> <20181026180042.52199-2-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:05:40 +0100
X-Gmail-Original-Message-ID: <CAGXu5jLLzuwmO6C8nQp3YY0KC0yBiDSJ_U6-Xk1g8T8hzhcZpQ@mail.gmail.com>
Message-ID: <CAGXu5jLLzuwmO6C8nQp3YY0KC0yBiDSJ_U6-Xk1g8T8hzhcZpQ@mail.gmail.com>
Subject: Re: [RFC 2/6] pstore: remove type argument from ramoops_get_next_prz
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
> Since we store the type of the prz when we initialize it, we no longer
> need to pass it again in ramoops_get_next_prz since we can just use that
> to setup the pstore record. So lets remove it from the argument list.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Yes yes. I like where this is going. :)

-Kees

> ---
>  fs/pstore/ram.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index c7cd858adce7..cbfdf4b8e89d 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -125,9 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>
>  static struct persistent_ram_zone *
>  ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
> -                    u64 *id,
> -                    enum pstore_type_id *typep, enum pstore_type_id type,
> -                    bool update)
> +                    u64 *id, enum pstore_type_id *typep, bool update)
>  {
>         struct persistent_ram_zone *prz;
>         int i = (*c)++;
> @@ -147,7 +145,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
>         if (!persistent_ram_old_size(prz))
>                 return NULL;
>
> -       *typep = type;
> +       *typep = prz->type;
>         *id = i;
>
>         return prz;
> @@ -257,8 +255,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>         while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
>                 prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
>                                            cxt->max_dump_cnt, &record->id,
> -                                          &record->type,
> -                                          PSTORE_TYPE_DMESG, 1);
> +                                          &record->type, 1);
>                 if (!prz_ok(prz))
>                         continue;
>                 header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
> @@ -274,20 +271,18 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
> -                                          1, &record->id, &record->type,
> -                                          PSTORE_TYPE_CONSOLE, 0);
> +                                          1, &record->id, &record->type, 0);
>
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
> -                                          1, &record->id, &record->type,
> -                                          PSTORE_TYPE_PMSG, 0);
> +                                          1, &record->id, &record->type, 0);
>
>         /* ftrace is last since it may want to dynamically allocate memory. */
>         if (!prz_ok(prz)) {
>                 if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
>                         prz = ramoops_get_next_prz(cxt->fprzs,
>                                         &cxt->ftrace_read_cnt, 1, &record->id,
> -                                       &record->type, PSTORE_TYPE_FTRACE, 0);
> +                                       &record->type, 0);
>                 } else {
>                         /*
>                          * Build a new dummy record which combines all the
> @@ -306,8 +301,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>                                                 &cxt->ftrace_read_cnt,
>                                                 cxt->max_ftrace_cnt,
>                                                 &record->id,
> -                                               &record->type,
> -                                               PSTORE_TYPE_FTRACE, 0);
> +                                               &record->type, 0);
>
>                                 if (!prz_ok(prz_next))
>                                         continue;
> --
> 2.19.1.568.g152ad8e336-goog
>



-- 
Kees Cook
