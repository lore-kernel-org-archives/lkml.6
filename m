Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49XRIQYr305rkNCalfIN9UKladPDMcBi/Tk6qCvUuaX303/WbydNEumDURrjszxyBkkF7Fm
ARC-Seal: i=1; a=rsa-sha256; t=1522346847; cv=none;
        d=google.com; s=arc-20160816;
        b=kXGjSAO7laoxJyp5k7pOEN/AAo394JlLVR48AuzeiROqmfyhw/r3dZc8//CwmVCE69
         GHnkS4f9MVWG+OKh9WQfYIvhQesOcCYZbFSzhvyUwRq69P5CNs0ID22BTdhSiXuOYNox
         SXh0hajIkjcc2e8mOEL4CUYXby6+vgYnE8WQqIEi3peDsogwQaW08cdDpOWQUeyLcNr0
         IKjsqeh4o3QczugoftYrD9Zob7l9qMSGbCYiSMNZcAXPLG2ACV+hhgqCpwl64ixM7xIi
         lomHTMX2fFZSlX2zrCTZ/6y/ns/X4kRsE1si+Kp3enJTv22SBLsJePIMuzRkJ7dHf3Hq
         XrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MaYqeV9YmzKTi0r55Xr4cqp6ZOjLv53ClNjePZwvCy4=;
        b=PoSf1xmYt36ZpE2UKazcWIGmVBYwvWigyL2olzgbtHAFXXmuA3etuJ0OB5qBHrphhL
         xp1xl0LSuvBJFiJYQTGc2oYurNCJ8pJrJ2bCuu+SxdBVD5pzQZMn/9D3cWa22hz0Uhb/
         X1OPZjXrseoUIDBw5IH2ouCkj+DaONwtQ6RXKTDm6cl935beLNolrBTYf25oQjaiiqw2
         gFVSWaI/XMlThTl4P5MEAwk8jdeDucoQRRDGZpFLsCTPzXITCU72ILw73JQ03z7j1URy
         gda3ZlZtJCPxIcMZGdby7kUSOP8TyMihyA9aWAM/4qsUzR12f+AUqenCuGCHP0e8dVsY
         obrQ==
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
Subject: [PATCH 4.9 09/28] net: Fix hlist corruptions in inet_evict_bucket()
Date: Thu, 29 Mar 2018 20:00:28 +0200
Message-Id: <20180329175734.574879436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296057389749858?=
X-GMAIL-MSGID: =?utf-8?q?1596296367940806545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
