Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJW0MqISaMaa9tqwwFwRtNUWsg4AMkgBEm4SuiK5tn6/oHu5IFNSlwi/Qb93u5knesSEUq
ARC-Seal: i=1; a=rsa-sha256; t=1521484012; cv=none;
        d=google.com; s=arc-20160816;
        b=lPYbXexdnKqed4mIP3Wm9vr2HKNM/NeTVx34SdJa73rj8S4jI7MaweAzDl8fBOpRPd
         920D/yMTXnpWpI5LxOY1a7iYf0AUB114CjCeOJHKOfKj1+xIty4Ag5SbQCpHvh6hEHRI
         sQtOoR86eNy2cgU1Tac95bcLR5gcW2MKCaq+yEld8XNmKbOjnT5PestNbG0DJ0PJBh4P
         FFXaFah37uUs3Lske5kOQUWcOsy6F/Zg/bxq/YsPQu+GZOYh9hmvDKzjdCaDFAZhiude
         VayNE5xyirgxmaf25opeDhJV9Tg1WXxuOBkZ56rFM5+ZbwipwmmvfSftc38z9egfjZDm
         1iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8oJA1H2ZhgbIL3zYuFeo9INkmFjPQbiUS3UlV5PpHwg=;
        b=RE/fW8ZtQWZujJ9LXMjqGQdFTFDD9gOYynmyCPXUe/KuFEj6fuSrAZjswATcK6gFYF
         kzaA7hobxrt8P+4K6vVa+/RvSQAQPWWtQHWh05zK7PpUsyVsUSYDf8N1rnvzUCnCVafP
         P9WtYXogfMxWwFVruFKvz3ucJPuQWHGza4J6lc+Fy8kOCDhoKCNtf6UUrgjillOaxbkf
         TjZZ0if4Ke+MSWiZM9ijm/h2u5S7b+2Y0YafbqaE4J9bzsMT6lZHlVF4ektKzr13Hx5W
         7iKnGEvxBLWBcOtI2RMB+Ojh2W4OH7m/3MoFA9/WGSrMGtZO05JvxlxECKc31ryNoQa9
         iWjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 199/241] veth: set peer GSO values
Date: Mon, 19 Mar 2018 19:07:44 +0100
Message-Id: <20180319180759.431582219@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390628799057705?=
X-GMAIL-MSGID: =?utf-8?q?1595391619410607098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>


[ Upstream commit 72d24955b44a4039db54a1c252b5031969eeaac3 ]

When new veth is created, and GSO values have been configured
on one device, clone those values to the peer.

For example:
   # ip link add dev vm1 gso_max_size 65530 type veth peer name vm2

This should create vm1 <--> vm2 with both having GSO maximum
size set to 65530.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/veth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -425,6 +425,9 @@ static int veth_newlink(struct net *src_
 	if (ifmp && (dev->ifindex != 0))
 		peer->ifindex = ifmp->ifi_index;
 
+	peer->gso_max_size = dev->gso_max_size;
+	peer->gso_max_segs = dev->gso_max_segs;
+
 	err = register_netdevice(peer);
 	put_net(net);
 	net = NULL;
