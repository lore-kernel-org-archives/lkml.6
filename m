Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6CCC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC1C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHCfdHoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC1C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJHRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:10:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40337 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeJHRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:10:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so8124313pfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TPKLJvi0bu0T0vgO/2whyuCmUDDDZkWtuXYkyhUy2Zg=;
        b=XHCfdHohHLEgqq+l/ncblEg3sleWSnwJaLftTIlygyNo2a61jSFr5vgwfiLnIA9TXN
         +6cuwjpbmc9L0Ucz9uLkRq+BaHBuPnQ/lMN3MPo1Lh9e4991uN7nrO3sOqPpzeM2F3m6
         tS/x57JqkcS4Cv5TNVdBb8VYbKt9S/6FpVLmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPKLJvi0bu0T0vgO/2whyuCmUDDDZkWtuXYkyhUy2Zg=;
        b=sBCPqGNZ/7llMXJN8r4NUJynlFTMDukBKOK5ZREIhYgmvEHFhLDlJWXeXvVECmbD8T
         LlYRm8Yg1EaQXmEC/DPuhOYlOfY0R4MANCLJKZc0ND9i+hfomWPK9bgy1SZ3/F6tXPd8
         /u+idpQIbWl6IdmRkNN3vaji1aDHJWdAjNxRGh3waXl2ecVPqr1SwasQIQ7TCT9TyaXd
         M3yzGy3jteRfRv71N/eWgfUipQgMu8lqnxFpU6cLBO//9E85XOeeA8IXfEZDYUES9qHp
         uHBqECj+Q8g8v3jYVSnNJj/4j+RLGGN6X1vnDgQRd98YXfJg+Lym5YOH1iETEOcxZfkl
         cmyA==
X-Gm-Message-State: ABuFfogoM/IUcVUaI7/zL4NyVhqVOxjISFNKXTih1yanrmgphWayvXtY
        jO5143zkYpCLD2zSHkMcN2DVgA==
X-Google-Smtp-Source: ACcGV62xbZvEAThPJXexgESqwrL0kTn1YUqQTnFejvzpRL48Us2Fd4xLshUsP33k5LCWcDkhfrUPbg==
X-Received: by 2002:a62:6c48:: with SMTP id h69-v6mr24257997pfc.61.1538992795877;
        Mon, 08 Oct 2018 02:59:55 -0700 (PDT)
Received: from localhost ([122.172.112.137])
        by smtp.gmail.com with ESMTPSA id a2-v6sm18047693pgc.68.2018.10.08.02.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 02:59:54 -0700 (PDT)
Date:   Mon, 8 Oct 2018 15:29:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181008084012.GA23693@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008084012.GA23693@centauri.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-18, 10:40, Niklas Cassel wrote:
> > +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> > +				"#freq-domain-cells", 0, &args);
> 
> Hello Taniya,
> 
> in your DT binding, you use
> 
> #freq-domains-cells = <1>
> 
> Yet here you parse for "#freq-domain-cells".

And what is the problem with that ? Or are you suggesting her to call
of_parse_phandle_with_fixed_args() ?

-- 
viresh
