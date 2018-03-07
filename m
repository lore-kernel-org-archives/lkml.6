Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELveK0PG7v+wPMMS07+c+X1HB1CbNbzFYLc9ubcmZKd+WaNcYXXFmhxOLb/9fFuMJ4Yfc1f7
ARC-Seal: i=1; a=rsa-sha256; t=1520451778; cv=none;
        d=google.com; s=arc-20160816;
        b=nn44CgjI96xau5KlqUsO/7HIC9sFBE/q9SzklvMTNPlHB6FflTx3IA+lGXL/udS9c8
         gQnCdGuA7scon7ALu3jEGGxiMhN2JSq0Wh/oq5tenvdb3ptCWGwuz3SDfu0HPECvw6+I
         nBy+3sacy7xIPNqrj6f5gTg6ShO5UmcJz+FW1MoVPSXhGnVWeSg8HOyaJ10AnHbos2r1
         qrnP7FSWKb6IzM3tY3q9UBxGYF4uyEoiLWkyQgu1Xyya4W+/azOO0/Pn4iA61nX8kP9y
         f7KICNdooTQ2lm0D+9xoEp+TM+VKXBZt64JtgRhxc+hILU9QiTeMok5Xs6KEMgiR2Aab
         vuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3cvih4qZRJAwL3qOm0CVHPDy0sTBW7WDwvFG5qnDiiY=;
        b=Gs/+hIfduJX2sWrYGLH0m0mU4YzdSMdQZSWI5yPe8mxmIElw6ceCiEZ6lbQVnEnBx7
         kxD+tNtTHcvwi4YrB8vYdYzTqBo1gjwEaCweEsMsGJo36jvlAi9t4ZujzL0IkvtWgVJV
         7fWJCuNX+hxYOlXitkooEAlHHYuoV+PtpksUwPt+szOjzkHfldF3FxoqQTqcjiFwCVzj
         PzWpfSSQjlDH8alU+iuEzFx3XcUG+9QW+F0pKiqlsmA++suYUrpugEuhGmwgkJnd0ibs
         G6+u4lVpM9kSy78bCAjALBZpYDBts5n1iHzyS1q/wLSpMQUDfrPGzUe9Gbswurh8uqrk
         zTMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 091/122] s390/qeth: fix IP removal on offline cards
Date: Wed,  7 Mar 2018 11:38:23 -0800
Message-Id: <20180307191742.558338027@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309244301293317?=
X-GMAIL-MSGID: =?utf-8?q?1594309244301293317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 98d823ab1fbdcb13abc25b420f9bb71bade42056 ]

If the HW is not reachable, then none of the IPs in qeth's internal
table has been registered with the HW yet. So when deleting such an IP,
there's no need to stage it for deregistration - just drop it from
the table.

This fixes the "add-delete-add" scenario on an offline card, where the
the second "add" merely increments the IP's use count. But as the IP is
still set to DISP_ADDR_DELETE from the previous "delete" step,
l3_recover_ip() won't register it with the HW when the card goes online.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -256,12 +256,8 @@ int qeth_l3_delete_ip(struct qeth_card *
 	if (addr->in_progress)
 		return -EINPROGRESS;
 
-	if (!qeth_card_hw_is_reachable(card)) {
-		addr->disp_flag = QETH_DISP_ADDR_DELETE;
-		return 0;
-	}
-
-	rc = qeth_l3_deregister_addr_entry(card, addr);
+	if (qeth_card_hw_is_reachable(card))
+		rc = qeth_l3_deregister_addr_entry(card, addr);
 
 	hash_del(&addr->hnode);
 	kfree(addr);
@@ -404,11 +400,7 @@ static void qeth_l3_recover_ip(struct qe
 	spin_lock_bh(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
-		if (addr->disp_flag == QETH_DISP_ADDR_DELETE) {
-			qeth_l3_deregister_addr_entry(card, addr);
-			hash_del(&addr->hnode);
-			kfree(addr);
-		} else if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
+		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			if (addr->proto == QETH_PROT_IPV4) {
 				addr->in_progress = 1;
 				spin_unlock_bh(&card->ip_lock);
