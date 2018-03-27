Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JmDFVP08GBKg2GsxWS1zkzUgoRo84dwUsCENwj30GUD57V2tKlJsT9MjlNLYktbWHxpt6
ARC-Seal: i=1; a=rsa-sha256; t=1522168916; cv=none;
        d=google.com; s=arc-20160816;
        b=EltpLEGb09esjpsyJfD+RhEm8XD425Hd0xmHi80nq8KmomADiPjgwM4FDCZ/SemRc4
         zg5MzpcN+/Vf1L0HDckEcpC7nJQ25zoOmkbnhaGDx8wTd5LQlBVrgq7d5/2ntufG02+j
         1/4aH7meXfBBKCz9F8O/I3zl9TmGrZScqWx5R2SbLZf2qJ3EBEXy9D5FEr5APEcTc93k
         KO7tqfJ0ZkRQsxDLcwer2DK4+mjPHZeDukP8J+4AxUSJLIthPxdOxyJ6PQe781GWWuzg
         SQ2mCRoDafe5LIjr/xpYZWoib3FAc/b+h+JDD0ZsIvZgeNvhAvwB6yHX5j7pLET2Q+Fa
         1V5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XUP0Igxd/zufXR1IeJ8uT3OJcJsLePJsznDzH2JkcM4=;
        b=G2B+XgrbT471WoRg31s/zrngPYQ1KkCLTLHNotfGDh0CsE/wIDTO7wpjwZK2VtBIzb
         N+2glufH8gwUjc8wd9nveFfZluHw6CqaG2njtk9vQlodEXwaC28bZg8indN1V6MeX2AA
         LUeCB2iRGp0LcmaJGEbZVDzD/VcPbIG6TCfCwQu+Y3SPrj4xiSWMRPhUkPdmlL0/nvus
         oCT60h37HC92EPhQtOWgmJvL8yUpxq6TgWUvt2nUdGWPDuzCCmDO6lwxg+Ez8UCVrQje
         0tgmyeyWOl1FS+GioH/FAhvU8tqrqWOoJWX1SDVG7sByPAfy2CagXVbQCjWVSzBmt+La
         3PQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4.15 043/105] sched, cgroup: Dont reject lower cpu.max on ancestors
Date: Tue, 27 Mar 2018 18:27:23 +0200
Message-Id: <20180327162759.897978919@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109794296369871?=
X-GMAIL-MSGID: =?utf-8?q?1596109794296369871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit c53593e5cb693d59d9e8b64fb3a79436bf99c3b3 upstream.

While adding cgroup2 interface for the cpu controller, 0d5936344f30
("sched: Implement interface for cgroup unified hierarchy") forgot to
update input validation and left it to reject cpu.max config if any
descendant has set a higher value.

cgroup2 officially supports delegation and a descendant must not be
able to restrict what its ancestors can configure.  For absolute
limits such as cpu.max and memory.max, this means that the config at
each level should only act as the upper limit at that level and
shouldn't interfere with what other cgroups can configure.

This patch updates config validation on cgroup2 so that the cpu
controller follows the same convention.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6611,13 +6611,18 @@ static int tg_cfs_schedulable_down(struc
 		parent_quota = parent_b->hierarchical_quota;
 
 		/*
-		 * Ensure max(child_quota) <= parent_quota, inherit when no
+		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
+		 * always take the min.  On cgroup1, only inherit when no
 		 * limit is set:
 		 */
-		if (quota == RUNTIME_INF)
-			quota = parent_quota;
-		else if (parent_quota != RUNTIME_INF && quota > parent_quota)
-			return -EINVAL;
+		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
+			quota = min(quota, parent_quota);
+		} else {
+			if (quota == RUNTIME_INF)
+				quota = parent_quota;
+			else if (parent_quota != RUNTIME_INF && quota > parent_quota)
+				return -EINVAL;
+		}
 	}
 	cfs_b->hierarchical_quota = quota;
 
