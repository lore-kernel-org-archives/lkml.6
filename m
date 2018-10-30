Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECE22082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CknvO3tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECE22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJ3RZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:25:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42529 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJ3RZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:25:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so5442075pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rB/CFxtipBzQgkj5+sd0Du4yiefTtXPhPzY4IOo1hww=;
        b=CknvO3tRaZ9bZM1JrQM+BKzaS1acJeHKIi5nMGPJvFtcZNhF31FKfV3PBxpA7AIqtQ
         Lolo3Je4sJGgZJFfDrYJ4rvO9iK08734xhTwIYHyrN/fAv1SoxC+cLXtTr0V/wGbDBqz
         ZavExg4Jh/FYVdV/4unFqIbyjDdXNW4pOQWLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rB/CFxtipBzQgkj5+sd0Du4yiefTtXPhPzY4IOo1hww=;
        b=eO1EF1NQQO4b8ZC1i8Bli5wJLpV9Q5/o9Yebs5AoPGTqSa48RrjYn91q4ZBpRcwfir
         8f+1D8g7ByuGj9y5P6dn/vIS01ArNlewUkZDDP0JnEghasgwjKaAk09Ouu7U2fZWY5U2
         v7X3V8FawaASK+m7lahvCZ3QAoc8Ffp0IFAffJL63u06VJfUwmYlbhWrkVlXv9W4wbAI
         QSEeVuRCcIXV5efGEB7NoaQQ+aZr1hOKVtshgqkH8KCbpiFnF3MP94n5fo6uqF3fUSzp
         9GN8TSngKLZsI/vhaI3bG4JdaLAWVp2lWE1hAWNr6a3TXMvgpp5RAYGiDWcg9jGWED/T
         /MGg==
X-Gm-Message-State: AGRZ1gJqXR08W9yg6n2Mrl2BcmPfEL+BaeLiL+iFVvNeZB25PaKxI2SW
        c0aVThIsQQept7f9Hy2S+LvFOA==
X-Google-Smtp-Source: AJdET5cGwExQsTxHYBiOwElbixBDpI+6ahMsc7rqMDBxkiKj2Qji1vCyEs8+97+Wb6WhFfWBdu2Ctw==
X-Received: by 2002:a63:d444:: with SMTP id i4-v6mr16917479pgj.194.1540888391777;
        Tue, 30 Oct 2018 01:33:11 -0700 (PDT)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id g123-v6sm52276313pfc.67.2018.10.30.01.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:33:11 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:03:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] base/drivers/arch_topology: Remove useless check
Message-ID: <20181030083308.5znognajpwjvdxfv@vireshk-i7>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <CAOh2x==y+7jEdC-3xpvhr6j+RTtXRwTnBFC2uRVUmuktbCvsKw@mail.gmail.com>
 <d689e382-e4f2-0b03-03a5-2ff4a6bb88bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d689e382-e4f2-0b03-03a5-2ff4a6bb88bb@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-18, 08:55, Daniel Lezcano wrote:
> The workqueue is called from init_cpu_capacity_callback(). This one is
> called in the notifier callback. IOW the notification callback
> unregisters itself. But if it is not registered, it won't unregister,
> hence it won't call the workqueue and init_cpu_capacity_notifier() is
> not called.

Sorry, couldn't understand most of your reply :)

Though let me try to explain the problem I was trying to show you..

cpufreq-notifier-callback
        -> init_cpu_capacity_callback()
                -> free raw capacity
                -> queue_work() to unregister the notifier
                -> return

        ->init_cpu_capacity_callback() called again before work was processed.
                -> If we don't check raw_capacity, we may end up using
                NULL pointer, as the notifier isn't unregistered yet.

-- 
viresh
