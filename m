Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Q+H0ALENRkVPhMTXej9ZgMGNSMMnPnqu9pZKf8Ad4y9XOUPZiTOLM8cH2inOllWuKq072
ARC-Seal: i=1; a=rsa-sha256; t=1522346707; cv=none;
        d=google.com; s=arc-20160816;
        b=dukzFmE7McKHKtfnqI4hwzUbZMrxF8PfowrChqr22Zkcj3HqmO3G5zKvfasAGp879Y
         f50FdW3S0DUadwhu1Tb4dnjyuRxpbNGlFOQ2/3aEX7mgJr+GpGCrdCNxB4Qze10qKRuI
         Ao7T8wYnZyr4Uw1C1tuo5wdnx3wuaqEgayjV/Or608eqVrfYRoORuv6eFunQL8lhB/sQ
         XdKUO+NXQo/f7UBU7rDx+ommYrXQ9m7zzqtEL8zVepp3DWtLRC/0DbGBIKEdfEg8o51I
         jNVAwWRcsfSqyB60hzlSIs3R1oh8wswEIf6K5iNgHS43ufjS5nLgH6NydPrUerEsDzu9
         vVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+ED0wwIOPNqCWuvkIGYRcBNXOskUMiwWjEDbrNW/j/0=;
        b=hnwyeci7f4q9yPrpPgB/2+zRYLoY7OKfNc8rhCWe+Sxz0EvmnMtQwCd9OZPighM7iP
         TSosrR/sJv4m2ecOdV9IkkdydhU2coYku6o7xo+cZx9fWhzl+7Vam40IAJ30/Qn9E2SG
         /HoAVskB/5u8hv8QhEUEkmMjZ5pGzrvA2Ey7kdAwRchrtm+Q2Nvs2KgGnd+KKrrOqwt0
         yspyxGm5LQewb+QXEqxmu1zMGtqrRzb1UshWq7St0BFMlfnS9UWx5xipbM1gXwxevk64
         a3ljLokBlLRHi1bfMW4R4ET4romxgpgmvQ3zDct8iUDQJV7OsL/o0ncAH8f2pH2vR/YQ
         yUMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/43] net: Only honor ifindex in IP_PKTINFO if non-0
Date: Thu, 29 Mar 2018 20:00:25 +0200
Message-Id: <20180329175733.265590324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296117721109691?=
X-GMAIL-MSGID: =?utf-8?q?1596296220991036748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>


[ Upstream commit 2cbb4ea7de167b02ffa63e9cdfdb07a7e7094615 ]

Only allow ifindex from IP_PKTINFO to override SO_BINDTODEVICE settings
if the index is actually set in the message.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -258,7 +258,8 @@ int ip_cmsg_send(struct sock *sk, struct
 			src_info = (struct in6_pktinfo *)CMSG_DATA(cmsg);
 			if (!ipv6_addr_v4mapped(&src_info->ipi6_addr))
 				return -EINVAL;
-			ipc->oif = src_info->ipi6_ifindex;
+			if (src_info->ipi6_ifindex)
+				ipc->oif = src_info->ipi6_ifindex;
 			ipc->addr = src_info->ipi6_addr.s6_addr32[3];
 			continue;
 		}
@@ -288,7 +289,8 @@ int ip_cmsg_send(struct sock *sk, struct
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct in_pktinfo)))
 				return -EINVAL;
 			info = (struct in_pktinfo *)CMSG_DATA(cmsg);
-			ipc->oif = info->ipi_ifindex;
+			if (info->ipi_ifindex)
+				ipc->oif = info->ipi_ifindex;
 			ipc->addr = info->ipi_spec_dst.s_addr;
 			break;
 		}
