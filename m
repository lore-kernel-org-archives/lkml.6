Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67234C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225BF218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3CUYELD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbeLUHWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:22:38 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:50965 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeLUHWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:22:37 -0500
Received: by mail-wm1-f44.google.com with SMTP id n190so4324199wmd.0;
        Thu, 20 Dec 2018 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GzeltqxFAQnpEcrb2NhLMA4iyajjz5DNGaJuU+o+NGI=;
        b=J3CUYELD/CxW9UjCVz9CBiI7cvtXttH08Lt4c0bU8/HVzIg46zT8FCrUqNdCoXQ/P+
         z5lEeiVHjr6uOh5JHXSVtFN6FWqpwjqc+idndz4eyVH/tOQiwCtDzOajNCti016U9RmN
         9X65rmQkAf01i1OlBSHW07/KcCEWcV+1BmUT61JLHOCRjHUTLCr6ZZoAGJGC1RkL7JaH
         SHDaVURgS9xj+CRDs8Bqmzw0K3tle1EQqh4pzAamrWgGaRJ5HUu8z05RGrA0Mk5j83FC
         e9sPNnfkrE9y1Jz0oubsesweL0ISxP6WQwew18pIQ06E0UmQfQNxu1tYGZsQnyS5WwD3
         bGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GzeltqxFAQnpEcrb2NhLMA4iyajjz5DNGaJuU+o+NGI=;
        b=DVeUFejrL1YVCdN3KswrtZn2EH8Ft8eKiev4bO/GNLjm5BvGu82vAqWCIA/eOMwISY
         9JjD55zVQIa/l6YWboKgYRDRc9FolDUAWztinu3mohD/49y49axCC04r3MCGkUZV2QE5
         YIKzHga9G29InGXH6npcP7x2oYZPpt+rpbIfWVWxjyLP+qBp9ftno6PLj01++abovRwv
         UnEWmIHmtWmtE9bj4UnfFJGN5XKWnOB/FQo91TQxT3Ur57oEiYQtGi8pzxChE6/lY6ai
         oHvuYZiQfdny4uuXb4uaVH72R6uoqnmd4pcgdNCovO68V3rRsU6Kg0TcFygDOi603fo6
         JP7A==
X-Gm-Message-State: AJcUukcZ2npNZxTTvt4arNGHm8o0aL//InwntoFQJR8ngiRLXrkYBk+9
        il4kuqjsJg1zmyzC85to3qs=
X-Google-Smtp-Source: AFSGD/UYRS5OvatX7abJb4mXlfhQAs+9DCR4t89H9o59ume/CrRz5uT/owC+QUQZpFjdfxu/Z9Oxgw==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr1604884wmb.125.1545376954767;
        Thu, 20 Dec 2018 23:22:34 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t199sm9305822wmt.1.2018.12.20.23.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:22:34 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:22:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang build error in drivers/scsi/smartpqi/smartpqi_init.c
Message-ID: <20181221072232.GA32524@flashbox>
References: <20181221071100.GA20515@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221071100.GA20515@flashbox>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:11:00AM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> After commit 4fd22c13ad44 ("scsi: smartpqi: add ofa support"), an arm
> allyesconfig build with Clang fails with the following warning/error:
> 
> drivers/scsi/smartpqi/smartpqi_init.c:7473:2: warning: comparison of distinct pointer types ('typeof ((sg_count)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
>         do_div(sg_count, chunk_size);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
>         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
> drivers/scsi/smartpqi/smartpqi_init.c:7473:2: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
>         do_div(sg_count, chunk_size);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/div64.h:239:22: note: expanded from macro 'do_div'
>                 __rem = __div64_32(&(n), __base);       \
>                                    ^~~~
> ./arch/arm/include/asm/div64.h:33:45: note: passing argument to parameter 'n' here
> static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>                                             ^
> drivers/scsi/smartpqi/smartpqi_init.c:7473:2: warning: shift count >= width of type [-Wshift-count-overflow]
>         do_div(sg_count, chunk_size);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/div64.h:235:25: note: expanded from macro 'do_div'
>         } else if (likely(((n) >> 32) == 0)) {          \
>                                ^  ~~
> ./include/linux/compiler.h:76:40: note: expanded from macro 'likely'
> # define likely(x)      __builtin_expect(!!(x), 1)
>                                             ^
> 
> According to include/asm-generic/div64.h, the first parameter of do_div
> must be a 64-bit number, meaning the below diff would properly fix it.
> 
> However, I am not sure if there are any unintended consequences of this
> change, hence reaching out before sending it in. If you have a more
> preferred way of fixing it, please do so.
> 
> Thank you,
> Nathan
> 
> ==========================================================================================
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index e57fbff08f03..6a185a6172c4 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -7460,7 +7460,7 @@ static void pqi_ofa_ctrl_unquiesce(struct pqi_ctrl_info *ctrl_info)
>  static int pqi_ofa_alloc_mem(struct pqi_ctrl_info *ctrl_info,
>         u32 total_size, u32 chunk_size)
>  {
> -       u32 sg_count;
> +       u64 sg_count;
>         u32 size;
>         int i;
>         struct pqi_sg_descriptor *mem_descriptor = NULL;

Ugh disregard, I just looked at the SCSI tree and saw this was fixed
already:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=e52c9e0710d2f5d54a521d620a230ac2ae646dc7

Should have looked at it before sending, sorry for the noise!
Nathan
