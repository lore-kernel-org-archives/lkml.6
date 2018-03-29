Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495wogB71rcmLzl3gvbEn3Nhb30d1F8i3Sf6wleHsb3Um0HbRZoPlC2twqNN//bn6YQQNlP
ARC-Seal: i=1; a=rsa-sha256; t=1522346811; cv=none;
        d=google.com; s=arc-20160816;
        b=Dl5mzKayR3d3t3zV1MnRW/MoE8pL6gYIwprbBPnQPSa6LVzhGztpmDJit+U9/jvTx7
         iDzPOPnSPExsBwY1QfnOo/rhSdyJqkr99WNbTYrYQCofg7g3HqeZaiRpw0mueppXce71
         rxXeyNuyHy/pS0KhlidsNRHCvDL/Oh4hkk1xdsqvxAnxD+Fn3Z+cpcpENRRMCRAb5W2y
         vcXU287IQSe6RbJR48njron4jBUwRCRA1i1ry4oXzqG75zsjfUvsh3PBJh1cOYt47QF3
         wdLBJf2TrA3L/auQ48lKks8kSW6/vvQEpmrhXFlkQRcpSvwxj22q3G90FKo7VnxKVJBT
         Bx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1iZvuWkH0E9+GZoxUW93SI+L+ybRcHqCaJSUG40AgGM=;
        b=EMzAMyW0x0APJNRdMy2H5zGE65jVMzNizp2arBqVG1fZ98tZaVXinlcpj2pqUHMToU
         cxFmVCC3J69SF58ZI/9TX7GygOe76xUvW5MKP1AWsKiA6c5zmImRHNwk5PZ99gNf4c4R
         ePNHrnokW9HBXanKyAQu6ltVKVAkHB9K4LWFLvEh5M1uu6TaTPSfDZhfbkG20P1o+ttH
         mvnJ+a7whZg7CQToAbdcWcFQ8hZGKrbE20jTGdWTxRQqGyB8A7kbr0ZOfTsso2nRkFZO
         3M9xhe058rBUqR5CGTCn4aV/NenrjmXCuv2A3+B+VaMW4Zp60xe6qssp05ZgifM6+gb1
         CeOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 22/28] s390/qeth: free netdevice when removing a card
Date: Thu, 29 Mar 2018 20:00:41 +0200
Message-Id: <20180329175735.918291463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296062916351982?=
X-GMAIL-MSGID: =?utf-8?q?1596296330233416511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 6be687395b3124f002a653c1a50b3260222b3cd7 ]

On removal, a qeth card's netdevice is currently not properly freed
because the call chain looks as follows:

qeth_core_remove_device(card)
	lx_remove_device(card)
		unregister_netdev(card->dev)
		card->dev = NULL			!!!
	qeth_core_free_card(card)
		if (card->dev)				!!!
			free_netdev(card->dev)

Fix it by free'ing the netdev straight after unregistering. This also
fixes the sysfs-driven layer switch case (qeth_dev_layer2_store()),
where the need to free the current netdevice was not considered at all.

Note that free_netdev() takes care of the netif_napi_del() for us too.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    2 --
 drivers/s390/net/qeth_l2_main.c   |    2 +-
 drivers/s390/net/qeth_l3_main.c   |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4989,8 +4989,6 @@ static void qeth_core_free_card(struct q
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
-	if (card->dev)
-		free_netdev(card->dev);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
 	kfree(card);
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1057,8 +1057,8 @@ static void qeth_l2_remove_device(struct
 		qeth_l2_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 	return;
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3192,8 +3192,8 @@ static void qeth_l3_remove_device(struct
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
