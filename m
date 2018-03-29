Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/WVZUTByV7zubrL5s4apwFC1LdsTBHPGtOG1vySEZNoQNSEOF9qcZr3rS1waLBxs7Zs5ae
ARC-Seal: i=1; a=rsa-sha256; t=1522346608; cv=none;
        d=google.com; s=arc-20160816;
        b=qrkE2w50sxs8To2N3Hbi64sObSiva/sgQuPc2fDNbpB4EVH98zqYeJAaAxKWPy89y4
         Ez877ynkhGCQDr7sjbaG2leg1cYaNej5gwEvQE4Z8+tpknPCyRYe3WkSN3PnfW5S20to
         kpW8GgnIphMCNK/3Op+wVpZfbk8Fmp6jMTs9pYIePUNOmitNq1gzU4VsviOb4jPn7EGH
         GFWmDt+n27vbvdeeR8YCnP1Vwtl+l/FSsEY42eOfF2tZP9Ik2qbS9njhKrLhlQ/O98m8
         c0n8PI2pdJRb0JDHGkSqvZY20bTa7dut4BNDZSDvNzPzTd3wNhiaJoi00oSxSL9vB4zF
         VVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uKoiO3OJcQK7TZXUj7cRf9+Y/P1wB4Joaq0copKXy6E=;
        b=tIVloUymyPr7igGCO/uK93lbxKSNljpZVOZT2aD6q0qPjhtPDX5S2jlbk2WALuQQn+
         DUfs3ol9k0pqhdQA7tdui7/N+hANv42Tbo9j+QTRuAJMgaHsWRw39xa5USDZ28hr1+s8
         17v4V/HCbeT3BHRefAa2UY7oyh0XZ76JQVbHsgI4YsQ6ccOk8smOp1Y5vE46xQPn6Zdr
         A1MMKFpbt+Xc9STlpR0sF9VLYLcLNu/FLnPcXNTfYDIY3QjiC23wqwE6UMNwRyWxE9SQ
         KLsUlSGrKBQhmYdZE4RlmrF1rfGzjIx+YsB1/hQhKnGIkzKPVxtbXwEfieeMenxraoDF
         MDSg==
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
Subject: [PATCH 4.15 43/47] net: Only honor ifindex in IP_PKTINFO if non-0
Date: Thu, 29 Mar 2018 20:00:24 +0200
Message-Id: <20180329175733.119308500@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296117721109691?=
X-GMAIL-MSGID: =?utf-8?q?1596296117721109691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
