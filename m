Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE169C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D732243B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="acZDJbkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D732243B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405770AbeKTD0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404876AbeKTD0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:26:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D141223CB;
        Mon, 19 Nov 2018 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646909;
        bh=VxZnKpQBXEbYXDOooHL4rSl26Mi5HJP6IlYdYMr7dog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acZDJbkLFjwtqFfilxIlWIXZLLFUPFpxqytHwtBHQ6gxe0ZpK7xTawPmPQ6lRmQh8
         xe5An9F3EFLwqqRmRbaPM8qCPLHvmzIu3V5HHRBZqNYyiUo6bI9JjNYMYT0xOzLTra
         N9zNxjNSrqbv3NCBtVCv2RvR3T2j0TJotCznqH5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: [PATCH 4.4 136/160] clockevents/drivers/i8253: Add support for PIT shutdown quirk
Date:   Mon, 19 Nov 2018 17:29:35 +0100
Message-Id: <20181119162643.328815914@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mikelley@microsoft.com>

commit 35b69a420bfb56b7b74cb635ea903db05e357bec upstream.

Add support for platforms where pit_shutdown() doesn't work because of a
quirk in the PIT emulation. On these platforms setting the counter register
to zero causes the PIT to start running again, negating the shutdown.

Provide a global variable that controls whether the counter register is
zero'ed, which platform specific code can override.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "jgross@suse.com" <jgross@suse.com>
Cc: "akataria@vmware.com" <akataria@vmware.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>
Cc: "apw@canonical.com" <apw@canonical.com>
Cc: vkuznets <vkuznets@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1541303219-11142-2-git-send-email-mikelley@microsoft.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/i8253.c |   14 ++++++++++++--
 include/linux/i8253.h       |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -19,6 +19,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter_on_shutdown = true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -108,8 +115,11 @@ static int pit_shutdown(struct clock_eve
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
+
+	if (i8253_clear_counter_on_shutdown) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
 
 	raw_spin_unlock(&i8253_lock);
 	return 0;
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 


