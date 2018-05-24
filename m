Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoojTCRtSMU1FkfYuP4TJc+50sGQI4fJCIgRlUUBcb2NsC2dvteuagaDS2lvPxC7UEoClth
ARC-Seal: i=1; a=rsa-sha256; t=1527155996; cv=none;
        d=google.com; s=arc-20160816;
        b=dSXZjQILo4vJ37504Zd7bTpF4zNq3x58+GL9MXlMu5lw13/tEn0MEJ1FK+GJeyNUzY
         4+Lpv+ZiykJpR4bI2kwHmqEhSmYeOMXKjrDErpfU4lFjeBDmf0dbuPLI9u21YJ+JrVWt
         4LQhyKT29KS123HQ0DAM4U16cGkcwgbXrDSAc6trVa+D6uRstuMytGcuo3YmAFpN63b3
         prqk3V92o26uCV6LX8m2jzpaTd+aumYRLjVp4UlpNgKOnf0OPR6ThMF72ddBvaA3iOhP
         axxQcxoAtXHtPsX1GAanMO2l4qXcdQJK2w9Ta6zBzSyrxUUPY+UUFW5+yXd5l40j+S56
         wbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=g4OuDBBg8YgALk3avBthbYdaaCgQW7kAimuxcgXcYKo=;
        b=MexqPwWKX2CS1qXcqWRocubsu4QUUqzBmslnn3sRcLppqJgZePQUAX2zAd0x4xeYZw
         +JhSYaeLZufyaxCFy53sTAFwIbBHnIiHVkHfXItXf3n+IuxpmGzohS0Uyn0h9Z5wNIF8
         Gy3lKq3L3wapp7egMCCkKLpWc8PWEX4JO0yYWVJBe40qzZk5gOiSJxSAWSD0Qbh9yKUY
         61VFQ/MySYs/Z87xnRCPeemAKhR8O44h9J0no6717lzhaXtP7PhHUCW8IURhCMuSWRid
         3xsa+/BY1DtO3JVHvUk9R1dJCcxJ5T5ZoJF9p73fi0uRrJ83zWKymMstM2x3BQh7BWyh
         0Mbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rETxsgin;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rETxsgin;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 007/161] net: test tailroom before appending to linear skb
Date: Thu, 24 May 2018 11:37:12 +0200
Message-Id: <20180524093019.221178851@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338008840596039?=
X-GMAIL-MSGID: =?utf-8?q?1601339126016131167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 113f99c3358564a0647d444c2ae34e8b1abfd5b9 ]

Device features may change during transmission. In particular with
corking, a device may toggle scatter-gather in between allocating
and writing to an skb.

Do not unconditionally assume that !NETIF_F_SG at write time implies
that the same held at alloc time and thus the skb has sufficient
tailroom.

This issue predates git history.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_output.c  |    3 ++-
 net/ipv6/ip6_output.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1040,7 +1040,8 @@ alloc_new_skb:
 		if (copy > length)
 			copy = length;
 
-		if (!(rt->dst.dev->features&NETIF_F_SG)) {
+		if (!(rt->dst.dev->features&NETIF_F_SG) &&
+		    skb_tailroom(skb) >= copy) {
 			unsigned int off;
 
 			off = skb->len;
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1489,7 +1489,8 @@ alloc_new_skb:
 		if (copy > length)
 			copy = length;
 
-		if (!(rt->dst.dev->features&NETIF_F_SG)) {
+		if (!(rt->dst.dev->features&NETIF_F_SG) &&
+		    skb_tailroom(skb) >= copy) {
 			unsigned int off;
 
 			off = skb->len;
