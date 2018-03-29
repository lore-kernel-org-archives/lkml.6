Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49y4B7bZNZ9d7is5hcJ+jr8LzYHod5XDPK5zTspGftAY677KhUCS8GGSj25xA8fqHx1Cmmz
ARC-Seal: i=1; a=rsa-sha256; t=1522346666; cv=none;
        d=google.com; s=arc-20160816;
        b=amHwkhwBxKksBo4JX+ik3tyFldn/weqswFOSCx2o4ZJiPePFSTMSXLLnvxbbXGGq/u
         M7FVGvwj1fI3N1M0w9CQTK3TXhn9sGZ0Jw71YD+evCoZ0FhZSc5gcPdC8/Afn6MvZKPt
         Rglvp1TiPhol/u7hd9g6/k9zNNYGhXiJJZZ4+rGi+el3gS3URuQpNaHj4JUb/YX5U8km
         MSJNWsOz2Njj3YaWv/LZlq/MAyydDNhiJoh/4DZgL33eYgOL7TrKqq9838X9FnP3QUNg
         fB6LxfhoZZKUr9S0I2gLgfsFD2kiXH0aZ/CFsOQfZf0vZFD5XST7op2qWTh9dXkh8rfN
         FOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U4N98ONfecZpLNqhW9OGyBkPf5kZ5yFUxzNjUylybbM=;
        b=uowUdmUIj01lilGIKK2OKIpEZD+SoC0sD2U/T1vNrHHhBfr5KdhmXfTKsmq1b66qUL
         cqTAsQFyXfh5TfBN7qKLcB/e6pznbZatAobibP14KQoSGQgpLLp8Jx5EGQN5CRpFHKMk
         2dLMa8YNp2kAnxpR1XZE0OMjegXGrdt1sN1tYqidbStefOunMwjbLgc/QN+fyHFo+jMj
         pJs/9b6qoSek2QzSh2PyNi94pK8V/veSHqI9AlU2kXvz030B4l+Ibw4RBNqpx1hUvC6F
         Uvb3H5uiGaWLusz1d7KCEtTt6PIlUhxZun8esIzmi+FWB7FuLklBVqiFK7nBoEAp0WIq
         oqbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Blakey <paulb@mellanox.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 16/43] rhashtable: Fix rhlist duplicates insertion
Date: Thu, 29 Mar 2018 20:00:11 +0200
Message-Id: <20180329175731.778320923@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296039463531522?=
X-GMAIL-MSGID: =?utf-8?q?1596296178278933961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Blakey <paulb@mellanox.com>


[ Upstream commit d3dcf8eb615537526bd42ff27a081d46d337816e ]

When inserting duplicate objects (those with the same key),
current rhlist implementation messes up the chain pointers by
updating the bucket pointer instead of prev next pointer to the
newly inserted node. This causes missing elements on removal and
travesal.

Fix that by properly updating pprev pointer to point to
the correct rhash_head next pointer.

Issue: 1241076
Change-Id: I86b2c140bcb4aeb10b70a72a267ff590bb2b17e7
Fixes: ca26893f05e8 ('rhashtable: Add rhlist interface')
Signed-off-by: Paul Blakey <paulb@mellanox.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rhashtable.h |    4 +++-
 lib/rhashtable.c           |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -750,8 +750,10 @@ slow_path:
 		if (!key ||
 		    (params.obj_cmpfn ?
 		     params.obj_cmpfn(&arg, rht_obj(ht, head)) :
-		     rhashtable_compare(&arg, rht_obj(ht, head))))
+		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
+			pprev = &head->next;
 			continue;
+		}
 
 		data = rht_obj(ht, head);
 
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -537,8 +537,10 @@ static void *rhashtable_lookup_one(struc
 		if (!key ||
 		    (ht->p.obj_cmpfn ?
 		     ht->p.obj_cmpfn(&arg, rht_obj(ht, head)) :
-		     rhashtable_compare(&arg, rht_obj(ht, head))))
+		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
+			pprev = &head->next;
 			continue;
+		}
 
 		if (!ht->rhlist)
 			return rht_obj(ht, head);
