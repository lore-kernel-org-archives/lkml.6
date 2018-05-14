Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoCefw+lPqr6ASdARBLHg9H+w5iy6Ms0i/AWXn7znNxVd3aX0/5gt8cT7s66X1isJ3x1tdd
ARC-Seal: i=1; a=rsa-sha256; t=1526281094; cv=none;
        d=google.com; s=arc-20160816;
        b=04IHdrHdkhtimDaiP2OF0SqE6qWlm6JxUtwU9DFiN7ac1fl9n53+ekqyIYNtwTWdyo
         jVnvEP1E5Cy3hqWu539nt8n/hP3HJP8jn8BOK6o7XWh4ZiQsjWTaQb3P0J8S4wwcbSH7
         k4kMe6vb0e2sB7R+7B7k/L5SKxmuxsEncg0ND5X2qEaPK69dVanSvLWHA+0wnA7zvuCA
         mIA9EETCTfIOlwwLAAn6Ak+ISaIljP9NPJQHEB36WXYhfFXruIPPYMyfuncKpx8QLBAt
         ROMzQvwQan8DAlhhRQl2AuqSZRldjfJEhe+vYXmVAkrEfQeXIq7TIR1GsIDWe6ejyHBX
         UI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ypq26hywklYOHEPLo9TGcGHNHSRJbuGPfoqm5FShIHA=;
        b=xj354pZS0yZeJi0ivWk7xHtghyY0P3IfPEV9Y5Oz3ip8YhM/mtt9UW4EbdR31is6T3
         CmvARhRsa13r2TRR4bLlnSUF+OH+sY2+SRs+ZNTD0K+bupoa7pVni3lDXjgWKvyYTpnB
         mWmobnSQlzC4z5yEV11pgKpLnSN1KPI9BGlkMZuRIUYIUdrNPLRi7BBXj3LtUvzFRQ8i
         mIwRnGh4oWzxiMHW19f/ga4T03LMzvv8NQ257G05m6lbFO8ObvQ82p4WzGyr1sJINjo7
         T5SVvT3X4vzgckoweJPw4qmToSw8i28YXnQ1X3NP3z+9+S5vh6WSKcMiotQgqzbL7GXv
         e6lA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sLeHa8rD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sLeHa8rD;
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
Subject: [PATCH 4.16 16/72] memcg: fix per_node_info cleanup
Date: Mon, 14 May 2018 08:48:33 +0200
Message-Id: <20180514064823.726404952@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421541789119667?=
X-GMAIL-MSGID: =?utf-8?q?1600421724593199600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4108,6 +4108,9 @@ static void free_mem_cgroup_per_node_inf
 {
 	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
+	if (!pn)
+		return;
+
 	free_percpu(pn->lruvec_stat_cpu);
 	kfree(pn);
 }
