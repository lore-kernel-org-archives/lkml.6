Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D37ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1BA20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1BA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeGSXPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:15:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbeGSXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:15:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMTlp62439267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:29:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMTkWk2439264;
        Thu, 19 Jul 2018 15:29:46 -0700
Date:   Thu, 19 Jul 2018 15:29:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-4b1b7f8054896cee25669f6cea7cb6dd17f508f7@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: pasha.tatashin@oracle.com, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180719205545.16512-17-pasha.tatashin@oracle.com>
References: <20180719205545.16512-17-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] timekeeping: Default boot time offset to
 local_clock()
Git-Commit-ID: 4b1b7f8054896cee25669f6cea7cb6dd17f508f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4b1b7f8054896cee25669f6cea7cb6dd17f508f7
Gitweb:     https://git.kernel.org/tip/4b1b7f8054896cee25669f6cea7cb6dd17f508f7
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:35 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:41 +0200

timekeeping: Default boot time offset to local_clock()

read_persistent_wall_and_boot_offset() is called during boot to read
both the persistent clock and also return the offset between the boot time
and the value of persistent clock.

Change the default boot_offset from zero to local_clock() so architectures,
that do not have a dedicated boot_clock but have early sched_clock(), such
as SPARCv9, x86, and possibly more will benefit from this change by getting
a better and more consistent estimate of the boot time without need for an
arch specific implementation.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-17-pasha.tatashin@oracle.com

---
 kernel/time/timekeeping.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cb738f825c12..30d7f64ffc87 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1503,14 +1503,17 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
  * Weak dummy function for arches that do not yet support it.
  * wall_time	- current time as returned by persistent clock
  * boot_offset	- offset that is defined as wall_time - boot_time
- *		  default to 0.
+ * The default function calculates offset based on the current value of
+ * local_clock(). This way architectures that support sched_clock() but don't
+ * support dedicated boot time clock will provide the best estimate of the
+ * boot time.
  */
 void __weak __init
 read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 				     struct timespec64 *boot_offset)
 {
 	read_persistent_clock64(wall_time);
-	*boot_offset = (struct timespec64){0};
+	*boot_offset = ns_to_timespec64(local_clock());
 }
 
 /* Flag for if timekeeping_resume() has injected sleeptime */
