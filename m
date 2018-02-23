Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227FKtZ2RORMFQlDM8l0Y8GpUG/16xkiX0m9GLUSwn42nEym/Xi6W+ac+Q5punlaVKTmJfL+
ARC-Seal: i=1; a=rsa-sha256; t=1519410794; cv=none;
        d=google.com; s=arc-20160816;
        b=ub2KztgRehlLcWlAyxUFMgY1WUSZehEFWyAi/RQPCE0ruPbda8mz2W3JiqslHZpL6Y
         3rWZm9krp9xD0OBas/p/PMkIWFFqE5d2JJdIqYiPcc7LrQbwFYJ033lKe42x8uOsUx6j
         2iPhi2ioM9Bfu9g7vjBwc6FiR3gz3b7h/Cy5DCUek/X5183tQ/6ws2cXKEguVRUA8Ucp
         XtDTNHX2Cx1atqfyXU5EWdZGyCwLNTlr6YKii2Ktj2feRZh6ClhY2GVBTBocYjkYAluG
         5ldzBGE0QLGTfYHjXpCm6np38R5qSn4JlAJGulAWjshsrOO0/FkOrKMdzXbcs1u3fiJs
         OEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6TxRH9qQw5BWV7qSHI/m/nXZGZ5Mk98vwWJ3o+TURro=;
        b=sgnf1hhWwxCAdN74o8ToJor+O8T4Fh+pOAfAGIYOmurSFDKkiw9Dx53PxBsUlB325T
         U6VPDIDYCBRppHGvZoTlsxz6+2HawXtZ1oJ08FuhKk7JTLMmrEeJYO9uow0/EV70Imvi
         J3kn7MsB4Dz4XlUVY7OV1ztdpMGMyPRPPIjMzy5R90bkFNdP5Hfw+iAI4bzwexw6mx8N
         TgOAYZIgQSbegzFud6hB7eoC+lo499LXumOOL0gvK3czAdyAjAIZX0aoA7rzfq0361IG
         tZ+Ug4bh3SheLjqk6HgWACn8foT8BAqbbP0SI1NJX2T56dQ/E1SCkkVS5W5SLL6UU7RB
         LxuQ==
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
Subject: [PATCH 4.4 017/193] netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()
Date: Fri, 23 Feb 2018 19:24:10 +0100
Message-Id: <20180223170328.783017063@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217540767031199?=
X-GMAIL-MSGID: =?utf-8?q?1593217693684388120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -365,7 +365,7 @@ static int clusterip_tg_check(const stru
 	struct ipt_clusterip_tgt_info *cipinfo = par->targinfo;
 	const struct ipt_entry *e = par->entryinfo;
 	struct clusterip_config *config;
-	int ret;
+	int ret, i;
 
 	if (par->nft_compat) {
 		pr_err("cannot use CLUSTERIP target from nftables compat\n");
@@ -384,8 +384,18 @@ static int clusterip_tg_check(const stru
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
