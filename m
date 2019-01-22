Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4114BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1354921019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVd7UCwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfAVTXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:23:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35487 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:23:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so12252966pfi.2;
        Tue, 22 Jan 2019 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ysWqIk937UHo0upDeFfQCaECDfOjsnrVYPbbUwPmjo=;
        b=XVd7UCwUgnRhqow0GocsJdGPLSHCriUrtKRDHrjgK57F23Kqx3COgr2FU44VlNBJWV
         juTXHCO52Mboxsv/vRi0g1NpH6ko9iZzO+oOH9K0MEsU8IvHpOueMjQ7zJabWFCboGn8
         PLR0UqaNFn9JhhZn3xt/vWlrREqnusfXnvrmtAI1hHI2oaqpyqTmYoQ/EjwtempRBw43
         LqeSKtMFbMT7fHIz/gWiMGcsyOYr7TMKlloVSLoM0MtrUITLYnqdlGECsxNgdR9aAyJG
         IOIka9aKoGHiI65mSDccpV2GNKKv2ZG/I22ofd1qkLWhGtCWBiWcXlZZcDhAJYyR0fAJ
         +58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ysWqIk937UHo0upDeFfQCaECDfOjsnrVYPbbUwPmjo=;
        b=EjMGPeBH9uX+1Vj7XLP8m0wneFAqbiAUgmcmxVeOnz3tr3euRZBrRAccQOqpk9suyx
         O3pPHjMeSw1LWUg214iNzRu35uQMzpd8LbM2Mmz+3prkW2tFg0y5Jqz/bC4cJlErL0l0
         kdsFF6PaAauDvCQN+mZefR+iXJBpb2VzCF8H7u2k5lmWzi9zCugleEsdDQO9CAjHYPsP
         IGBsuEm/s9fS4ZFiORbrxNvISYro31INM+zNQRO9ZoQSHVXMaoJZDLPor8xGidsc0f/M
         y2IkxEUUZA5I5VfNMXxH7RWip9CW1kjWFmny3q0hvyS9R84VjEJes9l1o82frii0h9uZ
         9Mug==
X-Gm-Message-State: AJcUukdBdqFtgNsJqVo5GaHEWO8GYepfMS+EFXtC50qbzQi1sl9yLTh1
        k6xmkI9yWJKmm8uqBJMObKI9Mbho
X-Google-Smtp-Source: ALg8bN55j35RP+uZNjIQiOqNQ4bI+VRexVPU6CVyz6oga38i82DrqCkLVIrBHU5peMc/YHzCd7dNJA==
X-Received: by 2002:a63:5723:: with SMTP id l35mr31995240pgb.228.1548184995400;
        Tue, 22 Jan 2019 11:23:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm24105444pgg.62.2019.01.22.11.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:23:14 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:23:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/59] 4.14.95-stable review
Message-ID: <20190122192313.GA2224@roeck-us.net>
References: <20190121122456.529172919@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:43:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.95 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:23:55 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
