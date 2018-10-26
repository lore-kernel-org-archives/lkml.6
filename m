Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC8AECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47CC20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JE/EvnHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47CC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJ0Dmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:42:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45294 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJ0Dml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:42:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id i185-v6so869936ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ASRa0PLo0MQ8W2WPVtvFTYJmIDsri9QltaJjOZZ6SW0=;
        b=JE/EvnHQHolbSz3/Gooz5PzTN7NeZnEi7cpN0DWM7SvvOkAMxLQvardBMewUSq5Qqh
         iquNeksS1kscq2p3GeuqyNuOaZWfVpTdFcAe/Slnas9p3ehcnSp9/M+6A6EU60qVmkl1
         h6bp1fLvVygy2Np7iFBUys/zEyYqb2q9vZAU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ASRa0PLo0MQ8W2WPVtvFTYJmIDsri9QltaJjOZZ6SW0=;
        b=pA+KrQgMLMkNsP1WAoc6ymMHIDNgn/LoIl/qpFn9MC98vkG4/toEAa1/9XcvGDSYtq
         mu1/pjGZJsgjAl+TVx4b5HB1rTWvZ4gI5ZhFQA0tnrKXr8WK/BjUmjIEo2lXENDPMRiz
         uqoH/pVvt1rkWsILkC4hEhwz1jT8kTcRRKvR8SoVcAyt95fdcDxjvbC3jvvVYVy5uVUs
         vymBbRt4eeyN7w4P/uu/N9+yOaup7tf015SgxuYXwXWC0LFZoLMckGYv9UAx2DF0o9Nh
         /nrR2XAHOIcXt1wCbQ4MScUQ9YP0nDHAzJ8kCTtTQNHSHHdBTsKnFBu21DUgr8Msbk9c
         3sIA==
X-Gm-Message-State: AGRZ1gLMRztpLnDd94l6DqgUa5hhn0T+8aDaAzT1Kjzy/a3A54K2amlR
        kbdce5CbkofNzmaclMZElgM+Pz8iNhikZw==
X-Google-Smtp-Source: AJdET5cWRPnqhiwAbLbfuGbS3ukxiqG5Mg/d3LzRgmw13XRI4D1JK1uwufaB0Z6o53gzGPqvce3NSw==
X-Received: by 2002:a81:1c47:: with SMTP id c68-v6mr4765047ywc.247.1540580667720;
        Fri, 26 Oct 2018 12:04:27 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id w188-v6sm2718797ywf.59.2018.10.26.12.04.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:04:26 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p144-v6so892940yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:04:26 -0700 (PDT)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr5015603ybi.141.1540580665754;
 Fri, 26 Oct 2018 12:04:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 12:04:24
 -0700 (PDT)
In-Reply-To: <20181026180042.52199-1-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 20:04:24 +0100
X-Gmail-Original-Message-ID: <CAGXu5jLKLKDwVgRoMx57Y76V9FVJqQ+EeTHB2CnxAN5CnC2Jmw@mail.gmail.com>
Message-ID: <CAGXu5jLKLKDwVgRoMx57Y76V9FVJqQ+EeTHB2CnxAN5CnC2Jmw@mail.gmail.com>
Subject: Re: [RFC 1/6] pstore: map pstore types to names
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
> In later patches we will need to map types to names, so create a table
> for that which can also be used and reused in different parts of old and
> new code. Also use it to save the type in the PRZ which will be useful
> in later patches.

Yes, I like it. :) Comments below...

