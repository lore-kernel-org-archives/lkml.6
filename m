Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/qFZ4PMiq6VfiUnwpSdXkpnTM4aMOAAlfbPRlDHY/BNzxlErm0B3jhCPJg/ZflKtcnwrvW
ARC-Seal: i=1; a=rsa-sha256; t=1522346635; cv=none;
        d=google.com; s=arc-20160816;
        b=PGxNTgTX7VJE2elRtPaGIqulEMqGsENR/kpCltBANGKgtXiYzDr/UKBLMaXlzuRvmM
         FVWhA1n8529QMpfKzGSajbSwhGPt6auP5qlwLKfFr6rV+9X3rcKr5udZXwypBAP2hYG6
         u0rujFqhirx4wWx4/lmtxgKh8rvfGPRcr/Mg9LRufIuGTs06M6W1NmCKXcR0gpDz+05Z
         2RvLCl0A/v2xffBIzcV8WYJkLJOShfLbXGtmHN0bY6EluLXFC2KoPSR+IbWAi1ZEgSx+
         Np/pcYRbOzCU2qZMDxbxfrDrhS/eWndYZlKsaf2fwNkV6xSm47iehMrCIIdOWqQAnMjg
         jjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vnXH1TyrBlH2w0iY4ZzOxGAdHnDAIXCbhlmM08mYaHE=;
        b=yBSvGLbr74FgG4XVu4gQQHjdzLvenCtoa1iwSZR3681uwNNhGmHmbtPxeIp5uFij45
         PQ7O3BfDDwms8LKuZi0jZ4Oiu3Ns8uiiOo7qcVyVk4/b6cgR0+GFqZNaPaZOqhiIwPhj
         8lD1awSulSbejprzCAyAm4c7LX8J/7FLQXib3WYfjJeKbdME4iHCDDLQ/REh/HXygTEO
         2IGRhvfv/D0c/lbDe4RlTqQMep7KinbJdqwo+NV79bPrXIBFF1FfJn22oUcyIfBkFSCq
         KMibGsr1AFgKSg4aYYKNMcOqE+zY0pIAonebPY8FYT6vu1K9Jp7nd2Ot6npP02L1ZmAK
         Cj2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kalderon <michal.kalderon@cavium.com>,
	Ariel Elior <ariel.elior@cavium.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 45/47] qede: Fix qedr link update
Date: Thu, 29 Mar 2018 20:00:26 +0200
Message-Id: <20180329175733.294847819@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296145048379870?=
X-GMAIL-MSGID: =?utf-8?q?1596296145048379870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>


[ Upstream commit 4609adc27175839408359822523de7247d56c87f ]

Link updates were not reported to qedr correctly.
Leading to cases where a link could be down, but qedr
would see it as up.
In addition, once qede was loaded, link state would be up,
regardless of the actual link state.

Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2066,8 +2066,6 @@ static int qede_load(struct qede_dev *ed
 	link_params.link_up = true;
 	edev->ops->common->set_link(edev->cdev, &link_params);
 
-	qede_rdma_dev_event_open(edev);
-
 	edev->state = QEDE_STATE_OPEN;
 
 	DP_INFO(edev, "Ending successfully qede load\n");
@@ -2168,12 +2166,14 @@ static void qede_link_update(void *dev,
 			DP_NOTICE(edev, "Link is up\n");
 			netif_tx_start_all_queues(edev->ndev);
 			netif_carrier_on(edev->ndev);
+			qede_rdma_dev_event_open(edev);
 		}
 	} else {
 		if (netif_carrier_ok(edev->ndev)) {
 			DP_NOTICE(edev, "Link is down\n");
 			netif_tx_disable(edev->ndev);
 			netif_carrier_off(edev->ndev);
+			qede_rdma_dev_event_close(edev);
 		}
 	}
 }
