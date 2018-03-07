Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELue/fG9ROMTdGprvFrwXIARhN2HwcIgKhwoTAuNZnZm+BCDZtNEYBm/cUyTU5SPtNUSJrMv
ARC-Seal: i=1; a=rsa-sha256; t=1520451739; cv=none;
        d=google.com; s=arc-20160816;
        b=mNMQ71wHkNeAk7Q/5TZ0KVhq0xk1SrU97NZgQPwZmJoKyBEqlSGBA8BHsUN32vUBju
         1Ht7Gu6AzwHQQGxHuH0HwP71rhO6+EEzKYS91eSPasTcQIFO1NAYsPZm/PhUKVT4GQSE
         LT2V9Dxq25gqUaechPuWiPXZQXVF0eCEVuRPtgTzP0kahG/1LAlOe68q3zhW6bclDZbE
         GnWU7W8OnE1SNhZnfVFShQ/QyL8jNQdph2Z0MSKDOfpVPtsyIeXcGWX6BvkphiMNj9d5
         3L0H0Eh7Bc/TZBVVbXCbGKz+gN0gZaVAhqznwUvniKa1sqLJ1irlSt3kBHEbSkfE146w
         /Gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uU1Ajy3k9uLWnUK23EGbSk0FZbHSHjKE2EjdDvNFRaU=;
        b=BNMOyZsAixxJdxGaWdEzRhQdADLZJHUZ3jAfZocLpAlmOAT6MP+Q8mxLC0Cb1XAE88
         3JBlUh1EffTe0cJRxdYq7bF4SpvYBJDgfU218+aFQFnL7Pc07knw/3vAH7SRi+xrlBbk
         tLXni81knZTqwQ7OOd6lrNFMnqeWfbecM3tK8MeLzd8EkyCU+81szkD7oe8fsvRKWh5E
         gCUEgzFuoHGA5zho+268xbhO6zH7Z9mSMgWHVbCGqkjgGPqxxUDwFrr5dxfuynwWsGp8
         30gPKvBeuKU7bsNP+r24Dd5dmiV2oOABalN/8jdim2i/Etcu66ksO9bBZs0++xi41+9B
         IkTg==
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
Subject: [PATCH 4.15 039/122] bridge: check brport attr show in brport_show
Date: Wed,  7 Mar 2018 11:37:31 -0800
Message-Id: <20180307191734.729830899@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309203094602682?=
X-GMAIL-MSGID: =?utf-8?q?1594309203094602682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -255,6 +255,9 @@ static ssize_t brport_show(struct kobjec
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
 	struct net_bridge_port *p = to_brport(kobj);
 
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
 
