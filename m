Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB34C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C58E2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVfGqJde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C58E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeKFKwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:52:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46011 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeKFKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:52:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so7602069lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 17:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1e3I/KDnanvN9kwto57/PKEf+Ws+74tzdDp4sUDSZN8=;
        b=MVfGqJdeyXJoIVT0PZ1gVIewHUjg77kUJNNYFPLWx502B/3kHWbdb7jcxEOab6iUgV
         v700n82DYM1EroUcjoTO7vU33H8Zq0nYsm3UctCUtNR6bF24pJMmgHLWHlYMZDTaHvbS
         QpUl3IM8jUpwFqcEbWe1zfC+WVqqgSnSk+vis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1e3I/KDnanvN9kwto57/PKEf+Ws+74tzdDp4sUDSZN8=;
        b=DRfleRnPt2kSetmhMiYI6hBBOOAriRSdZwSQ9tkdMCCvPb91qBHNRZFp4NprQBX142
         xQN8rsm9NJW2U7EThGGePxg+l6dbeF7y1MTalWd7VpNYHpAXI0cQgHw4wYz0A3clCU+0
         Fjz9gJvzIj0L+0ht4Ewpkhqoj7cSAjq0JOspftvOqOEu6RbbkvlUjfGvwW/1Ff6K2imp
         wVPoDnhsmhDSNTkw5jk9uDIYO+r0dpW6RrMHinkaLJ5YKmbg6TrcRDavrupgAz6ZOG1+
         Vsw+T9lPJiYXFYp6SlqapjnRlLJL9lsLZaTJFMsCyE3QwYoiwo8+dkBs3xlqF6f+tjqN
         L4Kg==
X-Gm-Message-State: AGRZ1gJyYen4ALHerh86pL2R1tMz9zgm6N7W/5RBDGXspcydx1HpHdKn
        Xy3dcoAvHKuhO4YTF0jnk20b9g==
X-Google-Smtp-Source: AJdET5cjdnpGsVdaEI8EwDqy3Z4IMDSmz9lqo9i/suMIdrqKiTkrwaLwURJB/1iYAxogBwf4HuFUaA==
X-Received: by 2002:a19:982:: with SMTP id 124mr8008351lfj.138.1541467771494;
        Mon, 05 Nov 2018 17:29:31 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j126sm519697lfe.10.2018.11.05.17.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:29:30 -0800 (PST)
Date:   Tue, 6 Nov 2018 02:29:28 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     bgolaszewski@baylibre.com
Cc:     srinivas.kandagatla@linaro.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [regression 4.20-rc1, bisected] cpufreq fails to register on db820c
Message-ID: <20181106012928.GA32044@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartosz,

I've run into a regression on v4.20-rc1, where cpufreq on dragonboard 820c
fails to register.

I've bisected the issue to:
e888d445ac33 ("nvmem: resolve cells from DT at registration time")

If I revert that patch, cpufreq starts working on dragonboard 820c again.


Before your patch:
[    5.052985] qcom_cpufreq_kryo_probe:110 speedbin_nvmem: ffff8000d4d51e00
[    5.053133] qcom_cpufreq_kryo_probe:120 speedbin: ffff8000d4d51d00
[    5.058895] qcom_cpufreq_kryo_probe:121 *speedbin: 0


After your patch:
[    4.791664] qcom_cpufreq_kryo_probe:110 speedbin_nvmem: ffff8000d472ed00
[    4.791815] qcom_cpufreq_kryo_probe:120 speedbin: ffff8000d451b300
[    4.797575] qcom_cpufreq_kryo_probe:121 *speedbin: 12


The prints are debug prints that I've added locally:

--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -107,6 +107,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
        }
 
        speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+       pr_err("%s:%d speedbin_nvmem: %lx\n", __func__, __LINE__, speedbin_nvmem);
        of_node_put(np);
        if (IS_ERR(speedbin_nvmem)) {
                if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
@@ -116,6 +117,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
        }
 
        speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+       pr_err("%s:%d speedbin: %lx\n", __func__, __LINE__, speedbin);
+       pr_err("%s:%d *speedbin: %u\n", __func__, __LINE__, (unsigned int)(*speedbin));
        nvmem_cell_put(speedbin_nvmem);
        if (IS_ERR(speedbin))
                return PTR_ERR(speedbin);


So it appears that the read from nvmem_cell_read()
gets another value after your commit.

This value is then given to dev_pm_opp_set_supported_hw(),
however, since this new value (12) from nvmem_cell_read()
doesn't have any matching opp-supported-hw in device tree,
cpufreq fails to register.

This error only happens when we read this new incorrect value
(12 instead of 0).
Any idea why nvmem_cell_read() returns a new value for the
same efuse?


Kind regards,
Niklas
