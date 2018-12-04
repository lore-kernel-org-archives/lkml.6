Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C315C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482B6208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX3Z2FAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482B6208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLDEuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:50:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35219 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDEuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:50:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so7577711pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 20:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYO/z386VNta4UctSXviaV0eojIktFtruslaGj5T1jA=;
        b=eX3Z2FAPyiFwfJg39MtL+iaSaMbHj5OFaKHUeBBI8VONTld5bQeEl+26bNkGxuU51S
         XgvuDbL7HxBHD4gIz7si8AJ1OMQaQrIlKubdmm3qn0v/MscqixrDa2z8djLd5QBXT61F
         ApycqKdmLQDS/PHpC7Epk0rLYyUaBd9M++tcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYO/z386VNta4UctSXviaV0eojIktFtruslaGj5T1jA=;
        b=qMqbLPNgIjqA5XMLJWKEGlGsum5+vN9lLo1mrDmVPeCjO4i0+6LB43Rb6ChUezVZzW
         T2WsKwfpaduPP1FQ8+cLUHkl4L/w6yWJlNK5pKjJeylrUnrIWY4DCaty4ysVng5V50rN
         M7jDaAAiuNFCk8+WosKdB6WYiE2JiWlDXdoRFQBSyTafTvxv0hIojrAQ0RdCsAmv3VUz
         OTHScWbufzYrmBNNR+NIXtnrXUCIL2Nho2l7EmpwRybnCYRj7Rz+xVTmqazerBE2g1nW
         zPseOANPVKGoZtPDMsVTivjBBVAhndV8e7UMnRTpFO3KzubJmBo0U47CAC5nhmuaFcKN
         xFkA==
X-Gm-Message-State: AA+aEWbr3f4idOaYQjkiKDbVPBN4CuxvP6w2p37rnCt8LlHdvHZ9zfzB
        UAq8N6KkDwyBgjEtJFX2sl7nSg==
X-Google-Smtp-Source: AFSGD/UAX0MAs8RNeAxBsaKCfBK/eDrOFZA8RfH7eX2u6cmuW/MmsP/VKckyuTCgd4W1+CBAkzYiDA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr15715043pgj.421.1543899016897;
        Mon, 03 Dec 2018 20:50:16 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id v184sm19346547pfb.182.2018.12.03.20.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 20:50:15 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:20:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 28/34] dt-bindings: arm: Convert SPEAr board/soc
 bindings to json-schema
Message-ID: <20181204045012.gy6xs7nggtcurdu5@vireshk-i7>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-29-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-29-robh@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-18, 15:32, Rob Herring wrote:
> Convert SPEAr SoC bindings to DT schema format using json-schema.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/spear.txt         | 26 -------------------
>  .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
