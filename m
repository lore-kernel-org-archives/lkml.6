Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/rh2N7ZaH9SItDA4ktXXFZ3qBRnckJ5x8/ePDfGqagPv9RaXDxtq7MysNNhjDc8DjPC5u6
ARC-Seal: i=1; a=rsa-sha256; t=1522346551; cv=none;
        d=google.com; s=arc-20160816;
        b=AhlmG80BGe/OrjDZkQIbbWoXjAxkAUXOH8vySTOFfAz8uaieazZ2W8GcRzKgvVNL8C
         1GQNwnJ+pMWW3TZv0qVU6U6pbgZ/M+hYUyHjiZyGTdu8ris5e6jJFuML9unG0tXNyj1h
         qlNpWuNxctA9IxOd9TpLJzEQWoeqqqGeamBB3JsIglzlhTBehNMV7zQF3WWCAxrQKfkt
         5lfdQnAn5H7UjJafI21GrEJgxXrBRfRc+508d0RlrdauLHO5/EAVpjpqAcLEB76m/dnu
         Y93xwITknobdy8tOrxL8ehCfm+fcqZm+mfSJU5cesJWVbbm4NyetN/YqU8D/wU7DLpBd
         6oSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HgjbtKV/UBaSzyukzsj27Y+V1C8X63ldn+XFQfJx5nE=;
        b=cjVWqx0QV/IY6W42fy0LJbprH5lvvcAnNVnyU8ltu4mNjWE7bTL8YzxtU4K2iSWgv6
         VM0vZEeUPvEZdTPAhZCBLrz4d0jl9NT5FOGCTf6UdCfKl8mY9o/hSxKyhmbuVn/AYgDA
         Fe3lqVVSbsMBCZvgbHD/sn6TZ5b8tRK+/ZluZyc90FNp4Gqn8fBw8FPgH3RZnnoOUKn6
         rlqque9npl4lk7xvirRLU+oWni5EnxuO6XiKNstotDPAcxzewfy4s/bgJx3ERnG3i/GB
         g11KArI2MU1mpECszLGCOM0D7K0uXCgTVhnIYNwF3NA9/p/1ZDCPOXBMkNAT0oA9TGuw
         ZgZg==
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
Subject: [PATCH 4.15 25/47] net: Fix hlist corruptions in inet_evict_bucket()
Date: Thu, 29 Mar 2018 20:00:06 +0200
Message-Id: <20180329175731.120226973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296057389749858?=
X-GMAIL-MSGID: =?utf-8?q?1596296057389749858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
