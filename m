Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+m407+MJ81T7bRxPUhgqkDFnej/L2eMmt6kiC9O6/ETuDRySmHxhoTJH0KAAoZaWzHZonB
ARC-Seal: i=1; a=rsa-sha256; t=1522346675; cv=none;
        d=google.com; s=arc-20160816;
        b=m6N2HetnGUfIXjkZWywONqt3bi+HMVYO6PtIpu7kd2KuizCtOwv0bWa6thXjtFJj8P
         E4hRJC84Br9piMoOHnRJHqME/Y6blY8F0qv9uBY6W+5VwMO4KfvMM5fVXj4UdQbCu39e
         jcplOpA/zvv6ax2jj+revYDEBf9xL12vFY6ZxHCrnu8bXSE9YM6hgpX4B0X5YmW7ut/h
         J9xLpDwpy4KkFyLWeBIEW7IufpPbxKvSwbfKzNHk2RM/QMOpkwsQs5NlFQEAPmakkHVc
         lX+PWvMOzAjutPnGhevIEZSnSQLtk3/rD4RGW0KMy90xhpMBDpyfmfxtLL+LnxQ7Ton8
         j6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mY84Ry/MKzzm7vybLg4reVzvHWsls/58DV0bDmuaB4M=;
        b=ZhSXlSC7JsXRVurXfB5IJ7huV+BAEtw4titqok7B1tE6BpFZHJABTcSxa0nigIqLVD
         1SiBbvicS4lSglMqk+JvOqhNWTNbnZuVgJ3GGf3E94/FSfBhOiykK5qST0HjY92Hj2Ix
         HHWpnzB19GqKO47K5eMEVxIcTyoZ0PlyNeFK1SJrhBDbYUWPbe8KFt4GkyyUqtdQw8X7
         3zOdhRZzBkeR/mna2O/WtubzQq/2YQlIScKnyexmUSspz6cEzG5N3Zd/jv+KVjsWBvwv
         dMjy/bQWLSus3sMWHnQvW3HTmNxy2ZhzORLRTDIjsKwaccu/f6VFrPNcBRCAuW/XxWbV
         UBHg==
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
Subject: [PATCH 4.14 19/43] ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
Date: Thu, 29 Mar 2018 20:00:14 +0200
Message-Id: <20180329175732.127977782@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296051714340324?=
X-GMAIL-MSGID: =?utf-8?q?1596296187477658713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
