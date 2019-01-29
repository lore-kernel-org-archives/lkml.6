Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E968C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387322177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gyf6+jVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfA2FVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:21:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2FVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:21:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so9112933pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MocKRkdC18SJkDN5xcTx2h7stLKydkn0qoTXnW+pXpU=;
        b=Gyf6+jVt8wnlYCiKL/ufNlS/0yvf7ogt6FnFW6AIn/c/FudD7ed+huUP/lWl8+MEp3
         +vSmNpDk0TuRw0iyrKJDlwF6tnKKceXFwM3UObuzRk34nwGQtxkhr41h0fm2/BHtOufR
         3scbtuAjV707rSID9xt+1j+Z2MM175WpXeBZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MocKRkdC18SJkDN5xcTx2h7stLKydkn0qoTXnW+pXpU=;
        b=UPnYTFm64IapeLAdamtIEfLhMnre4aXcE8MR5gjBM8tkNvn7XSHmPKFZVbzWvYFDWm
         Mn3FxQ3icm6cNNYDdQiIeXU84EWwUAYtnY0PxAR4ld/BEMVQbzQ2JVTNP/e41RjDHkiN
         FOpQm8nsiqbckZQL16ygkSclaQNuNSgGrDFUhcmebj/BH/ak7u1UZnseZ0qlTTDn/lyN
         pPtZH51xQbY9KKbX4bc/Vq2DK6Eese/d9WR7/LvyTzAzH3pJx9nw6uIb8/ojeRmYk6AI
         UV4/CcsSgbVZwiYl+PhuHwEo805rpzTki7yyWSGSgaH9Xgij9hZgskVkG89Vc3rqIt40
         uEcQ==
X-Gm-Message-State: AJcUukfrlHyUCRIUTwIWeOvYqLWW+iwrzPuLAG4LPfeZ8ICj7EfMvNG1
        hr/3y2xTJGG8SzBtQUre6YWq0g==
X-Google-Smtp-Source: ALg8bN4U8mbu9H0uw2niwNQHldIvToq3nahdrDeilzsmOAKw6XVJWQAqJ7RxW2rV2XHQWZfKZnRuNQ==
X-Received: by 2002:a63:7154:: with SMTP id b20mr22353034pgn.342.1548739307652;
        Mon, 28 Jan 2019 21:21:47 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id c23sm40614694pfi.83.2019.01.28.21.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:21:46 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:51:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Quentin Perret <quentin.perret@arm.com>, rjw@rjwysocki.net,
        sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128193656.GI81583@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> I think this patch will result in error messages at registration on
> platforms that use the cpufreq-dt driver and don't specify
> 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> a problem as long as the cpufreq initialization succeeds regardless,
> it could be seen as a not-so-gentle nudge to add the values.

That wouldn't be acceptable.

-- 
viresh
