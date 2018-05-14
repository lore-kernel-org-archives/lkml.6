Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqiaanNBvWHFpeITBFoZuhR/hKY6eJlU59fefIfOIC2os8s2vFgvXLZaBpuEJEfL/9Zlvfi
ARC-Seal: i=1; a=rsa-sha256; t=1526282277; cv=none;
        d=google.com; s=arc-20160816;
        b=wAvCnqxV3/F0RiMGmUEk+MkupAuzPZgr0kX52MB7KgAr3SzMr51ranjXZOMtS/zscY
         fPkut50zoti4XFqRKmLaPOkUkWsR9xIgHq4WIVk3Zh5iM4AX0nR3ToQGpR1sgQLCSewi
         MjxsQhL1z6v1qLjGw7q0nRcR0z3fa7fgBzzPhuOazvnvLNouF0QG09eSSGVI9lTJfcDw
         9hOVX0ZcvkhGdJiW59nIJNjSO516sTbFa2iK6pQVVVzXDJLziRh1cImxkFFmH79BTQUe
         2lN7IcTcUDHyeak39reVS5nGoy96yCtVjivv2CKkndalPx2/sk+7Nigc/jCnlpyjjSGN
         6YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tNOQp0bbxzoxSSRoNYvADxoVkm/bWb1b1p5MToOhC9I=;
        b=RZtiCrbIduKnV57wI7JFvgTZ8sJxZ7q8fmaH/6DdBOeXagwN9Ae5DoZXaJK/7G/uxN
         y/HFE2ryM+v/VZOt4g6cHtdryjrJ1GhRk36YeCkJbQM+m8nQarLZ9CiNbRLNEvK5ZnoE
         HfRpQ4fU2Ux/QX3iGF9w1e7tU/ElwZ5zxRo9B9P7FS1XVGtkl/N9R4gMRzS7xFlYekZj
         uc13BsFee35KGpnWLN9xZQ+kpTuiVWmInOGSEEFJfqOJhc+KgzoMvNMmgc1/qDQdHJPB
         OYL6dvkOIMZszErzpMZFGwu7KHD30QSSk++HNnQ7PO8K0pfiWbIFeXfBUPa3xGaZvXx5
         wdqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1D/v/poS;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1D/v/poS;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 54/62] sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
Date: Mon, 14 May 2018 08:49:10 +0200
Message-Id: <20180514064819.484188159@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422964745996071?=
X-GMAIL-MSGID: =?utf-8?q?1600422964745996071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 354d7793070611b4df5a79fbb0f12752d0ed0cc5 upstream.

> kernel/sched/autogroup.c:230 proc_sched_autogroup_set_nice() warn: potential spectre issue 'sched_prio_to_weight'

Userspace controls @nice, sanitize the array index.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/autogroup.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -7,6 +7,7 @@
 #include <linux/utsname.h>
 #include <linux/security.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 
 unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
@@ -213,7 +214,7 @@ int proc_sched_autogroup_set_nice(struct
 	static unsigned long next = INITIAL_JIFFIES;
 	struct autogroup *ag;
 	unsigned long shares;
-	int err;
+	int err, idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -EINVAL;
@@ -231,7 +232,9 @@ int proc_sched_autogroup_set_nice(struct
 
 	next = HZ / 10 + jiffies;
 	ag = autogroup_task_get(p);
-	shares = scale_load(sched_prio_to_weight[nice + 20]);
+
+	idx = array_index_nospec(nice + 20, 40);
+	shares = scale_load(sched_prio_to_weight[idx]);
 
 	down_write(&ag->lock);
 	err = sched_group_set_shares(ag->tg, shares);
