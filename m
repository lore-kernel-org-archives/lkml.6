Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvMsRtB+9DX0WUdcyvVqBOgi63EmMFMKFcJlpbzNPhgTvulpoy0TAw/JH1VrbqWTwIrcxzo
ARC-Seal: i=1; a=rsa-sha256; t=1521483379; cv=none;
        d=google.com; s=arc-20160816;
        b=A4sdhWNBd/bIuiFQSaR+amc6NTKjk1xyuGX0vxlI/1dKD1l5MXuLHSJ/5KnNoTF9nu
         rkmZVkrwZfd/4eY8QvsCwpzWA1J8yRQK7eml9Bd67tCrIzCEh5O7cEBlhmQ4W7ZwwHGe
         Hq0v9GxZmIQc+ks4gVz/mw68ppvmubSM4lLTi4U3tCQZ8/LeQx5HISKbxFXcg0sy8/CK
         OfEDePMxHavIpSK2zz+w+AIIWBDdyPodqwUMJZvuKZTcvoFdkcM+imNCJ3YLIPCvaC8P
         +/ngSuS1ciD8TviCtNapt93VBq85DtKSlJZWACp+aLRBp1uCH5i5VRsp2RK3ZkrqoabW
         6wDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O21O4p3mT3YWmYYagH80rk1Z+pdTLsGGteCPgF9I3F8=;
        b=sRM4+rGLciIeY4XipDtsHjfS3IfMoYmameT1BUE1kw9MQ6w//pZ3Wgpn+lo2LvltyN
         1sYsBhTt8qvwL2yNmr57fzFzfeU8EEsrrp7X5AT0Hty4QonW25fJTAHCr7QGdUIcTamU
         JAEPP9liZkwV3xXBDp2jps5oPd6t/u0KN1MiF3Oh+quY4p2Xno+fjAny8b39bLNJdBOA
         tYLbiIQzHz37WznTuVqmWahyiOMD5VrPxSZ7onwZx7IB4kU42JpYWG6XYjqBnHjt9Ipe
         fp5FxPe8IfWEHdC6FdbxMNPJcUch3KKU/2UP14W7+8aHbZVXy7SAIcTrHgBacNefU/0C
         kEgQ==
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
Subject: [PATCH 4.4 101/134] veth: set peer GSO values
Date: Mon, 19 Mar 2018 19:06:24 +0100
Message-Id: <20180319171903.826889201@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390628799057705?=
X-GMAIL-MSGID: =?utf-8?q?1595390956426594653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -399,6 +399,9 @@ static int veth_newlink(struct net *src_
 	if (ifmp && (dev->ifindex != 0))
 		peer->ifindex = ifmp->ifi_index;
 
+	peer->gso_max_size = dev->gso_max_size;
+	peer->gso_max_segs = dev->gso_max_segs;
+
 	err = register_netdevice(peer);
 	put_net(net);
 	net = NULL;
