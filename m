Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937AD21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129571;
	bh=+4qE49ibkjcEDtFsDK+s5xsPpi3MRURuhSI1cY7hS/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CEcDuQivVtZq9yfcKbMr1XzHV1NginEjDZ59ygq+XGWCGQ6N5YefL5jY7CuKQfbZK
	 6Q9Q5ud7SaDzjsXB5rCXo91duxKJLEKo7uJqz+tgmXY5pl2BLNIjRmbB1hUWxVMVEt
	 f3V/T+B4o5G2XllLto54PqSAs93i57QP35Ic76vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfBYVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbfBYVT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:19:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C56205C9;
        Mon, 25 Feb 2019 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129567;
        bh=+4qE49ibkjcEDtFsDK+s5xsPpi3MRURuhSI1cY7hS/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luv34jMbG1gT+Pj0T4fsMZ3i6HmTbMXWDpzVq9lWp9yEBwp4QWdtp/N++5y+GgbpV
         XkPCIV7WGPKrG9fJZZGl9l8hgbefBS+M2ni0wkb+q8J9MQK5xXIndHnvB/KhnEe9MU
         NAYkcTT4b9dMffOSqNQN46huxlgir5BRoJMVCUEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shile Zhang <shile.zhang@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14 71/71] sched/sysctl: Fix attributes of some extern declarations
Date:   Mon, 25 Feb 2019 22:12:13 +0100
Message-Id: <20190225195040.022531845@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit a9903f04e0a4ea522d959c2f287cdf0ab029e324 upstream.

The definition of sysctl_sched_migration_cost, sysctl_sched_nr_migrate
and sysctl_sched_time_avg includes the attribute const_debug. This
attribute is not part of the extern declaration of these variables in
include/linux/sched/sysctl.h, while it is in kernel/sched/sched.h,
and as a result Clang generates warnings like this:

  kernel/sched/sched.h:1618:33: warning: section attribute is specified on redeclared variable [-Wsection]
  extern const_debug unsigned int sysctl_sched_time_avg;
                                ^
  ./include/linux/sched/sysctl.h:42:21: note: previous declaration is here
  extern unsigned int sysctl_sched_time_avg;

The header only declares the variables when CONFIG_SCHED_DEBUG is defined,
therefore it is not necessary to duplicate the definition of const_debug.
Instead we can use the attribute __read_mostly, which is the expansion of
const_debug when CONFIG_SCHED_DEBUG=y is set.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shile Zhang <shile.zhang@nokia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20171030180816.170850-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/sched/sysctl.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -38,9 +38,9 @@ extern unsigned int sysctl_numa_balancin
 extern unsigned int sysctl_numa_balancing_scan_size;
 
 #ifdef CONFIG_SCHED_DEBUG
-extern unsigned int sysctl_sched_migration_cost;
-extern unsigned int sysctl_sched_nr_migrate;
-extern unsigned int sysctl_sched_time_avg;
+extern __read_mostly unsigned int sysctl_sched_migration_cost;
+extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+extern __read_mostly unsigned int sysctl_sched_time_avg;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,


