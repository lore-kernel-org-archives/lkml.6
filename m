Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8693ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5632D20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eOmLSWlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5632D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ0EKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:10:38 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43407 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJ0EKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:10:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id j75-v6so909634ywj.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m18beiZY/NGt28plFCGcBYujG4QmYJLf0rMTu/FwF7g=;
        b=eOmLSWlkOkyLSkag1HPj5TmM3aQsCcdKlPrd3qoRECFKlYRPEV+oJeECzVJPbAhTKi
         dNKd/UzsaX/tekvwsKpjFrkkA3BBh5AdSs7Q8gtdlMfUZzblyP4dBmrviHXzEw0TgneG
         +PYw9e6dlwawEhAlYsQb1f039t4ODKeh2/4AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m18beiZY/NGt28plFCGcBYujG4QmYJLf0rMTu/FwF7g=;
        b=Ya8p/QylqMHA8eIWwIAEf/Ah7Gh1Sl2mVD8FXDUnptxqqrBQxwlDZd0Wud3Ay/YH62
         29TRtUa9J55du9tL4m1zgiUvWUchqGytplsk6K8p24WvXTkRxkbIoA/3McgGAUqw8Dss
         zVi4HnH/CAlhdgY2SZgmLp/4gkJZ1RDvQvQEDsSKVY7Sm8gwNIeWP78+liUWBPcRmboM
         9phApK4yyh3CH7zzbAOGSB3TtjjozZL/juQpJORdTU4t4+4GF+Haa08xSRQXlX5rcutu
         t/LA2UDzmBWhGTn3blMWkCe7RRU+3u8YUDsRnDmCFm8Nzjj/F9btZnD/0wk+vNBaSlh6
         zqnQ==
X-Gm-Message-State: AGRZ1gIziL6yWQx+FdNMe+xYCcw6WOzGSNxTXYkZRnJ0XAKYc5ssoqTW
        wjKU8v9G9gRYnQIKgb144s8SRVvN2Bo2bw==
X-Google-Smtp-Source: AJdET5f+LsFV8l+xsRMUcVUh4KGfkxvU2ZCOR0fVVp8Y9V8zSGfxnrO25P+FNBrn0gyDYQPF1Tc3LQ==
X-Received: by 2002:a0d:da85:: with SMTP id c127-v6mr4952923ywe.21.1540582339427;
        Fri, 26 Oct 2018 12:32:19 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 84-v6sm2654511ywp.69.2018.10.26.12.32.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:32:18 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p144-v6so929420yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:32:18 -0700 (PDT)
X-Received: by 2002:a25:c6c8:: with SMTP id k191-v6mr4669235ybf.171.1540582337622;
 Fri, 26 Oct 2018 12:32:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:32:16
 -0700 (PDT)
In-Reply-To: <20181026180042.52199-4-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org> <20181026180042.52199-4-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:32:16 +0100
X-Gmail-Original-Message-ID: <CAGXu5jJi5M+wfF8X7ud2jTjdJZRE4sCnZgv9OA9ZX-wwpZ5PnA@mail.gmail.com>
Message-ID: <CAGXu5jJi5M+wfF8X7ud2jTjdJZRE4sCnZgv9OA9ZX-wwpZ5PnA@mail.gmail.com>
Subject: Re: [RFC 4/6] pstore: further reduce ramoops_get_next_prz arguments
 by passing record
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
> Both the id and type fields of a pstore_record are set by
> ramoops_get_next_prz. So we can just pass a pointer to the pstore_record
> instead of passing individual elements. This results in cleaner more
> readable code and fewer lines.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/pstore/ram.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 3055e05acab1..710c3d30bac0 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -125,7 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>
>  static struct persistent_ram_zone *
>  ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
> -                    u64 *id, enum pstore_type_id *typep, bool update)
> +                    struct pstore_record *record, bool update)
>  {
>         struct persistent_ram_zone *prz;
>         int i = (*c)++;
> @@ -145,8 +145,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
>         if (!persistent_ram_old_size(prz))
>                 return NULL;
>
> -       *typep = prz->type;
> -       *id = i;
> +       record->type = prz->type;
> +       record->id = i;

Yes yes. I've been meaning to get all this cleaned up after I
refactored everything to actually HAVE record at all. :P

>
>         return prz;
>  }
> @@ -254,7 +254,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>         /* Find the next valid persistent_ram_zone for DMESG */
>         while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
>                 prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
> -                                          &record->id, &record->type, 1);
> +                                          record, 1);

In another patch, I think you could drop the "update" field too, and
use the record->type instead to determine if update is needed. Like:

static struct persistent_ram_zone *
ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint c,
                                      struct pstore_record *record)
{
    bool update = (record->type == PSTORE_TYPE_DMESG);
...

>                 if (!prz_ok(prz))
>                         continue;
>                 header_length = ramoops_read_kmsg_hdr(persistent_ram_old(prz),
> @@ -270,18 +270,17 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
> -                                          &record->id, &record->type, 0);
> +                                          record, 0);
>
>         if (!prz_ok(prz))
>                 prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
> -                                          &record->id, &record->type, 0);
> +                                          record, 0);
>
>         /* ftrace is last since it may want to dynamically allocate memory. */
>         if (!prz_ok(prz)) {
>                 if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
>                         prz = ramoops_get_next_prz(cxt->fprzs,
> -                                       &cxt->ftrace_read_cnt, &record->id,
> -                                       &record->type, 0);
> +                                       &cxt->ftrace_read_cnt, record, 0);
>                 } else {
>                         /*
>                          * Build a new dummy record which combines all the
> @@ -298,8 +297,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>                         while (cxt->ftrace_read_cnt < cxt->max_ftrace_cnt) {
>                                 prz_next = ramoops_get_next_prz(cxt->fprzs,
>                                                 &cxt->ftrace_read_cnt,
> -                                               &record->id,
> -                                               &record->type, 0);
> +                                               record, 0);
>
>                                 if (!prz_ok(prz_next))
>                                         continue;
> --
> 2.19.1.568.g152ad8e336-goog
>



-- 
Kees Cook
