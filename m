Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+b8S1aC58q66s/PzDRbCAXIG/ex0/uP4HjBfpkBk5Xg6ie9Px7XRPV4TpR2s/8L3Ix/b47
ARC-Seal: i=1; a=rsa-sha256; t=1522346556; cv=none;
        d=google.com; s=arc-20160816;
        b=z+E5RwiTE8WgKkO5UuuEVupsc61oY6amgMhD2SwkzFUi/el8k0YLWg83dIZK8+KpiF
         nF/11knaQECD58xprvoQDPqX+YIl94RyY+Ep7tAC7AbmP8EYgWcyen3psovox4RXlXHy
         rEY54QR0ZeX8kuxBHAyR2mMuvUU808XsF8GE5TQQLzPrj+0nzK5E9ksMqHRXjb8z6/vy
         eTEl0WXFvZ7zQRmbM6CXB/UCMu9STT6zUx+QXusubdzjtWjgCWOWO8geo9WnZ3HWaC7H
         drrEo7T8K+4/FLYQmvGNvz5RfXeMaw9V0MsPhaltpsEgs+junhWRkFe1zq/mbqFHMcGD
         57Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jqxHKhckHNVjkiqLSuJiV31F3vcmUCKI7WGZaGo0QLg=;
        b=RyBBksPu0D2k0cD/dQDjTSMjh29U+5PfPhP64iuT9shLExvUYY2I6yRdfWT5tb2gNq
         o3yLqxEt0VvMPQGTy4Y9pHlN73XQd+SHBSp3n9ogX//PWE6ZPnM3D097kl7tly0Ai1pM
         0CdWN/jBD43IS6os9oDQ+7VzD7GdegQYfdbNsu9nE7B4yAda9l3JfhVDdTFyGlaF12v2
         r282Hd4DcsQi93BTleR7b1N+25ZVzDIJJxSq7jMCShxWtrspgssI2q8QvnZ41engsWQ0
         OAyhO/CEktc+hZWanvV/LgTaKCGTSp3Z11I1178L5UJF9tX3y+66PyMFIqDTr+hMY4wG
         ZoMg==
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
Subject: [PATCH 4.15 26/47] s390/qeth: free netdevice when removing a card
Date: Thu, 29 Mar 2018 20:00:07 +0200
Message-Id: <20180329175731.241533400@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296062916351982?=
X-GMAIL-MSGID: =?utf-8?q?1596296062916351982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5022,8 +5022,6 @@ static void qeth_core_free_card(struct q
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
@@ -933,8 +933,8 @@ static void qeth_l2_remove_device(struct
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
@@ -3042,8 +3042,8 @@ static void qeth_l3_remove_device(struct
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
