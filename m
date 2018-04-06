Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EXcuD+vhQOJOHtSmmbSiEBXnw/VcPZm7fnFPGC2uwAStth0VHZSsG1hT8AnvjwgU9tL3z
ARC-Seal: i=1; a=rsa-sha256; t=1523021909; cv=none;
        d=google.com; s=arc-20160816;
        b=P85jU+a9rAsTqCX4FLky5pTzrgJEa8nwOLOv+rc9Lb0DSGRfiuLKfCxtXqNb958Tsc
         Y56yIg1jjTLisA0vE7vwMdoBYyYprPrONzV34C/lshhfDrbxESlAToIib2y98RQFw3al
         ww78Twx3AsoIDgW+1CpuavRNhhTnfiH7izNsCf6R8WlYTaXfKm/CUktCRVNl/cc0W9H2
         7PcGaKWXoS/B7Yiw5wEElZGDnz5kbA28SAYW3iRzJhy80YKTQhzTCrRqeNlG9PE2gqzQ
         WiZY/Wrio1DTOitJr0dVE3ZMrafZW48ny+bSQ9IV1GieZugsBNY3jo94gvfI1yCssBqr
         /ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oOC6WEuBus3gtfHar1njFnKUtdhkgOxjRerNVlt0OGg=;
        b=Y7L+l3NsSasyKZwGA384jbvcuCRkRFxbYb0FnZjBEsip0cQ6vWJXC1TxyY1qTpCQSR
         IFEh0HZUsnt1E7b6U9rL7rVuywAOLW9imoiyn60p7kxQLiCkZq9Z62wT2PPnwlal2Nq2
         A1ir+G1IHwY+ifVkEfY1YJLziQuOn5tlI6HYaJ+xRurNnJ8Lq+3KYzH8Bj/VPYs1xXou
         CAUjOQloIt1s6LYqB1A7g+THzt8vvLIePSyAu+lRjWQUeFMDiTAKcMLBghi4vniAF2MU
         Nx9VbBP9KpYuj/CJ2d/cquYLiZ+LZASccEjkJhb+48Om03oodGgmLVMYYdPaSfiMedJg
         fE5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Florian Westphal <fw@strlen.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 29/67] netfilter: x_tables: make allocation less aggressive
Date: Fri,  6 Apr 2018 15:23:59 +0200
Message-Id: <20180406084345.147965221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004221950095682?=
X-GMAIL-MSGID: =?utf-8?q?1597004221950095682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@kernel.org>

commit 0537250fdc6c876ed4cbbe874c739aebef493ee2 upstream.

syzbot has noticed that xt_alloc_table_info can allocate a lot of memory.
This is an admin only interface but an admin in a namespace is sufficient
as well.  eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc() in
xt_alloc_table_info()") has changed the opencoded kmalloc->vmalloc
fallback into kvmalloc.  It has dropped __GFP_NORETRY on the way because
vmalloc has simply never fully supported __GFP_NORETRY semantic.  This is
still the case because e.g.  page tables backing the vmalloc area are
hardcoded GFP_KERNEL.

Revert back to __GFP_NORETRY as a poors man defence against excessively
large allocation request here.  We will not rule out the OOM killer
completely but __GFP_NORETRY should at least stop the large request in
most cases.

[akpm@linux-foundation.org: coding-style fixes]
Fixes: eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc() in xt_alloc_tableLink: http://lkml.kernel.org/r/20180130140104.GE21609@dhcp22.suse.cz
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1008,7 +1008,12 @@ struct xt_table_info *xt_alloc_table_inf
 	if ((size >> PAGE_SHIFT) + 2 > totalram_pages)
 		return NULL;
 
-	info = kvmalloc(sz, GFP_KERNEL);
+	/* __GFP_NORETRY is not fully supported by kvmalloc but it should
+	 * work reasonably well if sz is too large and bail out rather
+	 * than shoot all processes down before realizing there is nothing
+	 * more to reclaim.
+	 */
+	info = kvmalloc(sz, GFP_KERNEL | __GFP_NORETRY);
 	if (!info)
 		return NULL;
 
