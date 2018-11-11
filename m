Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46865223CA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tukCJ2Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46865223CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbeKLITj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbeKLITi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25542154B;
        Sun, 11 Nov 2018 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975382;
        bh=BtkZCaIzEZOL+3cmitvb+lpZb0mN1w43MAR2Yp+JKyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tukCJ2Dwcwfx7Gq2AxhvRPw95FxPzHcFexaLP8nt5/GM5nso+xiv2x0PgjhSvFll6
         svGlja+K3O4wvAAyD9Vr3QyKCQUZNN6BomNoU0HJph1EKTspQoIpCZdwD+nsf+Pair
         RhiEtXqzFo+Y7+IBefpaX4JRl9qCCU7KxgWZe9Fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 020/350] ACPI / OSL: Use jiffies as the time bassis for acpi_os_get_timer()
Date:   Sun, 11 Nov 2018 14:18:04 -0800
Message-Id: <20181111221708.018543494@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

commit 83b2348e2755db48fa8f40fdb791f366fabc0ba0 upstream.

Since acpi_os_get_timer() may be called after the timer subsystem has
been suspended, use the jiffies counter instead of ktime_get(). This
patch avoids that the following warning is reported during hibernation:

WARNING: CPU: 0 PID: 612 at kernel/time/timekeeping.c:751 ktime_get+0x116/0x120
RIP: 0010:ktime_get+0x116/0x120
Call Trace:
 acpi_os_get_timer+0xe/0x30
 acpi_ds_exec_begin_control_op+0x175/0x1de
 acpi_ds_exec_begin_op+0x2c7/0x39a
 acpi_ps_create_op+0x573/0x5e4
 acpi_ps_parse_loop+0x349/0x1220
 acpi_ps_parse_aml+0x25b/0x6da
 acpi_ps_execute_method+0x327/0x41b
 acpi_ns_evaluate+0x4e9/0x6f5
 acpi_ut_evaluate_object+0xd9/0x2f2
 acpi_rs_get_method_data+0x8f/0x114
 acpi_walk_resources+0x122/0x1b6
 acpi_pci_link_get_current.isra.2+0x157/0x280
 acpi_pci_link_set+0x32f/0x4a0
 irqrouter_resume+0x58/0x80
 syscore_resume+0x84/0x380
 hibernation_snapshot+0x20c/0x4f0
 hibernate+0x22d/0x3a6
 state_store+0x99/0xa0
 kobj_attr_store+0x37/0x50
 sysfs_kf_write+0x87/0xa0
 kernfs_fop_write+0x1a5/0x240
 __vfs_write+0xd2/0x410
 vfs_write+0x101/0x250
 ksys_write+0xab/0x120
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x71/0x220
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 164a08cee135 (ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop detection)
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
References: https://lists.01.org/pipermail/lkp/2018-April/008406.html
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/osl.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -617,15 +617,18 @@ void acpi_os_stall(u32 us)
 }
 
 /*
- * Support ACPI 3.0 AML Timer operand
- * Returns 64-bit free-running, monotonically increasing timer
- * with 100ns granularity
+ * Support ACPI 3.0 AML Timer operand. Returns a 64-bit free-running,
+ * monotonically increasing timer with 100ns granularity. Do not use
+ * ktime_get() to implement this function because this function may get
+ * called after timekeeping has been suspended. Note: calling this function
+ * after timekeeping has been suspended may lead to unexpected results
+ * because when timekeeping is suspended the jiffies counter is not
+ * incremented. See also timekeeping_suspend().
  */
 u64 acpi_os_get_timer(void)
 {
-	u64 time_ns = ktime_to_ns(ktime_get());
-	do_div(time_ns, 100);
-	return time_ns;
+	return (get_jiffies_64() - INITIAL_JIFFIES) *
+		(ACPI_100NSEC_PER_SEC / HZ);
 }
 
 acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)


