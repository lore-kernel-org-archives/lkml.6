Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsNeD0WAXThnh5267p0kWp+Y90H6pB0/n5uIVUy/zZaNYk1FsFNUNALfI6eYxStP9e0JfEi
ARC-Seal: i=1; a=rsa-sha256; t=1520641150; cv=none;
        d=google.com; s=arc-20160816;
        b=EUCp23lJnbtd6RIE5I4wvNquL9DQkB8z2sFqVcjonSqrNtX3HZ2axybjI4WF78VKdU
         ewN7uxAj7LIfqbkoN7mfThnDbRoP5PpGbeEHhb/FmSdYqsdfK6SNcKHtzRVD/GnDVCLa
         zFDKDc367E61dAV0xL2QuuLyeuVmwyqd73cGaV+EZEhqmqwaEFYGBrLkaRr7ois/1E97
         DUdFEHbcswcUg53Xejz9Ivjegs2/l4rBSW4xnKR8+bXUPUtyffbakj5lMaIZKKCS6RL2
         IzPM7GGqu37fs4XTbSGer5GAfwzQ5R+J6NlSVYA1pN1wS4+jqFAFdA5hM3TbyKwCuvqW
         NGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k16rjpRO0UZhLgvObuJcx9QJrzlcFvbHNh1yVr4DOzk=;
        b=KBMMMNsXlmo8s23lyskBNbdIjy86Ebkd3n7UvezKtlDs5gH20VJYsYxGFeDu8j+zkq
         YT2gx+mJrquj5kUWCmh2L7JY7g1Chg5qA3mI8ueu1byBYZXNc43wVacub3CpFqS1wkcC
         YlbZqXoimeh+hOlV9eaIp6x1qvYU/R4RdJP7d9JV9AehEeHrRIH3od3iYMmYRyGjUMLj
         V3NsQ1a52lrwDP9jvDL8Us72R9u51XRgB4qavHb7QXGmSi7LrKFFEENqtJjm7dAKyX6y
         NPrOdsSNfLy6kfc4QlwXpur6C+MRJEHT33LoUQE9sQqAXinE6Wzmp9Zme2qoMCt2lvhR
         fAkQ==
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
Subject: [PATCH 3.18 08/21] bridge: check brport attr show in brport_show
Date: Fri,  9 Mar 2018 16:18:30 -0800
Message-Id: <20180310001801.531714893@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507815386940691?=
X-GMAIL-MSGID: =?utf-8?q?1594507815386940691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -225,6 +225,9 @@ static ssize_t brport_show(struct kobjec
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
 	struct net_bridge_port *p = to_brport(kobj);
 
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
 
