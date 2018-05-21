Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrUU5QldBEDWCM61PxrI4hzJtvp2m2eJxSzWaMLGXAs0ssDqZW5UWhqzmeSjSG2eYS+ulcz
ARC-Seal: i=1; a=rsa-sha256; t=1526937511; cv=none;
        d=google.com; s=arc-20160816;
        b=d9PS3eW5J58nprgeyqQ6D48Dg7IYMwODR8SgIvSIfszKEG8CHv1H83oJ9ckiVc2cXF
         KQJ3viNeNfDM5pxEDyBPlWz4c6xQbRU8Y0OllQOcmsJ03XPEeNQ6iDL6jCrlReJigFCk
         lB/+CjK8Ml16ZmRZz2WswWgKePTeZ29gwcIxSvd8aBJKguikN+BGnJklPFYE+TXs8Few
         RWKwCCd+Exp/zFkLtc9T9mjN/QY49zNiYcSrRL/CVjRdn+B+9dUz87m/uoz+IueFeuow
         tQkSZyodbGIpLaIJFEkPfGuuC/S+qG5b794p5+R3jB3EpxoqMVMbmLCaB9EGNURriSWH
         B3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=vmOKOSNdJLSEV6DcuHszJdlMIkDL6WTJcqpOPMyxXfM=;
        b=Sgss0j8TjRvuH6vTdkynrqpeub3WhD3G1vd3rLUFcFm42zqJUZ4uxr9JfCt+BYUy2f
         wvdEoA05cVTiAtDJz5cEaoUSh57snqW/pkwsn2sF7Cb7o7gu5McOP4gpsUxATdohbkNr
         OwTQhbSjDGqe31pBv9K+yzECNapgiRCATmBGwg98QNyq3Rc7BXYy5ykB943m7PAOicYD
         Bd+zr1CoHUWmBqDMbSO2r9LHWPoJMHP1CFGX1FYiAOyyYSZ38xNnCFCqeNBKzCKcOwY4
         UOWbKXCTMnqeX4i5GepasN1OMUpDTc/748yfd5LT8IsDgC7mlmGQExa3ekJTBH1q/O3r
         nOdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pAyhzYk3;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pAyhzYk3;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejaswi Tanikella <tejaswit@codeaurora.org>,
	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 20/95] netfilter: nf_socket: Fix out of bounds access in nf_sk_lookup_slow_v{4,6}
Date: Mon, 21 May 2018 23:11:10 +0200
Message-Id: <20180521210452.047584395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110028217164602?=
X-GMAIL-MSGID: =?utf-8?q?1601110028217164602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

commit 32c1733f0dd4bd11d6e65512bf4dc337c0452c8e upstream.

skb_header_pointer will copy data into a buffer if data is non linear,
otherwise it will return a pointer in the linear section of the data.
nf_sk_lookup_slow_v{4,6} always copies data of size udphdr but later
accesses memory within the size of tcphdr (th->doff) in case of TCP
packets. This causes a crash when running with KASAN with the following
call stack -

BUG: KASAN: stack-out-of-bounds in xt_socket_lookup_slow_v4+0x524/0x718
net/netfilter/xt_socket.c:178
Read of size 2 at addr ffffffe3d417a87c by task syz-executor/28971
CPU: 2 PID: 28971 Comm: syz-executor Tainted: G    B   W  O    4.9.65+ #1
Call trace:
[<ffffff9467e8d390>] dump_backtrace+0x0/0x428 arch/arm64/kernel/traps.c:76
[<ffffff9467e8d7e0>] show_stack+0x28/0x38 arch/arm64/kernel/traps.c:226
[<ffffff946842d9b8>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff946842d9b8>] dump_stack+0xd4/0x124 lib/dump_stack.c:51
[<ffffff946811d4b0>] print_address_description+0x68/0x258 mm/kasan/report.c:248
[<ffffff946811d8c8>] kasan_report_error mm/kasan/report.c:347 [inline]
[<ffffff946811d8c8>] kasan_report.part.2+0x228/0x2f0 mm/kasan/report.c:371
[<ffffff946811df44>] kasan_report+0x5c/0x70 mm/kasan/report.c:372
[<ffffff946811bebc>] check_memory_region_inline mm/kasan/kasan.c:308 [inline]
[<ffffff946811bebc>] __asan_load2+0x84/0x98 mm/kasan/kasan.c:739
[<ffffff94694d6f04>] __tcp_hdrlen include/linux/tcp.h:35 [inline]
[<ffffff94694d6f04>] xt_socket_lookup_slow_v4+0x524/0x718 net/netfilter/xt_socket.c:178

Fix this by copying data into appropriate size headers based on protocol.

Fixes: a583636a83ea ("inet: refactor inet[6]_lookup functions to take skb")
Signed-off-by: Tejaswi Tanikella <tejaswit@codeaurora.org>
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/nf_socket_ipv4.c |    6 ++++--
 net/ipv6/netfilter/nf_socket_ipv6.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/net/ipv4/netfilter/nf_socket_ipv4.c
+++ b/net/ipv4/netfilter/nf_socket_ipv4.c
@@ -108,10 +108,12 @@ struct sock *nf_sk_lookup_slow_v4(struct
 	int doff = 0;
 
 	if (iph->protocol == IPPROTO_UDP || iph->protocol == IPPROTO_TCP) {
-		struct udphdr _hdr, *hp;
+		struct tcphdr _hdr;
+		struct udphdr *hp;
 
 		hp = skb_header_pointer(skb, ip_hdrlen(skb),
-					sizeof(_hdr), &_hdr);
+					iph->protocol == IPPROTO_UDP ?
+					sizeof(*hp) : sizeof(_hdr), &_hdr);
 		if (hp == NULL)
 			return NULL;
 
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -116,9 +116,11 @@ struct sock *nf_sk_lookup_slow_v6(struct
 	}
 
 	if (tproto == IPPROTO_UDP || tproto == IPPROTO_TCP) {
-		struct udphdr _hdr, *hp;
+		struct tcphdr _hdr;
+		struct udphdr *hp;
 
-		hp = skb_header_pointer(skb, thoff, sizeof(_hdr), &_hdr);
+		hp = skb_header_pointer(skb, thoff, tproto == IPPROTO_UDP ?
+					sizeof(*hp) : sizeof(_hdr), &_hdr);
 		if (hp == NULL)
 			return NULL;
 
