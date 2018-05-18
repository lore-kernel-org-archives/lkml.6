Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo/dFfRleBl1Dv2YXbpfY0KSWN+2CA5/zGruHp52/L0vB6lPJpwTlhxtOyx0SELIA2p6ceN
ARC-Seal: i=1; a=rsa-sha256; t=1526631614; cv=none;
        d=google.com; s=arc-20160816;
        b=nVHLihl865GKjgNc9OCO2cXlMH/GDKapAVD3y+NoigCnRpr5IKA9ZMolWAbJiv3HD1
         vH4qji8cD4817kV8vQhAwXDC51kQJ8juNl01AjIoTvpdFR9xGWiC9Q72Y95mlw483iba
         E5I+j/wjk0o/jRDH1oZ2vopWC5ZT1WSMqcequ5wH/ZuKrySjyFL3KGG+U1o3pkM3RorO
         YFR/Gy7lF3FvZshuqV5UXLwmGM4KDEOzy7fcQK4O0yQwLd8TouUzrdYAlo81B/VDRxEI
         JyA4/czMWvICMidfOZCHrL/8PJxjdIZzwe3rQL24EgInw5E/syYz3MATKSNVeA38iOhZ
         sD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=E51ZxscytkpQ1qKPct34/IaUTJAoszG68R7FcqXQtFk=;
        b=s8P3GQMImjX+AiLcH3u7+W0EschEwWqFZpnTPFbRYvDIEZ5x3jQMGktVIhlPAB0rZ9
         AnHtnA6a+NDP5QCyQ3k9X33XsWvUVCLdOZoGVkhv0VVqhVNKKoDB9QiO89i8liJ9/n+Z
         wRDYSnczRUJqgrpIs+NzUCU9iemSGRPNYVZjpYIva7xD8w1UdzCEKj9Z6uF16AhAVHOr
         /nCCXjE9sxuArkcZtdUV1ErPe75F9zYBdBrZOlXBerDqJCBWIc8C0rdVeXEWenb64TKk
         pJtivZIFUyUzMt6LSMu1hyjvVi8pexp2UDqgM3nZpYbLggI6PgMGSEqRJ7IWew76U6fi
         tAQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l51odCpy;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l51odCpy;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Debabrata Banerjee <dbanerje@akamai.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/45] bonding: do not allow rlb updates to invalid mac
Date: Fri, 18 May 2018 10:15:47 +0200
Message-Id: <20180518081531.873661220@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789117326053762?=
X-GMAIL-MSGID: =?utf-8?q?1600789271703968795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Debabrata Banerjee <dbanerje@akamai.com>

[ Upstream commit 4fa8667ca3989ce14cf66301fa251544fbddbdd0 ]

Make sure multicast, broadcast, and zero mac's cannot be the output of rlb
updates, which should all be directed arps. Receive load balancing will be
collapsed if any of these happen, as the switch will broadcast.

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_alb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -450,7 +450,7 @@ static void rlb_update_client(struct rlb
 {
 	int i;
 
-	if (!client_info->slave)
+	if (!client_info->slave || !is_valid_ether_addr(client_info->mac_dst))
 		return;
 
 	for (i = 0; i < RLB_ARP_BURST_SIZE; i++) {
