Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0A020857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GDjitgFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0A020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKHP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:27:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47053 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:27:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so8365281pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 21:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcN9WxpMosPsVV4YhOBM1HipQZY6NZU/heHzRUZE7Hg=;
        b=GDjitgFMVSIKrN5S+jpLx0no035v7UnjBsahpdUZYiKWARpslI7v3yKuzSFWG6NYAC
         2RR56PX5TNUS/fgYD9mbSTeWVMk53XmEjpntVUx6R8v2M7Rt3DhcUfe8tlOgAUPc/Vs2
         O6D9/osPPPJ7g/4+4ufPQEhE/nZUQspLnFQn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcN9WxpMosPsVV4YhOBM1HipQZY6NZU/heHzRUZE7Hg=;
        b=ExLVH2dn6XQd6gDK7D8y+BOhlMnl+/hESna/k7GqE2shimGD4P0gakO2Lx8HwXP505
         H1htZXGDcuwXJ9cPsXETdePx8IF3qJfQWxgIdXSHhM5BEuUNKrgkyaYJRF0r05SJqoY3
         AFZBzQU7SP60oyuDuyP+4JWz28PvX5W4HI6nT52kBu8nBeaL9HfBeI/HnuUcfaq2XTcM
         uiJhDrImFk8IbggkJfAhtI+2uwe2GMF525rEE9jvruAP5QVE3/WNHiI4gVXDnZMkNvQG
         3XIdmx3i/rwLY8ijb25lEfK5IvFT292lLHPftKWTRx5b2qEK0sG1+x5sZ9ecndXLaG/j
         ZROw==
X-Gm-Message-State: AGRZ1gKxFhPCIKMtczy6viD/FUbHjFnZxySz/AqH+hPSC8LqzqrzWh7F
        P7BGzV7poaTBlJJoi6uuxh0lZw==
X-Google-Smtp-Source: AJdET5dp94v6GlIVjTIqmYXv+chCnLneVE1zZPzFHxCZMYx/3IKPEx2KNwC1T5QjNIpHPF9v9WeYlA==
X-Received: by 2002:a63:9501:: with SMTP id p1mr2777889pgd.149.1541656408441;
        Wed, 07 Nov 2018 21:53:28 -0800 (PST)
Received: from localhost ([122.172.167.71])
        by smtp.gmail.com with ESMTPSA id e131-v6sm2622373pfc.122.2018.11.07.21.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 21:53:27 -0800 (PST)
Date:   Thu, 8 Nov 2018 11:23:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     d-gerlach@ti.com, Keerthy <j-keerthy@ti.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        t-kristo@ti.com
Subject: Re: [PATCH 0/2] opp: ti-opp-supply: Fixes
Message-ID: <20181108055324.rlqmerb3imas5yfc@vireshk-i7>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-18, 10:04, Keerthy wrote:
> The series brings in couple of fixes to the ti-opp-supply driver.
> One of them updates u_volt_min dynamically and avoids hang due
> to lesser static u_volt_min and the other fixes the supply in
> _get_optimal_vdd_voltage.
> 
> Keerthy (2):
>   power: opp: ti-opp-supply: Dynamically update u_volt_min
>   power: opp: ti-opp-supply: Correct the supply in
>     _get_optimal_vdd_voltage call

@Dave: I would like to get an Ack from you on these before applying.

-- 
viresh
