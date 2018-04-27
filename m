Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqOjSNj9+9y6mydejH5hIT6eAWc4kxeq8ZTpj5rGji235BOAFCfz9BOCOYB6ts+AOJW73Q+
ARC-Seal: i=1; a=rsa-sha256; t=1524838309; cv=none;
        d=google.com; s=arc-20160816;
        b=TlceTwP6IMFvpUszlKobxIDOisbSN2Z20zAz5nYB+qVtHTLJXnrmRux5g2IaTHfdi5
         Ivfoq/MkefOszG6S+L3LoLeKWGFT2rO0MdkdeWq3yXHEKczo8furKLeNp31UcwMpVCf7
         /f4nguVDdHMc6ibxSRcicXeoGmAkb8exdmk7NrXayisxQAAqxic7I/W2PjP1BPLh8GGc
         AbHCKicEIQyqHjlNR58H2Gc2MqDxSt9zLah3W4zCIOAiXLIuEpdoKDjRSiWJejjWIdVK
         p9928E/MWjMmAhCW75zrtrt9koGIGm6NFlRrnKfDwKKCaB1n+1GZ3SYyvZv0Jkc2UE0r
         KkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=9h04DGzb2vPkMIcEr4BlO+dwF9CReu0bthZveG3jG3U=;
        b=WtcywjjWa3p3B67/q6/dMBEpROPOkbSVPh1Fjkgpz8Z8+29FIKR22DLwL1SJu90JQq
         IMY7ah7RA66xy9eR4feS5+aYI8DCjoOjU+3RTWSmvTWo+gWk1eGNjQd3S81olAxAtKos
         FrmGKdfuHEmUkK7aSguYY9s1qL9fS4O8fMI4bdZYH3XQHm56yE1IFhJYSPowq9mtWz8P
         pyVLfO+uWIaMMfXAgGenWfbedtIfwEGRFqboHjr2Y9YXRw5+4fZoT6VQZOTm/Y3X0nwZ
         WGPgiatmOumzgjsaTUYGscjQW2DySqSD1I+Y177IbHEwCQ74ju+0wos+T89tq+eLQeZb
         L2rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2492189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Arcari <darcari@redhat.com>,
	Igor Russkikh <igor.russkikh@aquantia.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 57/81] net: aquantia: oops when shutdown on already stopped device
Date: Fri, 27 Apr 2018 15:58:59 +0200
Message-Id: <20180427135746.588632187@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908854896987444?=
X-GMAIL-MSGID: =?utf-8?q?1598908854896987444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <igor.russkikh@aquantia.com>


[ Upstream commit 9a11aff25fd43d5bd2660ababdc9f564b0ba183a ]

In case netdev is closed at the moment of pci shutdown, aq_nic_stop
gets called second time. napi_disable in that case hangs indefinitely.
In other case, if device was never opened at all, we get oops because
of null pointer access.

We should invoke aq_nic_stop conditionally, only if device is running
at the moment of shutdown.

Reported-by: David Arcari <darcari@redhat.com>
Fixes: 90869ddfefeb ("net: aquantia: Implement pci shutdown callback")
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -951,9 +951,11 @@ void aq_nic_shutdown(struct aq_nic_s *se
 
 	netif_device_detach(self->ndev);
 
-	err = aq_nic_stop(self);
-	if (err < 0)
-		goto err_exit;
+	if (netif_running(self->ndev)) {
+		err = aq_nic_stop(self);
+		if (err < 0)
+			goto err_exit;
+	}
 	aq_nic_deinit(self);
 
 err_exit:
