Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yYJDG9naTdPHI8JRHoilPBItQr7X5JCaflRUkKWw1n6Vl4r234j+Hclk380gztTrW+D4/
ARC-Seal: i=1; a=rsa-sha256; t=1522346867; cv=none;
        d=google.com; s=arc-20160816;
        b=XDyTTG3fMK93rRHmdJ682GMNORzmb2IKWpBzeKsNJp9rnGs9tvgIs5kLhDEVVHAdKU
         Zn4nGH/ny67gpla21fDjYnt/ATsBBsqqaUrRM/TmJD7FHtPz30QPUtypgJ+vAOggoib8
         pSsyknWhImF4Bk/Nd9Hmtyt3uznFooNw7UGQyFjlahn/iO6BGUsBHYQgfhRv7D2NqMNP
         BUsilgGbmZ1uIBBBDkeUgCvIT0Xyn5W2kIytZ1cR6YkfugSm8dmuYM5IFaUIN9uEYHC8
         7dTh4aa1cRA9eJnPG1fh1P4SpJ/+G/Y4U7/9lCBoppO0oE+kwIQy1+5+ODYERzGz3r0Y
         rh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QQZL4XUHNWLslAJaj+3yY9Ag1+0aTG0d4A+48gZnPoA=;
        b=cL4zHttzsG7OAVnstnTJyfUXFwojDZJbQbABshlprcn4mGdRgJmjx5ekPLfnpFmFeT
         anNbG8CwaEYWPIs1YCjA3kujq0eBFy3JQNA7GWNlorhx/yXDIlpxcXWIx98ZdYhVWrcE
         np1CYa9t9tXnFOxfn6NlycskuM9yFI+w0ocXPzrUkxTMd5SeuQlBcpELfOMUmRrnu0FY
         4SSmJvHCtvfusOtfz4fH3NIPB3BIoBnMg/pRV7tP09MHXBUWD9JhkPtM+qBpRbiYSbYF
         OF8lJpmGLJ//vdy9nd480294KlBW2ZURlNJd/PdMz95jGaJQ10gfqExiQGWghiRk+TA0
         OdOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/20] net: Fix hlist corruptions in inet_evict_bucket()
Date: Thu, 29 Mar 2018 20:00:39 +0200
Message-Id: <20180329175742.027507747@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296057389749858?=
X-GMAIL-MSGID: =?utf-8?q?1596296389401239331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>


[ Upstream commit a560002437d3646dafccecb1bf32d1685112ddda ]

inet_evict_bucket() iterates global list, and
several tasks may call it in parallel. All of
them hash the same fq->list_evictor to different
lists, which leads to list corruption.

This patch makes fq be hashed to expired list
only if this has not been made yet by another
task. Since inet_frag_alloc() allocates fq
using kmem_cache_zalloc(), we may rely on
list_evictor is initially unhashed.

The problem seems to exist before async
pernet_operations, as there was possible to have
exit method to be executed in parallel with
inet_frags::frags_work, so I add two Fixes tags.
This also may go to stable.

Fixes: d1fe19444d82 "inet: frag: don't re-use chainlist for evictor"
Fixes: f84c6821aa54 "net: Convert pernet_subsys, registered from inet_init()"
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -119,6 +119,9 @@ out:
 
 static bool inet_fragq_should_evict(const struct inet_frag_queue *q)
 {
+	if (!hlist_unhashed(&q->list_evictor))
+		return false;
+
 	return q->net->low_thresh == 0 ||
 	       frag_mem_limit(q->net) >= q->net->low_thresh;
 }
