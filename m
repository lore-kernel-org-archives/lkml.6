Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELux4geyIQX93cGaEawXjp0Eucovzd34qtO/xXd164MDLb0Cd03qaz96u1Wx6pSz87DkoCWq
ARC-Seal: i=1; a=rsa-sha256; t=1520451929; cv=none;
        d=google.com; s=arc-20160816;
        b=xuDIKHj15S5dwJ+3A2nQiolUGiXnZRJWRFu4Yhne/EeAHLqLZ5Ph3/JYeqSDDx7PUB
         j6MxZ/DG4N2I/j6OUm72Vlh4imoQXF9nNP0upe2bpMwPNkLSblya3EdHvtiz9ahMy1p0
         zsQArM4moMOY82D0g7re2a7AJMQ1oKIk0AM0VGLmnjmZqUAHtdK3k3pfPs8dwHvFLdgd
         LtE4M9mfBTjkP2rc4HLOkktxtqU9lTgvvcymVjk9cZk+/mauXOoUs67jcGkXl9WJuOBo
         y+70Z9hEL3f6cOjrkhbrL0kwWCnvJcophJES3Kb6twIyIzdfej8kmCQmEG4YMFsBLfIT
         m+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2s8TRWxxKauhm8zCI/Xk6KJFW04RrSX1Pp2N10+UkRo=;
        b=svHn7raqCyO8yc3+ERIS376TNrxf6oVCsyi+Ya3ZfxxgYDqzAtkARGRdgGB/BOHeoz
         GR4bkEXufEv2/LLKyP66Owi6O3umiIm6NvX1jyirhiMPJFAmt03vtTc9Y9DC0qY6Ryw5
         BWSG7P+91AK3GB81qNX4uv61uSQ6frTdzsTY9lKRpQTTy11698NqqhcY6SOwnfpn2V9L
         R6knabVyRxDFmmUzjp7Ny/MLTgY2QUb7r0LeVy649z6feu3EKiCzoHVp3czfjor0tuF1
         S8haWEu7lX/lKTQK7D6TMBuJ5QmVu6il+uIN4D+awtAUUOG28v4C1FfJv59MZ8htzaSQ
         lOuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiong Zhou <xzhou@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 034/110] bridge: check brport attr show in brport_show
Date: Wed,  7 Mar 2018 11:38:17 -0800
Message-Id: <20180307191044.105042038@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309203094602682?=
X-GMAIL-MSGID: =?utf-8?q?1594309403065061619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 1b12580af1d0677c3c3a19e35bfe5d59b03f737f ]

Now br_sysfs_if file flush doesn't have attr show. To read it will
cause kernel panic after users chmod u+r this file.

Xiong found this issue when running the commands:

  ip link add br0 type bridge
  ip link add type veth
  ip link set veth0 master br0
  chmod u+r /sys/devices/virtual/net/veth0/brport/flush
  timeout 3 cat /sys/devices/virtual/net/veth0/brport/flush

kernel crashed with NULL a pointer dereference call trace.

This patch is to fix it by return -EINVAL when brport_attr->show
is null, just the same as the check for brport_attr->store in
brport_store().

Fixes: 9cf637473c85 ("bridge: add sysfs hook to flush forwarding table")
Reported-by: Xiong Zhou <xzhou@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_sysfs_if.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -235,6 +235,9 @@ static ssize_t brport_show(struct kobjec
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
 	struct net_bridge_port *p = to_brport(kobj);
 
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
 
