Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F81C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71C6208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eUBo/QWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71C6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeLMJ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:58:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45431 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeLMJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:58:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so807900pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:subject:to
         :references:message-id:from:user-agent:cc:date;
        bh=1kVV8CE7EWZ3is/5Q2ZpcJ9855pQEXrzA6Tf5+AYdxI=;
        b=eUBo/QWgquKx41bva9jx5VllbXg4K55MJXYTtYRn87PvO1g/IgXhlbbRpw7b0YQCgf
         IbzQaBWuGFZKGY5kW1FoDqwUZ163saheWgH+YAScc/S9iKWl7okO95BnoDzNiQI7xvpk
         K4fC0k4UNOecSwHE0JnbU04ArW6fSX8xMDIdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:subject:to:references:message-id:from:user-agent:cc
         :date;
        bh=1kVV8CE7EWZ3is/5Q2ZpcJ9855pQEXrzA6Tf5+AYdxI=;
        b=ceoUXIhwZpCp6j0AoPTUlvwc+W0KFUXYMj/cC4IVSeGlf/ZXeyqWunsMyDf/mZouGx
         +100gIrwKQrvlhgOrIvocG/2p7SQSz6wTmUVV6Ik3ljbTb2RGs0gmi9+laxJG/tFDo84
         62LSUde3mlTBDU6G0+ar8bBln5QFNyS3EPhAXcIWy/f4IlPs1p4Y2p+qZwJqOp+pE3+W
         A7BM5LNp91D3+17URoQoMlv6TVddYgoWul6dZGrvRcBQE8YgjjgqzkeYUANAG6j5ISvH
         dAXtGlu+BpoEEffPAG6n7Daxa3q8EIYgYe1XxIeBk9Oo9Z3KZ3rYdTJsN++NH/McdyZE
         pRBw==
X-Gm-Message-State: AA+aEWbOWj13TGu3Mt4CqmyhdUgPa8n7fx0jrvcvGtJKpCDlG6fV7pC9
        8bwGzjIttRaJmkq7OYOMaJUQzg==
X-Google-Smtp-Source: AFSGD/W+wzfrYTZnGEbQoh/pHH0SFq5gpobZ2Z4GZ+uxGc6mDMTCS31cfwQWNAWa6hdjpkIRUhEXdw==
X-Received: by 2002:a63:f241:: with SMTP id d1mr21389248pgk.2.1544695108476;
        Thu, 13 Dec 2018 01:58:28 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c13sm2173369pfo.121.2018.12.13.01.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:58:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544687394-331-3-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org>
Message-ID: <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 13 Dec 2018 01:58:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-12 23:49:54)
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>=20
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

But I noticed that we don't release the I/O region anymore so hotplug
and replug of a whole clk domain fails. I guess devm_ioremap_resource()
was just too much magic so how about we downgrade to devm_ioremap()
instead?

BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
upon bringing the policy online the second time. I guess cpufreq_stats
aren't able to be freed from there because they take locks in different
order vs. the normal path?

-----8<-------
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufr=
eq-hw.c
index fce7a1162e87..0e1105151478 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -182,9 +182,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_pol=
icy *policy)
 	index =3D args.args[0];
=20
 	res =3D platform_get_resource(global_pdev, IORESOURCE_MEM, index);
-	base =3D devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (!res)
+		return -ENODEV;
+
+	base =3D devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return -ENOMEM;
=20
 	/* HW should be in enabled state to proceed */
 	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
