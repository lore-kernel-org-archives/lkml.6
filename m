Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpxeujD+xoAJpCbtS4svruSLwSQX4uZw8SNtmqVR0egdlfeF9ZHxwGWsvQ+YkZRVy7UfJgP
ARC-Seal: i=1; a=rsa-sha256; t=1526280919; cv=none;
        d=google.com; s=arc-20160816;
        b=M+p4Hv8wGHo5PvVnhtRk4Ox9y+3PvkMmETFZk1nEH0hHcHcbBdFiFlwJUUPwm7a90P
         XkNhEK0EqGt5tSN7AxWcPmy/gUvciNV+E4HrX1ZVNNygMc6C7DENwPVjxstKJnQVOYtl
         u95xy/keMwUXmPePyjpzhlQ5jPvOTXxgBPsU5LwGa0Zzj9Kpa9+nOy8+7IELJvEfl/ui
         s0ZmFYyUQybViUqXrY7wf6iX3nf7KGO3Ql3vtUd4zZkfEDCMHg/jB37BugRGN22icSGp
         Txr0T+YRPaniZpNsojoPP8V4m8L5p9O8zm+Pw1rYMGyNTXAOlkxM0W/RHQGUu5M3gX/L
         c3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=00litIDzdeMrQ250zR44GIjETWFZ7k/UVh+wW6au5mE=;
        b=dPlB4nDmlomHxMUV63yxgq210UR2K6lsjd5ALFCEcyJr7Gcx0oVZryqIPmvUkIjsAk
         hUeFy9WD2BTj2W1WuV1mcUoMK6ZZGvwfm6BseXzsla8sTaxJa4tlF4Hdd1rV2x02ihR4
         evvL85aDLGSn/pN+Dmea6YoysuNnyrzdq/1QIAWIEmpGbExmx2X3fMptAibeJxqXNV9D
         rOdI944G5OpazkHU5qyPYnz6W6e6HsOiknqL3o3y7vadazCimzOQXYVk4IKUgJmisT9K
         qiPGuhRkaxNKfJVQzz70FNcbUF1IqoLLf6koZG3OvtFKvMXHRrT/Qdpqrchd/5rbqntX
         QuZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pNWBbA4P;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pNWBbA4P;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+8a5de3cce7cdc70e9ebe@syzkaller.appspotmail.com,
	Michal Hocko <mhocko@suse.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 13/62] memcg: fix per_node_info cleanup
Date: Mon, 14 May 2018 08:48:29 +0200
Message-Id: <20180514064817.154335104@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421541789119667?=
X-GMAIL-MSGID: =?utf-8?q?1600421541789119667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 4eaf431f6f71bbed40a4c733ffe93a7e8cedf9d9 upstream.

syzbot has triggered a NULL ptr dereference when allocation fault
injection enforces a failure and alloc_mem_cgroup_per_node_info
initializes memcg->nodeinfo only half way through.

But __mem_cgroup_free still tries to free all per-node data and
dereferences pn->lruvec_stat_cpu unconditioanlly even if the specific
per-node data hasn't been initialized.

The bug is quite unlikely to hit because small allocations do not fail
and we would need quite some numa nodes to make struct
mem_cgroup_per_node large enough to cross the costly order.

Link: http://lkml.kernel.org/r/20180406100906.17790-1-mhocko@kernel.org
Reported-by: syzbot+8a5de3cce7cdc70e9ebe@syzkaller.appspotmail.com
Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memcontrol.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4187,6 +4187,9 @@ static void free_mem_cgroup_per_node_inf
 {
 	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
+	if (!pn)
+		return;
+
 	free_percpu(pn->lruvec_stat);
 	kfree(pn);
 }
