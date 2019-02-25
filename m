Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38260C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131091;
	bh=mJvg6CqohgYuPmD7jiSz5AJJH72tzit/RTjIKOtBccA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x77ZHB7nIGDmKW1Os/VhTL3a+nVsJ7ODkOYuxoEtmohpl/8gJ+iW+4JyC7jY5zVoc
	 WDDkn83Ccje5d0hzhkl/9VZJA1s+A8JejsSTEhWA83mmOwl8k+iJB1k05cWQxuwWmo
	 ltl/Al0C2xiiOVDTmALaOBFS2Nlcp2CXSNPtwlD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfBYVot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732068AbfBYV34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA92217F5;
        Mon, 25 Feb 2019 21:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130195;
        bh=mJvg6CqohgYuPmD7jiSz5AJJH72tzit/RTjIKOtBccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aM8k3R+Z4alMsH6WG656sdjtbhtd8C4Ji4TqiCQUBoYKriuUeVbGTZhYe3k1NWFhZ
         Fk0V4Uf62+MFfcHOi5iB14S/6/i2baIwRIwb7bIQ5HxOvOhDh98EtIk/aCkL0S92E5
         hfjjX7uAf4UcISfQR6Ygx3bMWWNOLeiHaX+4AYck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Oskolkov <posk@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 044/183] selftests: net: fix/improve ip_defrag selftest
Date:   Mon, 25 Feb 2019 22:10:17 +0100
Message-Id: <20190225195102.041744713@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3271a4821882a64214acc1bd7b173900ec70c9bf ]

