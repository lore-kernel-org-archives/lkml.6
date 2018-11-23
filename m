Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED45205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7E7OHhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED45205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503143AbeKWUsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:48:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41355 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393967AbeKWUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:48:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so10442023plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2y1KVAbWvz/994jcHVJp36lM4Da09nI3Ip6J0nl6deE=;
        b=X7E7OHhAPl/zsXXx3SXDRE2S4pY0V7jmLXTCD+55y5YgkD+6C/OWqKUeBKGivF0oGF
         BpY2/qFeWffx4uX0ORkazSNDROgGdbRRnoBKb4zu12uqA5RA600wNPPp+QPsIu/Z6kYK
         Ac+PaunRKwyTSJuOmJX01rezn/mmIUcL+HJmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2y1KVAbWvz/994jcHVJp36lM4Da09nI3Ip6J0nl6deE=;
        b=efoIMelgOng+Xr5rCom3szQCnl0k/Y0KlAGN/Zg5aPaTr3mXa+QBSN/M6MVWphJzz1
         nJoGlv10v8VjccUkNjoPZrFoyeP5uCSs6DBq6fa/knxxSKSRtdEnPlASpTiLlL93ds4T
         wrQlIU0hnmKwDP/YyV2s2Lf/r5QPcskj6nWgwwb4K2RWa4yprSkiLLYSD2cWVbOEJzoG
         r7xvKiETFoTg3aBbxHs+3wd5M5TDkG1jinDpLI8D5/JMbZ0KhW+CjoU+n3mS3tvQCWSK
         e+dP2qpvghX035lAqi/z3tYo80sdjT8CFzYoOQVWOBpTT/pM3IFuhw1JC7oRDFqlXAzT
         RQHg==
X-Gm-Message-State: AA+aEWbl0Km9a5wZCw1uuCTfAAMBePaxPAwE0uTLuIJ6HgZdEghOZUlx
        xovQJ8vnbGERJG8oiq4BpizXhQ==
X-Google-Smtp-Source: AFSGD/UbLiSDVhXIlWro01ix6bXMTniHbXrnMZFSpLNENT5tzP1ouR7cHIA2rkGLjAaI68QHABRb+Q==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr14323736plb.6.1542967484744;
        Fri, 23 Nov 2018 02:04:44 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id r81-v6sm106873736pfa.110.2018.11.23.02.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 02:04:44 -0800 (PST)
Date:   Fri, 23 Nov 2018 15:34:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181123100441.nlapxupdcqehwj6m@vireshk-i7>
References: <1542890209-3263-1-git-send-email-daniel.lezcano@linaro.org>
 <1542890209-3263-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542890209-3263-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-18, 13:36, Daniel Lezcano wrote:
> In the case of asymmetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity computation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
> 'capacity-dmips-mhz' is defined in the DT.

We aren't doing this anymore. You should rather explain that we just
allocate raw_capacity now and rest is left for
init_cpu_capacity_callback() to fix.

-- 
viresh
