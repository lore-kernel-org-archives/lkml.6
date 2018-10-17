Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02603ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87DB2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwJ1Fso2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87DB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQUXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:23:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44850 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:23:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so19639596lfl.11;
        Wed, 17 Oct 2018 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EyldOrl1AnlI7bDeSkD8n3QBfB1hJho+erDX8iZ85/s=;
        b=IwJ1Fso2PgZU6HOwFCFc0BVHhFn7dAbnbny+NqUpkrjribbvX94WCURXyApn5BP4RA
         z14wX59eLmaERvim275eJA+Yo/103F1r992dIO/XLKC2DRKl8u9p1ZlHjfoG2hGEayvW
         m6lCsezlscDJ1oakuZRc9ZoctRV+DXREmDc1DFJtSIqncEdBZJQToMqzoiA+kK0QHd5K
         /kvymPJ/ivUbQdQHmgqp712MMb5i22KlNlZJL6Fk7e1/XPpgOXVt8iaPvgucf7laZXmE
         c9wVGcyj00pILZlc1blJMqmdY/ojFtgS9pBdNwwNl9+H3qoBi5u60uMLk2jT3x+6VAM5
         5uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EyldOrl1AnlI7bDeSkD8n3QBfB1hJho+erDX8iZ85/s=;
        b=WkGy5NyTjI4Sk5wvWL7f5k7AMYGO5hWjblXHqWBZCRqmOaGSdkpmipZmzs+PLOyv4I
         beXTuhJZ3rUsz75bruewHsyEd+Kyb74giRLBI7K3z9p+T4hkBvwasigwIJ6kuSO43zsG
         kP375ldE3xz0HPAY9/T23c2SFZkvgt/nxqrxBciV5MGOph1bQy8wGUlAcfNYIA8NAT0z
         XuH6cfdj5f+gFHd93/bt7vO200bSohBidrtJKCaYqmRXG2P1ImciTlMiAvY1A2ZsAAIR
         cdUok+DCSP/VZofaQEgf33gaZDHlGw03RGgt9V4XcEfLMGVjurkcykh7rWejywuakrG7
         m+SQ==
X-Gm-Message-State: ABuFfoj5wicWraD7aoBY1DbPimMEWzzEpYRnn2llgqfBzH24q8kFByAl
        tMLbLK36pfxVXFU1TAeKzFbczNt4
X-Google-Smtp-Source: ACcGV609L5u4voduDTYHIB8fdIkubV1Buw2BdRViIDrfJRLJPaw9zS8bDY1YioiIo7EvgvCpV6Hbew==
X-Received: by 2002:a19:d7d6:: with SMTP id q83-v6mr15583396lfi.27.1539779252844;
        Wed, 17 Oct 2018 05:27:32 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id g92-v6sm4117414lji.24.2018.10.17.05.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:27:31 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] clk: tegra: Convert CCLKG mux to mux + clock
 divider on Tegra30
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180830192045.11017-1-digetx@gmail.com>
 <20180830192045.11017-2-digetx@gmail.com>
 <19523f37-eb78-067c-cc62-b6ceaad985a9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b1265595-f01d-5ab2-aaf9-6c4d674f9f3a@gmail.com>
Date:   Wed, 17 Oct 2018 15:27:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <19523f37-eb78-067c-cc62-b6ceaad985a9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 11:53 AM, Jon Hunter wrote:
> 
> On 30/08/2018 20:20, Dmitry Osipenko wrote:
>> Some of the CCLKG parents aren't accessible via device tree because they
>> are created as non-DT clocks. Apparently there is no reason to define
>> these clocks in that manner, hence convert CCLKG mux to mux + clock
>> divider to remove the non-DT parent clocks. Now it is possible to request
>> all of CCLKG parents from device tree, which is necessary for the CPUFreq
>> driver.
> 
> Is it likely that all of these clock parents will be used by the CPUFreq
> driver for these devices? If the clocks you currently need are available
> then my preference would be to stick with what we have for now.

You could use them all if you want, that's what HW allow. The current clock description doesn't fully describe the HW, though it should be enough at least for the CPUFreq driver if we are going to use clk_get_sys() and stick to the "default" parent. Peter?
