Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E942124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJwQ/Lo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E942124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeGMHke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:40:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeGMHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:40:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so24011205wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ev31j3SE7QKWQzwmrY3nLg4Juo2rTX9hW+XaPcBv1fo=;
        b=CJwQ/Lo2r0jvzm/rHLQa/O99Ve1u2aIi4ksRxAQh6nhVr1B7jST9nUHrtGKheT6vYy
         rEgSdmbCe4M9g+0oJ1cww4TEvC85INPLykUocsEuOZXnQbgZCRF0NPETbPe+DfZPVKvg
         7EN682SnHoc1wrxBKGSSWcwWHIzUUXHSjgd58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ev31j3SE7QKWQzwmrY3nLg4Juo2rTX9hW+XaPcBv1fo=;
        b=HJTdIRYzaVNC1g3nUW0E60CajldaVaF+2Znu94n/ebhLbn3qidNLOtG249dYrvUYaa
         IOz81F9wAkTbO/VInnBEoWJ3I5RSC0m48rOybVM8hm0CRpIr4EBpSEASAo0kL2fxnjrC
         3aB9j1AI2gwZPmMJxnlclI+tL2zsmQta3G1jbLvfXKkRbLhcskk+XpEn54oicddibZRf
         BMblqyETmqPxb4VBwdqUhfdF4JLLxTZxukUVp1IgETuB9NvOUW92KYAeDIL+4bK+u2DN
         Neerk9CAgQeRDtnBQEA584cn11cbW6Ch7obTwMK7ATaCOgtb9hHSoWRZHCnoDtss7V/+
         i1Dg==
X-Gm-Message-State: AOUpUlHPrBlG87esxmY/Q4MHNXoWsf/BcxFQ/tXkVp1MuX+SBmdX8HJC
        qDuICyoTWLpEr0p3GqunvFHFMA==
X-Google-Smtp-Source: AAOMgpeCkxO+S5Uc0ZHN8spO7svHy/ik+meQDNWomTKs+R90QApELwQHoqcRdv4fPPFesz7p+PUq5w==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr4027322wrf.206.1531466831535;
        Fri, 13 Jul 2018 00:27:11 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id g75-v6sm8273292wmd.38.2018.07.13.00.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:27:10 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:27:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        puck.chen@hisilicon.com, john.stultz@linaro.org,
        ltp@lists.linux.it, lkft-triage@lists.linaro.org
Subject: Re: [PATCH] mfd: hi655x: Fix regmap area declared size for hi655x
Message-ID: <20180713072708.GL4641@dell>
References: <20180706172833.533-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180706172833.533-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Rafael David Tinoco wrote:

> Fixes: https://bugs.linaro.org/show_bug.cgi?id=3903
> 
> LTP Functional tests have caused a bad paging request when triggering
> the regmap_read_debugfs() logic of the device PMIC Hi6553 (reading
> regmap/f8000000.pmic/registers file during read_all test):
> 
> Unable to handle kernel paging request at virtual address ffff0
> [ffff00000984e000] pgd=0000000077ffe803, pud=0000000077ffd803,0
> Internal error: Oops: 96000007 [#1] SMP
> ...
> Hardware name: HiKey Development Board (DT)
> ...
> Call trace:
>  regmap_mmio_read8+0x24/0x40
>  regmap_mmio_read+0x48/0x70
>  _regmap_bus_reg_read+0x38/0x48
>  _regmap_read+0x68/0x170
>  regmap_read+0x50/0x78
>  regmap_read_debugfs+0x1a0/0x308
>  regmap_map_read_file+0x48/0x58
>  full_proxy_read+0x68/0x98
>  __vfs_read+0x48/0x80
>  vfs_read+0x94/0x150
>  SyS_read+0x6c/0xd8
>  el0_svc_naked+0x30/0x34
> Code: aa1e03e0 d503201f f9400280 8b334000 (39400000)
> 
> Investigations have showed that, when triggered by debugfs read()
> handler, the mmio regmap logic was reading a bigger (16k) register area
> than the one mapped by devm_ioremap_resource() during hi655x-pmic probe
> time (4k).
> 
> This commit changes hi655x's max register, according to HW specs, to be
> the same as the one declared in the pmic device in hi6220's dts, fixing
> the issue.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Cc: <stable@vger.kernel.org> #v4.9 #v4.14 #v4.16 #v4.17
> ---
>  drivers/mfd/hi655x-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
