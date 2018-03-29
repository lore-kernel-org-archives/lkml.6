Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49luohuMUANSCliDJiVNQVjTVc38CJ01QMF/H58nhgRX5alyO1evEC3GJXcbbpYMGmZD+WF
ARC-Seal: i=1; a=rsa-sha256; t=1522346704; cv=none;
        d=google.com; s=arc-20160816;
        b=CbTX1PYJWJU3RM8+rGJMGVqMb3M9WmLO4iv+5fer6MocpY4mBuhvzTovZJmOqCDFTI
         awlZDjWbVmCo0sBTWye2H/T8S5ZUtmirz1nSUjjCW2/IYQIE4Vo4OWpvj3UfJrvEgZSr
         mXbjMLMm+Du4EyftatcbkhKNqngoLJU/dz8A0A6DQqMl1ikkHHvOguSGtL2j9vX9ZnOa
         tKRPyIwPcAV3r9QPwXgNik5hhtBruoJ+b8KZejFWSYTsnYvxhuQK1ppMGgztb/T6e7Kl
         zBmWm2fnZZKVYQALk7yM8FH4hyRwWq9zHskBq5/QkNOF35dl2eAgDPo6uvW5NqqFPi7B
         156g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IG8HK9JD9vw/X1orCcOh3EbuP5rqPsRdWLyAfeFNHd4=;
        b=omMTD9zuxANK5h/7JKJIw0w4EJow+vLABQtV7xu/pjQw1R/uiTEJRDRTIlFRGHDyZx
         xrLcA6gFluaEKn8CWE7o081DOE00bzd2PPPoY+y2mEnqYU4lIswKxuHSO3U2ezSxAjsG
         d2aMsFo7c1W6KOw5Frsb3hvCvQsmhIyGc/jdl/fAQKlWHfOhQdMiN5CDK8GyjPK85AQe
         JCVAZ85R9YT0IYOjUd9ueS5/Al3U/bEeop3rMNXxoNRYvSmHOIC/IP7gJthaEHHykahj
         1fxdcfy/bZC9fNTQv5ciqD1we5fQZ1Q8HA+yE4d1kbLCZ4yVDULRpIXffJkkWZG6m7P4
         c5oQ==
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
Subject: [PATCH 4.14 21/43] net: Fix hlist corruptions in inet_evict_bucket()
Date: Thu, 29 Mar 2018 20:00:16 +0200
Message-Id: <20180329175732.339446788@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296057389749858?=
X-GMAIL-MSGID: =?utf-8?q?1596296217789450355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
