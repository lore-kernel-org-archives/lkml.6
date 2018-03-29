Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4++nSfi6H/8FxAKhLoqYk0tnOyo5hjFww9PptdQX1bJy5pL4YFeg/EUYBykfiAbwP7iG6RJ
ARC-Seal: i=1; a=rsa-sha256; t=1522346836; cv=none;
        d=google.com; s=arc-20160816;
        b=jzIe9U8zlhpvC+Wp0uAyvW+++QrRN8L2mqTHDXsXBeh+FdzgEfS8A8AJHuQkJe7+cM
         6s/XCG6gv325VZC9v1ys9eJzW5L30/anJuTIUOqNsJyj5jdjWfiVtfdCFZgu+hNy5ndm
         SIdjxHIN2rqsvVnGylNmq/uh3+mf6iKZKKvL9/mGe3IQ4PnUQaHecPOP4vVrHt+7RB3J
         KVBnDZwvW9AP8+LJTJPtVFdIE2JWO8IcdsoIcdQFzuv63cpnb3lRyyF7E6xActuaHxU5
         H2BK/Y5ovjLCfEmEdt3RULjteBpKeAOnms+0Y7FNeorSx1nPMwPDRKXJ7Vz5ST++dV+0
         dwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5BdZZ6+b3tB9kOVOw/YX5N1EKWvvEPTAKYuwFKSGdXw=;
        b=vZ6ykvC5a7RgWo3gc7ksyPBi2jH5Y+8GD9FJq6ayFvLYutYCvjluL+to941MWkwaH/
         NPIfDD8QTA53D6Odou3zVQxSNHE3UvL/o614573SMv9q3fiOaN9/5yzWbwz3ZO22foGJ
         pH3PZeeDYY//GvVs9fCWpNJ11EZBmoT74NWWroiO5tHi+vaRDUQTYErWdAXD6RU3Q9hM
         yld+ATadAjgQE7PdRL1ys51EvNQ3VCff9qwewF7glHyaO/IGzDwHqnuFqzsF37Ywy8oi
         FzIcuFgFALm7RD8N6hFkeErnOGb9fLc/QHxBNXngMcr4PMfBdZSd6H/Gcwoq4fPkP133
         kqfQ==
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
Subject: [PATCH 4.9 05/28] rhashtable: Fix rhlist duplicates insertion
Date: Thu, 29 Mar 2018 20:00:24 +0200
Message-Id: <20180329175734.116913018@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296039463531522?=
X-GMAIL-MSGID: =?utf-8?q?1596296356328468736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -706,8 +706,10 @@ slow_path:
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
@@ -448,8 +448,10 @@ static void *rhashtable_lookup_one(struc
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
