Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yFmWYATSBukj+sXEBIZfsgJhrgztNpJdScS7swm1410MyMOwaObDqE7+kXw8EqEG3Mwcs
ARC-Seal: i=1; a=rsa-sha256; t=1522346902; cv=none;
        d=google.com; s=arc-20160816;
        b=U4LVD6nE5Wrowt7reR1ATyhPIgm12T2LOZD9YDlew+NWcO3ULK6LKKiTC22KHebJ8g
         VDkBa8v5BZiSojeZdyRgau43hb8mPCunlmsm8EqjZOxMXUlWKqi62ycD6EU3vnHq5btY
         T6ZjT6Kdqdbd+suPqcpxVPIChf6tqhAhy6gVr4is3bvOPFXHb0hPTSOXxu5deBfeVLrP
         bwhj6OVII6v7XS2jEa4NXYQx7BzQ3L2J82ecLhRqCW0B6pSk2anfYLLuZrhnjigALrR5
         cWyZ6ogrEkuABe+/4nYJkgVvfqcbMgeDODY8KNH6ahfbMab5rujhIQkHdOTYOGM2ihAp
         Qj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2P/xCYN6wF28rs+vopHIGf5Cw1vd+JPcOveDbiGUNlM=;
        b=K04Sd0lZje2jjZsEnOs9F660wek2qHl8mrPHH9Lcmw0rtKlSqpOTbztWGRggWyNIk6
         COxhEBoItYeM5upuGTFHfF1WF7eUHawjYi5x30iDs55AFN91eg2INgD4/1aaluOOPf4z
         dvFOj4MMXxDtk+bEJn35k8Uck3qStf+1TCE8hIgLWUk1tQREowb1h5DHBlFNFAPFyQ5P
         68819ppTRILmIMkufwDP3SRhUFaQJ/CIt7BMtHrVIC/v3Ikg+uELldWUZLv9jRSbLeVT
         XpZUlHn1GGsmAyHdD1ESu8zU9OLdzfpFSQbRNmD35scAjmBwBCdYEZAQ1pCOXvJVKuw7
         ebNg==
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
Subject: [PATCH 4.4 18/20] ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
Date: Thu, 29 Mar 2018 20:00:54 +0200
Message-Id: <20180329175742.805429429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296051714340324?=
X-GMAIL-MSGID: =?utf-8?q?1596296425641191742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 		goto out;
 
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
 		break;
