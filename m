Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELthdLR/12Z0QQXZ1qjogP2Kp3OSu5pP1X31ZQw/IBYNZ/GJuALjg7wgqxJKhJ+4LQ52S7op
ARC-Seal: i=1; a=rsa-sha256; t=1519981412; cv=none;
        d=google.com; s=arc-20160816;
        b=mcimmJLGxx0OgLvg8aVanZFjwS7Yq+a6nVfeIuGaNbX+MulfoLxnGgTrlG8iWCV0Ec
         T31Vbajx/5f/e5wePfGF+aa+GwO8kC8N//S5mfwCzS4MNaV8yIYCTWQ/Yf4GEwSbrUFz
         RedHcVePPMg8F/QjC0O7+mAHQqbQ0+RNKFy6AsBTtpjQ7vHuab0US6y9FvA9tSSnk2Sa
         0XVGOII0PdMfIqgaoh5C+BRH6UTghu29YmD9cBkCm710/BVPoldIqbdxA0zi1xPTiC4W
         H4Z1+o5jUN+f2uG7vTGpPX6C6jLuPTMAYsnU1+/dlMxIMabbSXEdc82/TheXkFHnxDDr
         5oSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AJOKhx7qv8tkxQrlfwtlQLlTM/xDiYXkPE/uOdHqRpw=;
        b=BFOJG6rEnvsflOO0hf8KjFQpBlTyFMYt0gmVBIVW93LNKCjQyr1BFoV/QVmSwu65GN
         c+4RjKvT1g4YztIv9WY/7MPiL/rJFijAkbk6r8umwVovC4GWjk+ROJjRTAYpeZD360dT
         REbA3WN3ciAL0wQkmjwdUMflf1w0r6OpCy1T5bCHKvq3bLsCZy4Dzl0vk3NUrdv2+Q1U
         4kpfNdaDhEuRR46QHWHFGvwfmn7wcL07YKB2/18juAJak8+/AwKurx6A1+PX2efqJxvj
         nUzuClo65CCMQIbFOCqXC0RJrNbeVJxtErMo9eW/h8XM82W/9m+IwYOOr9KEOPQb29mm
         tnEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Netanel Belgazal <netanel@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 083/115] net: ena: unmask MSI-X only after device initialization is completed
Date: Fri,  2 Mar 2018 09:51:26 +0100
Message-Id: <20180302084507.208102278@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816028931880647?=
X-GMAIL-MSGID: =?utf-8?q?1593816028931880647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>


[ Upstream commit 7853b49ce8e0ef6364d24512b287463841d71bd3 ]

Under certain conditions MSI-X interrupt might arrive right after it
was unmasked in ena_up(). There is a chance it would be processed by
the driver before device ENA_FLAG_DEV_UP flag is set. In such a case
the interrupt is ignored.
ENA device operates in auto-masked mode, therefore ignoring
interrupt leaves it masked for good.
Moving unmask of interrupt to be the last step in ena_up().

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1565,7 +1565,7 @@ static int ena_rss_configure(struct ena_
 
 static int ena_up_complete(struct ena_adapter *adapter)
 {
-	int rc, i;
+	int rc;
 
 	rc = ena_rss_configure(adapter);
 	if (rc)
@@ -1584,17 +1584,6 @@ static int ena_up_complete(struct ena_ad
 
 	ena_napi_enable_all(adapter);
 
-	/* Enable completion queues interrupt */
-	for (i = 0; i < adapter->num_queues; i++)
-		ena_unmask_interrupt(&adapter->tx_ring[i],
-				     &adapter->rx_ring[i]);
-
-	/* schedule napi in case we had pending packets
-	 * from the last time we disable napi
-	 */
-	for (i = 0; i < adapter->num_queues; i++)
-		napi_schedule(&adapter->ena_napi[i].napi);
-
 	return 0;
 }
 
@@ -1731,7 +1720,7 @@ create_err:
 
 static int ena_up(struct ena_adapter *adapter)
 {
-	int rc;
+	int rc, i;
 
 	netdev_dbg(adapter->netdev, "%s\n", __func__);
 
@@ -1774,6 +1763,17 @@ static int ena_up(struct ena_adapter *ad
 
 	set_bit(ENA_FLAG_DEV_UP, &adapter->flags);
 
+	/* Enable completion queues interrupt */
+	for (i = 0; i < adapter->num_queues; i++)
+		ena_unmask_interrupt(&adapter->tx_ring[i],
+				     &adapter->rx_ring[i]);
+
+	/* schedule napi in case we had pending packets
+	 * from the last time we disable napi
+	 */
+	for (i = 0; i < adapter->num_queues; i++)
+		napi_schedule(&adapter->ena_napi[i].napi);
+
 	return rc;
 
 err_up:
