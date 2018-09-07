Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9536CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592AD20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592AD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeIHB7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeIHB7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E3CBFAA;
        Fri,  7 Sep 2018 21:16:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 088/145] PM / sleep: wakeup: Fix build error caused by missing SRCU support
Date:   Fri,  7 Sep 2018 23:09:14 +0200
Message-Id: <20180907210911.328946929@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangyi (F) <yi.zhang@huawei.com>

commit 3df6f61fff49632492490fb6e42646b803a9958a upstream.

Commit ea0212f40c6 (power: auto select CONFIG_SRCU) made the code in
drivers/base/power/wakeup.c use SRCU instead of RCU, but it forgot to
select CONFIG_SRCU in Kconfig, which leads to the following build
error if CONFIG_SRCU is not selected somewhere else:

drivers/built-in.o: In function `wakeup_source_remove':
(.text+0x3c6fc): undefined reference to `synchronize_srcu'
drivers/built-in.o: In function `pm_print_active_wakeup_sources':
(.text+0x3c7a8): undefined reference to `__srcu_read_lock'
drivers/built-in.o: In function `pm_print_active_wakeup_sources':
(.text+0x3c84c): undefined reference to `__srcu_read_unlock'
drivers/built-in.o: In function `device_wakeup_arm_wake_irqs':
(.text+0x3d1d8): undefined reference to `__srcu_read_lock'
drivers/built-in.o: In function `device_wakeup_arm_wake_irqs':
(.text+0x3d228): undefined reference to `__srcu_read_unlock'
drivers/built-in.o: In function `device_wakeup_disarm_wake_irqs':
(.text+0x3d24c): undefined reference to `__srcu_read_lock'
drivers/built-in.o: In function `device_wakeup_disarm_wake_irqs':
(.text+0x3d29c): undefined reference to `__srcu_read_unlock'
drivers/built-in.o:(.data+0x4158): undefined reference to `process_srcu'

Fix this error by selecting CONFIG_SRCU when PM_SLEEP is enabled.

Fixes: ea0212f40c6 (power: auto select CONFIG_SRCU)
Cc: 4.2+ <stable@vger.kernel.org> # 4.2+
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
[ rjw: Minor subject/changelog fixups ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/power/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -105,6 +105,7 @@ config PM_SLEEP
 	def_bool y
 	depends on SUSPEND || HIBERNATE_CALLBACKS
 	select PM
+	select SRCU
 
 config PM_SLEEP_SMP
 	def_bool y


