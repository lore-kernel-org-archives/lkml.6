Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207CBC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20262513A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20262513A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030228AbeGAQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:29:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGAQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:29:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E5F1AD8;
        Sun,  1 Jul 2018 16:29:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 012/157] PM / Domains: Fix error path during attach in genpd
Date:   Sun,  1 Jul 2018 18:21:24 +0200
Message-Id: <20180701160852.893088349@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 72038df3c580c4c326b83c86149d7ac34007532a upstream.

In case the PM domain fails to be powered on in genpd_dev_pm_attach(), it
returns -EPROBE_DEFER, but keeping the device attached to its PM domain.
This leads to problems when the next attempt to attach is re-tried. More
precisely, in that situation an -EEXIST error code is returned, because the
device already has its PM domain pointer assigned, from the first attempt.

Now, because of the sloppy error handling by the existing callers of
dev_pm_domain_attach(), probing is allowed to continue when -EEXIST is
returned. However, in such case there are no guarantees that the PM domain
is powered on by genpd, which may lead to hangs when buses/drivers tried to
access their devices.

Let's fix this behaviour, simply by detaching the device when powering on
fails in genpd_dev_pm_attach().

Cc: v4.11+ <stable@vger.kernel.org> # v4.11+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/domain.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2162,6 +2162,9 @@ int genpd_dev_pm_attach(struct device *d
 	genpd_lock(pd);
 	ret = genpd_power_on(pd, 0);
 	genpd_unlock(pd);
+
+	if (ret)
+		genpd_remove_device(pd, dev);
 out:
 	return ret ? -EPROBE_DEFER : 0;
 }


