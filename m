Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433E220854
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="chD4O5nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433E220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeGPFfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 01:35:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38810 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeGPFfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 01:35:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so14741731pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F0UnHrDuIsT1+I0lKILxiKGYZdUg0AMu06Dp82pbQEA=;
        b=chD4O5nqdXwLk98APJ/vf5lpxOEW+kCVjgsGkLUxrnB78THoTPV43PPeWATayzibN9
         OI48YkhOR7/+WirFvIi9dIg6KvWwRSfGPHBTgA07dPgw7iicp+4zHkVDbhg/mbygY9Ha
         y55II5ofGgOYI4+UVtrk113N1kOKlod7fo6m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F0UnHrDuIsT1+I0lKILxiKGYZdUg0AMu06Dp82pbQEA=;
        b=QDq4OOnHffKt6F3TR9rBgq7GG+MgHNpnlC62R+6apr0fbX/gq9DVS81SDUplCgBGDN
         aF+NXXebk1WEByr+dbZ32bMVJDoxyUR+5ElY3Q7Rc2OWR6e2bEfUaS1EUNf6m0SWcAtu
         Gu2XYb4TOa9zV262WRu5Iez63NQM9+XfSO/lGz5YiHOKD8K2hnZP9pu7U+mlr06/5kQt
         UUTCzEZvrbxNVWusIRcqI3bU99G0Upraoamdw57TGYpXzM5ekf4sN/yj/7ouxYpsXGUr
         dU1mZa2YLwJmmujBTXwNMKPTw9BRz72JdlPmHR7a/nUZNUA2fkI4Hs+pf3vV41Z+l8PE
         B96A==
X-Gm-Message-State: AOUpUlEhtm3Q0q6in9+a9RY8m1b78xVDTfJ4qbFeLJPNnvQ7PriZaVwm
        QKn72lIFzbQ+fiGHlhmtK7t1GA==
X-Google-Smtp-Source: AAOMgpcRWkJedBQA68nOFNz8hLSouPyLO4Fry3LAXD/Wdbq9GsbUDkCGW5lh2jEyfMpi1zRUcHOIwQ==
X-Received: by 2002:a17:902:22e:: with SMTP id 43-v6mr15607492plc.82.1531717800367;
        Sun, 15 Jul 2018 22:10:00 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id x2-v6sm51990806pgq.33.2018.07.15.22.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 22:09:59 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:39:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20180716050957.bujhcfxrfbnnvn4v@vireshk-i7>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-18, 23:35, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  10 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 344 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

Have you addressed my concerns that I raised for this patch in the
previous version ? You never replied to me as well.

-- 
viresh
