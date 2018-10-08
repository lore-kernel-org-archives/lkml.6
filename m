Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F90C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598D020C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zh4n/cMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598D020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeJIBqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbeJIBqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:46:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A54E2089D;
        Mon,  8 Oct 2018 18:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023619;
        bh=WsEwiZX0SybsdVqPl4/bH8he6rwozqO8g/AgEwraJ6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh4n/cMSchj9u2YPYsjADfjhTUFZ9VU2ZfbuzfmCxpy0Ev1MRMbHEx/7u8gewSj40
         nnsdyI8rdQsE+kWqZdPjJ3n/Pw+lBxGedtBGow5/Qscw5lvkPM1xOhyDP9QW4zjv4C
         QXXvyfPce6CJQwshPYbiJRUIyZO36urQir3pmiL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 007/113] power: vexpress: fix corruption in notifier registration
Date:   Mon,  8 Oct 2018 20:30:08 +0200
Message-Id: <20181008175531.219817187@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
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

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 09bebb1adb21ecd04adf7ccb3b06f73e3a851e93 ]

Vexpress platforms provide two different restart handlers: SYS_REBOOT
that restart the entire system, while DB_RESET only restarts the
daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
if it exists.

notifier_chain_register used in register_restart_handler by design
relies on notifiers to be registered once only, however vexpress restart
notifier can get registered twice. When this happen it corrupts list
of notifiers, as result some notifiers can be not called on proper
event, traverse on list can be cycled forever, and second unregister
can access already freed memory.

So far, since this was the only restart handler in the system, no issue
was observed even if the same notifier was registered twice. However
commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
support for SP805 restart handlers and since the system under test
contains two vexpress restart and two SP805 watchdog instances, it was
observed that during the boot traversing the restart handler list looped
forever as there's a cycle in that list resulting in boot hang.

This patch fixes the issues by ensuring that the notifier is installed
only once.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 46c99ac66222 ("power/reset: vexpress: Register with kernel restart handler")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/reset/vexpress-poweroff.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -35,6 +35,7 @@ static void vexpress_reset_do(struct dev
 }
 
 static struct device *vexpress_power_off_device;
+static atomic_t vexpress_restart_nb_refcnt = ATOMIC_INIT(0);
 
 static void vexpress_power_off(void)
 {
@@ -99,10 +100,13 @@ static int _vexpress_register_restart_ha
 	int err;
 
 	vexpress_restart_device = dev;
-	err = register_restart_handler(&vexpress_restart_nb);
-	if (err) {
-		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
-		return err;
+	if (atomic_inc_return(&vexpress_restart_nb_refcnt) == 1) {
+		err = register_restart_handler(&vexpress_restart_nb);
+		if (err) {
+			dev_err(dev, "cannot register restart handler (err=%d)\n", err);
+			atomic_dec(&vexpress_restart_nb_refcnt);
+			return err;
+		}
 	}
 	device_create_file(dev, &dev_attr_active);
 


