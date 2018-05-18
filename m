Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpsP7HdgbiTMWZ7XLCB29sy/eeYFNOXF7dF+qq1Sk6LFVx9EBrr/s9YfbzD8DjdNXSvNn+6
ARC-Seal: i=1; a=rsa-sha256; t=1526631581; cv=none;
        d=google.com; s=arc-20160816;
        b=abwabO0G8074xnaZHdpSlsG416ShUPM58K5hbm9GnowUuo6ipQLY20xZBgnSNR4Gvq
         x91W7EbI6NiolCSKbCzORXAtu0MhfKRpIR2pSbo2rTu7usPnE6Va1XQjvLsnq88ENsPc
         SCtWHc3oPlkkoeXt0ilrgAemI2Dj7c0U41JyR79M3yXqz//2GoUeC9B2TWGMejlD1Jym
         WXGGlYYlsRE2Epa4v6FQAPWIyqGM1M/E95ums7+0XEAWgR807CtfcIlpaWbbjR2fxRce
         tDlq2y77EgWVCjloLPbfQMy6caDCgZL4+1pwR4auEEOcQu+R+BgYJ1FoxKI517sf749B
         5NJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=nLdXspPE+4VxcFW4sb0oJnCtGRI/VlPDNfZH6m71chU=;
        b=GBQ8DwlRA4T4cgylQnd8hs5vzL0YBXiLlSa+0PSSz3KKjrgh8Wcce/HTcbLFrL4edl
         fFYZQy4e63de5PeVJX/lAwekLQqXQl10toiguDK26sOXUe0FYyMJNpxF2PCH71p3gQhX
         PEvnGrJrrAgy0qPeKHAhHm/ThvzNVTWiMU/wfRc0fwiL67NgQMD/DSED1bdqcStETyKS
         W98qmUm86SlqmUPjsM9JsuhQfFfkLR6xy01tq7bppNsFPjw63na4GWmVVnQhRVLCB2iR
         46Ns7ZYgc8vRAQpUwqSG8pzbLq+2J293kT48fEQZvofXeQAd7S4OVppUUjE7I+NUe3aa
         ZR9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tqtgF5mg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tqtgF5mg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 02/45] bridge: check iface upper dev when setting master via ioctl
Date: Fri, 18 May 2018 10:15:19 +0200
Message-Id: <20180518081530.441456191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789066927104198?=
X-GMAIL-MSGID: =?utf-8?q?1600789237125478308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit e8238fc2bd7b4c3c7554fa2df067e796610212fc ]

When we set a bond slave's master to bridge via ioctl, we only check
the IFF_BRIDGE_PORT flag. Although we will find the slave's real master
at netdev_master_upper_dev_link() later, it already does some settings
and allocates some resources. It would be better to return as early
as possible.

v1 -> v2:
use netdev_master_upper_dev_get() instead of netdev_has_any_upper_dev()
to check if we have a master, because not all upper devs are masters,
e.g. vlan device.

Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_if.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -503,8 +503,8 @@ int br_add_if(struct net_bridge *br, str
 	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit)
 		return -ELOOP;
 
-	/* Device is already being bridged */
-	if (br_port_exists(dev))
+	/* Device has master upper dev */
+	if (netdev_master_upper_dev_get(dev))
 		return -EBUSY;
 
 	/* No bridging devices that dislike that (e.g. wireless) */
