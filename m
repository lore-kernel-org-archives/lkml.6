Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49XDvsPS7saUSFq/b9xs+AZ0riWY4gY382iJkfkcOcXpQPibOkBkLzYDi2LsfP9LmcnpJ7s
ARC-Seal: i=1; a=rsa-sha256; t=1523399398; cv=none;
        d=google.com; s=arc-20160816;
        b=iVkVMQRUGKkDZXdXLLCtUezwwA/quqzGACXwvxtc+cA7dTZPhy1DnLi3eis6dWsHmg
         PmOuqdqDV/VYmBMWFRIbeezZrzz4CxQxjyJ2a/HwAfVZExzCLixarUqzwjr1TpwVHoie
         McRG4puuCxJTlNbcAzDiiDgmjxKRX3YUJCwW3jq4jWEtvqQLZfFMipiAJvYfx//KTih7
         E2LTFBwfMI3miHebgjscNvkzk62i6OJiIkeZuE2tOWZfVScR6UMWNQAjF8ipxLzXnmGJ
         QkKbxnwDPVdR69PAmTH+FDz56PgNRCrbpKvrsYEA51R6iHdkJ1tCQaK0ezEIOAe36fFi
         egdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PK17IMzNt4+/g7Wo7FU1A0Z5zcescpLYyf7zGAiSX8I=;
        b=t0+7Hdlj0/ezixK5/WCpsu8BMQUdPvBbEGaKBDCaflg1nI70FFAIuavdavLNBlrh9F
         lCFT0Gurj+goYAVEP2bd4aPOdwd5BjBd3oDWFMXhIgd808Aw7QSs0Tx3sKCq/HZsFvtX
         ijOo1FYJkkCaksqPj0U4DM951GIUpUrn5bX09EnHheH6DXH4H/3X0ZF2MF+BjM3b1Lgp
         OwCIqM7dR7Sic6YrS2CLZLo3CghwpR2QbfxtFeBfW5XWwuCVJSOKoSgaajK3Y3YGW34n
         /3qrlWRcGwgnSzV+ovi2hJjd9suX4voFGJz0NyCH62LD4vFhPyslhr7WRbEASWsnhvK/
         QjZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arjun Vynipadath <arjun@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 092/168] cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages
Date: Wed, 11 Apr 2018 00:23:54 +0200
Message-Id: <20180410212804.168651435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400047926607571?=
X-GMAIL-MSGID: =?utf-8?q?1597400047926607571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arjun Vynipadath <arjun@chelsio.com>


[ Upstream commit ea0a42109aee7b92e631c4eb3f2219fadf58acdd ]

We'd come in with SGE_FL_BUFFER_SIZE[0] and [1] both equal to 64KB and
the extant logic would flag that as an error. This was already fixed in
cxgb4 driver with "92ddcc7 cxgb4: Fix some small bugs in
t4_sge_init_soft() when our Page Size is 64KB".

Original Work by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2619,8 +2619,8 @@ void t4vf_sge_stop(struct adapter *adapt
 int t4vf_sge_init(struct adapter *adapter)
 {
 	struct sge_params *sge_params = &adapter->params.sge;
-	u32 fl0 = sge_params->sge_fl_buffer_size[0];
-	u32 fl1 = sge_params->sge_fl_buffer_size[1];
+	u32 fl_small_pg = sge_params->sge_fl_buffer_size[0];
+	u32 fl_large_pg = sge_params->sge_fl_buffer_size[1];
 	struct sge *s = &adapter->sge;
 
 	/*
@@ -2628,9 +2628,20 @@ int t4vf_sge_init(struct adapter *adapte
 	 * the Physical Function Driver.  Ideally we should be able to deal
 	 * with _any_ configuration.  Practice is different ...
 	 */
-	if (fl0 != PAGE_SIZE || (fl1 != 0 && fl1 <= fl0)) {
+
+	/* We only bother using the Large Page logic if the Large Page Buffer
+	 * is larger than our Page Size Buffer.
+	 */
+	if (fl_large_pg <= fl_small_pg)
+		fl_large_pg = 0;
+
+	/* The Page Size Buffer must be exactly equal to our Page Size and the
+	 * Large Page Size Buffer should be 0 (per above) or a power of 2.
+	 */
+	if (fl_small_pg != PAGE_SIZE ||
+	    (fl_large_pg & (fl_large_pg - 1)) != 0) {
 		dev_err(adapter->pdev_dev, "bad SGE FL buffer sizes [%d, %d]\n",
-			fl0, fl1);
+			fl_small_pg, fl_large_pg);
 		return -EINVAL;
 	}
 	if ((sge_params->sge_control & RXPKTCPLMODE_F) !=
@@ -2642,8 +2653,8 @@ int t4vf_sge_init(struct adapter *adapte
 	/*
 	 * Now translate the adapter parameters into our internal forms.
 	 */
-	if (fl1)
-		s->fl_pg_order = ilog2(fl1) - PAGE_SHIFT;
+	if (fl_large_pg)
+		s->fl_pg_order = ilog2(fl_large_pg) - PAGE_SHIFT;
 	s->stat_len = ((sge_params->sge_control & EGRSTATUSPAGESIZE_F)
 			? 128 : 64);
 	s->pktshift = PKTSHIFT_G(sge_params->sge_control);
