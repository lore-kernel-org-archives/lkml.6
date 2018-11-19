Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD5214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVy5oHbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDD5214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeKTC7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbeKTC7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9073A2147D;
        Mon, 19 Nov 2018 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645328;
        bh=GfufoFuYuZIlefOKN/ISAx7g9fTqE9KexTyLnoXzAQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVy5oHbFPZgcR14yuX6E0TXTTOBC5heXfhY1CjWbEAINDKs35y5I7bl9AhEw3+Pzs
         MmdvYhLSIJwl9CDO0Y3tMs5nZiZwdOQcT+oDz9E4KAa705Lni2dtTpeK26edtkOMz4
         XjN8uyQH21axsj32kR998wdBp2/anlOF2k/FjF7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <babu.moger@oracle.com>
Subject: [PATCH 4.19 122/205] watchdog/core: Add missing prototypes for weak functions
Date:   Mon, 19 Nov 2018 17:27:09 +0100
Message-Id: <20181119162636.197468034@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Malaterre <malat@debian.org>

commit 81bd415c91eb966118d773dddf254aebf3022411 upstream.

The split out of the hard lockup detector exposed two new weak functions,
but no prototypes for them, which triggers the build warning:

  kernel/watchdog.c:109:12: warning: no previous prototype for ‘watchdog_nmi_enable’ [-Wmissing-prototypes]
  kernel/watchdog.c:115:13: warning: no previous prototype for ‘watchdog_nmi_disable’ [-Wmissing-prototypes]

Add the prototypes.

Fixes: 73ce0511c436 ("kernel/watchdog.c: move hardlockup detector to separate file")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180606194232.17653-1-malat@debian.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nmi.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,6 +119,8 @@ static inline int hardlockup_detector_pe
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
+int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_disable(unsigned int cpu);
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.