>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/pstore/inode.c          | 44 ++++++++++++++++++++------------------
>  fs/pstore/ram.c            |  4 +++-
>  include/linux/pstore.h     | 29 +++++++++++++++++++++++++
>  include/linux/pstore_ram.h |  2 ++
>  4 files changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 5fcb845b9fec..43757049d384 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -304,6 +304,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>         struct dentry           *dentry;
>         struct inode            *inode;
>         int                     rc = 0;
> +       enum pstore_type_id     type;
>         char                    name[PSTORE_NAMELEN];
>         struct pstore_private   *private, *pos;
>         unsigned long           flags;
> @@ -335,43 +336,44 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>                 goto fail_alloc;
>         private->record = record;
>
> -       switch (record->type) {
> +       type = record->type;

Let's rename PSTORE_TYPE_UNKNOWN in the enum to be PSTORE_TYPE_MAX and
!= 255 (just leave it at the end). The value is never exposed to
userspace (nor to backend storage), so we can instead use it as the
bounds-check for doing type -> name mappings. (The one use in erst can
just be renamed.)

Then we can add a function to do the bounds checking and mapping
(instead of using a bare array lookup).

> +       switch (type) {
>         case PSTORE_TYPE_DMESG:
> -               scnprintf(name, sizeof(name), "dmesg-%s-%llu%s",
> -                         record->psi->name, record->id,
> -                         record->compressed ? ".enc.z" : "");
> +               scnprintf(name, sizeof(name), "%s-%s-%llu%s",
> +                        pstore_names[type], record->psi->name, record->id,
> +                        record->compressed ? ".enc.z" : "");
>                 break;
>         case PSTORE_TYPE_CONSOLE:
> -               scnprintf(name, sizeof(name), "console-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_FTRACE:
> -               scnprintf(name, sizeof(name), "ftrace-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_MCE:
> -               scnprintf(name, sizeof(name), "mce-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_PPC_RTAS:
> -               scnprintf(name, sizeof(name), "rtas-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_PPC_OF:
> -               scnprintf(name, sizeof(name), "powerpc-ofw-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_PPC_COMMON:
> -               scnprintf(name, sizeof(name), "powerpc-common-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_PMSG:
> -               scnprintf(name, sizeof(name), "pmsg-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_PPC_OPAL:
> -               scnprintf(name, sizeof(name), "powerpc-opal-%s-%llu",
> -                         record->psi->name, record->id);
> +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> +                         pstore_names[type], record->psi->name, record->id);
>                 break;
>         case PSTORE_TYPE_UNKNOWN:
>                 scnprintf(name, sizeof(name), "unknown-%s-%llu",

All of these, including PSTORE_TYPE_UNKNOWN are now identical (you can
include the .enc.z logic in for all of them. I think the entire switch
can be dropped, yes?

scnprintf(name, sizeof(name), "%s-%s-%llu%s",
               pstore_name(record->type), record->psi->name, record->id,
               record->compressed ? ".enc.z" : "")

> @@ -379,7 +381,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>                 break;
>         default:
>                 scnprintf(name, sizeof(name), "type%d-%s-%llu",
> -                         record->type, record->psi->name, record->id);
> +                         type, record->psi->name, record->id);
>                 break;
>         }
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index f4fd2e72add4..c7cd858adce7 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -604,6 +604,7 @@ static int ramoops_init_przs(const char *name,
>                         goto fail;
>                 }
>                 *paddr += zone_sz;
> +               prz_ar[i]->type = pstore_name_to_type(name);
>         }
>
>         *przs = prz_ar;
> @@ -642,6 +643,7 @@ static int ramoops_init_prz(const char *name,
>         persistent_ram_zap(*prz);
>
>         *paddr += sz;
> +       (*prz)->type = pstore_name_to_type(name);
>
>         return 0;
>  }
> @@ -777,7 +779,7 @@ static int ramoops_probe(struct platform_device *pdev)
>
>         dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
>                         - cxt->pmsg_size;
> -       err = ramoops_init_przs("dump", dev, cxt, &cxt->dprzs, &paddr,
> +       err = ramoops_init_przs("dmesg", dev, cxt, &cxt->dprzs, &paddr,

Yup. That's a funny mismatch. Not exposed to userspace in a released kernel. ;)

>                                 dump_mem_sz, cxt->record_size,
>                                 &cxt->max_dump_cnt, 0, 0);
>         if (err)
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index a15bc4d48752..4a3dbdffd8d3 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -47,6 +47,21 @@ enum pstore_type_id {
>         PSTORE_TYPE_UNKNOWN     = 255
>  };
>
> +/* names should be in the same order as the above table */
> +static char __maybe_unused *pstore_names[] = {

This should be static const char * const pstore_names[], I think?

> +       "dmesg",
> +       "mce",
> +       "console",
> +       "ftrace",
> +       "rtas",
> +       "powerpc-ofw",
> +       "powerpc-common",
> +       "pmsg",
> +       "powerpc-opal",
> +       "event",
> +       "unknown", /* unknown should be the last string */

End this with a NULL for a cheaper compare below.

> +};
> +
>  struct pstore_info;
>  /**
>   * struct pstore_record - details of a pstore record entry
> @@ -274,4 +289,18 @@ pstore_ftrace_write_timestamp(struct pstore_ftrace_record *rec, u64 val)
>  }
>  #endif
>
> +static inline enum pstore_type_id pstore_name_to_type(const char *name)
> +{
> +       char *str;
> +       int i = 0;
> +
> +       for (; strncmp(pstore_names[i], "unknown", 7); i++) {
char **ptr;

for (ptr = pstores_names; *ptr; ptr++) {

> +               str = pstore_names[i];
> +               if (!strncmp(name, str, strlen(str)))

"n" version not needed: the LHS is controlled and we want full matching:

    if (!strcmp(*ptr, name))

> +                       return (enum pstore_type_id)i;

I don't think this cast is needed?

        return (ptr - pstores_names);

> +       }
> +
> +       return PSTORE_TYPE_UNKNOWN;
> +}
> +
>  #endif /*_LINUX_PSTORE_H*/
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index e6d226464838..ee0f493254dd 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -22,6 +22,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/pstore.h>
>  #include <linux/types.h>
>
>  /*
> @@ -47,6 +48,7 @@ struct persistent_ram_zone {
>         size_t size;
>         void *vaddr;
>         struct persistent_ram_buffer *buffer;
> +       enum pstore_type_id type;
>         size_t buffer_size;
>         u32 flags;
>         raw_spinlock_t buffer_lock;
> --
> 2.19.1.568.g152ad8e336-goog
>



-- 
Kees Cook
