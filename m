Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C066720672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5imna4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeLMJNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:13:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeLMJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:13:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so807110pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7X6T2IG7YYmJq1D85TMXm+q74QihwQLU6cLo+sOoltI=;
        b=S5imna4ZzJu2Drfa+T1H2V26jrYxChMOkLhfbzoS5JF2ESj8VGbfTLUpxq5Y8kC0K0
         jTclJcWuV1k2/kjrhsW83MzG27eHWzkLVMmvSqtLA22mejweqZ/e0cmwBhIbCdpkgtkA
         Nc41YORj7crBcf/ELXbUhhxZ027ha3HE0DbFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7X6T2IG7YYmJq1D85TMXm+q74QihwQLU6cLo+sOoltI=;
        b=qOxw5V+BLwOwchtKA3nBaCWDFzgLACWCICfXG+ZXJtQNWrBYI3cOTMzVqwShFvZ4u4
         BrnnRR5ZJOLtWp4lnJeczlmJ2Dobf/yhmc8FI174tKkMyGJrjK+GR11KsJ8oCDMyXQv7
         XgxetFkafE/3FkRzO92SgaPlv+0vivPrCrJYi39EpgcaK5x/hrWwBORIKjajivSAaOP2
         9TpHldl68JTervamHk/UyDJK1w+sIHFmESyAVg+n7b/r1gfWSxNrv/UoqTGa3fUpe7pS
         7Qpu83jgTB9ykpWBLXByYoHF9CG77x4kaRrpQc36ayn/6KtrpX94wPDXfCp/sAhfrnDZ
         Y9Hw==
X-Gm-Message-State: AA+aEWbtWJjdBWPNMY+c1MOutRL7FrXMzTHEOz4qXytibpKHQg7qqii9
        XAvWNtLtKgVhGsyFEDqn1JCyow==
X-Google-Smtp-Source: AFSGD/VafrA7iQbHLbw0cZa1je0n0qrV0AKD8hMApddKTpaelqDn2AfDtF8z6f746B9lAiz2AfFvjg==
X-Received: by 2002:a63:9e19:: with SMTP id s25mr1882623pgd.203.1544692404515;
        Thu, 13 Dec 2018 01:13:24 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id z8sm2834378pgz.53.2018.12.13.01.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 01:13:23 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:43:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181213091319.lsvfyzg6xlg72xic@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544687394-331-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 13:19, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 305 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
