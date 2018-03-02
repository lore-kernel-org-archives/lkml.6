Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBAft5wgoE2Gj2KsXR+ZOgWW4AsHIzqf+nA1HHuqgaO975iCVKi9Uq9APys/h+NSP81Ogr
ARC-Seal: i=1; a=rsa-sha256; t=1519981504; cv=none;
        d=google.com; s=arc-20160816;
        b=R7kyux11HIFO3qbzEieZRaGuFY+IOWzw7vT6zhdMvaLvf5yFGUY+3V4sClaQgUFLAd
         8zCKlYdYfS1hVtfgP5xy7YYZ0X7uBMedr6T6/jj88tDnBIt55O3xUFffK96yypsbOfBh
         fhpL5X1r7rNSF0H1s/kp00/cqGwXEr/x5jws+hJNUUofoyHImhGtVP2WfN4w/Jr9rD/7
         BxXeAu0HA8GLppsCuJ/cuzPVS+83OHLLphvXzu2EjxY+llY07J4+b0znZ16AJyHGxLno
         7cs3WcP27qwBp06NDJqBRq3XBlpNOPzLPBd4wMHVAWoWgzqqE0vZCxcZKIPMkegN2fqP
         dFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L3PV5ZBsCufuej0Lngz1JHMGx7nxY3YJRx1bziqdVa0=;
        b=S1HAgbRRK58CiLHontgIngL9n4BjxVJy7MxIfVY2tfMt9O3T/5pulPlW/7fdxqP1AJ
         CSKnXFZBTj08hfyFJVGeXxtSeSAacnRP02u5cGt5PoNQSEFiPn/5TFjfNF+JqrjRcBx4
         LbaqC0EqYWGyrJgEuHqQ0qlR+6hfiExv3GeS3SZxadw0vepgAualxtOFC3qaSjm48q5B
         xAH0OqH1/DJoxwYovGNbctiDNSRdKL2ti71mrBqO6ndIbgn00ssimVqgYjrKvcfb9zRW
         qXz+zNIu3nV2mGMNPKHIc1A9qnA+AbR1rcMqIB5L31nfSiOPFg84a9AIdRtu03jbeWbn
         E9SQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@mellanox.com>,
	Roman Kapl <code@rkapl.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.14 112/115] net: sched: fix crash when deleting secondary chains
Date: Fri,  2 Mar 2018 09:51:55 +0100
Message-Id: <20180302084508.373570078@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816125875521944?=
X-GMAIL-MSGID: =?utf-8?q?1593816125875521944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kapl <code@rkapl.cz>

commit d7aa04a5e82b4f254d306926c81eae8df69e5200 upstream.

If you flush (delete) a filter chain other than chain 0 (such as when
deleting the device), the kernel may run into a use-after-free. The
chain refcount must not be decremented unless we are sure we are done
with the chain.

To reproduce the bug, run:
    ip link add dtest type dummy
    tc qdisc add dev dtest ingress
    tc filter add dev dtest chain 1  parent ffff: flower
    ip link del dtest

Introduced in: commit f93e1cdcf42c ("net/sched: fix filter flushing"),
but unless you have KAsan or luck, you won't notice it until
commit 0dadc117ac8b ("cls_flower: use tcf_exts_get_net() before call_rcu()")

Fixes: f93e1cdcf42c ("net/sched: fix filter flushing")
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Roman Kapl <code@rkapl.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/cls_api.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -197,14 +197,15 @@ static struct tcf_chain *tcf_chain_creat
 
 static void tcf_chain_flush(struct tcf_chain *chain)
 {
-	struct tcf_proto *tp;
+	struct tcf_proto *tp = rtnl_dereference(chain->filter_chain);
 
 	if (chain->p_filter_chain)
 		RCU_INIT_POINTER(*chain->p_filter_chain, NULL);
-	while ((tp = rtnl_dereference(chain->filter_chain)) != NULL) {
+	while (tp) {
 		RCU_INIT_POINTER(chain->filter_chain, tp->next);
-		tcf_chain_put(chain);
 		tcf_proto_destroy(tp);
+		tp = rtnl_dereference(chain->filter_chain);
+		tcf_chain_put(chain);
 	}
 }
 