Commit ade446403bfb ("net: ipv4: do not handle duplicate fragments as
overlapping") changed IPv4 defragmentation so that duplicate fragments,
as well as _some_ fragments completely covered by previously delivered
fragments, do not lead to the whole frag queue being discarded. This
makes the existing ip_defrag selftest flaky.

This patch
* makes sure that negative IPv4 defrag tests generate truly overlapping
  fragments that trigger defrag queue drops;
* tests that duplicate IPv4 fragments do not trigger defrag queue drops;
* makes a couple of minor tweaks to the test aimed at increasing its code
  coverage and reduce flakiness.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/ip_defrag.c  | 96 +++++++++++++++++++++---
 tools/testing/selftests/net/ip_defrag.sh |  9 ++-
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ip_defrag.c b/tools/testing/selftests/net/ip_defrag.c
index 61ae2782388e9..5d56cc0838f62 100644
--- a/tools/testing/selftests/net/ip_defrag.c
+++ b/tools/testing/selftests/net/ip_defrag.c
@@ -203,6 +203,7 @@ static void send_udp_frags(int fd_raw, struct sockaddr *addr,
 {
 	struct ip *iphdr = (struct ip *)ip_frame;
 	struct ip6_hdr *ip6hdr = (struct ip6_hdr *)ip_frame;
+	const bool ipv4 = !ipv6;
 	int res;
 	int offset;
 	int frag_len;
@@ -239,19 +240,53 @@ static void send_udp_frags(int fd_raw, struct sockaddr *addr,
 		iphdr->ip_sum = 0;
 	}
 
+	/* Occasionally test in-order fragments. */
+	if (!cfg_overlap && (rand() % 100 < 15)) {
+		offset = 0;
+		while (offset < (UDP_HLEN + payload_len)) {
+			send_fragment(fd_raw, addr, alen, offset, ipv6);
+			offset += max_frag_len;
+		}
+		return;
+	}
+
+	/* Occasionally test IPv4 "runs" (see net/ipv4/ip_fragment.c) */
+	if (ipv4 && !cfg_overlap && (rand() % 100 < 20) &&
+			(payload_len > 9 * max_frag_len)) {
+		offset = 6 * max_frag_len;
+		while (offset < (UDP_HLEN + payload_len)) {
+			send_fragment(fd_raw, addr, alen, offset, ipv6);
+			offset += max_frag_len;
+		}
+		offset = 3 * max_frag_len;
+		while (offset < 6 * max_frag_len) {
+			send_fragment(fd_raw, addr, alen, offset, ipv6);
+			offset += max_frag_len;
+		}
+		offset = 0;
+		while (offset < 3 * max_frag_len) {
+			send_fragment(fd_raw, addr, alen, offset, ipv6);
+			offset += max_frag_len;
+		}
+		return;
+	}
+
 	/* Odd fragments. */
 	offset = max_frag_len;
 	while (offset < (UDP_HLEN + payload_len)) {
 		send_fragment(fd_raw, addr, alen, offset, ipv6);
+		/* IPv4 ignores duplicates, so randomly send a duplicate. */
+		if (ipv4 && (1 == rand() % 100))
+			send_fragment(fd_raw, addr, alen, offset, ipv6);
 		offset += 2 * max_frag_len;
 	}
 
 	if (cfg_overlap) {
 		/* Send an extra random fragment. */
-		offset = rand() % (UDP_HLEN + payload_len - 1);
-		/* sendto() returns EINVAL if offset + frag_len is too small. */
 		if (ipv6) {
 			struct ip6_frag *fraghdr = (struct ip6_frag *)(ip_frame + IP6_HLEN);
+			/* sendto() returns EINVAL if offset + frag_len is too small. */
+			offset = rand() % (UDP_HLEN + payload_len - 1);
 			frag_len = max_frag_len + rand() % 256;
 			/* In IPv6 if !!(frag_len % 8), the fragment is dropped. */
 			frag_len &= ~0x7;
@@ -259,13 +294,29 @@ static void send_udp_frags(int fd_raw, struct sockaddr *addr,
 			ip6hdr->ip6_plen = htons(frag_len);
 			frag_len += IP6_HLEN;
 		} else {
-			frag_len = IP4_HLEN + UDP_HLEN + rand() % 256;
+			/* In IPv4, duplicates and some fragments completely inside
+			 * previously sent fragments are dropped/ignored. So
+			 * random offset and frag_len can result in a dropped
+			 * fragment instead of a dropped queue/packet. So we
+			 * hard-code offset and frag_len.
+			 *
+			 * See ade446403bfb ("net: ipv4: do not handle duplicate
+			 * fragments as overlapping").
+			 */
+			if (max_frag_len * 4 < payload_len || max_frag_len < 16) {
+				/* not enough payload to play with random offset and frag_len. */
+				offset = 8;
+				frag_len = IP4_HLEN + UDP_HLEN + max_frag_len;
+			} else {
+				offset = rand() % (payload_len / 2);
+				frag_len = 2 * max_frag_len + 1 + rand() % 256;
+			}
 			iphdr->ip_off = htons(offset / 8 | IP4_MF);
 			iphdr->ip_len = htons(frag_len);
 		}
 		res = sendto(fd_raw, ip_frame, frag_len, 0, addr, alen);
 		if (res < 0)
-			error(1, errno, "sendto overlap");
+			error(1, errno, "sendto overlap: %d", frag_len);
 		if (res != frag_len)
 			error(1, 0, "sendto overlap: %d vs %d", (int)res, frag_len);
 		frag_counter++;
@@ -275,6 +326,9 @@ static void send_udp_frags(int fd_raw, struct sockaddr *addr,
 	offset = 0;
 	while (offset < (UDP_HLEN + payload_len)) {
 		send_fragment(fd_raw, addr, alen, offset, ipv6);
+		/* IPv4 ignores duplicates, so randomly send a duplicate. */
+		if (ipv4 && (1 == rand() % 100))
+			send_fragment(fd_raw, addr, alen, offset, ipv6);
 		offset += 2 * max_frag_len;
 	}
 }
@@ -282,7 +336,11 @@ static void send_udp_frags(int fd_raw, struct sockaddr *addr,
 static void run_test(struct sockaddr *addr, socklen_t alen, bool ipv6)
 {
 	int fd_tx_raw, fd_rx_udp;
-	struct timeval tv = { .tv_sec = 0, .tv_usec = 10 * 1000 };
+	/* Frag queue timeout is set to one second in the calling script;
+	 * socket timeout should be just a bit longer to avoid tests interfering
+	 * with each other.
+	 */
+	struct timeval tv = { .tv_sec = 1, .tv_usec = 10 };
 	int idx;
 	int min_frag_len = ipv6 ? 1280 : 8;
 
@@ -308,12 +366,32 @@ static void run_test(struct sockaddr *addr, socklen_t alen, bool ipv6)
 			payload_len += (rand() % 4096)) {
 		if (cfg_verbose)
 			printf("payload_len: %d\n", payload_len);
-		max_frag_len = min_frag_len;
-		do {
+
+		if (cfg_overlap) {
+			/* With overlaps, one send/receive pair below takes
+			 * at least one second (== timeout) to run, so there
+			 * is not enough test time to run a nested loop:
+			 * the full overlap test takes 20-30 seconds.
+			 */
+			max_frag_len = min_frag_len +
+				rand() % (1500 - FRAG_HLEN - min_frag_len);
 			send_udp_frags(fd_tx_raw, addr, alen, ipv6);
 			recv_validate_udp(fd_rx_udp);
-			max_frag_len += 8 * (rand() % 8);
-		} while (max_frag_len < (1500 - FRAG_HLEN) && max_frag_len <= payload_len);
+		} else {
+			/* Without overlaps, each packet reassembly (== one
+			 * send/receive pair below) takes very little time to
+			 * run, so we can easily afford more thourough testing
+			 * with a nested loop: the full non-overlap test takes
+			 * less than one second).
+			 */
+			max_frag_len = min_frag_len;
+			do {
+				send_udp_frags(fd_tx_raw, addr, alen, ipv6);
+				recv_validate_udp(fd_rx_udp);
+				max_frag_len += 8 * (rand() % 8);
+			} while (max_frag_len < (1500 - FRAG_HLEN) &&
+				 max_frag_len <= payload_len);
+		}
 	}
 
 	/* Cleanup. */
diff --git a/tools/testing/selftests/net/ip_defrag.sh b/tools/testing/selftests/net/ip_defrag.sh
index f346727960449..7dd79a9efb177 100755
--- a/tools/testing/selftests/net/ip_defrag.sh
+++ b/tools/testing/selftests/net/ip_defrag.sh
@@ -11,10 +11,17 @@ readonly NETNS="ns-$(mktemp -u XXXXXX)"
 setup() {
 	ip netns add "${NETNS}"
 	ip -netns "${NETNS}" link set lo up
+
 	ip netns exec "${NETNS}" sysctl -w net.ipv4.ipfrag_high_thresh=9000000 >/dev/null 2>&1
 	ip netns exec "${NETNS}" sysctl -w net.ipv4.ipfrag_low_thresh=7000000 >/dev/null 2>&1
+	ip netns exec "${NETNS}" sysctl -w net.ipv4.ipfrag_time=1 >/dev/null 2>&1
+
 	ip netns exec "${NETNS}" sysctl -w net.ipv6.ip6frag_high_thresh=9000000 >/dev/null 2>&1
 	ip netns exec "${NETNS}" sysctl -w net.ipv6.ip6frag_low_thresh=7000000 >/dev/null 2>&1
+	ip netns exec "${NETNS}" sysctl -w net.ipv6.ip6frag_time=1 >/dev/null 2>&1
+
+	# DST cache can get full with a lot of frags, with GC not keeping up with the test.
+	ip netns exec "${NETNS}" sysctl -w net.ipv6.route.max_size=65536 >/dev/null 2>&1
 }
 
 cleanup() {
@@ -27,7 +34,6 @@ setup
 echo "ipv4 defrag"
 ip netns exec "${NETNS}" ./ip_defrag -4
 
-
 echo "ipv4 defrag with overlaps"
 ip netns exec "${NETNS}" ./ip_defrag -4o
 
@@ -37,3 +43,4 @@ ip netns exec "${NETNS}" ./ip_defrag -6
 echo "ipv6 defrag with overlaps"
 ip netns exec "${NETNS}" ./ip_defrag -6o
 
+echo "all tests done"
-- 
2.19.1



