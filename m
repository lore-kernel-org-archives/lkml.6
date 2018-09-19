Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341C7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5A8214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5A8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeISOOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:14:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37205 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeISOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:14:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id o13-v6so4935250otl.4;
        Wed, 19 Sep 2018 01:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ut1Sg8OlXKA7dKdCvFO/7KFBC7eHFfj3TfBx7eeS5Iw=;
        b=WV8QFuKhehDPecXVxB9ae6wdfuM8ARGKcEsom2UjLOH//r6iVkGRCmL/TdAHLby+Zf
         rPIPQHXnC6HEOu9wLjKcTBdh2hkUbm4M8I0zGTovnOYOiubfTb2EbhrodxFPnwsRujaB
         NGi+4r/RxfI+97NO9wM4tDoX+XiuXI/nN32YU6S6Lp4fYzYFI9zJ3E6K8ukbDbowX3Oj
         aJXl4W5PtOkeuaJPSPYoJLkJKQH/emfmHL58RtFfqCvbm2kXpcG3Y9O0OiKeHUspJQB2
         lV2zzWfYZ7tmnyOzCsZ4zQFnuXedFbEB86C1/O1WcJ8owQGqZKRolzjsJOqg6F/1whlQ
         2LYA==
X-Gm-Message-State: APzg51AhVfbp5RfwiFapLWrECtBDGy1piLJniKbf/tC9q8FK8rbyAfmq
        PXBWnI9Nr5DY0o1KWOgYvP6WQN8s47rvqo8RgPw=
X-Google-Smtp-Source: ANB0VdZuiCeq68Y0LCfU4Gr0jBfjMTBMPzrvJ+omvzsRaMzahYjNkMlkac9a/BPa+uz3rLb3SkdoS2pMoepYE/JM1yM=
X-Received: by 2002:a9d:19e8:: with SMTP id k95-v6mr19163979otk.248.1537346230459;
 Wed, 19 Sep 2018 01:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537275915.git.yu.c.chen@intel.com> <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
In-Reply-To: <f50baa939e550d4c6e09fd15ed2c0ddb0b23b023.1537275915.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 10:36:59 +0200
Message-ID: <CAJZ5v0hLmvrUqcCD1xcx3eMOFvCQHs_JiqNA5Eu_vJAgy5WyTQ@mail.gmail.com>
Subject: Re: [PATCH 02/12][RFC v3] PM / hibernate: Check the success of
 generating md5 digest before hibernation
To:     "Chen, Yu C" <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kookoo.gu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 9:31 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Currently if get_e820_md5() fails, then it will hibernate nevertheless.
> Actually the error code should be propagated to upper caller so that
> the hibernation could be aware of the result and terminates the process
> if md5 digest fails.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/power/hibernate_64.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index f8e3b668d20b..e0de959ad02d 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -265,9 +265,9 @@ static int get_e820_md5(struct e820_table *table, void *buf)
>         return ret;
>  }
>
> -static void hibernation_e820_save(void *buf)
> +static int hibernation_e820_save(void *buf)
>  {
> -       get_e820_md5(e820_table_firmware, buf);
> +       return get_e820_md5(e820_table_firmware, buf);
>  }
>
>  static bool hibernation_e820_mismatch(void *buf)
> @@ -287,8 +287,9 @@ static bool hibernation_e820_mismatch(void *buf)
>         return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
>  }
>  #else
> -static void hibernation_e820_save(void *buf)
> +static int hibernation_e820_save(void *buf)
>  {
> +       return 0;
>  }
>
>  static bool hibernation_e820_mismatch(void *buf)
> @@ -333,9 +334,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>
>         rdr->magic = RESTORE_MAGIC;
>
> -       hibernation_e820_save(rdr->e820_digest);
> -
> -       return 0;
> +       return hibernation_e820_save(rdr->e820_digest);
>  }
>
>  /**
> --

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
