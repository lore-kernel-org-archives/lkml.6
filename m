Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E14206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3KjGQRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E14206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeJBWhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:37:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJBWhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:37:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so2815658wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkBrxHh+dQETCSWOYREyl9ZaCa2nOFIlFDPzVtD0lFw=;
        b=W3KjGQRNW5XdieM3wmkmtoG86n1YA6Wnt0XpqzTipISw502dcmcZZC+FoBaYmb0Dlg
         qMJULchDD+5L3y3b/L6fG21/mq6FdQplBhwNq9VUGHZipqe51BeDks1lga95TCnm9gyw
         C12SQ4bD5+RDqvGdrR4+Dx42unG8UFBjP+Izc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkBrxHh+dQETCSWOYREyl9ZaCa2nOFIlFDPzVtD0lFw=;
        b=EiWAIh20b2JaWM9XtA2MiVjOhpr3li8xi/Sylzx9X22VfgSQu7uzgQzgcunwYsa1tE
         ZC5sDP/SngopU6hVTCKQBd1Q8T0vXoG4yJ1G3NCVuxl8zAkFpmk1qrI/KNBVskyV2g/l
         5cE4mYbm+7k1ULXHDwpFqmdIl/Rizl57+nx2EYQZZoA563yWJhTtIhxKF17lkot3oQ5H
         cVqt7naZ1M/VsiTpILdqIT3wKLl0KTEKkOkSL1TzlQ3XUAkkxraKr9KKZliat/ZIJINv
         81JGtMtQbvsni8iOhQyK8YXvo5/Ocp1wVYEvIFsTL9lRwU9Cgs+1zzCZawNUaLtT99Pg
         Cqdg==
X-Gm-Message-State: ABuFfojbx2qav7V77szYByNTNLn9KeWf2wusvVP1pdexSaBgDuOUansc
        PAMEFPHBotHIa2ZSgJJR4UFCpQ==
X-Google-Smtp-Source: ACcGV61dhgPbSm+q9/2TRk8rfZ/BwSQ5ORTV+uqPo4EbEihWKizBPviFo2xxE9QWjI7aPqcNikiNDg==
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr5899756wrc.102.1538495598484;
        Tue, 02 Oct 2018 08:53:18 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id s10-v6sm18011715wmd.22.2018.10.02.08.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:53:17 -0700 (PDT)
Subject: Re: [PATCH v2] kdb: Use strscpy with destination buffer size
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Toppins <jtoppins@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
References: <20180920125914.17920-1-prarit@redhat.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <9192af58-7966-c023-8b19-5b291839a228@linaro.org>
Date:   Tue, 2 Oct 2018 16:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180920125914.17920-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 13:59, Prarit Bhargava wrote:
> gcc 8.1.0 warns with:
> 
> kernel/debug/kdb/kdb_support.c: In function ‘kallsyms_symbol_next’:
> kernel/debug/kdb/kdb_support.c:239:4: warning: ‘strncpy’ specified bound depends on the length of the source argument [-Wstringop-overflow=]
>       strncpy(prefix_name, name, strlen(name)+1);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/debug/kdb/kdb_support.c:239:31: note: length computed here
> 
> Use strscpy() with the destination buffer size, and use ellipses when
> displaying truncated symbols.
> 
> v2: Use strscpy()
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Jonathan Toppins <jtoppins@redhat.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> ---
>   kernel/debug/kdb/kdb_io.c      | 15 +++++++++------
>   kernel/debug/kdb/kdb_private.h |  2 +-
>   kernel/debug/kdb/kdb_support.c | 10 +++++-----
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index ed5d34925ad0..6a4b41484afe 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -216,7 +216,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>   	int count;
>   	int i;
>   	int diag, dtab_count;
> -	int key;
> +	int key, buf_size, ret;
>   
>   
>   	diag = kdbgetintenv("DTABCOUNT", &dtab_count);
> @@ -336,9 +336,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
>   		else
>   			p_tmp = tmpbuffer;
>   		len = strlen(p_tmp);
> -		count = kallsyms_symbol_complete(p_tmp,
> -						 sizeof(tmpbuffer) -
> -						 (p_tmp - tmpbuffer));
> +		buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
> +		count = kallsyms_symbol_complete(p_tmp, buf_size);
>   		if (tab == 2 && count > 0) {
>   			kdb_printf("\n%d symbols are found.", count);
>   			if (count > dtab_count) {
> @@ -350,9 +349,13 @@ static char *kdb_read(char *buffer, size_t bufsize)
>   			}
>   			kdb_printf("\n");
>   			for (i = 0; i < count; i++) {
> -				if (WARN_ON(!kallsyms_symbol_next(p_tmp, i)))
> +				ret = kallsyms_symbol_next(p_tmp, i, buf_size);
> +				if (WARN_ON(!ret))
>   					break;
I'm getting confused by having two different branches on ret.

Don't get a WARN_ON() when ret == -E2BIG?


Daniel.


> -				kdb_printf("%s ", p_tmp);
> +				if (ret != -E2BIG)
> +					kdb_printf("%s ", p_tmp);
> +				else
> +					kdb_printf("%s... ", p_tmp);
>   				*(p_tmp + len) = '\0';
>   			}
>   			if (i >= dtab_count)
