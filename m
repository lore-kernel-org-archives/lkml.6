Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49WoUCdoHTx3tFi8pgfkW8OpInUvWXk72da/4o47oZKidvZpW44V3MtZKIZeJ+Sik+jiD33
ARC-Seal: i=1; a=rsa-sha256; t=1522346858; cv=none;
        d=google.com; s=arc-20160816;
        b=W67F9ZUoF9+V595YxkZh5Hcz1blAjMoOEfEJHWkLCuewUzIl/ki/Pl8IhS0OKY1ybm
         uwJLDM04qAp8yGJSBlYoNa53O54tdZP0B9wJPZs28HIosEe3ft+bO/nPwh30nNjQMqxV
         pq9iLWmErrdVGnsKfdcMNruWmwYwZGcG06Kq5M6Cvez8f/Lv4DZK7Yj/AHiiDePh75w2
         LOMXro6b/OHtNwACMXAz+I+1PWu5Q5B1DuhEL252nmHDxbl+6L2nGv0kWa2WwKEQ8Zmr
         +2CQ1xB+n+tWnC9wzvCILDZ35CuJ4SQh0F1V9CEMB+fK8fmbfzuEvB+dV8xK2t61rImI
         xvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S91oGCAgOD5W0olh9ClFVRAU20BXqjMmt+N3uQffuR4=;
        b=AVU9V5Ra2mb8LZGqFCKyRjnXfWNxzdNpb/JTCJe0QOXNZRBVNlKejg0z0NzYMi0d89
         OxbgFvaH75DqW+K+IMGvFJmdoTj1RgM2aUxGpcw+vGRMDuNtJCKyOceOzPKI9UYjyhGh
         RA5OqQa5zoU+5CuWI6ej6qEzymWNPxO2kXH2qudxIV+5pKCNIeuZhpzQ+hxAZzOB6OsG
         Zb/NgiKEQoQaiSTbVlztIEQUPhf7GTrgpNBw2KxmnuPh2L0mmmpLKOUiQ2Bbh2v8rAgP
         9aiAGH+dh0ueFkfHpTNWdFecRBk6ar8xKzwr9vCqzCAGBDHbwsEaCW1BudlrcfaZLNDC
         0rbg==
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
Subject: [PATCH 4.4 11/20] net: Only honor ifindex in IP_PKTINFO if non-0
Date: Thu, 29 Mar 2018 20:00:47 +0200
Message-Id: <20180329175742.363684649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296117721109691?=
X-GMAIL-MSGID: =?utf-8?q?1596296379687683021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -241,7 +241,8 @@ int ip_cmsg_send(struct net *net, struct
 			src_info = (struct in6_pktinfo *)CMSG_DATA(cmsg);
 			if (!ipv6_addr_v4mapped(&src_info->ipi6_addr))
 				return -EINVAL;
-			ipc->oif = src_info->ipi6_ifindex;
+			if (src_info->ipi6_ifindex)
+				ipc->oif = src_info->ipi6_ifindex;
 			ipc->addr = src_info->ipi6_addr.s6_addr32[3];
 			continue;
 		}
@@ -264,7 +265,8 @@ int ip_cmsg_send(struct net *net, struct
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct in_pktinfo)))
 				return -EINVAL;
 			info = (struct in_pktinfo *)CMSG_DATA(cmsg);
-			ipc->oif = info->ipi_ifindex;
+			if (info->ipi_ifindex)
+				ipc->oif = info->ipi_ifindex;
 			ipc->addr = info->ipi_spec_dst.s_addr;
 			break;
 		}
