Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A36DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052722ACD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C052722ACD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeGBVFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:05:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeGBVFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFEA281A4EB9;
        Mon,  2 Jul 2018 21:05:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 567C12026D5B;
        Mon,  2 Jul 2018 21:05:11 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video/console/vgacon: Print big fat warning with nomodeset
Date:   Mon,  2 Jul 2018 17:04:40 -0400
Message-Id: <20180702210442.18648-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 21:05:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 21:05:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a pretty good while since kernel modesetting was introduced.
It has almost entirely replaced previous solutions which required
userspace modesetting, and I can't even recall any drivers off the top
of my head for modern day hardware that don't only support one or the
other. Even nvidia's ugly blob does not require the use of nomodeset,
and only requires that nouveau be blacklisted.

Effectively, the only thing nomodeset does in the year 2018 is disable
your graphics drivers. Since VESA is a thing, this will give many users
the false impression that they've actually fixed an issue they were
having with their machine simply because the laptop will boot up to a
degraded GUI. This of course, is never actually the case.

Things get even worse when you consider that there's still an enormous
amount of tutorials users find on the internet that still suggest adding
nomodeset, along with various users who have been around long enough to
still suggest it.

There really isn't any legitimate reason I can see for this to be an
option that's used by anyone else other then developers, or properly
informed users. So, let's end the confusion and start printing warnings
whenever it's enabled.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/video/console/vgacon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f09e17b60e45..09731b2f6815 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -112,6 +112,11 @@ EXPORT_SYMBOL(vgacon_text_force);
 static int __init text_mode(char *str)
 {
 	vgacon_text_mode_force = true;
+
+	pr_warning("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
+	pr_warning("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
+	pr_warning("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
+
 	return 1;
 }
 
-- 
2.17.1

