Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608BAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C03D20666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C03D20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeI0P1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:27:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55128 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeI0P1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:27:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D25010A4;
        Thu, 27 Sep 2018 09:10:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 17/88] tls: fix currently broken MSG_PEEK behavior
Date:   Thu, 27 Sep 2018 11:02:58 +0200
Message-Id: <20180927090302.567599412@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 50c6b58a814d86a93c0f6964570f839632854044 ]

In kTLS MSG_PEEK behavior is currently failing, strace example:

  [pid  2430] socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 3
  [pid  2430] socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 4
  [pid  2430] bind(4, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
  [pid  2430] listen(4, 10)               = 0
  [pid  2430] getsockname(4, {sa_family=AF_INET, sin_port=htons(38855), sin_addr=inet_addr("0.0.0.0")}, [16]) = 0
  [pid  2430] connect(3, {sa_family=AF_INET, sin_port=htons(38855), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
  [pid  2430] setsockopt(3, SOL_TCP, 0x1f /* TCP_??? */, [7564404], 4) = 0
  [pid  2430] setsockopt(3, 0x11a /* SOL_?? */, 1, "\3\0033\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 40) = 0
  [pid  2430] accept(4, {sa_family=AF_INET, sin_port=htons(49636), sin_addr=inet_addr("127.0.0.1")}, [16]) = 5
  [pid  2430] setsockopt(5, SOL_TCP, 0x1f /* TCP_??? */, [7564404], 4) = 0
  [pid  2430] setsockopt(5, 0x11a /* SOL_?? */, 2, "\3\0033\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 40) = 0
  [pid  2430] close(4)                    = 0
  [pid  2430] sendto(3, "test_read_peek", 14, 0, NULL, 0) = 14
  [pid  2430] sendto(3, "_mult_recs\0", 11, 0, NULL, 0) = 11
  [pid  2430] recvfrom(5, "test_read_peektest_read_peektest"..., 64, MSG_PEEK, NULL, NULL) = 64

As can be seen from strace, there are two TLS records sent,
i) 'test_read_peek' and ii) '_mult_recs\0' where we end up
peeking 'test_read_peektest_read_peektest'. This is clearly
wrong, and what happens is that given peek cannot call into
tls_sw_advance_skb() to unpause strparser and proceed with
the next skb, we end up looping over the current one, copying
the 'test_read_peek' over and over into the user provided
buffer.

Here, we can only peek into the currently held skb (current,
full TLS record) as otherwise we would end up having to hold
all the original skb(s) (depending on the peek depth) in a
separate queue when unpausing strparser to process next
records, minimally intrusive is to return only up to the
current record's size (which likely was what c46234ebb4d1
("tls: RX path for ktls") originally intended as well). Thus,
after patch we properly peek the first record:

  [pid  2046] wait4(2075,  <unfinished ...>
  [pid  2075] socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 3
  [pid  2075] socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 4
  [pid  2075] bind(4, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
  [pid  2075] listen(4, 10)               = 0
  [pid  2075] getsockname(4, {sa_family=AF_INET, sin_port=htons(55115), sin_addr=inet_addr("0.0.0.0")}, [16]) = 0
  [pid  2075] connect(3, {sa_family=AF_INET, sin_port=htons(55115), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
  [pid  2075] setsockopt(3, SOL_TCP, 0x1f /* TCP_??? */, [7564404], 4) = 0
  [pid  2075] setsockopt(3, 0x11a /* SOL_?? */, 1, "\3\0033\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 40) = 0
  [pid  2075] accept(4, {sa_family=AF_INET, sin_port=htons(45732), sin_addr=inet_addr("127.0.0.1")}, [16]) = 5
  [pid  2075] setsockopt(5, SOL_TCP, 0x1f /* TCP_??? */, [7564404], 4) = 0
  [pid  2075] setsockopt(5, 0x11a /* SOL_?? */, 2, "\3\0033\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 40) = 0
  [pid  2075] close(4)                    = 0
  [pid  2075] sendto(3, "test_read_peek", 14, 0, NULL, 0) = 14
  [pid  2075] sendto(3, "_mult_recs\0", 11, 0, NULL, 0) = 11
  [pid  2075] recvfrom(5, "test_read_peek", 64, MSG_PEEK, NULL, NULL) = 14

Fixes: c46234ebb4d1 ("tls: RX path for ktls")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -872,7 +872,15 @@ fallback_to_reg_recv:
 				if (control != TLS_RECORD_TYPE_DATA)
 					goto recv_end;
 			}
+		} else {
+			/* MSG_PEEK right now cannot look beyond current skb
+			 * from strparser, meaning we cannot advance skb here
+			 * and thus unpause strparser since we'd loose original
+			 * one.
+			 */
+			break;
 		}
+
 		/* If we have a new message from strparser, continue now. */
 		if (copied >= target && !ctx->recv_pkt)
 			break;


