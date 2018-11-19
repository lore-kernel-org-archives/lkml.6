Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DD21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHO0S579"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0DD21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbeKTDGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbeKTDG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E224821104;
        Mon, 19 Nov 2018 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645739;
        bh=KNfDTB8iznhNw9Ets15O8s7iRvdfwail4merX2Q6fCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHO0S579ZleVjKoNqh29ekU0HO5J8pQ/8mhfmTrxu1KkuT8Qie1OV/WbGjT4PqVSb
         uaur94DfOmi3Cm8RIQPW1HnQ318q+DgMv92+LwHjD6z/VAqblwUV3DK2IQHfJGwPnM
         obXvHV1tlNTo4BVQp0PEDECCPH9jDRUXFDs3wyDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4.18 070/171] thermal: core: Fix use-after-free in thermal_cooling_device_destroy_sysfs
Date:   Mon, 19 Nov 2018 17:27:46 +0100
Message-Id: <20181119162631.070725266@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <digetx@gmail.com>

commit 3c587768271e9c20276522025729e4ebca51583b upstream.

This patch fixes use-after-free that was detected by KASAN. The bug is
triggered on a CPUFreq driver module unload by freeing 'cdev' on device
unregister and then using the freed structure during of the cdev's sysfs
data destruction. The solution is to unregister the sysfs at first, then
destroy sysfs data and finally release the cooling device.

Cc: <stable@vger.kernel.org> # v4.17+
Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/thermal_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1102,8 +1102,9 @@ void thermal_cooling_device_unregister(s
 	mutex_unlock(&thermal_list_lock);
 
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
-	device_unregister(&cdev->device);
+	device_del(&cdev->device);
 	thermal_cooling_device_destroy_sysfs(cdev);
+	put_device(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 


