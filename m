Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03512081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DA7ABQvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03512081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeK1VIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:08:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42734 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeK1VIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:08:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so9273024pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Uf5ON4PQUeHa7J1HpS84L1IRMGfJxHcJSrQS8VJU/Q=;
        b=DA7ABQvIm7ouybHvWSJMPrDHDiU/nvYBKZVTn9EXZ6Ajap7MD8tEY7y6l0cZeDgJwR
         U1R1nHxRia3t7oLHT2hVnEAE1gCt8eH9Oegz6jzMXkjCU7bzahiq4DpZ1h7PzSfHO94C
         kQiP9V1EMR9QbS6ROiHcCUfYD3I89TZsqngMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Uf5ON4PQUeHa7J1HpS84L1IRMGfJxHcJSrQS8VJU/Q=;
        b=R8XNezwqzspkalmitfIaVan2AqjbzHTDbLDdGKA9IFtBv7cngogRK8ZRAfU81yVtlk
         N4Nrx53qvoXXk3Z4AgE71AUn0LqQNMtgfdxDV/05GKGs+20ifEEUzLjOx51DjGY+CJaE
         8mr1xlWiZfNL0yPtkBETsRxJejfja5st9dGjogVVgGlMuceecXXJ0vaCLimQaOA4dIz8
         K3qUnnQtAk6sb8lZBz5BYa2FWdl4aTQzTj7DzG9Hb5HBiLh6/9Q5ZYD3E6HqbLZoYIws
         BccMja8l1etcapLnPkbGWuvCXjD2bdUklX9X5jJDUJJUqDnFloqtloZm9zyUCRp27ZR8
         a9Vg==
X-Gm-Message-State: AGRZ1gJKA6FNLzSN+AyVcKTT7pujXzjfYjuIJZ7n01rxFY3VtHTgF5aG
        0cbVt6LIta0yIV5ZoSSV8Qbdmw==
X-Google-Smtp-Source: AJdET5c+DLNXr991fRabrDMN97goeWjeSavAGvx/KkGFDwgkm87YAlTMDsKQWcHxyi5iAoq3zMHR4w==
X-Received: by 2002:a62:1a44:: with SMTP id a65mr37548187pfa.30.1543399659815;
        Wed, 28 Nov 2018 02:07:39 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id v5sm11795864pgn.5.2018.11.28.02.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 02:07:39 -0800 (PST)
Date:   Wed, 28 Nov 2018 15:37:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add cpuidle document
Message-ID: <20181128100736.m2cbaqijmyxmtldp@vireshk-i7>
References: <4064391.AYvOMBeiDo@aspire.rjw.lan>
 <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
 <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
 <20181128093137.a5d4kwgfdthlsolw@vireshk-i7>
 <CAJZ5v0j4B6ODKzJ+XWvMS_dc6BpQcYkK6=L-zg8wcWXQxMcFhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j4B6ODKzJ+XWvMS_dc6BpQcYkK6=L-zg8wcWXQxMcFhQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-18, 11:01, Rafael J. Wysocki wrote:
> BTW, I didn't respond to the remark about the ladder governor.  I have
> no plans to describe it at this time and that can be done at any time
> later easily enough if anyone wants to do it.

That would have made this doc complete somewhat. But anyway, that's fine with
me.

-- 
viresh
