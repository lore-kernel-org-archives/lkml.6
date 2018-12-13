Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF80C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7300A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKBnNbYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300A20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeLMKgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:36:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeLMKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:36:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so866706pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SwYvU/M3hbmvCYJA7zah6T5lSDc6wB4N5mxGaysrMPA=;
        b=KKBnNbYQOIMumoYSQddbIKqiYu5Z8n0x+2B0A0g1Epb185/wMN02QATmla9cp6TFyj
         vqSrrqculzjLFsw30ApRUt431HL1dRgNl6zoyNHEYMSh3TjaKPR2Z0DRXr2aafzIVfjY
         0HMtkNjG0uDtHwrURsTp9nE+0D9+2sXL1YopQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SwYvU/M3hbmvCYJA7zah6T5lSDc6wB4N5mxGaysrMPA=;
        b=tWXIN8sYnejyDO36iuYvpXuBpCI4Ig9NB5Keb3JOzhEQsxrkqjwp2kvD3rZfm9/fhm
         y6MJLUGXmfoSPwwUjRxk3mxMdcEj7rHrVNeGQ9oms075WxWJYYSqmInvL300y3flwpez
         QR823G1GbjfA8tHg4A2Z9cUjWnLlEgoAjBNeV846HVPuQ/Q1fMgeLKWlLizDETiWsMpC
         FLD6TXQhXHklgJA3N7rdPIy1IfAsQADqqG2cPEjqQHQBqwDyosq9EeDVLrc7A/eNaNhd
         Vd/uGHZuElAzwoGD4DO4U2lUTdiyxF3EZlFMXH4+ocp2mGekUWfRRa0N7NhRMaH8JTVR
         3ntQ==
X-Gm-Message-State: AA+aEWbcHmeESHRnfyCia9pgDxZEBRxbB7JKvF4QXv5YMTV4LC4I8S/B
        E3Vm3KOJ7FL3CRjPLwjvpQ3MLQ==
X-Google-Smtp-Source: AFSGD/UqWxY/re1IdEnW7NdeEZvizFGcfTzWWHijlW6BgNsF1fMA5nx0P4+Z4Etg7SDV9E1tt6EAZw==
X-Received: by 2002:a63:d904:: with SMTP id r4mr21477267pgg.207.1544697371517;
        Thu, 13 Dec 2018 02:36:11 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id i123sm3116538pfg.164.2018.12.13.02.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:36:10 -0800 (PST)
Date:   Thu, 13 Dec 2018 16:06:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181213103608.vs255cq46fu4w2cc@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
 <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
 <154469713309.19322.12951478077195078609@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154469713309.19322.12951478077195078609@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 02:32, Stephen Boyd wrote:
> I have one policy for four CPUs. So take down all four of those CPUs by
> writing a 0 to the online file for each CPU, and then bring them back
> online. That should make cpufreq_driver->init() be called twice, once
> during boot when the CPUs are bound to the cpufreq devices, and second
> from the sysfs write when the user brings the first CPU in that policy
> online again by writing a 1 to the online file. If that second time it
> fails I suspect we hit the lockdep warning.

Okay, that is a special sequence. I will try to reproduce that
locally. Thanks.

-- 
viresh
