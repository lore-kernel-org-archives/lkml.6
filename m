Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvhDsetqFVRVsRipeZZTnbNoWAtEgxeS6mxZZsG7YRGSRAza5kqolm9FOI0h9cIQTUVBjiL
ARC-Seal: i=1; a=rsa-sha256; t=1521483761; cv=none;
        d=google.com; s=arc-20160816;
        b=yS8p/f2AL7lGau6Io2bPUO2xIfgGpLA0DqDfc7E2EjSZeSN+DvsoEOIDwGEDWn3gx1
         QlNTZPKz2mOSLYR/C1F+GQ/pr6inVPqNMTGvYq8ORGLDQI3Tc5OtYADGaAuLKcBINigz
         B2B+P+3/5sGONvhCqkIsQ3U295E7fFJCv+wwupmAKnKQyihVO5WWInUJ99hfVshBt4dO
         7WBa8/l2O1ogGwAeXTKhuszgjXZ4uqtVFZZ6+gYPqgF2OK1/xggbABi+GnyNkx3FfpKS
         kJEgwjR6U2T2Uu8DHghsLQ77SfVpNjBxJSYTS4pyiAscR69SsORMk44A+nRpDtrCKqKw
         FvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=05QoaKJDhw0nEXf0zr/R8sI74C00v5BBQBr0JgLHLB4=;
        b=04QPPDD8Tbrff6KREGiYMtTHhaG+l8JYC4UEcPZsr0+90WeCPr6rbikqPPLa6VyzIO
         sSC0pJJQWDMH9bPJnxHcA6JmuBqXI5k6cEGXgKvtHRY+vIiDiFT90sid6MB0KJ1axLr/
         0FSvH328co4sJuCAoyKK3PNRQiwU2dVJ7SytsEm3r9oxaqdqwnEmeYW5q+qssLmsjDPh
         0nzbemseMv9iSRbMwBc+JFceqWGXmWwIxdxxWooTMuEZsgfnZJxu+rAJhn0xTpW8w0f8
         Yq3b5s7y73NGjunLK5nHg8kAUboH53XzIA54VOidgCaRaZBCHq+GXQlWZVc5cv6lkwX/
         xfOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Yuval Mintz <Yuval.Mintz@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 100/241] qed: Fix TM block ILT allocation
Date: Mon, 19 Mar 2018 19:06:05 +0100
Message-Id: <20180319180755.343126670@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391355913125769?=
X-GMAIL-MSGID: =?utf-8?q?1595391355913125769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>


[ Upstream commit 44531ba45dbf3c23cc7ae0934ec9b33ef340ac56 ]

When configuring the HW timers block we should set the number of CIDs
up until the last CID that require timers, instead of only those CIDs
whose protocol needs timers support.

Today, the protocols that require HW timers' support have their CIDs
before any other protocol, but that would change in future [when we
add iWARP support].

Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c |   32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -271,16 +271,34 @@ struct qed_tm_iids {
 	u32 per_vf_tids;
 };
 
-static void qed_cxt_tm_iids(struct qed_cxt_mngr *p_mngr,
+static void qed_cxt_tm_iids(struct qed_hwfn *p_hwfn,
+			    struct qed_cxt_mngr *p_mngr,
 			    struct qed_tm_iids *iids)
 {
-	u32 i, j;
-
-	for (i = 0; i < MAX_CONN_TYPES; i++) {
+	bool tm_vf_required = false;
+	bool tm_required = false;
+	int i, j;
+
+	/* Timers is a special case -> we don't count how many cids require
+	 * timers but what's the max cid that will be used by the timer block.
+	 * therefore we traverse in reverse order, and once we hit a protocol
+	 * that requires the timers memory, we'll sum all the protocols up
+	 * to that one.
+	 */
+	for (i = MAX_CONN_TYPES - 1; i >= 0; i--) {
 		struct qed_conn_type_cfg *p_cfg = &p_mngr->conn_cfg[i];
 
-		if (tm_cid_proto(i)) {
+		if (tm_cid_proto(i) || tm_required) {
+			if (p_cfg->cid_count)
+				tm_required = true;
+
 			iids->pf_cids += p_cfg->cid_count;
+		}
+
+		if (tm_cid_proto(i) || tm_vf_required) {
+			if (p_cfg->cids_per_vf)
+				tm_vf_required = true;
+
 			iids->per_vf_cids += p_cfg->cids_per_vf;
 		}
 	}
@@ -696,7 +714,7 @@ int qed_cxt_cfg_ilt_compute(struct qed_h
 
 	/* TM PF */
 	p_cli = &p_mngr->clients[ILT_CLI_TM];
-	qed_cxt_tm_iids(p_mngr, &tm_iids);
+	qed_cxt_tm_iids(p_hwfn, p_mngr, &tm_iids);
 	total = tm_iids.pf_cids + tm_iids.pf_tids_total;
 	if (total) {
 		p_blk = &p_cli->pf_blks[0];
@@ -1591,7 +1609,7 @@ static void qed_tm_init_pf(struct qed_hw
 	u8 i;
 
 	memset(&tm_iids, 0, sizeof(tm_iids));
-	qed_cxt_tm_iids(p_mngr, &tm_iids);
+	qed_cxt_tm_iids(p_hwfn, p_mngr, &tm_iids);
 
 	/* @@@TBD No pre-scan for now */
 
