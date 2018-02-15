Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226hxQs/sIKeX31U+i9LycrsA1g3nqI3MTFbmv4w7uimQZJjushz290XtnWCcwZiQWmBc87D
ARC-Seal: i=1; a=rsa-sha256; t=1518707918; cv=none;
        d=google.com; s=arc-20160816;
        b=mGRTJomFoi4GnxcO8jsR6+GsVgGn89n+oWOJb6hlA1UcmmxAHhyU9xwhcVf1cbnFsV
         IAZJ7ngi6DRhg1p4ts82jmdiaKHLSMLdTEfS2Vn8xedMB/+6EvOE5BF/6Qa7X2upqnTT
         0CJI84ObYmN+TCwwo+pCki9+/N3wsg++b9MBK0CiusS2Qy0TBC4mntbQJhWK6zVm/MVd
         h/n1+5mBppUpv6DybfwlHsYEZFjUi+Vyetxm+mePpeM0tRrsSE2AH1RFJfiqR2JuY7Vi
         H0FDuDSbZacAcphiDX5R913+eidKzYI1rDZYGT6Z4JLQVD9tDTotWkdwXy81GyN5uVdY
         Qsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A5qRu5O4XdLKAtLThe4keXjZHlOX9tznKgLQ2HWSaso=;
        b=CFI3VKb3J1ZyYI8NOMHRm+x3sUkkOZdCs1JWyGwNfJZHnBFczlaGAWTZso0fQjBOtp
         Drwp24SzUmTOASeWOMUFrSGIXJqTSooFE8HvbRqVLcsW0405KztW76JPvVUw69mALG1h
         6U8vZ3hgi7hGLTnJU3HsAudjbnCA2EHtgePBdEtXGcByxZNenba2AhhzSaX5oEslZX36
         iof7jWAL8q6iL54QapdVm9x3p+vdv4WoCrE83p/8TpNkgz8JgQ0Xb5HmAsNdmpmyouqV
         uezZRPOG9dqltYjTXp7b/VOjt2GoxpHzYgUvvZ1IZVGoz5vSRcB3zRHLszQuI2wojR5c
         3pSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wang Han <wanghan1995315@gmail.com>
Subject: [PATCH 3.18 10/45] ipv4: Map neigh lookup keys in __ipv4_neigh_lookup_noref()
Date: Thu, 15 Feb 2018 16:17:01 +0100
Message-Id: <20180215144118.045871977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480674237416402?=
X-GMAIL-MSGID: =?utf-8?q?1592480674237416402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Han <wanghan1995315@gmail.com>

Commit 6c16fa957e84 is an incorrect backport as we map the keys in
struct __ipv4_neigh_lookup(), but the correct place to add the
code is struct __ipv4_neigh_lookup_noref(), compared to upstream.

Fix it by moving the code, or fewer cases will be covered as
__ipv4_neigh_lookup_noref() will be called unconditionally from
__ipv4_neigh_lookup(), and it can be called from other places
such as ip_output.c.

Fixes: 6c16fa957e84 (ipv4: Make neigh lookup keys for loopback/point-to-point devices be INADDR_ANY)
Signed-off-by: Wang Han <wanghan1995315@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/arp.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -22,6 +22,9 @@ static inline struct neighbour *__ipv4_n
 	struct neighbour *n;
 	u32 hash_val;
 
+	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
+		key = INADDR_ANY;
+
 	hash_val = arp_hashfn(key, dev, nht->hash_rnd[0]) >> (32 - nht->hash_shift);
 	for (n = rcu_dereference_bh(nht->hash_buckets[hash_val]);
 	     n != NULL;
@@ -37,9 +40,6 @@ static inline struct neighbour *__ipv4_n
 {
 	struct neighbour *n;
 
-	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
-		key = INADDR_ANY;
-
 	rcu_read_lock_bh();
 	n = __ipv4_neigh_lookup_noref(dev, key);
 	if (n && !atomic_inc_not_zero(&n->refcnt))
