Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49wF9iuFXM2TYchynFWx2sPe/6R1AwzlCc/NJdiytU6f/HC7v1Yy+iRmAZ8otR/YB1D7iVR
ARC-Seal: i=1; a=rsa-sha256; t=1523399210; cv=none;
        d=google.com; s=arc-20160816;
        b=DTPP6Aq8Kejhm3sB5bjMQ3Ybz4xQN7qVNwZHfhg/O6KIcDpBEvzywFSZ3mG0uANb86
         +1ZU6m5yAkxFn1Ql7hvdUL1luoUbTjycApIDQ0TNBP465WRt0u4BBX0yXQR9dj4XA1EB
         81PfTkGsuk7vDvgbvAZCf1uS96eY0GJuZ1jgfc/sWYc4pV61kI5vepun2ZQIxIdKXSdl
         UgUAWecKUDThiHMJK/B/I4/qmV/6AA+ETkqpVXUUnD/E92xyr3oe6H07EImVAiWKOR5F
         EPViOCHptJRZl539UFe2VCNPLNowgbR9/9+UQ4JSunvksTRi6TMG4mAJMyMjJCfllmi/
         mw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FAplxqT4zNK9+/08kjEMdRbHnuaE6vgoFAOINkw64zQ=;
        b=ckclpp5diEIvSMN/67eSvY1gW0IBlFMi4M66iMVajbrhZNDl/5CcAR4s/F6tIbACgw
         K/8QV/aaalBnvyuyDeA0CXgI8bAN5T+dkR2n/1gXsJcWhYNCBw0SUAcBwqZZKB3fkGIL
         3IJd5NMqeyYFECbSyRUF8uKoQGspNXsOVBXsKyp2ReTKOr3yHJGr8rjsOPppG+PZdqc0
         Q6FzgJvIcT/R/ROiaOXJD3RypatzDp7qeUuBjgugelTAymxra6Lv1pN12MofjMe7jWeC
         eHUf43wT1CopiOafSjmjxEjLu3avRbpB1+SO58n5r+72tlBc3rVQRumRbkJQGomJ/qnS
         NGcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nogah Frankel <nogahf@mellanox.com>,
	Yuval Mintz <yuvalm@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 026/168] net_sch: red: Fix the new offload indication
Date: Wed, 11 Apr 2018 00:22:48 +0200
Message-Id: <20180410212801.312204330@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399850662683170?=
X-GMAIL-MSGID: =?utf-8?q?1597399850662683170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 8234af2db3614d78b49e77ef46ea8cfab6586568 ]

Update the offload flag, TCQ_F_OFFLOADED, in each dump call (and ignore
the offloading function return value in relation to this flag).
This is done because a qdisc is being initialized, and therefore offloaded
before being grafted. Since the ability of the driver to offload the qdisc
depends on its location, a qdisc can be offloaded and un-offloaded by graft
calls, that doesn't effect the qdisc itself.

Fixes: 428a68af3a7c ("net: sched: Move to new offload indication in RED"
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Reviewed-by: Yuval Mintz <yuvalm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_red.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -157,7 +157,6 @@ static int red_offload(struct Qdisc *sch
 		.handle = sch->handle,
 		.parent = sch->parent,
 	};
-	int err;
 
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
@@ -172,14 +171,7 @@ static int red_offload(struct Qdisc *sch
 		opt.command = TC_RED_DESTROY;
 	}
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
-
-	if (!err && enable)
-		sch->flags |= TCQ_F_OFFLOADED;
-	else
-		sch->flags &= ~TCQ_F_OFFLOADED;
-
-	return err;
+	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
 }
 
 static void red_destroy(struct Qdisc *sch)
@@ -294,12 +286,22 @@ static int red_dump_offload_stats(struct
 			.stats.qstats = &sch->qstats,
 		},
 	};
+	int err;
+
+	sch->flags &= ~TCQ_F_OFFLOADED;
 
-	if (!(sch->flags & TCQ_F_OFFLOADED))
+	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
+		return 0;
+
+	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
+					    &hw_stats);
+	if (err == -EOPNOTSUPP)
 		return 0;
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
-					     &hw_stats);
+	if (!err)
+		sch->flags |= TCQ_F_OFFLOADED;
+
+	return err;
 }
 
 static int red_dump(struct Qdisc *sch, struct sk_buff *skb)
