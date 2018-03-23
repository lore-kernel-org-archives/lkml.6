Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs3yrGudBl9OUgxANsfGLv7fQgUuRE1vAy5G4ZstNrdG2mJwCRH5P/p4YirzCtUE7ugpAwB
ARC-Seal: i=1; a=rsa-sha256; t=1521800225; cv=none;
        d=google.com; s=arc-20160816;
        b=guqxeYimFTEDVp5rI4+Cxq6cOkKS/hpVo8t3bQOHHHcvUIg3o6zKGev186p+9Hfmnt
         spyoHFZrqooxgRSUe+JJ8SbPEHpRpLXj8y1EQHa93rCEEXf5bneK3qBprUzWfQOSDodg
         QnoItUxlAQ4fVN/ldCUNyviInRhP5ZH6aPBMAs7z2nBhpKGNxw79/wafG1LPzp+qc/Kr
         f0IspA3f0P3U5/FC+lo88kn+kwtYS/UCYmpaTM9ztsHkglvPIs7IOPfGLPKJUe2EiUCR
         whRf3uJQfjOkqz0Ltdm92g04rhAB1WEuDp96N8OkynDg2mZXp2ZkuWhrZVGiWfnjT+rV
         cKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tOf6nbK7CUFqmAaGqPxD9O3+kc+zq7ig/VJBMMhGpoU=;
        b=eXvuftpWsoKZ41FdfhxgxGiQ1rm6lkLmqRkzCRn4BgOiUSmMtv0m9S8CbrkxspygcX
         5tDXNrfO5m8gp198S6h6GClOC7zoZRAxD8ewPYgjcIKzw1hRCZHIgUoUwTW/bjgyNAp3
         xGyplXB7X4FHNgj/gCa/d2IoBQK4l+ObHNz29vEao3gfDL4NBa0Yx4T623UwIMstz23r
         erTNEEjPE4VYaz6WFLSFVyr2oxJaCMS6nZMuglMoYZveg/63ldKdTDoPx62h5zH8WU0k
         vj2ukCxv5XNcoWs6e0A7noxnQLgTBdsEKE4T9wN+HChAP25AIcbNIO8XfEDiWBeOBaoO
         7omA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 92/97] ip6_vti: adjust vti mtu according to mtu of lower device
Date: Fri, 23 Mar 2018 10:55:19 +0100
Message-Id: <20180323094202.622913188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722029897098807?=
X-GMAIL-MSGID: =?utf-8?q?1595723193798452395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]

LTP/udp6_ipsec_vti tests fail when sending large UDP datagrams over
ip6_vti that require fragmentation and the underlying device has an
MTU smaller than 1500 plus some extra space for headers. This happens
because ip6_vti, by default, sets MTU to ETH_DATA_LEN and not updating
it depending on a destination address or link parameter. Further
attempts to send UDP packets may succeed because pmtu gets updated on
ICMPV6_PKT_TOOBIG in vti6_err().

In case the lower device has larger MTU size, e.g. 9000, ip6_vti works
but not using the possible maximum size, output packets have 1500 limit.

The above cases require manual MTU setup after ip6_vti creation. However
ip_vti already updates MTU based on lower device with ip_tunnel_bind_dev().

Here is the example when the lower device MTU is set to 9000:

  # ip a sh ltp_ns_veth2
      ltp_ns_veth2@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 ...
        inet 10.0.0.2/24 scope global ltp_ns_veth2
        inet6 fd00::2/64 scope global

  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 1500 ...
        link/tunnel6 fd00::2 peer fd00::1

After the patch:
  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 8832 ...
        link/tunnel6 fd00::2 peer fd00::1

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -614,6 +614,7 @@ static void vti6_link_config(struct ip6_
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
+	struct net_device *tdev = NULL;
 
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -626,6 +627,25 @@ static void vti6_link_config(struct ip6_
 		dev->flags |= IFF_POINTOPOINT;
 	else
 		dev->flags &= ~IFF_POINTOPOINT;
+
+	if (p->flags & IP6_TNL_F_CAP_XMIT) {
+		int strict = (ipv6_addr_type(&p->raddr) &
+			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
+		struct rt6_info *rt = rt6_lookup(t->net,
+						 &p->raddr, &p->laddr,
+						 p->link, strict);
+
+		if (rt)
+			tdev = rt->dst.dev;
+		ip6_rt_put(rt);
+	}
+
+	if (!tdev && p->link)
+		tdev = __dev_get_by_index(t->net, p->link);
+
+	if (tdev)
+		dev->mtu = max_t(int, tdev->mtu - dev->hard_header_len,
+				 IPV6_MIN_MTU);
 }
 
 /**
