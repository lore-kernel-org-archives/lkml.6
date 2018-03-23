Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsFuc6Ryx4/fgR6QDNYyvJ4kBY/2Cz61WoC5eVXpGZsU5VrRs8jFbjl+w+wSjJ+tIN0jbpm
ARC-Seal: i=1; a=rsa-sha256; t=1521800161; cv=none;
        d=google.com; s=arc-20160816;
        b=dIUPJ1I8owVZ0OagPCjqFyycwJIaG6H9JUNNrOXDYyo7oQf0RAabXJIKgJmPPiVcjd
         ER2f7p6HEB1tf2wyojUfV6BgDzKNt86ktT9xm7cCHFmgyExWwzk+oKkOC13t/8S/SRm1
         OrkXoxvyuq94/Uvg2NzKRwkmP0cAKVoLSVTIHxa5eYlaVgSWy9x9q7VCvat4MoGARYSI
         +D+HWvYpntmvQFICGgVviZdWTOXfRrPxPIOArW2mBiUmbsMrltV/JriYPVrc1baxMm7T
         0OquwRq37I+z3tJsOlthKKQK7VlZpWYYwjdJudVeYD0+Q7Zv+ey79wQsJg+/oseb76Ri
         6+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KZ7Yds+f6DDMGiAF8X+lPwMuEkbIgoJsOM4p/uJLXIQ=;
        b=lhZ4//plY2oWy5KM90gb+jLkrFtinQWkNlCd1KZKMBo15icsH7uLdY8EDxIViSWmQm
         liKUezjXDUB71Qg6G1iMDOMDsHVHo+EPyi98DFsLSAVSRCyYRr0jeDY5/iJG5UXVKVHi
         j12HChzsCFR8X2hP+XrMrNMGAXuUodxgKOCbrkpN1V6HdQpk/HMPxCseRqStMfljJx1x
         P1P7w1WXaV/ScriyBPZmhgZfOfmKfa9jmxlIQeDh/uRcXM9NuncVNiZwILlWci3P31Jx
         bR2ALhHzNuWGp7YkYoaYTPXytXmojNxzs3FdXIQlUoNZYohDxCUb3wpmgQ02rUwOcjZa
         9LMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Lippert <rlippert@google.com>,
	Corey Minyard <cminyard@mvista.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 57/97] ipmi/watchdog: fix wdog hang on panic waiting for ipmi response
Date: Fri, 23 Mar 2018 10:54:44 +0100
Message-Id: <20180323094200.838250542@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722653980136364?=
X-GMAIL-MSGID: =?utf-8?q?1595723125768759560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
