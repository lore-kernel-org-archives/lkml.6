Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256Z865r84a1Z74v4bRsG2TUzpPztuspMx31rUvUcfeStkxNu5TxA0ktSG9RB5RuBfUF6IY
ARC-Seal: i=1; a=rsa-sha256; t=1519412244; cv=none;
        d=google.com; s=arc-20160816;
        b=MyaamfqdeG6PMh+HZhygY/8ocdsI6UQy2NT5eiu6dq8/vGEiKwMrQA/PbqeF00khU5
         k4REpRGtWHyKFt0D5riI5B/3Utb/8rS448gA0wnfEJevrDlfUrPoNyKrfUE/HCV/36uQ
         BxXS9JouD8Y/trZM2gjRfeTuGan26Rp10DTl/NoNmZ9eb9Lptc0FmMm9bGE52tazHme7
         y4yaFc+6eTEOQyMMLUqlc3m4E9tshvg8SQBDZTLFGuVGuSVuPXgdpkHUkOPtzBSXCwrt
         axwdUFPC7SJfvH5bkS2IEuAbv1IvpOhl95WUsNoKG9UMEoyN0oGztaClyRE4FWOxOiA0
         q28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ugdTlBNBIzfZ2IFkpDY80ayQNo439UCI82ykC6yBHOg=;
        b=yA4npx/JnPeoAsWVqVcNZnom+xjUTWLqS5B1veYMnj9EhknyIXZnso41xv1LQ9RM2w
         zxpur0bTJ8sX/CEps/9T3nOrKpeI+exJZnILC05zI56aEO29htB3rGrr2zKjeHfMnA0H
         RdIYwHH0ofESn5fq9tlMGVUou+EGJ1QbJXY72Jw1T2X9RU15RrvaXfN0pGNEpabYJP7v
         ZHpPBcXFCRoJHHXHyhTK7iV07zokFxOhXSNumgG+Oji9In/HcCf9aOI1rZEXGyXlx4ih
         BmOLdI8cc/DFop7p6dDetrQ6ywpbR3f5YiArJh68Q/OMPYLFF3GZbtCpQyCwZMiBJwZ5
         iGDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 15/45] netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()
Date: Fri, 23 Feb 2018 19:28:54 +0100
Message-Id: <20180223170717.757260952@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217540767031199?=
X-GMAIL-MSGID: =?utf-8?q?1593219213910534070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 1a38956cce5eabd7b74f94bab70265e4df83165e upstream.

Commit 136e92bbec0a switched local_nodes from an array to a bitmask
but did not add proper bounds checks. As the result
clusterip_config_init_nodelist() can both over-read
ipt_clusterip_tgt_info.local_nodes and over-write
clusterip_config.local_nodes.

Add bounds checks for both.

Fixes: 136e92bbec0a ("[NETFILTER] CLUSTERIP: use a bitmap to store node responsibility data")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -431,7 +431,7 @@ static int clusterip_tg_check(const stru
 	struct ipt_clusterip_tgt_info *cipinfo = par->targinfo;
 	const struct ipt_entry *e = par->entryinfo;
 	struct clusterip_config *config;
-	int ret;
+	int ret, i;
 
 	if (par->nft_compat) {
 		pr_err("cannot use CLUSTERIP target from nftables compat\n");
@@ -450,8 +450,18 @@ static int clusterip_tg_check(const stru
 		pr_info("Please specify destination IP\n");
 		return -EINVAL;
 	}
-
-	/* FIXME: further sanity checks */
+	if (cipinfo->num_local_nodes > ARRAY_SIZE(cipinfo->local_nodes)) {
+		pr_info("bad num_local_nodes %u\n", cipinfo->num_local_nodes);
+		return -EINVAL;
+	}
+	for (i = 0; i < cipinfo->num_local_nodes; i++) {
+		if (cipinfo->local_nodes[i] - 1 >=
+		    sizeof(config->local_nodes) * 8) {
+			pr_info("bad local_nodes[%d] %u\n",
+				i, cipinfo->local_nodes[i]);
+			return -EINVAL;
+		}
+	}
 
 	config = clusterip_config_find_get(par->net, e->ip.dst.s_addr, 1);
 	if (!config) {
