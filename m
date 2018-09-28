Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70DBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796A621746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WkxLh0wV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796A621746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeI1NqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:46:08 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:35651 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbeI1NqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:46:08 -0400
Received: by mail-lj1-f181.google.com with SMTP id w4-v6so4871655ljd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hYGS7MoUcyyP/SEY7qmaBHiQFNrVr6erkjcrCSyNN2E=;
        b=WkxLh0wVIsJ3SigX6QtrWQtuPr5kjVuwX07BQuDLD/7YN9XRe7B5bb2ZS6DeLMOZGE
         9ytd9gVJKh28GkvOw48xVKdl/b2n45T0TRI+Zdf+uHk9hP1mCo0EACPgftzvc0q2a0w9
         SSz9WXl1Rsgl7A2gf7GsJFWMLYZMESdVwYC/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYGS7MoUcyyP/SEY7qmaBHiQFNrVr6erkjcrCSyNN2E=;
        b=H6yxxjaHzMaX+OndEsGamG3AU196GwjBWmWkBLP7Iw2dbQ9ZN7hBo3FizCGFrU3HEv
         iI9xPSauUsmyfkcpiYDaffWX7vQEV4d6eWDf0f3ZlSoJnqHFtCwNllOMODCT9mQfxFQa
         1Fk2W0Dl01hwE/5SNOLLqJ/kP8brT+pHijPfzp60vd1BAzdD2LhcJXmR+eMEN7RiilNv
         nQ2O3bqKJtmG7iuyZgQgymSqUs5rYD4cxhPwTZI26GUtMZd/O76l6Mz/rymcOuZdxpRR
         AFrMhYimVdM/EdOmF8pY/mMXLZt7eUVo1mw7NOgzcEeDijJvPiuWc33KtacQLsstFzCT
         eVVA==
X-Gm-Message-State: ABuFfoiNPqUHQm0HyBXWA8EEgiyzpi3sgpBCQzuxxoyWb3mAvEd+D2+m
        n0Q0742h67NJL2NpYHnmGzuZqQ==
X-Google-Smtp-Source: ACcGV62s2Das2Nkxt6u3B2Yn0eUHpr9SqoSqm0sE5eRbeCkcnCJVoEUj7aTMMGFdASeP/kad/0K/7w==
X-Received: by 2002:a2e:4e01:: with SMTP id c1-v6mr3017128ljb.157.1538119423676;
        Fri, 28 Sep 2018 00:23:43 -0700 (PDT)
Received: from [192.168.43.23] (77.241.135.131.mobile.3.dk. [77.241.135.131])
        by smtp.gmail.com with ESMTPSA id t18-v6sm851215lje.95.2018.09.28.00.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:23:42 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] mm: move is_kernel_rodata() to
 asm-generic/sections.h
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20180928071414.30703-1-brgl@bgdev.pl>
 <20180928071414.30703-3-brgl@bgdev.pl>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c7484684-8f92-8e7a-e4fb-015d50180414@rasmusvillemoes.dk>
Date:   Fri, 28 Sep 2018 09:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928071414.30703-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-28 09:14, Bartosz Golaszewski wrote:
> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().

s/devm_kfree_const/devm_kfree/.

Apart from that nit, feel free to add my ack to 1,2,3.

Thanks,
Rasmus
