Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493ymnoZKZvUVcwL9U2J0VtTZzw9BtMYfMc8cBNwCJMPND+i2/M+kezoHOtyw/eHWcKEkry
ARC-Seal: i=1; a=rsa-sha256; t=1523399761; cv=none;
        d=google.com; s=arc-20160816;
        b=ATytVXKPUz3cXEq0zedCNoIZ84qVHN7n0pQoQkYP0isvCQBAVfNkuWGWtR5z2cbuyq
         QRb7V3ZIE07ihzf2BPi4AcmuXC2J8NT+6Ihvu/soYusH3jN0mX0CLiZmYE7nlh+ZdMa+
         jcNF5DvpMjDnRzs2pJdb+OBjg/3IjixHuPmvcI6ICW9dkpkwJCgNiYxHGNveeuGB7ISv
         ii4p0+DvLuLBWKyj9saze8f4FSfg0y7s6fFVii8lO34Ib41e6d1zspv+bW/a1NWzZ/mO
         5Z9gPLDInUTW+XxLvk41fn8JUTfG12sAJIhUEu3WmJUvFhUgcDABub655iZF+GcVqG+e
         bLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gw2lFcRBsIJJI2e71x+z54D4zNLNMlfzlHy+ns8owM0=;
        b=0I0n0VwaPhBIliq/isLBBj9Vwvg4LtRvqqjb4hlpvMSdlarJ4eoHuWp0EPPGHvaWJ8
         5Trcw8qMXVEth2vJAyT62Ym+S8AORztp9GSvMTciCHPtyE8BovguYDjkD1eDQ7ULf+p8
         kHvhNYl9Kqyux1r4DqLS1iW0kUbS2RB6inAjUGAsQwvFQWU6SWG+sk6I1CjcnPZLswpf
         4dGxmDH7ri4pg6c3q9xPVtZhB2SbRB6AczXzFfqRl67o2ZK+vZABG87TaFVG08g/7lvp
         /ZralTzTzePRTob5yWyNEt9azXR8/U+Q8ltTpEVazv43Zgu2oC7PCvZZ0ZxrrYLlHxwd
         56Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 047/138] staging: lustre: disable preempt while sampling processor id.
Date: Wed, 11 Apr 2018 00:23:57 +0200
Message-Id: <20180410212907.554789447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399958975311347?=
X-GMAIL-MSGID: =?utf-8?q?1597400428705679432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>


[ Upstream commit dbeccabf5294e80f7cc9ee566746c42211bed736 ]

Calling smp_processor_id() without disabling preemption
triggers a warning (if CONFIG_DEBUG_PREEMPT).
I think the result of cfs_cpt_current() is only used as a hint for
load balancing, rather than as a precise and stable indicator of
the current CPU.  So it doesn't need to be called with
preemption disabled.

So disable preemption inside cfs_cpt_current() to silence the warning.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -528,19 +528,20 @@ EXPORT_SYMBOL(cfs_cpt_spread_node);
 int
 cfs_cpt_current(struct cfs_cpt_table *cptab, int remap)
 {
-	int cpu = smp_processor_id();
-	int cpt = cptab->ctb_cpu2cpt[cpu];
+	int cpu;
+	int cpt;
 
-	if (cpt < 0) {
-		if (!remap)
-			return cpt;
+	preempt_disable();
+	cpu = smp_processor_id();
+	cpt = cptab->ctb_cpu2cpt[cpu];
 
+	if (cpt < 0 && remap) {
 		/* don't return negative value for safety of upper layer,
 		 * instead we shadow the unknown cpu to a valid partition ID
 		 */
 		cpt = cpu % cptab->ctb_nparts;
 	}
-
+	preempt_enable();
 	return cpt;
 }
 EXPORT_SYMBOL(cfs_cpt_current);
