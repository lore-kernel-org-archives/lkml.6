Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqVxJxGxcL5TVJNTj/tW7Pv8pV0F2zRxNrdpgza6n4ViKl00UMrTieo/HIslPrHLaH36+Hi
ARC-Seal: i=1; a=rsa-sha256; t=1526631467; cv=none;
        d=google.com; s=arc-20160816;
        b=OljbT+XrnQrHbFGlCplBEeH73J9Q6EvY2DB/dsjcmKE1wEtbJM1YLKeMZ5TZtSHf5V
         qs9bhwgxox15Z4U3a4JOEaO6vjjF/iD1amdJMynr49tenIhR4mu/L4DrOjebu4ePCwfb
         OZljtTpXRSFDDAUsb0e8txzkbpFqZUg6U9HMZAXFLycHDHIF6mne07bjWRAPIu2u+0CW
         AKKzd43ep2XiWqr9SDmBTyrI5LRIe+eRsCJtmQ/tsCEA1Q6ZRrUVTtwXC3hKKEZeII5G
         Bl4gIr1uVnLZioC4HsgEtCuweExjSTmclchx2QsK+PrXBQCpyvLb1GloMLYPqSsPUBmO
         IL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3nXOwEZ9p0+AJj52O8mwXT5J/pNzjPojmtMUbaPxOjg=;
        b=mgeNP83oQcafTfqlfjbGk/E09QtgR0b4nmfsBgpwwR/k3dh1yH3gaS3XmyDt+AxLjq
         B1br9KoCmizrDRNUQ7yJD4Lfz/wmCbxHAQXqSet+2HJGmkhV5UuJOu39/6U+UtsozGEN
         j85V6f2vNGI3enKTVvwKWZSninoZlELJcSPUlS4gsEiATitp/IS+caRoWyEfNIrlzkJw
         xvYqFZ9JebpZwO3EpzFR5jXp8+BlRtHFo/a8N6RZ8f8hhsqT5qoBgShCGm7o4YguEjob
         xKAG8EMY8F2AIupUzCcccPybP5LE744IMNV1xQfnDcxoaKA9KuferkPiM596YhCYmErd
         D//g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lALQMQHQ;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lALQMQHQ;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Debabrata Banerjee <dbanerje@akamai.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 31/55] bonding: do not allow rlb updates to invalid mac
Date: Fri, 18 May 2018 10:15:27 +0200
Message-Id: <20180518081458.962621076@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789117326053762?=
X-GMAIL-MSGID: =?utf-8?q?1600789117326053762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
