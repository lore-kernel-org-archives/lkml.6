Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELustTAND9DWBJAaQsrmaa0UhgJV1uJYWBmC+0BmWlwNOCCV+Z5b+Dr/ZFYVZ8C//V6RsAZs
ARC-Seal: i=1; a=rsa-sha256; t=1521483647; cv=none;
        d=google.com; s=arc-20160816;
        b=CszNPHvLhuczWLn7MLjQPdevOgRzoqFgFRWiokVyOcrxTtLdg83fMRLM8pgzMM23tn
         dIpfFvrOqYMOzYF122VD/SGSBZXxLLu4VZK+Xafszyr2rePzJKnW5OlKgyVX8M/OqAnP
         z7wRZGRt1h6qdEomFpzES8ARQFelvim4gKeN4z/GrN1iL6gwfl6l9T+GANQjFgoeqteq
         DsM9m2ITSf5WJ3ub8J1jWNpPxux4/qHoi+oWm8kTb8aV22K+99uY/Hx++osS4hYevy2s
         E3/4lDAfUou/dTqL/nyrl6GEy0kE2PZwXO15Gf18Nl92JMkrB252X8c6oK22GSMUf0vf
         6TlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OBl5nU3VvpOeiTogMvEUB22/u3nxeZl/hicLCVgVeo8=;
        b=B3kleoExH86gMOVxHivakG+MS97QGs6GA/0t36Y3CgUZOopppGcfvp+uDn/Wo9v17C
         JnSk0EskCXI9qKP0EJBZRI3kkpLrsJ5hmB5gRkT43fi3nK08IgX0FiTw5ja2PD+KOwbQ
         RskFSt5JnwZJVMU1lPxHuhjStjwCofI6Qjqf3wlXp7CpyGRiIWRjCqvLI7+49aFJ4W12
         KwfECWPRg4cc9JkH1euyTVEKDFH0SZ2tOOIqZikdx5DnY+LYMpIU6qE0Y/M/Bx46hkA3
         BgAkxtzw0vzql0ONHWZQqZley2t0oJ2ggav6l+zkbsMurBslxShz0LBsZxfp/mC3mj8U
         /FeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Iyappan Subramanian <isubramanian@apm.com>,
	Quan Nguyen <qnguyen@apm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 030/241] drivers: net: xgene: Fix wrong logical operation
Date: Mon, 19 Mar 2018 19:04:55 +0100
Message-Id: <20180319180752.415954080@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391237661738388?=
X-GMAIL-MSGID: =?utf-8?q?1595391237661738388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quan Nguyen <qnguyen@apm.com>


[ Upstream commit 11623fce0f9afef30c45e3f2120b063de3809a8f ]

This patch fixes the wrong logical OR operation by changing it to
bit-wise OR operation.

Fixes: 3bb502f83080 ("drivers: net: xgene: fix statistics counters race condition")
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -537,9 +537,9 @@ static int xgene_enet_rx_frame(struct xg
 	buf_pool->rx_skb[skb_index] = NULL;
 
 	/* checking for error */
-	status = (GET_VAL(ELERR, le64_to_cpu(raw_desc->m0)) << LERR_LEN) ||
+	status = (GET_VAL(ELERR, le64_to_cpu(raw_desc->m0)) << LERR_LEN) |
 		  GET_VAL(LERR, le64_to_cpu(raw_desc->m0));
-	if (unlikely(status > 2)) {
+	if (unlikely(status)) {
 		dev_kfree_skb_any(skb);
 		xgene_enet_parse_error(rx_ring, netdev_priv(rx_ring->ndev),
 				       status);
