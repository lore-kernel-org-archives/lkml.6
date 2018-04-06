Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48c9dp+M+lcvGslbCFnHqYVbV/vib+JGr8anEXd635kGz5Hu0op9QldClkKfcniSKKA+5Bx
ARC-Seal: i=1; a=rsa-sha256; t=1523021159; cv=none;
        d=google.com; s=arc-20160816;
        b=tJy7kt89ZUm87GmKtD2FqT5Sex6oGYFYDkl+E0dSxED4wQlMUEweszG783+dLucpUs
         4KhLSx2I5v5rsLkFAGMLg+Hgnhfpse4oLX7FL7rwMvPoWyDJWbc41XUpSUlnMlNoFAHP
         B6N2flSMqj8mrRLJzqTkReyuHq9dIicvjdkuXknnG1R4QXj0phQesWuxhonmR0VH0KOd
         8wojajB9FILqhqKSiO5iPR/NpklYG54Bkshsy6iWMIRjy5yHnkPktGkm5ZmK7t5y+whD
         Zr0pZSt4/m8Swd6MPbmcqZALMTAuEmkeAWWITIaiR1LmxNnw2Ij+OyWlL/9lwYeuuNGd
         Bnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2cWLHwLlmyQU5E1C2Uhe9hrp80ScVCdCgvOsRk3nVkg=;
        b=ehdoch2VN5AR8xkqSoDkPGoicR7w+10/Q4p3i4b3z86nlqXK9NvFUBeltlnHYmCo8m
         eojX7mEAy/Y96YJjM08dUD83KZ7UzWclTj02OR84yn3oHDjvCxwp5DQp3jgDhyXhOfWV
         /wkiYvdRi4aDKPm9SadXmRMT+jqIuCUMR4qet7xx0O5IjD24ft1stvE/kFQXfcgVjKee
         FwnrBNUhoPmUCZi5OeGpEJ22G6VMuTAXfj29GZgfUTXqD8+bp+5AwUqwMzRwZgV+NZij
         i6Q/GFV1eom9Vy7oYNwanh+O0zGsDoow+A7D3dkQB9uvJXE/3t25TqOZWYTIg9RmZ5Rz
         EZ1A==
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
Subject: [PATCH 3.18 29/93] net: Only honor ifindex in IP_PKTINFO if non-0
Date: Fri,  6 Apr 2018 15:22:58 +0200
Message-Id: <20180406084226.223407130@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003435085415956?=
X-GMAIL-MSGID: =?utf-8?q?1597003435085415956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -206,7 +206,8 @@ int ip_cmsg_send(struct net *net, struct
 			src_info = (struct in6_pktinfo *)CMSG_DATA(cmsg);
 			if (!ipv6_addr_v4mapped(&src_info->ipi6_addr))
 				return -EINVAL;
-			ipc->oif = src_info->ipi6_ifindex;
+			if (src_info->ipi6_ifindex)
+				ipc->oif = src_info->ipi6_ifindex;
 			ipc->addr = src_info->ipi6_addr.s6_addr32[3];
 			continue;
 		}
@@ -227,7 +228,8 @@ int ip_cmsg_send(struct net *net, struct
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct in_pktinfo)))
 				return -EINVAL;
 			info = (struct in_pktinfo *)CMSG_DATA(cmsg);
-			ipc->oif = info->ipi_ifindex;
+			if (info->ipi_ifindex)
+				ipc->oif = info->ipi_ifindex;
 			ipc->addr = info->ipi_spec_dst.s_addr;
 			break;
 		}
