Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtHpl6SeCBgC13XVjt5+ntTqSQa52bsUmnpm/DDYIHrXybz6cCffdXnpLr7cdCzuzu9CR4T
ARC-Seal: i=1; a=rsa-sha256; t=1521214683; cv=none;
        d=google.com; s=arc-20160816;
        b=iyFvKjBqIr1G3IZnjVCJuJtuwo/vcpQICQ7qn78EhVeSwbVxi/xRjrhlrXdqR+cY3p
         AXA2kCaXshV0cP1U15pxDGlhVsBsQIY5AXdoko1B+AZbN0kFv+e57prOnns++Wd+tD9W
         zma4UTbhfh7S7DuXecLWBXqTXAW+10vJbENHY7lTSipo/6wtgt7jr/TI1zZF8/gMkZoX
         l8tCAQwkQHUpf2w+YBW6ItX0HBcbdnfJl8OPXpV8iQ0cICgZ2nJAenpWYRNyvQsrTFJQ
         L5FsLAlrLYN0hxmAW5i2UH6NfbqT/6GdWyNJ5ONmDi4Qoo/FoK0eFU2k4HDTinzbbPVW
         jpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6zD5hMPmcWDWTKV7ke9bMDqQocD6T3tyc12pUFQw4GM=;
        b=m6eXZefEbwi+RXpR9tMVCKHUWcMGJk1XEDuiywvuGjha06NEbMTPKI5gbChRwq9Nt+
         klVflIvmU+39CkWDJVLem1pf1BhCd4rcpU9JldkpxPnb2IMHViGLUMmHU//Y0dxHSssn
         1efK5rJ5OQAn0GbJTi4Vxz3zgSRY0pnPJ0ZC8enQ0lLwy1XbmAEv9/EOxSGOSZRtIU5t
         tPtWk/0DZfOer4sqt3VwM+Iv4XmefYcbEqXLb55NlE2QtcER7o7gC7nYT0zu+g/2Y1QL
         ZwQwbmoQnu1zFudSs7EAmuW1vLwoYstfVdii1fphcQfBejKmPJVtoI6ELF/tw9n7pXIO
         eGCg==
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
Subject: [PATCH 4.14 091/109] veth: set peer GSO values
Date: Fri, 16 Mar 2018 16:24:00 +0100
Message-Id: <20180316152334.862430052@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109208388318849?=
X-GMAIL-MSGID: =?utf-8?q?1595109208388318849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -410,6 +410,9 @@ static int veth_newlink(struct net *src_
 	if (ifmp && (dev->ifindex != 0))
 		peer->ifindex = ifmp->ifi_index;
 
+	peer->gso_max_size = dev->gso_max_size;
+	peer->gso_max_segs = dev->gso_max_segs;
+
 	err = register_netdevice(peer);
 	put_net(net);
 	net = NULL;
