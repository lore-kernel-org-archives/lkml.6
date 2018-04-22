Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8BJ63j69LQLVPPG0yC86XpZlkPUeTe/bQ0IM9O2n7FoyDFbqq5qgnzK/EykYxcr/B4F7E
ARC-Seal: i=1; a=rsa-sha256; t=1524406226; cv=none;
        d=google.com; s=arc-20160816;
        b=G3tqIA50Bux7vm7Hm4wABKnjx64VrfYtrUuYthA8RKxUVRYXdsOPbeFSvYZeVixfFL
         8QKYuYmOuEhX8WnxzLaXt8FpOsh/qKRi2Vo5qnpQ0H/W6ARSc6sFwblLJtGxAPQ/DTNy
         qQlwOELBrzpUh6TkEH1yBLTgML8R9b3L7vlZNLmPoAeoLmagJn93bCYeXYFDumlSBWUx
         i8kNULnXiE9BJ+llpwpb9BLbxfVz8VpAf0C0AKhxeGXu0vDuL0DCoVs4QAsj4FFzo4TY
         GKziq1lYYdcISHQtIf6B/QaKYWEtYlRrhA22xgv3ndz9yTWdifRjTn+Nvmp9bTDuPt1L
         6Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mfx7samidQ1nHoA1c1+qnazCy9ClZe5DzMPYzO8xwyI=;
        b=QjMVrsSvTXHd6guWxSsIGubdVpA5fB58kpAeu45iKAr6fAdemdx1oc1D3Dmiw63YkY
         Gu7Ac5AUkQquBCoVmi/LqytfI8rJ2QHYuv4F38Aq3NbJqHaBTKnQ82G6to6waajZrDgC
         bJGHQ+NyuQYiKgMuaynZLVBR5skKjwAAxvjqPv1Fh94hs+jpDp3bk+eHVbyMG1HaCZMf
         qTwHjChpzQTAMAmm0mfm47BxUwLHneJmZrDj+YCF7qn29DIaO9sLZN7LZ8hG7LOy4rNV
         jfZ6rJHcUij7eh9l7nj+WN8Hl+5FwzfXekPj+yVchhh5gVrUnLAbYJqACeJXYwtThh1x
         kt/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Healy <cphealy@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 159/164] net: dsa: Discard frames from unused ports
Date: Sun, 22 Apr 2018 15:53:46 +0200
Message-Id: <20180422135142.118069425@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455784163331240?=
X-GMAIL-MSGID: =?utf-8?q?1598455784163331240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

commit fc5f33768cca7144f8d793205b229d46740d183b upstream.

The Marvell switches under some conditions will pass a frame to the
host with the port being the CPU port. Such frames are invalid, and
should be dropped. Not dropping them can result in a crash when
incrementing the receive statistics for an invalid port.

This has been reworked for 4.14, which does not have the central
dsa_master_find_slave() function, so each tag driver needs to check.

Reported-by: Chris Healy <cphealy@gmail.com>
Fixes: 91da11f870f0 ("net: Distributed Switch Architecture protocol support")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_brcm.c    |    3 +++
 net/dsa/tag_dsa.c     |    3 +++
 net/dsa/tag_edsa.c    |    3 +++
 net/dsa/tag_ksz.c     |    3 +++
 net/dsa/tag_lan9303.c |    3 +++
 net/dsa/tag_mtk.c     |    3 +++
 net/dsa/tag_qca.c     |    3 +++
 net/dsa/tag_trailer.c |    3 +++
 8 files changed, 24 insertions(+)

--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -121,6 +121,9 @@ static struct sk_buff *brcm_tag_rcv(stru
 	if (source_port >= ds->num_ports || !ds->ports[source_port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(source_port)))
+		return NULL;
+
 	/* Remove Broadcom tag and update checksum */
 	skb_pull_rcsum(skb, BRCM_TAG_LEN);
 
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -107,6 +107,9 @@ static struct sk_buff *dsa_rcv(struct sk
 	if (source_port >= ds->num_ports || !ds->ports[source_port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(source_port)))
+		return NULL;
+
 	/*
 	 * Convert the DSA header to an 802.1q header if the 'tagged'
 	 * bit in the DSA header is set.  If the 'tagged' bit is clear,
--- a/net/dsa/tag_edsa.c
+++ b/net/dsa/tag_edsa.c
@@ -120,6 +120,9 @@ static struct sk_buff *edsa_rcv(struct s
 	if (source_port >= ds->num_ports || !ds->ports[source_port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(source_port)))
+		return NULL;
+
 	/*
 	 * If the 'tagged' bit is set, convert the DSA tag to a 802.1q
 	 * tag and delete the ethertype part.  If the 'tagged' bit is
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -92,6 +92,9 @@ static struct sk_buff *ksz_rcv(struct sk
 	if (source_port >= ds->num_ports || !ds->ports[source_port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(source_port)))
+		return NULL;
+
 	pskb_trim_rcsum(skb, skb->len - KSZ_EGRESS_TAG_LEN);
 
 	skb->dev = ds->ports[source_port].netdev;
--- a/net/dsa/tag_lan9303.c
+++ b/net/dsa/tag_lan9303.c
@@ -108,6 +108,9 @@ static struct sk_buff *lan9303_rcv(struc
 		return NULL;
 	}
 
+	if (unlikely(ds->cpu_port_mask & BIT(source_port)))
+		return NULL;
+
 	if (!ds->ports[source_port].netdev) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid netdev or device\n");
 		return NULL;
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -81,6 +81,9 @@ static struct sk_buff *mtk_tag_rcv(struc
 	if (!ds->ports[port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(port)))
+		return NULL;
+
 	skb->dev = ds->ports[port].netdev;
 
 	return skb;
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -104,6 +104,9 @@ static struct sk_buff *qca_tag_rcv(struc
 	if (!ds->ports[port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(port)))
+		return NULL;
+
 	/* Update skb & forward the frame accordingly */
 	skb->dev = ds->ports[port].netdev;
 
--- a/net/dsa/tag_trailer.c
+++ b/net/dsa/tag_trailer.c
@@ -76,6 +76,9 @@ static struct sk_buff *trailer_rcv(struc
 	if (source_port >= ds->num_ports || !ds->ports[source_port].netdev)
 		return NULL;
 
+	if (unlikely(ds->cpu_port_mask & BIT(source_port)))
+		return NULL;
+
 	pskb_trim_rcsum(skb, skb->len - 4);
 
 	skb->dev = ds->ports[source_port].netdev;
