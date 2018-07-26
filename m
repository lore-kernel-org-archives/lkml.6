Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D06C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE45D20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE45D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeGZU0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:26:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32852 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbeGZU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:26:43 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so2690617qtp.0;
        Thu, 26 Jul 2018 12:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAA1UVt5MmrgMwmr02et0iJgT0r6sJhmsmYeo94XRR4=;
        b=qm4zC1rPrSrokmUWJeeMguIQsAyRVklaMxzHmpc3olyjlHGJp/UgVLsdBrHu/21+LE
         5i62MUSpPoX4fUaqhymS4D+JXgfnPjZvQDV3sUZ8xOmBmYazLUASSMxW0fmEOaYFF11A
         rGhGcUhUk36dNY9Q0qY7Xae9wAcBWcEUbk7r+GnkEv+wo0pkK9RNpokKKNZEDhp/LX5Y
         hCc/3OlXypspbyaqeEyTmsSl6qYXE0bYr5dKo1zhFDtnRpPpQZfDjMB+eEuvQNMU1YVJ
         /g+CpWr6+UT0oUnvVvpETsz6GOqZQLoqi9gVq5fZfB1s6XIiw7JF6AqJ9s+2EPaRT23c
         ATjw==
X-Gm-Message-State: AOUpUlEBgpaGIyDDqhvbV9CObIxTQicSBI50slKnPzTkl2LJNYGWZo1n
        a59hrYpHN6xYBoQxxFsk3ivlc+L4umlBgTDHrWGreamL
X-Google-Smtp-Source: AAOMgpf9h0/SB+FMD/jd7KbwMRZf4jOjDObrKs0pQKPH+1+sLZB9+Q0/lsEiPKgBLsfBj110KTZXjvx82dcdOYcheGQ=
X-Received: by 2002:ac8:196c:: with SMTP id g41-v6mr3260169qtk.277.1532632112831;
 Thu, 26 Jul 2018 12:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180718222656.11795-1-calvin.walton@kepstin.ca> <20180718222656.11795-2-calvin.walton@kepstin.ca>
In-Reply-To: <20180718222656.11795-2-calvin.walton@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 26 Jul 2018 15:08:22 -0400
Message-ID: <CAJvTdKmA=18nqHh0QFMb+P=41YfQA1Jc3EC8_qWfjOGfjSNP6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] turbostat: Read extended processor family from CPUID
To:     calvin.walton@kepstin.ca
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calvin,

Your patch looks correct on both AMD and Intel.
Thanks for noticing this, and taking the extra step to fix it!

Please re-send your patch with a Signed-off-by: line, so that I can apply it.

Note that first running checkpatch.pl on patches before submitting
will point out such issues, so they are easily avoided.

thanks,
-Len
On Wed, Jul 18, 2018 at 6:27 PM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> This fixes the reported family on modern AMD processors (e.g. Ryzen,
> which is family 0x17). Previously these processors all showed up as
> family 0xf.
>
> See the document
> https://support.amd.com/TechDocs/56255_OSRR.pdf
> section CPUID_Fn00000001_EAX for how to calculate the family
> from the BaseFamily and ExtFamily values.
> ---
>  tools/power/x86/turbostat/turbostat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..f404d67fda92 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4031,7 +4031,9 @@ void process_cpuid()
>         family = (fms >> 8) & 0xf;
>         model = (fms >> 4) & 0xf;
>         stepping = fms & 0xf;
> -       if (family == 6 || family == 0xf)
> +       if (family == 0xf)
> +               family += ((fms >> 20) & 0xff);
> +       if (family == 6 || family >= 0xf)
>                 model += ((fms >> 16) & 0xf) << 4;
>
>         if (!quiet) {
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
