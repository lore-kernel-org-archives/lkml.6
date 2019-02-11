Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F13AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C99B217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897614;
	bh=d0lQgnfoGHOGO/KlILRPtMHl7qyBCId4a+nJr9V/nPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XomBND6abxF5t281Wzl6v0ulKk0LnT/PmhGFHWSxjKjJu+Q2PSi2swSMg/+TIEzpH
	 QluCenMMdbeiLlSZsDoHh1ofogjD+rtznXTrNgJ6k0ugls8QFSlpotKIVkzNqIlxcR
	 2hA0Y6B3EIdUvD6O2r0Gl5yuTfkfuyNyp6r4cbXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfBKPGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:06:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbfBKPGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:06:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D561217D9;
        Mon, 11 Feb 2019 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897609;
        bh=d0lQgnfoGHOGO/KlILRPtMHl7qyBCId4a+nJr9V/nPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxg9ep5zfAAW/Cmd5niyAykODdKgzDUyHUwbk8upZKPEIGvTiCBGiG5sGX1M3Qn6N
         pd19bXAvrFBkRAMdWV6RpKkn90VW0NYINEvWVmuHS6uKuO79AScsXA0a1+ztnxKhUn
         YFJTOtM3yV81JUx5WvXqmghSSbjlDZHDnWDAls6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 055/137] memstick: Prevent memstick host from getting runtime suspended during card detection
Date:   Mon, 11 Feb 2019 15:18:56 +0100
Message-Id: <20190211141817.067343961@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e03e303edf1c63e6dd455ccd568c74e93ef3ba8c ]

We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
helpers to let memstick host support runtime pm.

The rpm count may go down to zero before the memstick host powers on, so
the host can be runtime suspended.

So before doing card detection, increment the rpm count to avoid the
host gets runtime suspended. Balance the rpm count after card detection
is done.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/core/memstick.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index a0547dbf9806..4d673a626db4 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 
 #define DRIVER_NAME "memstick"
 
@@ -436,6 +437,7 @@ static void memstick_check(struct work_struct *work)
 	struct memstick_dev *card;
 
 	dev_dbg(&host->dev, "memstick_check started\n");
+	pm_runtime_get_noresume(host->dev.parent);
 	mutex_lock(&host->lock);
 	if (!host->card) {
 		if (memstick_power_on(host))
@@ -479,6 +481,7 @@ out_power_off:
 		host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
 
 	mutex_unlock(&host->lock);
+	pm_runtime_put(host->dev.parent);
 	dev_dbg(&host->dev, "memstick_check finished\n");
 }
 
-- 
2.19.1



