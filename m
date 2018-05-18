Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqhvwG+DpnL5SBBEz5dwBaCAUSXFTqmyIYBQYiFP1uvwJFXrcuorTnKtfJAeGlnwMJH1LZx
ARC-Seal: i=1; a=rsa-sha256; t=1526631712; cv=none;
        d=google.com; s=arc-20160816;
        b=acxFidnoGpXiYN2O0r49rmBKxJxGD1kAEpseCH1TMC3XlmSpDJmp1TzBGrg976T5lK
         xguWlz8XNfnKA26ojFOctAhQxd6xxxrv3Djl90PnJVk1xp3/6lAXMaOS/aP/vHJgo9t7
         8aDmMgekvQU046/pbAFlKaEre7pTBJVk3zl5vywPMd/B3BPekhGRtDTFZZCXC8L3LPRc
         lx+beIhzgPD6NG+AK88V5koGZFBqSAw1DiNlNHSJfGdAtkizYocqhK2WoOnvoVggFNSe
         zXUTkuWA8MMnsNoNwbAhjWBgFJsHjx760cp1k9ae8megb4lBITFSku/6OwtxeO1jActO
         wuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WGyAjFqgrBDmocmKiWMoUWh4IqtahZ2DdbgydzX902I=;
        b=xqFM60a5XtJ0hVG+UKe2tqMNK1VBNg7RV259GNDvRsPASrzHMhPV0cPik2DDSogUJi
         WEnc6LeuX9vK9gEJERMkjkh95JuhQjvrOkJQbhk14gim4m9dvWJJEd5plaeQuNifY9rK
         0NG5Udgn/xTlXroNdaNQEP9MBxkfYyjfFKNP47l/YZvSe1jZW6vGabUHhcCmKyLRiGGI
         ciDSfMED8aLJ9zF9ySY+KDcT4QCsnCLDHm6Pj6NpcT2NqDI9B/gN4wenknVrHOQFAj+H
         bVYOBs+EHcLNWX0TsUywJ573KCUMZLJOh2aUXS+fh52yP2ILdlNSE0FLWeyxwjsoK4M7
         CKeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XpqX6pmf;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XpqX6pmf;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Debabrata Banerjee <dbanerje@akamai.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 20/33] bonding: do not allow rlb updates to invalid mac
Date: Fri, 18 May 2018 10:15:59 +0200
Message-Id: <20180518081535.908070464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789117326053762?=
X-GMAIL-MSGID: =?utf-8?q?1600789373811186633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
