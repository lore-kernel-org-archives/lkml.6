Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD73C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F19E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F19E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeIMUdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbeIMUdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:33:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38C13C02C01F;
        Thu, 13 Sep 2018 15:23:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0006D5C1B4;
        Thu, 13 Sep 2018 15:23:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 13 Sep 2018 17:23:09 +0200 (CEST)
Date:   Thu, 13 Sep 2018 17:23:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] kernel/hung_task.c: disable on suspend
Message-ID: <20180913152307.GA31894@redhat.com>
References: <20180912161119.2692-1-vkuznets@redhat.com>
 <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jeq=PoF10OZgO9ST_nuRW3Z8emPmX=nTrOSsLKYzZuww@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Sep 2018 15:23:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13, Rafael J. Wysocki wrote:
>
> On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > It is possible to observe hung_task complaints when system goes to
> > suspend-to-idle state:
> >
> >  PM: Syncing filesystems ... done.
> >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >  OOM killer disabled.
> >  Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> >  sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >  INFO: task bash:1569 blocked for more than 120 seconds.
> >        Not tainted 4.19.0-rc3_+ #687
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  bash            D    0  1569    604 0x00000000
> >  Call Trace:
> >   ? __schedule+0x1fe/0x7e0
> >   schedule+0x28/0x80
> >   suspend_devices_and_enter+0x4ac/0x750
> >   pm_suspend+0x2c0/0x310
>
> This actually is a good catch, but the problem is related to what
> happens to the monotonic clock during suspend to idle.
>
> The clock issue needs to be addressed anyway IMO and then this problem
> will go away automatically.

I don't understand your discussion with Vitaly, but shouldn't we make
khungtaskd thread freezable anyway?

Oleg.

--- x/kernel/hung_task.c
+++ x/kernel/hung_task.c
@@ -185,7 +185,7 @@ static void check_hung_uninterruptible_t
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
-		if (!max_count--)
+		if (!max_count-- || freezing(current))
 			goto unlock;
 		if (!--batch_count) {
 			batch_count = HUNG_TASK_BATCHING;
@@ -249,6 +249,7 @@ static int watchdog(void *dummy)
 {
 	unsigned long hung_last_checked = jiffies;
 
+	set_freezable();
 	set_user_nice(current, 0);
 
 	for ( ; ; ) {
@@ -266,7 +267,7 @@ static int watchdog(void *dummy)
 			hung_last_checked = jiffies;
 			continue;
 		}
-		schedule_timeout_interruptible(t);
+		freezable_schedule_timeout_interruptible(t);
 	}
 
 	return 0;

