Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804075-2-14608862695408512624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804074; b=Yx/NbOwln3lShKbR6GDzUwt86DdOsGRaNkhsFo/D8Kt1zfs
    Tng7u4JeIyR0+Lx23UyqxzjUhoHk48vRneD7b1BfNRHmOt5xoOHeOEqw+YcPu7Jk
    xI+iTZXniYCDeQld7zBf1g7S+9GFo8k3mA25GoHLB+QZBA+g3Xisks/llBZf4UPU
    JkVdRdYXIQv0Hhmdi3ccdqJ3C4ahIAn/6okoUj2G1/YrA6HiMxGf7IWxyTIDFP7R
    GXFoszDDUjB451T7ulujTkyAi1wq/7dTeIs3ziXjO1vipWv1bwy9lYjPs9US7WN5
    5BKMJfoNfKXWd4qynskUrRN4XAGtfHlnVgDDs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804074; bh=UcMJnIoj6YeQch52MNDyIpAVQb
    FvKwTgcPqKUbuiWJI=; b=DFJEe8+9JjxJl5B4mbawhtyOAG885tL/RiLLpfcw0y
    eg+JdMs81Ktvvw1WYHFoatFW0MUkb9e80ltEQY02SU8gx6GP7BygjvANG9jtRLsQ
    B8DBPFpI+RRbXF287BcC5HaoQXdb94rN1/Ydsj7VMqJ6sbpn9hw4AjkJSyRFMBP6
    st1koWqtLBodlelt67P8b0qu8CaSIf+S970DPNTVt6mfQHaGfCBgzip373mUzaPr
    6yQzQAvQeGtzjmdR/OEPVqDd9DEkDTCiaDJWvXvQdZipsBSBktvvjXgUDay7bgN5
    BaE4IzxfMFs1WtwEMMWhBJdqOWiUZFnigCqO1f4oZjgQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbeCWKId (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbeCWKIa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Lippert <rlippert@google.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/177] ipmi/watchdog: fix wdog hang on panic waiting for ipmi response
Date: Fri, 23 Mar 2018 10:53:46 +0100
Message-Id: <20180323094209.608400602@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Lippert <roblip@gmail.com>


[ Upstream commit 2c1175c2e8e5487233cabde358a19577562ac83e ]

Commit c49c097610fe ("ipmi: Don't call receive handler in the
panic context") means that the panic_recv_free is not called during a
panic and the atomic count does not drop to 0.

Fix this by only expecting one decrement of the atomic variable
which comes from panic_smi_free.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_watchdog.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -515,7 +515,7 @@ static void panic_halt_ipmi_heartbeat(vo
 	msg.cmd = IPMI_WDOG_RESET_TIMER;
 	msg.data = NULL;
 	msg.data_len = 0;
-	atomic_add(2, &panic_done_count);
+	atomic_add(1, &panic_done_count);
 	rv = ipmi_request_supply_msgs(watchdog_user,
 				      (struct ipmi_addr *) &addr,
 				      0,
@@ -525,7 +525,7 @@ static void panic_halt_ipmi_heartbeat(vo
 				      &panic_halt_heartbeat_recv_msg,
 				      1);
 	if (rv)
-		atomic_sub(2, &panic_done_count);
+		atomic_sub(1, &panic_done_count);
 }
 
 static struct ipmi_smi_msg panic_halt_smi_msg = {
@@ -549,12 +549,12 @@ static void panic_halt_ipmi_set_timeout(
 	/* Wait for the messages to be free. */
 	while (atomic_read(&panic_done_count) != 0)
 		ipmi_poll_interface(watchdog_user);
-	atomic_add(2, &panic_done_count);
+	atomic_add(1, &panic_done_count);
 	rv = i_ipmi_set_timeout(&panic_halt_smi_msg,
 				&panic_halt_recv_msg,
 				&send_heartbeat_now);
 	if (rv) {
-		atomic_sub(2, &panic_done_count);
+		atomic_sub(1, &panic_done_count);
 		printk(KERN_WARNING PFX
 		       "Unable to extend the watchdog timeout.");
 	} else {
