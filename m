Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZomqwQkkVZ4T827baIZhlpv+19chdLVIV6Y01uu/5uPDBBB66b9yC+EBpn+piasDAh/nx7u
ARC-Seal: i=1; a=rsa-sha256; t=1527156039; cv=none;
        d=google.com; s=arc-20160816;
        b=m+cSdsWd1gDzvZJOYgINCY+qhgZnRJzV6gELM3R7feoQoa9gWIqM36xeecC/GXwKTx
         SPF7jD1+dQVCwkfqtwYFc2fvGyUX5zo/O3z3KF957HtZz/kgSpfLuyX8cYqmyDi13guj
         FMGtav5XYEgndwXJsjSZq7fdxw2Jg0A8I6Tzk8jVudOnF3E+7lOhpUYwFWO9YPOeQ28L
         ypZTyFQCNvZtUXCTk93a800w7EEwbKc95rO6XYZRtRuGRMQRmTkrbkXdvZiVAok05qOq
         4300/AVJetmDelV2y4whw3b6meHRbCbqXKKqMOnXM06utTI7CWFifdQ9Ig22kP+rrbag
         YpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eODh6k1VEr0215hdFr5PiQ/ntByLEmkMxGDix9bUdtc=;
        b=SR78AQEIXRTXLuU3kVXIsmJf+jhBjYw2fGz85w7fGmYhh7gdpbqow6HdlHW2xUMxzu
         RLNpEp4zVd2RMWzQ7PhomhEokqceRwwFttMXzxuHeoJCYBy8hrunlbyLbRqtEtplwE7J
         KmNtdecIlBrivQAdR09w+UA0L9livIUyCm2muDRPRFO/7FNdRyZ17Xua1JTX10zT2h3l
         b1bQsIfsYcarzsxW4/PBPaeLylvijvRtzpe3L+NuBJ7rQhT0x/YgKddz8k+DiOizE8FI
         vE5eLfMFsGPVb0EoDbgAkR+vcrMkmiMnYohofcTHmxxmtfcuzG1JkzWnBEnKQLCiM5LW
         F+tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vWOYqPPe;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vWOYqPPe;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petr Machata <petrm@mellanox.com>,
	William Tu <u9012063@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 024/161] net: ip6_gre: Split up ip6gre_tnl_link_config()
Date: Thu, 24 May 2018 11:37:29 +0200
Message-Id: <20180524093021.241884033@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339171209200855?=
X-GMAIL-MSGID: =?utf-8?q?1601339171209200855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit a483373ead61e6079bc8ebe27e2dfdb2e3c1559f ]

The function ip6gre_tnl_link_config() is used for setting up
configuration of both ip6gretap and ip6erspan tunnels. Split the
function into the common part and the route-lookup part. The latter then
takes the calculated header length as an argument. This split will allow
the patches down the line to sneak in a custom header length computation
for the ERSPAN tunnel.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1019,12 +1019,11 @@ tx_err:
 	return NETDEV_TX_OK;
 }
 
-static void ip6gre_tnl_link_config(struct ip6_tnl *t, int set_mtu)
+static void ip6gre_tnl_link_config_common(struct ip6_tnl *t)
 {
 	struct net_device *dev = t->dev;
 	struct __ip6_tnl_parm *p = &t->parms;
 	struct flowi6 *fl6 = &t->fl.u.ip6;
-	int t_hlen;
 
 	if (dev->type != ARPHRD_ETHER) {
 		memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
@@ -1051,12 +1050,13 @@ static void ip6gre_tnl_link_config(struc
 		dev->flags |= IFF_POINTOPOINT;
 	else
 		dev->flags &= ~IFF_POINTOPOINT;
+}
 
-	t->tun_hlen = gre_calc_hlen(t->parms.o_flags);
-
-	t->hlen = t->encap_hlen + t->tun_hlen;
-
-	t_hlen = t->hlen + sizeof(struct ipv6hdr);
+static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
+					 int t_hlen)
+{
+	const struct __ip6_tnl_parm *p = &t->parms;
+	struct net_device *dev = t->dev;
 
 	if (p->flags & IP6_TNL_F_CAP_XMIT) {
 		int strict = (ipv6_addr_type(&p->raddr) &
@@ -1088,6 +1088,24 @@ static void ip6gre_tnl_link_config(struc
 	}
 }
 
+static int ip6gre_calc_hlen(struct ip6_tnl *tunnel)
+{
+	int t_hlen;
+
+	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
+
+	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
+	tunnel->dev->hard_header_len = LL_MAX_HEADER + t_hlen;
+	return t_hlen;
+}
+
+static void ip6gre_tnl_link_config(struct ip6_tnl *t, int set_mtu)
+{
+	ip6gre_tnl_link_config_common(t);
+	ip6gre_tnl_link_config_route(t, set_mtu, ip6gre_calc_hlen(t));
+}
+
 static int ip6gre_tnl_change(struct ip6_tnl *t,
 	const struct __ip6_tnl_parm *p, int set_mtu)
 {
@@ -1381,11 +1399,7 @@ static int ip6gre_tunnel_init_common(str
 		return ret;
 	}
 
-	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
-	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
-	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
-
-	dev->hard_header_len = LL_MAX_HEADER + t_hlen;
+	t_hlen = ip6gre_calc_hlen(tunnel);
 	dev->mtu = ETH_DATA_LEN - t_hlen;
 	if (dev->type == ARPHRD_ETHER)
 		dev->mtu -= ETH_HLEN;
