Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B2BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0591B21709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X32hKi3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0591B21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeHNBVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:21:54 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38808 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbeHNBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:21:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id r3-v6so14828439ywc.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XAfGOK4B2MMbWewPI4MQYpStA+Plkj+5dy9ZnWeSt44=;
        b=X32hKi3kCmVGFK50uTpkXksdqEwSiF6VPY2eUgBQGyUxIfwZBKoth8wlZmrIEwp1w1
         k8JstpwqGGbyd5U2eMoSRPSQ/I0Jz9acNNEoY7fkN+DPy82r0wCUHTf1pqutCXTEh2/V
         ZnqJehWnlsXcSukrm7fm9QhT9YFIhOXd18XSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XAfGOK4B2MMbWewPI4MQYpStA+Plkj+5dy9ZnWeSt44=;
        b=NV1EWXJoZy6oRYmh7NggCX49r/EAEM2X4hKHBOmQfx3JvqyHz4k/xt2WBH1yRQ+JfP
         aRxXiQnFUF6di1AzJt+y50ZPGeBhxcYXIKq7qYxaMYvxGoK4e48hVVIcoeYTFzfEGHc/
         q3txcgh1GSMb8BTpVhdY4bHycghgY9Bv3V5+prXmQyZmXeN/U3yFI9Rordg+4gvlRj3K
         CHgAWWh5tgyMwfpTGJrB8dGOnOWGHKCyDpokiGUFGNGSZSqIJpKVcBrREB45Y/wH38mM
         v6AQmhlPrOjaLTccd3pF7/euanyDokTHfINwCBEJwWq2EMbId6fssjDVacdgi88ccMzo
         vvSA==
X-Gm-Message-State: AOUpUlHSI2SHg8x9Wffa1/wnk9MAtgysaXrq/0S8Z/JwWOMJP7SrrZnk
        96c7zlW+dqOD8fPHLBEw0/TLuTRT720=
X-Google-Smtp-Source: AA+uWPw6P48WH5CbVIupeI/21mmfYutbDfcAXoqDMacqPRj1gfFG2heqS8cqQQ1qFflEFvqVeIhJBg==
X-Received: by 2002:a25:103:: with SMTP id 3-v6mr9419407ybb.421.1534199859226;
        Mon, 13 Aug 2018 15:37:39 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id t6-v6sm10596409ywe.81.2018.08.13.15.37.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:37:37 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id l189-v6so14815912ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:37:37 -0700 (PDT)
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr10175698ybi.309.1534199856525;
 Mon, 13 Aug 2018 15:37:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 15:37:35
 -0700 (PDT)
In-Reply-To: <20180810154314.96710-1-zsm@chromium.org>
References: <20180810154314.96710-1-zsm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 15:37:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL-q6dxU6fXs2U9o8LMzmOF9mgT0OTkDiHtKw_wDCM0-A@mail.gmail.com>
Message-ID: <CAGXu5jL-q6dxU6fXs2U9o8LMzmOF9mgT0OTkDiHtKw_wDCM0-A@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Add __ro_after_init annotations
To:     Zubin Mithra <zsm@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 8:43 AM, Zubin Mithra <zsm@chromium.org> wrote:
> x86_pmu_{format,events,attr,caps}_group is written to in
> init_hw_perf_events and not modified after. This makes them suitable
> candidates for annotating as __ro_after_init.
>
> Signed-off-by: Zubin Mithra <zsm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/events/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5f4829f10129..88e5f67f5d4c 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1584,7 +1584,7 @@ static void __init pmu_check_apic(void)
>
>  }
>
> -static struct attribute_group x86_pmu_format_group = {
> +static struct attribute_group x86_pmu_format_group __ro_after_init = {
>         .name = "format",
>         .attrs = NULL,
>  };
> @@ -1715,7 +1715,7 @@ static struct attribute *events_attr[] = {
>         NULL,
>  };
>
> -static struct attribute_group x86_pmu_events_group = {
> +static struct attribute_group x86_pmu_events_group __ro_after_init = {
>         .name = "events",
>         .attrs = events_attr,
>  };
> @@ -2230,7 +2230,7 @@ static struct attribute *x86_pmu_attrs[] = {
>         NULL,
>  };
>
> -static struct attribute_group x86_pmu_attr_group = {
> +static struct attribute_group x86_pmu_attr_group __ro_after_init = {
>         .attrs = x86_pmu_attrs,
>  };
>
> @@ -2248,7 +2248,7 @@ static struct attribute *x86_pmu_caps_attrs[] = {
>         NULL
>  };
>
> -static struct attribute_group x86_pmu_caps_group = {
> +static struct attribute_group x86_pmu_caps_group __ro_after_init = {
>         .name = "caps",
>         .attrs = x86_pmu_caps_attrs,
>  };
> --
> 2.18.0.597.ga71716f1ad-goog
>



-- 
Kees Cook
Pixel Security
