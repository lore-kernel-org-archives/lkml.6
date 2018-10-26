Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC289ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46720868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAFEHw/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E46720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJ0EGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:06:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42856 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeJ0EGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id a128-v6so900853ywg.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+pwJzQoSPTNFFNkprvbzhir68fTkUN7OTk9sdznHjaU=;
        b=kAFEHw/PGcwqLqibLuSBBHsviy38nQK7DuZp8cgCV79W96l4xG4uT/PXtkkG5fpR4M
         HVBSjHzT4Vf7+EOwV7FSrITTuRlAKUFvI248TLbzEO2u1Qv4j4UYk6+fE3hmvT3mVXpG
         sQUx2b/ZQPGpZgjdz+qDxuC17PvMhP41yVO8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+pwJzQoSPTNFFNkprvbzhir68fTkUN7OTk9sdznHjaU=;
        b=r3Bkr72qJYH0HdgDS1daISc6XS5Yp502RdTHDnr3NZFqC+X4UypNJ3k0dwtpETMEZq
         CTLsBtWC5T7ACR8iR1XnKWShFomitUjxbHImHs96AhloJFAfmPcuaTFKdpxGaHj7fcG8
         QtMjmkt2vMk8wy2i3F4TsOt9V1Y2ooKN6LDBz5fml7IUs0NEIqbdOzpiNEaPOBlALZgl
         6apBY7TlpSXIBLd9rCIYx9z+RR87pvVf1cRzywmMYAGxuv2ynfgcoirbZq04mqJo+iUa
         12zIE+Euj3Azz2fs0/l/2JYae5RB3HpnY/gjhMp04ReCi4O1G8fmZWA8oLtp7QKwYyTW
         5pXQ==
X-Gm-Message-State: AGRZ1gItHt1rLIsS8Vx2a4FczvlmCrH9aJ5R0uLxJavHRQSQ/HcW72I+
        yWfOXhygBjMEpeiGbi9/njNhVT7BoOQOHQ==
X-Google-Smtp-Source: AJdET5flHhReHL24fHLHCC2lqIDoNg9FOUX0a+T3zJb68WbX0naAEFN7f4RL/H+CtXHkZfZt7ce0tQ==
X-Received: by 2002:a0d:f942:: with SMTP id j63-v6mr4903646ywf.7.1540582071706;
        Fri, 26 Oct 2018 12:27:51 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g5-v6sm786964ywa.39.2018.10.26.12.27.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:50 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j9-v6so933735ybj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:27:50 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr4953800yba.410.1540582070024;
 Fri, 26 Oct 2018 12:27:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:27:49
 -0700 (PDT)
In-Reply-To: <20181026192206.GC187415@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-3-joel@joelfernandes.org> <20181026192206.GC187415@joelaf.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:27:49 +0100
X-Gmail-Original-Message-ID: <CAGXu5jL38TrNzTefG=0qD25oue3xh_LR-Ky0xaejFa0HJt24dw@mail.gmail.com>
Message-ID: <CAGXu5jL38TrNzTefG=0qD25oue3xh_LR-Ky0xaejFa0HJt24dw@mail.gmail.com>
Subject: Re: [RFC 3/6] pstore: remove max argument from ramoops_get_next_prz
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:22 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 26, 2018 at 11:00:39AM -0700, Joel Fernandes (Google) wrote:
>> From the code flow, the 'max' checks are already being done on the prz
>> passed to ramoops_get_next_prz. Lets remove it to simplify this function
>> and reduce its arguments.
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  fs/pstore/ram.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index cbfdf4b8e89d..3055e05acab1 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -124,14 +124,14 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>>  }
>>
>>  static struct persistent_ram_zone *
>> -ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
>> +ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
>>                    u64 *id, enum pstore_type_id *typep, bool update)
>>  {
>>       struct persistent_ram_zone *prz;
>>       int i = (*c)++;
>>
>>       /* Give up if we never existed or have hit the end. */
>> -     if (!przs || i >= max)
>> +     if (!przs)
>>               return NULL;
>>
>>       prz = przs[i];
>
> Ah, looks like I may have introduced an issue here since 'i' isn't checked by
> the caller for the single prz case, its only checked for the multiple prz
> cases, so something like below could be folded in. I still feel its better
> than passing the max argument.
>
> Another thought is, even better we could have a different function when
> there's only one prz and not have to pass an array, just pass the first
> element? Something like...
>
> ramoops_get_next_prz_single(struct persistent_ram_zone *prz, uint *c,
>                             enum pstore_type_id *typep, bool update)
> And for the _single  case, we also wouldn't need to pass id so that's another
> argument less.
>
> Let me know what you think, otherwise something like the below will need to
> be folded in to fix this patch... thanks.
>
> ----8<---
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 5702b692bdb9..061d2af2485b 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -268,17 +268,19 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>                 }
>         }
>
> -       if (!prz_ok(prz))
> +       if (!prz_ok(prz) && !cxt->console_read_cnt) {
>                 prz = ramoops_get_next_prz(&cxt->cprz, &cxt->console_read_cnt,
>                                            record, 0);
> +       }
>
> -       if (!prz_ok(prz))
> +       if (!prz_ok(prz) && !cxt->pmsg_read_cnt)
>                 prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
>                                            record, 0);
>
>         /* ftrace is last since it may want to dynamically allocate memory. */
>         if (!prz_ok(prz)) {
> -               if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)) {
> +               if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
> +                   !cxt->ftrace_read_cnt) {
>                         prz = ramoops_get_next_prz(cxt->fprzs,
>                                         &cxt->ftrace_read_cnt, record, 0);
>                 } else {

Ah yeah, good catch! I think your added fix is right. I was pondering
asking you to remove the & on the *_read_cnt and having the caller do
the increment:

        while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
                prz = ramoops_get_next_prz(cxt->dprzs, cxt->dump_read_cnt++,
                                           &record->id,
                                           &record->type,
                                           PSTORE_TYPE_DMESG, 1);

-Kees

-- 
Kees Cook
