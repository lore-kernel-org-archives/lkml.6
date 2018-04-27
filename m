Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr6ws20iLMDdU4u+gkSVrFoWrZywunAKlnllfCkNScxqyUueOM8cgcWCTQePqWVzK7SvZmp
ARC-Seal: i=1; a=rsa-sha256; t=1524837749; cv=none;
        d=google.com; s=arc-20160816;
        b=XxFAPB28XnponCvHF2a+5i2lKq72pWdMpWH+9x0+5ixpZO/sOclKqiKLtMJazTbZz8
         fSqxnZpQuhSd4KSQ1CcGSql4Shp2r7xvadlQKxxENKcws3UNl7oizUMdnHwu8Lga6IWJ
         De7R672DQEyUAV9l1DL1tvb0d9fuYyjRdiqarNfFjN/taal7Tnmvi7bfYw64mu5wlup4
         6IWWkOHkSDMQiR2fsWZy/6NNEh+Wpis/CPrSO5SxG//PowkMxrxRSJCyIxQnhvwykGU7
         MJjSMtNAiiM+dfLAuCcq2C97lOcUY4cXvPV9QqUlA0p7tI7LMfkQVBekBIxRsdT3kO2L
         H3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ke4kmH7ZfzzlBZ+g3BHWzG54JYYyr+/vdV86NT+7A7s=;
        b=SX1mRKr5yInJkSr+Ip6+z11qxUG96aVH3JUTkfHjUKo35PdvFLbnBG9Zpx/q/jSEqJ
         IhSr8DpPs3JJld9xFkW0Y7G5B6M96jfPsNkcOA5kJJJGOBJVRok1ujf/PX1zxF3Cc3q6
         aLc+2SueIAehWD0B/C6g78qTSPYZNegRWx1ntvjc/J9vcW66NM6NkMQGhVAOlHZKqam6
         SpBdp1RmcQmDZ2P2dTrVM8XPGV3CNvSnZHZ7Tf5WQHyD7sdydwA1szyBx7vBUowqcSGA
         gS5cjtWz7NvhDnDRD/Slgd6OOaAfWyP7y2k6mwwg+qdHMo+S/ybwY2EXdYjDLQtyIGKK
         Y+zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C0721897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 45/50] net: af_packet: fix race in PACKET_{R|T}X_RING
Date: Fri, 27 Apr 2018 15:58:47 +0200
Message-Id: <20180427135658.343468609@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908116836629664?=
X-GMAIL-MSGID: =?utf-8?q?1598908267867719484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 5171b37d959641bbc619781caf62e61f7b940871 ]

In order to remove the race caught by syzbot [1], we need
to lock the socket before using po->tp_version as this could
change under us otherwise.

This means lock_sock() and release_sock() must be done by
packet_set_ring() callers.

[1] :
BUG: KMSAN: uninit-value in packet_set_ring+0x1254/0x3870 net/packet/af_packet.c:4249
CPU: 0 PID: 20195 Comm: syzkaller707632 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 packet_set_ring+0x1254/0x3870 net/packet/af_packet.c:4249
 packet_setsockopt+0x12c6/0x5a90 net/packet/af_packet.c:3662
 SYSC_setsockopt+0x4b8/0x570 net/socket.c:1849
 SyS_setsockopt+0x76/0xa0 net/socket.c:1828
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x449099
RSP: 002b:00007f42b5307ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000070003c RCX: 0000000000449099
RDX: 0000000000000005 RSI: 0000000000000107 RDI: 0000000000000003
RBP: 0000000000700038 R08: 000000000000001c R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000080eecf R14: 00007f42b53089c0 R15: 0000000000000001

Local variable description: ----req_u@packet_setsockopt
Variable was created at:
 packet_setsockopt+0x13f/0x5a90 net/packet/af_packet.c:3612
 SYSC_setsockopt+0x4b8/0x570 net/socket.c:1849

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2899,6 +2899,7 @@ static int packet_release(struct socket
 
 	packet_flush_mclist(sk);
 
+	lock_sock(sk);
 	if (po->rx_ring.pg_vec) {
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 0);
@@ -2908,6 +2909,7 @@ static int packet_release(struct socket
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 1);
 	}
+	release_sock(sk);
 
 	f = fanout_release(sk);
 
@@ -3577,6 +3579,7 @@ packet_setsockopt(struct socket *sock, i
 		union tpacket_req_u req_u;
 		int len;
 
+		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
@@ -3587,14 +3590,21 @@ packet_setsockopt(struct socket *sock, i
 			len = sizeof(req_u.req3);
 			break;
 		}
-		if (optlen < len)
-			return -EINVAL;
-		if (pkt_sk(sk)->has_vnet_hdr)
-			return -EINVAL;
-		if (copy_from_user(&req_u.req, optval, len))
-			return -EFAULT;
-		return packet_set_ring(sk, &req_u, 0,
-			optname == PACKET_TX_RING);
+		if (optlen < len) {
+			ret = -EINVAL;
+		} else {
+			if (pkt_sk(sk)->has_vnet_hdr) {
+				ret = -EINVAL;
+			} else {
+				if (copy_from_user(&req_u.req, optval, len))
+					ret = -EFAULT;
+				else
+					ret = packet_set_ring(sk, &req_u, 0,
+							      optname == PACKET_TX_RING);
+			}
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_COPY_THRESH:
 	{
@@ -4144,7 +4154,6 @@ static int packet_set_ring(struct sock *
 	/* Added to avoid minimal code churn */
 	struct tpacket_req *req = &req_u->req;
 
-	lock_sock(sk);
 	/* Opening a Tx-ring is NOT supported in TPACKET_V3 */
 	if (!closing && tx_ring && (po->tp_version > TPACKET_V2)) {
 		WARN(1, "Tx-ring is not supported.\n");
@@ -4280,7 +4289,6 @@ static int packet_set_ring(struct sock *
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:
-	release_sock(sk);
 	return err;
 }
 
