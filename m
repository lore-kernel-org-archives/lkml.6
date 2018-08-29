Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189E32064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="leA9ea0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189E32064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeH2WKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:10:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36025 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2WKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:10:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so2677247pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7woql3FaI3QRpEtCaSFvRq28PNUfUNTSsf/Q6j+fTiU=;
        b=leA9ea0gORbhgWTuDHjb95UiF5d5/za19jEpzIMC4Sgo+S5YAIdYGIe6N2Po4B/2Qk
         DEGiU4Whx1Lg1UEm+oZKmaAkmjfQurQCOYiOjigyyJpaXsWqq9GAySQgCmt34KSG8sps
         nKaXPzaIKoNorKeX7e8JE2M/jPwmdk/jLJd+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7woql3FaI3QRpEtCaSFvRq28PNUfUNTSsf/Q6j+fTiU=;
        b=hevO0ex1n0420KUQFkcP7E1AA+lnighsvGX/d19fGMnWqwVT9jRtr+hh+t/5GgQWwR
         R9c15ppA/AOcXwcoeeEHsPfnW2NJ7QcpsiSdNaCfdz/OGjM9B9xKQUoqkWB94dUcHZPn
         hL8jNdl2E7rs6HU8M6yHR0u/xsmalb0GjWVHuuGGF8FT9zEc7o5YAFbRyZ8SY2DjF38Q
         bpOG6tF5vRmLWFU2/6DBQPZ12OFt/5edC4+/KgIEJI2ek7z5l6C+rqJdlyWflgw4E03S
         yNeJGVl0g3NiR7QA2GCaAN55aoVHfRUUGJhX54Y5jKKOZDrle9iRfJTK+ZwbRzza0kM1
         1dPQ==
X-Gm-Message-State: APzg51DAh/Qo2NwdxvlAbj+kqAylvEndN8hA0UCqorfpGOg/zft1jgcD
        6HAKK4dgcl+gBfDLQ0IMbeCCjg==
X-Google-Smtp-Source: ANB0VdZCwcdZMGIL54gtXwHXfy56YIpPwvREa4SWfbEav47rxCpI8Ckb6ZGVzNHfNg9FuGyLeIqd3Q==
X-Received: by 2002:a65:464b:: with SMTP id k11-v6mr6576509pgr.448.1535566337751;
        Wed, 29 Aug 2018 11:12:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o10-v6sm18383911pfk.76.2018.08.29.11.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 11:12:17 -0700 (PDT)
Date:   Wed, 29 Aug 2018 11:12:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, dianders@chromium.org, edubezval@gmail.com,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
Message-ID: <20180829181216.GD10879@google.com>
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
 <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:39:12AM +0200, Daniel Lezcano wrote:
> On 18/07/2018 09:49, Amit Kucheria wrote:
> > One thermal zone per cpu is defined
> 
> The thermal zones are very close, especially when the CPUs belong to the
> same 'cluster'. Very likely the temperature will propagate from one core
> to another core, so when one core reaches the trip0, there is good
> chance the other cores will be close and cross the trip0 threshold too.
> 
> Having multiple thermal zones, one per CPU, may trigger an interrupts
> storm with the passive polling timer delay.
> 
> Does this board have a cooling device per CPU also ?

The cpufreq driver is still under development:
https://lore.kernel.org/patchwork/patch/966833/ . It currently doesn't
register cooling devices, but since CPUs from a 'cluster' use the same
cpufreq policy I think there will be one cooling device per 'cluster'.
