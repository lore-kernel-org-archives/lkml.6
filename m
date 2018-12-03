Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D34C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB53620881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqK7URzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB53620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeLCQ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:57:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41676 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLCQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:57:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so6660225pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=5dr5qxodFXW6Z9opJJzT19UChQi37W0A+LeEuzz2pEQ=;
        b=gqK7URzOo2h9U4LQhpBmoS4sAdWxnKgYvSFh+Ne1icVFGFkB+QflWWfA1puIydQXzx
         gnjMqyYZpdPNg7EohXzk5NTM7tX4SDJHgXOCAX+8wgnROdvUJMsHHuj6DZWaliL9XX2O
         M3iuWDMxvST6BWbZdL74cqLHOwovgj1beA5Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=5dr5qxodFXW6Z9opJJzT19UChQi37W0A+LeEuzz2pEQ=;
        b=NXqRxUA7Eaq0ggNr+UY8gWGIP9PRWRe4/DFBa5dpInObgMDYM+Z7Dw2dHIY8ECQAk+
         m3VARdcMgyDOF4OmT55gBFEIDB0ZiJJRg+0akuplhqZcO2rT2L6/QB09nmhMNdEzGtp8
         GNOT5jkR1RTFmpAzaqc61rpaO+mVCnh41Y6NVDkak6v9Er9/v9Oj3OW/r1c3C1Q7bLgN
         rKNzQrJSQeKYuf9ryAVIgbv7tu7t8N3RaL2ozZXwTHKMewwR+P4pUSHR0esOIvatE+mN
         Aae+APQ7lKsyhQmvi7JFuKgT0CWKY1uWtHInM+IHw6eXcgMwF+8odmfrQILfhEZiVDNP
         b+2A==
X-Gm-Message-State: AA+aEWaIsxtfuxiBBMq3G3XJFIeeUsZFJ01Ip1LEHgKYuq3b9+WgfzMH
        tS1eDzQ2fZCxCGVt5KXEAavGGA==
X-Google-Smtp-Source: AFSGD/W0nKyaEx+v9DNAFiOEN64YfM0PX0lbn1UarBYmLdkxx1oaXA9XYmwe+jMEQbvDF0/IXrzt3g==
X-Received: by 2002:a63:5346:: with SMTP id t6mr14206389pgl.40.1543856235796;
        Mon, 03 Dec 2018 08:57:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id i62sm11113410pfc.16.2018.12.03.08.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:57:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
Message-ID: <154385623442.88331.10221197549372099296@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Mon, 03 Dec 2018 08:57:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-01 19:55:03)
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> =

> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

