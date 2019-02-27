Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD5721908
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaUX8Xwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfB0CSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:18:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43559 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbfB0CSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:18:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so12570878ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wOBWNY374y/QfUc2jFMuBhBhbthjm2i0nq7yZ/ojO1I=;
        b=WaUX8Xwqg5HRRfL9G5j88gqwRF/sj3rDzWdnRHiS0K8nr7UDTL1BXAT3BiI0jDZYbF
         Q/qkwG0t1ZMkzR1Q6xJhV6VF1ZXXk63YWDpodzOC4ouGIXEObNNfZBXECoLuzCe5RYhI
         aXmYWTHO4ZN0kivPtVtp2lLhsFuflOqL1Bu7KkWeb5w3REz2v9RNxKERo89cV2NqLs+R
         sUxvCrB2pTWijTNIwOcfdEgSiqijKYeYseX5U1uJxthZVSktVphFC/qZh1k1lYy6/Pe7
         VZiOO9iS+W96MRN1u+dk3xktfX3kB5aFO7m7U/gRe5BomEY8oYFnsLkPEwA5gNVGTQsj
         kYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wOBWNY374y/QfUc2jFMuBhBhbthjm2i0nq7yZ/ojO1I=;
        b=S2EUArLziDST1CR1xZXSPkjxTxRbICHj7Z0ESVZ6Y3lO9oEvn7yqJPpIG7HvrNgpev
         Gqy4dS/RxTpldfkeCKkC55dkjnlPJtquauKkkSJlxbObAsSRCFm1ULiOHNkB719piafN
         aGRXcuopsP4ZeDHnfkqDCFBvOXJAMbDhSxAdxSPsQ0m4fQlfW+xtbRGQb/qsQ12cucMV
         FX1jrMAqUQ6TLKvbAcV2ejgeyqaLHtSdfkYtbhVTwMlPHddEvsdR01SjCd3GUBotAVfa
         DILFlorm46rPedaICS7TKXbUzrw98+seeAUYWH06jzU4Q67L1PpaiE/3L4PF5e2HAuya
         vQ4g==
X-Gm-Message-State: AHQUAuYYJhzZa0lYfyl50Rfv38Hz0RFZUXER2o3SoRBssHnGRlHOOgms
        BADN/Cb9NP8vDhPiGXD/ju73+g==
X-Google-Smtp-Source: AHgI3IaCk0QmoYK2sWM7bpPG2odhZcYzUoJ4/lYoQ0V484Rf9OA0BwKh7BlBYNL9jiLAzg8n60PIKA==
X-Received: by 2002:a2e:9001:: with SMTP id h1mr15291072ljg.5.1551233924543;
        Tue, 26 Feb 2019 18:18:44 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o14sm3402917lfl.41.2019.02.26.18.18.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Feb 2019 18:18:43 -0800 (PST)
Date:   Wed, 27 Feb 2019 03:18:41 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     robh@kernel.org
Cc:     agraf@suse.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: broken probe deferred for power-domains
Message-ID: <20190227021841.GA26337@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Your patch e01afc325025 ("PM / Domains: Stop deferring probe
at the end of initcall") breaks deferred probe for power domains.

The patch looks like this:

+++ b/drivers/base/power/domain.c
@@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
                mutex_unlock(&gpd_list_lock);
                dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
                        __func__, PTR_ERR(pd));
-               return -EPROBE_DEFER;
+               return driver_deferred_probe_check_state(dev);
        }


Having two drivers (both using module_platform_driver),
one being a PD provider and one being a PD consumer.

Before your patch:
The PD consumer driver calls dev_pm_domain_attach(),
and gets EPROBE_DEFER until the PD provider driver
has been probed successfully.

(The PD provider driver needs some regulators, so it
is only successfully probed after the regulator driver
has been probed successfully.)

Anyway, dev_pm_domain_attach() returned success after
the some deferred probes.


After your patch:
dev_pm_domain_attach() return ENODEV,
which comes from driver_deferred_probe_check_state().
Since it returns ENODEV rather than EPROBE_DEFER,
the PD consumer driver fails to probe.


The problem is related to your other patch 25b4e70dcce9
("driver core: allow stopping deferred probe after init").

driver_deferred_probe_check_state() returns ENODEV if
initcalls_done == true.

initcalls_done is set from late_initcall(deferred_probe_initcall),
in drivers/base/dd.c:
       driver_deferred_probe_trigger();
       flush_work(&deferred_probe_work);
       initcalls_done = true;

This does not seem very robust, since

#1 It does not handle the case where two drivers have been
deferred (put in the deferred probe pending list),
where additionally one of the drivers has to be probed
before the other.

(We would need to call driver_deferred_probe_trigger() + flush_work()
at least twice to handle this.)

#2 Since this code is run from late_initcall(),
initcalls_done might get set before other drivers using late_initcall()
have even had a chance to run.
I can imagine that a driver using late_initcall() + EPROBE_DEFER
will absolutely not work with this code.


This patch fixes #1, but not #2.
However, I assume that even this change would not work if we have 3
drivers, where each driver a > b > c has to be probed, in that order.
(and all of them were placed in the deferred probe pending list).

Suggestions and patches are welcome.


diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a823f469e53f..3443cb78be9b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -288,7 +288,6 @@ static int deferred_probe_initcall(void)
        driver_deferred_probe_trigger();
        /* Sort as many dependencies as possible before exiting initcalls */
        flush_work(&deferred_probe_work);
-       initcalls_done = true;
 
        /*
         * Trigger deferred probe again, this time we won't defer anything
@@ -297,6 +296,8 @@ static int deferred_probe_initcall(void)
        driver_deferred_probe_trigger();
        flush_work(&deferred_probe_work);
 
+       initcalls_done = true;
+
        if (deferred_probe_timeout > 0) {
                schedule_delayed_work(&deferred_probe_timeout_work,
                        deferred_probe_timeout * HZ);



Kind regards,
Niklas
