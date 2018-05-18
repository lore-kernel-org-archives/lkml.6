Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrDxewoEBW7HerkVuZTngZ6gtqk5Q8Q932LN3RCnlscsmh0srAaxDHQA3w4mJHQOB8Xg88f
ARC-Seal: i=1; a=rsa-sha256; t=1526631709; cv=none;
        d=google.com; s=arc-20160816;
        b=tEqw0Mm5LrsydflBkp0U/UXO7IWOQLyyr8MLoiRUAUFihPIrxyYgdzi7np2iavXKjX
         DU6NmG6VGjqOooHKxV0Vjfa6iK6Im7ZykvChAQMfmnLU5InSOh3OJ9YCuvuMM14EeC2i
         ljEQoOW6I7br//7TDyN2kWxSQc5Roy9jPaKDiEoqXBXzzqSnzpAApK3RDyn/7NACDeWq
         K3wamJKiX42DDau8x8bXwJZFt3zyA96EIBQ0eZmIvBJQ37mQmLgSfF06wSMacvoVfW95
         raIgtlLJZWUBIDl2IwOZfHTXXv3rVPSTwvBZbiSTypc6XviZ7PPudSpSZs4GgM9/EV90
         kd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=uVTC0qwiatRsK710ojv/4ZRUDqjaOF4WePUQ6UYbJBE=;
        b=Gvf9AkT44jzxUUgHldD3/gsgm8B3rSKRqXeG91BpNQ42N7M/gcglosb4smLDscNpxN
         Yb/9RobEKHum3gB5cHvv/vz6x0jSFZ0ynFhA5wr6lNJYQjzIQ6H8GMAMqd1Myd6DyRcA
         PkCwyUSxuta/EtnwItqn+01/7et2ep1DDb0wEjEZRBUIQsKuVcnRs+qJzYRJUk52zEW6
         XotwaGtv/+CrLcXy6i7dX0nSTTE2Boa2kHQyOIQxlKLv91eleFNAIA1Z1Liu92fMlt9Q
         Fmw0wSTTIQfQRmfb1zYpKqUV5WR9uq2GcSVFiIz6d8jFTvxcz4Ct+0E2Dtm2QxDndYbm
         Alxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0r31w9n4;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0r31w9n4;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 02/33] bridge: check iface upper dev when setting master via ioctl
Date: Fri, 18 May 2018 10:15:41 +0200
Message-Id: <20180518081535.198563210@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789066927104198?=
X-GMAIL-MSGID: =?utf-8?q?1600789371151292238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -504,8 +504,8 @@ int br_add_if(struct net_bridge *br, str
 	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit)
 		return -ELOOP;
 
-	/* Device is already being bridged */
-	if (br_port_exists(dev))
+	/* Device has master upper dev */
+	if (netdev_master_upper_dev_get(dev))
 		return -EBUSY;
 
 	/* No bridging devices that dislike that (e.g. wireless) */
