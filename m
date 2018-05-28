Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165829AbeE1OjC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161308AbeE1Kbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 078/329] netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure
Date: Mon, 28 May 2018 12:00:07 +0200
Message-Id: <20180528100249.333943475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit ea23d5e3bf340e413b8e05c13da233c99c64142b ]

Failures were seen in ICMPv6 fragmentation timeout tests if they were
run after the RFC2460 failure tests. Kernel was not sending out the
ICMPv6 fragment reassembly time exceeded packet after the fragmentation
reassembly timeout of 1 minute had elapsed.

This happened because the frag queue was not released if an error in
IPv6 fragmentation header was detected by RFC2460.

Fixes: 83f1999caeb1 ("netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -263,6 +263,7 @@ static int nf_ct_frag6_queue(struct frag
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
+			inet_frag_kill(&fq->q, &nf_frags);
 			return -EPROTO;
 		}
 		if (end > fq->q.len) {
