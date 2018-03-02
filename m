Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELswN3b7e016m1LrgMAxAAazI61Mc3Ye5mPtFtknSwZJJOx5KSfEIXBeXX0vNFVYKuHt3aJu
ARC-Seal: i=1; a=rsa-sha256; t=1519981477; cv=none;
        d=google.com; s=arc-20160816;
        b=X8UYr5Uof5SU2FzKduls9ZqxJO7SHm6JVDYWDjJulsRBGYgh1TEMnBTdcbvEJ3FWgY
         Ns+9DYWQj8jIetqcUJkAsoGC2d4rK2p+ROfFYPy/Gq0nRcrsdDcz4t1YdA2u6zDG6TTt
         scr42ArKTt6eaMRol4r/Dd+s7mV9inzXab50Zenj6F8JnXgKp3yarY4hm2dn5axo8TwW
         xKCbdsJY0ycJf3UevbJNcNjuUBqTAGY24F9Pjld7JQSca2sdG5KYGpeKjBGqhbaVZDGW
         FLeB4YPuBFJHg5I2WvEaAc0ZkJ03zao2bR1Bb/kd2hsKOzHV424DJJJxMAIb6iGfs8Ep
         mKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TOzUM2e7eV2M8OAVSDrA7TJfjTczS5wfYKm1YnlaWOQ=;
        b=nX2O4JWUZVyPIGVpuitZF9jtMSag0jSc+HGD/NKXUpcPJJQtJ0H32mIurNEaNWkdv8
         opBqKgJcFiHbQ9UV/AFkgbjYea4PclS09Yv0mCJSCw9iD9Kf0ATeygDSOrDSGavlddsR
         AmX4AtidKfPwo6fU7a77L29PUJ7i5vxKgabu7ZGDLyNGJ/9zrkcW+cY5+K6F7nCHBsM9
         pQu+tUvJOmlH2MF9uSIzknb5XhpAgJVE5p0+wKVCCN54Ub/+ohPTSZ72A00/iu3t1GLE
         Z4Q5yfFci/WFbb9dnD1lVVrFNhgX5T6HbIq4E/2A7Gxk7/pIvS6wUUvOimmId6+8EdT5
         KTyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 068/115] ip6_tunnel: allow ip6gre dev mtu to be set below 1280
Date: Fri,  2 Mar 2018 09:51:11 +0100
Message-Id: <20180302084506.611916790@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816097848819742?=
X-GMAIL-MSGID: =?utf-8?q?1593816097848819742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 2fa771be953a17f8e0a9c39103464c2574444c62 ]

Commit 582442d6d5bc ("ipv6: Allow the MTU of ipip6 tunnel to be set
below 1280") fixed a mtu setting issue. It works for ipip6 tunnel.

But ip6gre dev updates the mtu also with ip6_tnl_change_mtu. Since
the inner packet over ip6gre can be ipv4 and it's mtu should also
be allowed to set below 1280, the same issue also exists on ip6gre.

This patch is to fix it by simply changing to check if parms.proto
is IPPROTO_IPV6 in ip6_tnl_change_mtu instead, to make ip6gre to
go to 'else' branch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1684,11 +1684,11 @@ int ip6_tnl_change_mtu(struct net_device
 {
 	struct ip6_tnl *tnl = netdev_priv(dev);
 
-	if (tnl->parms.proto == IPPROTO_IPIP) {
-		if (new_mtu < ETH_MIN_MTU)
+	if (tnl->parms.proto == IPPROTO_IPV6) {
+		if (new_mtu < IPV6_MIN_MTU)
 			return -EINVAL;
 	} else {
-		if (new_mtu < IPV6_MIN_MTU)
+		if (new_mtu < ETH_MIN_MTU)
 			return -EINVAL;
 	}
 	if (new_mtu > 0xFFF8 - dev->hard_header_len)
