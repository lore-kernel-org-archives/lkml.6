Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A5FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54616208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54616208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeG0SMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:12:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43929 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbeG0SMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:12:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id f18-v6so5698368qtp.10;
        Fri, 27 Jul 2018 09:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8J+5ZsTN9DXDzisIsPRc8f+DQhHDMmRkAif6aVmM7A=;
        b=NDRN68IuBYlJaf7AGihukur66YYtCHxhvDNQgN3hU4zxJwHkNC9Iikgu/dQ5GZHqE+
         N5zYu9SCZ/v4zYlLDNhzROTyWj8kKS1b+4vC/EuHbZF6xgQvR6ehYoMIZ9KXSWFP9T/w
         llhgE7PPD5xBz/sA/XIUyGt6D1bwfCUB+eya8YMvMmMSA0mTX7Bior/aplAe7oHQbcib
         3eeZ69euocseqaX+FVyTWNQJChB8HJ1m9Tl2fbKIV6HvQ5u9vXjT1rSqVamC+ojYWpgf
         8Ud5UT4ELv31HyWK1eGXbte85sjRWR0SI0cdH8Bl1FGnhyio2N3AQcHR7ZkLlFARN7Y9
         Y5Ig==
X-Gm-Message-State: AOUpUlGjBI4q6SxK1UM5pYFeWCQSGyv55K3i5dXZ+obk3IvCcLtf40y7
        VpzyheJ84rot4vT6QA21IJQqgjxXxYHsdAGi8UxlJCh4
X-Google-Smtp-Source: AAOMgpdcoL/qi4UCyCWDIx9Eb7q3hGHVNs+Lqit3KZEXEJl/5cGud1K2+kImjL73n6fWbBGuPYNxEeGLr52b9DSaUyQ=
X-Received: by 2002:ac8:3f0a:: with SMTP id c10-v6mr6721381qtk.162.1532710201266;
 Fri, 27 Jul 2018 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180727113809.8427-1-calvin.walton@kepstin.ca> <20180727115053.8965-1-calvin.walton@kepstin.ca>
In-Reply-To: <20180727115053.8965-1-calvin.walton@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 27 Jul 2018 12:49:50 -0400
Message-ID: <CAJvTdK=k=VTprGyejhrWXjhg9Lf=j79Wkve+L96Ex2uM40B5Xw@mail.gmail.com>
Subject: Re: [PATCH v3] turbostat: Read extended processor family from CPUID
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied -- thanks!
On Fri, Jul 27, 2018 at 7:50 AM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> This fixes the reported family on modern AMD processors (e.g. Ryzen,
> which is family 0x17). Previously these processors all showed up as
> family 0xf.
>
> See the document
> https://support.amd.com/TechDocs/56255_OSRR.pdf
> section CPUID_Fn00000001_EAX for how to calculate the family
> from the BaseFamily and ExtFamily values.
>
> This matches the code in arch/x86/lib/cpu.c
>
> Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
> ---
>
> v3: Having just looked at the arch/x86/lib/cpu.c code again, I realized
> that it *didn't* actually match - the kernel code uses family >= 6 for
> applying the extended model number, while I was applying it only to
>  family == 6 or family >= 0xf. Change that to match for consistency.
>
> v2: I'm still working on updating the RAPL patch on top of the changes for
> v4.18, but this CPUID fix doesn't have to wait.
>
>  tools/power/x86/turbostat/turbostat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..ed024deed36f 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4031,7 +4031,9 @@ void process_cpuid()
>         family = (fms >> 8) & 0xf;
>         model = (fms >> 4) & 0xf;
>         stepping = fms & 0xf;
> -       if (family == 6 || family == 0xf)
> +       if (family == 0xf)
> +               family += (fms >> 20) & 0xff;
> +       if (family >= 6)
>                 model += ((fms >> 16) & 0xf) << 4;
>
>         if (!quiet) {
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
