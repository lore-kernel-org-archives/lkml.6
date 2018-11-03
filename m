Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DFC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38B92082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pvv3YCvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38B92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeKDAvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 20:51:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33896 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 20:51:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so4124482eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0hqAQLOqFQVsczGvcMDnxjl7eGvdeo9LIpKwvDyrZxc=;
        b=Pvv3YCvYeUO7ynri4chCxtnjikLL1Xk7pFZqKUeduvCBYbgyM4QC79LK9O2FWEhSC6
         dQz6O7tfy1dIc8+N4hQuAcEfc8whiBCQH5L4vHSQk0Ac05NyO2KSFjy4GULr+llqJGUo
         FZZO7LL+SnJ6n4ajbsPlIm8qLjFldwbxy+7Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0hqAQLOqFQVsczGvcMDnxjl7eGvdeo9LIpKwvDyrZxc=;
        b=G3RjbkUiyCeFrvQ+AKISDCc/XraF2NszBYbOtsIAGP4cJx1ZHoHIoKK1qYChdgtkNH
         1wBDmprGOHozRGRUG0RUrEaHkcww9KsY75LYZyyIENMtJ48f0vgaJhAhYElL9RR1wPFc
         2QfjwS1MK8ApzfV/hUNxNI19ku/yVM3fdapl0SdxW1z9LX+AAg/fq20oo1LfcuYgVkZB
         Xg7yJ3Lr7rTIAw7gnUPOyxAzMfOVpGkZQeQ4TuePOnxe+9ViFCAcha7RHWj0czex6zKm
         DZJ2oIhYds4IISzboxpwbvqY6Xy6UGqzq1eZJB+ABZKn3JEj8lI0HDSHmthGiOxG+hpf
         iy6Q==
X-Gm-Message-State: AGRZ1gI4Hrf663/hooZCAOE7VxLGaZqLKH38x8m6Z9PCOGhYV74FQ1kO
        7GnqSq/mggHuuCwkO+bk7dW6bw==
X-Google-Smtp-Source: AJdET5dDCxn6ajvqWQ7AqFINk0L1UDlBuM+PoLr3er5ZDLiVfXYo21DN5kv9EMjH8cWB3ZcsYci6kA==
X-Received: by 2002:a50:a938:: with SMTP id l53-v6mr12542299edc.30.1541259570399;
        Sat, 03 Nov 2018 08:39:30 -0700 (PDT)
Received: from holly.lan ([185.80.85.115])
        by smtp.gmail.com with ESMTPSA id o8-v6sm1439143edr.68.2018.11.03.08.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 08:39:29 -0700 (PDT)
Date:   Sat, 3 Nov 2018 15:39:25 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        prarit@redhat.com
Subject: Re: [PATCH] kdb: fix strncpy warning
Message-ID: <20181103153925.ozyb4pqnixu6hw4z@holly.lan>
References: <20181102212405.5911-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102212405.5911-1-olof@lixom.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:24:05PM -0700, Olof Johansson wrote:
> kdb does a strncpy(a, b, strlen(b)+1), which makes no sense. Might as
> well do a strcpy at this point.
> 
> Fixes this warning:
> 
> In function 'strncpy', inlined from 'kallsyms_symbol_next' at kernel/debug/kdb/kdb_support.c:239:4:
> ./include/linux/string.h:253:9: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-overflow=]

I think we already have a pending patch for this:
https://lore.kernel.org/patchwork/patch/989013/

When we looked into this there actually is an unchecked overflow here so
Prarit's fix adds infrastructure to keep track of the remaining length.


Daniel.


> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  kernel/debug/kdb/kdb_support.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index 990b3cc526c8..d5af8b38b84d 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -236,7 +236,7 @@ int kallsyms_symbol_next(char *prefix_name, int flag)
>  
>  	while ((name = kdb_walk_kallsyms(&pos))) {
>  		if (strncmp(name, prefix_name, prefix_len) == 0) {
> -			strncpy(prefix_name, name, strlen(name)+1);
> +			strcpy(prefix_name, name);
>  			return 1;
>  		}
>  	}
> -- 
> 2.11.0
> 
