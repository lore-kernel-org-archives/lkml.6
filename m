Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49eHuud+CBLx25PAs/vRDMMjVsGkxOibG1XjvYkUMERPwwX2aKR3435anqwUuQ7RWoJWjDq
ARC-Seal: i=1; a=rsa-sha256; t=1522346534; cv=none;
        d=google.com; s=arc-20160816;
        b=fBHTFm+IDhbx2IDFpPbPq2DCOb9M7XCfmDHn76dxcRuKaAgMkKRDeHfrD9o6/c65k5
         EqVwDNedjFLLFeH8P5KZrjv4p+42EOGsX+rzjci08xs62QYnTDRfmV8dv02QJV6S4JrX
         o3pTF7ZcMhamebKOuIl6JJkbxDxDTkMcsHaZDJ0sUwzEBSnkMWaFmc7t8PeOdSfVMUzE
         /IAt7j8eOpf/HjMbrihfffPQo+4VQuAFIS0Y6AlsezOKCfLzST3IlIbSCseHfCEB6kah
         zQN4huA7amBuJIKfw+IsABxOQl/fGTJn6D4hsYIX1RclB2ZcbZqXdQY63+nWgDWnDvSz
         g/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P20PrqN0elL6RExRjdoiSPKhtyM8im7a7fK8SC54f44=;
        b=ZohH4ZGQ7hGcRdkabg0tMGXKViSyRV+jb+2L0Y/xLS0WQfL+pQc1iXkn02XCYb/GjZ
         BIT2jFfnDOP8GVbo6aDKNi1mXUZzD/Hm4IOi96APUQY/zQmiVUrClxUgmencKS5pHUze
         LCPigA440bEkqxwv1vCLsJ9hBF1TAssKSz+CYOk1aB0Qafounm8xptWUGCsMifqfhBKK
         DUWQEEYYGZNC8X8FeB/jNlBhc9m5Mt2RoPb2cz4YHUVvf8+0R/k/gdZad9wO63Q9XCKo
         2vSUWMk/bKBmrkogEiwPsxuEiLH4UBVtCe9d57vu1fXy5CQQjfYu+O/7CpBX9XUCpH/q
         eThA==
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
Subject: [PATCH 4.15 19/47] rhashtable: Fix rhlist duplicates insertion
Date: Thu, 29 Mar 2018 20:00:00 +0200
Message-Id: <20180329175730.507661079@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296039463531522?=
X-GMAIL-MSGID: =?utf-8?q?1596296039463531522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
