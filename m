Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19785ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD92C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD92C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeGWNz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:55:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbeGWN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:26:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F40DDBE1;
        Mon, 23 Jul 2018 12:25:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dewet Thibaut <thibaut.dewet@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.17 12/63] x86/MCE: Remove min interval polling limitation
Date:   Mon, 23 Jul 2018 14:24:18 +0200
Message-Id: <20180723122446.842171967@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dewet Thibaut <thibaut.dewet@nokia.com>

commit fbdb328c6bae0a7c78d75734a738b66b86dffc96 upstream.

commit b3b7c4795c ("x86/MCE: Serialize sysfs changes") introduced a min
interval limitation when setting the check interval for polled MCEs.
However, the logic is that 0 disables polling for corrected MCEs, see
Documentation/x86/x86_64/machinecheck. The limitation prevents disabling.

Remove this limitation and allow the value 0 to disable polling again.

Fixes: b3b7c4795c ("x86/MCE: Serialize sysfs changes")
Signed-off-by: Dewet Thibaut <thibaut.dewet@nokia.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
[ Massage commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180716084927.24869-1-alexander.sverdlin@nokia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -2147,9 +2147,6 @@ static ssize_t store_int_with_restart(st
 	if (check_interval == old_check_interval)
 		return ret;
 
-	if (check_interval < 1)
-		check_interval = 1;
-
 	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
 	mutex_unlock(&mce_sysfs_mutex);


