Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488pAeFywEBz3zVcOjonUh4taUjOlDEBiIMZlxxucuTWuaG7yJmTNhwaUVpZO3nWCPaG0z3
ARC-Seal: i=1; a=rsa-sha256; t=1523022113; cv=none;
        d=google.com; s=arc-20160816;
        b=EkchW3bI8a4j/v2UXnhR6OqPSGe9QmZ8WAy/jaCXh2zIAUIjiGkbFBa2+RPuTSVuGj
         Pd+rzg+O036e53hz40MDO+JtcoBEXwmCPKYd4QUdKuBuDyQxQElydqEOj5VfF/1ZpQKM
         +nSADflSsZYMEGdCqxLIAXLZahau/irABjOwz0qCXP3MRWbmQKlBANjZVDxB/xtTOZpT
         R7tVGtdVl06rn3j3pEHy+uWON7+EET958S/FvfHdQwM0WO+NxRpqmn3/c+4vKDDoanjH
         W9t0q98NE3vRJYCWsDNePrdmB2Jbua+fPConKA/TtRrKzd4CxmSMPPlVtaK7bHkC2/R4
         kywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xLMXAwnc+FfHhvxShpU/FBWyAIJuoga6REeqBwjf48M=;
        b=Gj1NwIIjfd4gNOb8DSuxMrMSetQdv9FOwWcvWvl2XKZYG530QEeaCTO3E4v6kKLZGO
         zHwK952Xihnme1O1NapRl9sMLixxY2SpNnODysWbDrgxVYD1hc3ZewdQnAt6WedD559T
         pGSV8b9+PuDIetcwWa8TRV7oDxbN1gIR+ajDkkA9Yc+WLitsPfOVqygLWy9ss3sgNbXs
         Qp26BNIe1jdHbQ+w6A1Tdv+4tA070Uz0bC/OKdrVIx3n5EnBL0PqlqwPl1XawAYvw4Fn
         KPoSbCzpJtoDP/SM10jFZR1b/7tb/sVtADqOL/KNXQD+sUFucDaZf+YnmQPojJh7Rb1s
         JYQg==
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
Subject: [PATCH 4.15 32/72] netfilter: x_tables: make allocation less aggressive
Date: Fri,  6 Apr 2018 15:24:07 +0200
Message-Id: <20180406084352.045366378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004221950095682?=
X-GMAIL-MSGID: =?utf-8?q?1597004435191399767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
