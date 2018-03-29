Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+o3+SX6sFSH57AlgG7ojTZvaRoXmfSaQ8BmelRcebYt965G5ab/cMtIUpHcaQllpVJfN+
ARC-Seal: i=1; a=rsa-sha256; t=1522346546; cv=none;
        d=google.com; s=arc-20160816;
        b=Bqq2yCbbIcnPZbsqB48aKbzPDXB9dlSZZGtNLqf8GkUaPDuYEp85zD94wEIYo82/jo
         8XIdtlg6smGc5JUDVnGheh8u3tHU6dLldbZmXX9U33Ys1l5YssTPpHM/AYmkX3IIGQ5X
         JbhL3zkdv4f8UDjAAruaQ+mGuccRWEFCTbfNbuaQpJ99SCIdMrvbdvh2+5MoHm2XcDDn
         aTbMw04cU3L74AqFx1V2CkSUchxmuruWVmX3POrE/HimmJL2jpalR8i4wKP3//G4FZSU
         y8kFRtO40V2YRrYxhJytIq7ceQx8u5yZfMyTTrRbH7DUAsmrA3Rmqk4S//rjmvHES63f
         7Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RsS+ua/PD6UVtEVAm/0n4qeTIV29slW+4RnSwBEwz/w=;
        b=DLXBn8gKTB5nCurb3pqk6ld698FU9QZ9cfK8wui0ic/SYswFwdpvKT7BdNIcTKVuS6
         dtl61f1oE1JZdku/sE/NQ5GnU5Qju4kHEYLRuuDn5AhPkOxyQuQy1EgmpHjZFctOVVga
         qhAT/MTv2deGv91rUSscLbFyDEuZuL9rnMOyN+dWIe6CGMdeBiOwXjHRSIdsF0rV/YFp
         /OBZAKW3X5Lszx0f4dzh60pE+ZMI0I+QoJ8sh/syROgC7ZRtBG4cSTGMJ0/lZjd05s//
         xE9kHjOaJH2INzzmnguz9LGeIyq+6LKVHchGQ6SSOTe9hLen8C8R6JxIplaR7NOCDWIF
         Z3JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@osg.samsung.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 23/47] ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
Date: Thu, 29 Mar 2018 20:00:04 +0200
Message-Id: <20180329175730.973977320@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296051714340324?=
X-GMAIL-MSGID: =?utf-8?q?1596296051714340324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit ca0edb131bdf1e6beaeb2b8289fd6b374b74147d ]

A tun device type can trivially be set to arbitrary value using
TUNSETLINK ioctl().

Therefore, lowpan_device_event() must really check that ieee802154_ptr
is not NULL.

Fixes: 2c88b5283f60d ("ieee802154: 6lowpan: remove check on null")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -206,9 +206,13 @@ static inline void lowpan_netlink_fini(v
 static int lowpan_device_event(struct notifier_block *unused,
 			       unsigned long event, void *ptr)
 {
-	struct net_device *wdev = netdev_notifier_info_to_dev(ptr);
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct wpan_dev *wpan_dev;
 
-	if (wdev->type != ARPHRD_IEEE802154)
+	if (ndev->type != ARPHRD_IEEE802154)
+		return NOTIFY_DONE;
+	wpan_dev = ndev->ieee802154_ptr;
+	if (!wpan_dev)
 		return NOTIFY_DONE;
 
 	switch (event) {
@@ -217,8 +221,8 @@ static int lowpan_device_event(struct no
 		 * also delete possible lowpan interfaces which belongs
 		 * to the wpan interface.
 		 */
-		if (wdev->ieee802154_ptr->lowpan_dev)
-			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
+		if (wpan_dev->lowpan_dev)
+			lowpan_dellink(wpan_dev->lowpan_dev, NULL);
 		break;
 	default:
 		return NOTIFY_DONE;
