Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48LjB1wF2oum3KzOh/y6xHgVRxjn3+w0Fv4RabaqRASBsH7rA/cduSeV9xTpafNWULaGUwx
ARC-Seal: i=1; a=rsa-sha256; t=1522346738; cv=none;
        d=google.com; s=arc-20160816;
        b=htNllyAbY+rnzmGRPjrkSnR4UAC5x7izt0ZpR5xpl7xRlSnFXI1gGbgjPsNHrtin7o
         AcvFPzyPCH6GoO15chLwILFNP8wdFwkmEWEL/IN6TeRE5DvVsVxsEEBJzegIi5cewcqP
         D8FLZprUnqIdvr3Jmr+bEb+EFiyais+VfyRVPG9pKe9mUcWT/emM3zSw8DzZKPELYtWr
         uEYsJFjKZ85h/XyXgoErQRqxuG8ry8Kf+hHJbBT7juq0WEKj++L3JPKcbxVXqIeIYf8P
         lC0qXfqc+dKfu5v6/Y8sTRJZgrFZ7K6AsXrLoGztx1zbnzFXrO+rAUfCsJtoiMa0IPOe
         nzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IE49TKO7feAyAasrje/Ja7ajl9MvgcrTDH+hLNFOWYE=;
        b=qX9/1jqB6dAVNkGkKoLfZfCaJqC8XmU5FxAqf6O+ZX80Bx188Ux1nj/I5J7qP+6ecx
         VkcLU+eYiJ2vsPxAci6CVD0QdOkpYjOAT7mPWKmGC/t+68RD45hZiqC0wTwOi3pv40TC
         gBIwl0UZS2uW9LpKCX/kNXcYU1TMJnpPQFKfHrTfeKAeG1gZksvSazKwe39OBEUoddbI
         U4ZwNhW/Tpi9HCPVnIqnxfXsvjbyA2nJPo98KWYJs+50EKIvuCzc86W02KNhr84dxw9S
         rpPO9kSx2pa8XL+Gu/zJOfLkfJ/lper5p2wveItJVlB1t1N8itOypPD3qktNfGDnsTRI
         0Qmw==
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
Subject: [PATCH 4.14 40/43] s390/qeth: free netdevice when removing a card
Date: Thu, 29 Mar 2018 20:00:35 +0200
Message-Id: <20180329175734.460645051@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296062916351982?=
X-GMAIL-MSGID: =?utf-8?q?1596296253873504064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5061,8 +5061,6 @@ static void qeth_core_free_card(struct q
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
@@ -935,8 +935,8 @@ static void qeth_l2_remove_device(struct
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
@@ -3046,8 +3046,8 @@ static void qeth_l3_remove_device(struct
 		qeth_l3_set_offline(cgdev);
 
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev = NULL;
 	}
 
