Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+/Lzvtd/g0VE0Mzx/VX1Q5+mVmeWAK2+GjuOovBwF+ppUvDyhgRRuTcGTl9YA/z+4ARJ/Q
ARC-Seal: i=1; a=rsa-sha256; t=1523399313; cv=none;
        d=google.com; s=arc-20160816;
        b=ld1VEz563w3LG6KISytDajT3LpRSh4toXD1nSUmeiBs3UAHiwnxtHAAxdgxnkCxM3w
         LxvdnkuSZzFM/eTtCF1MQ0cTPmMfJ9SXGxUQQMgQGv9xSLYV1M+CGhxnywmeXr0K+tZ+
         tDv4z8mrwwOZRE9+KwL6G67WQD2w7FNCgaptAO4WjhdJTJjTTZfgEHGGm87MG1gmG5EM
         SC6XVp3H/IP/yIH5YRzTiWLQkKJYV0BUrj8OoGUaNMSNWh7ZuqTI+FGPJ6lr/9M80Ccd
         MePIjIYhoQawOwIqczHuiOkAV2yrK9ji7Do4M18eQ+zKthUvJwRajwXXHNior/BEk9Bs
         8ReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xwEmrKlBDt2erKy8LrWsxg8SWRru9+jwE5lf79E5II8=;
        b=mQAOMe5235qDqh0c6IH51oO0uOZ6tqF8drWZXgMT47HVWgnnFA6ufIKE/zAXBfr2BC
         MH+VaXYSmhMvKAO+S6Dfoxq8YuMK/XvJvnyUtIjdP6dP3U6C4nZ7mv/RvuJKLfFVFS7n
         FbzyzZDA46o3mMoE6HWIckMAvmidSrIUDv3KZFUlWYZbcwFIWlUUW+16yBo2eHZVROEO
         o+Aen97+kLuJEizWf/8mw9Je5MgoqKucotgN3i58U9kyalExjHaGzcMitKB08j+6Qg2/
         KTxwIFeaPMAmkDg540eEOvb9DzsktTYkaSspBjkVYTHOzEMQduZ7n4BnddpG5M/7nHo4
         zzcQ==
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
Subject: [PATCH 4.15 062/168] staging: lustre: disable preempt while sampling processor id.
Date: Wed, 11 Apr 2018 00:23:24 +0200
Message-Id: <20180410212802.839699613@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399958975311347?=
X-GMAIL-MSGID: =?utf-8?q?1597399958975311347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -529,19 +529,20 @@ EXPORT_SYMBOL(cfs_cpt_spread_node);
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
