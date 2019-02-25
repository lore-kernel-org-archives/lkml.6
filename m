Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B236C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21F220652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130785;
	bh=CYvS8pOLqXskB5v0iXtrhVQ9SR//B2g1di1nKnE30sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fH33CXV38RRhOZL989r2VIVekaGa8aqZFpA2RMFDc09tJZGj74w+1x942ofdu+Mr8
	 8qQYkCwLWbZGaZ1LRhTsRgsoirVRyZ5ndOx2cd7g7DO5F+ZxO5knRxg/HR8RaXvINt
	 vX+WZeLMXFGudOAJbU15tSsSZR1+F6C//EhSbDoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfBYVft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732155AbfBYVfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6024620578;
        Mon, 25 Feb 2019 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130542;
        bh=CYvS8pOLqXskB5v0iXtrhVQ9SR//B2g1di1nKnE30sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIr7nRigK45DOoXt6JW0jXnpYnUP2xoJ+67ZbpKnGAKx5m6DG8Rv5YXIq5tMqRWMQ
         r3PFNU0KHHbVnC4VcU4AbVLqwvP+sl54OiuwNj4VuT2I/kgMPm/1G9FvL2I+lbAoZZ
         HEf4q1e1LScfZQxkgzdLy0sljDyl1r+VYYLyMePc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 155/183] cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()
Date:   Mon, 25 Feb 2019 22:12:08 +0100
Message-Id: <20190225195121.080360008@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yangtao Li <tiny.windzz@gmail.com>

commit 8cbd468bdeb5ed3acac2d7a9f7494d5b77e46297 upstream.

This issue was detected with the help of Coccinelle. So
change the order of function calls to fix it.

Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/scmi-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpuf
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	kfree(priv);
 
 	return 0;
 }


