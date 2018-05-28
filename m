Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163827AbeE1NNQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163535AbeE1Kuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 181/496] ipvs: remove IPS_NAT_MASK check to fix passive FTP
Date: Mon, 28 May 2018 11:59:26 +0200
Message-Id: <20180528100327.590597623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit 8a949fff0302b50063f74bb345a66190015528d0 ]

The IPS_NAT_MASK check in 4.12 replaced previous check for nfct_nat()
which was needed to fix a crash in 2.6.36-rc, see
commit 7bcbf81a2296 ("ipvs: avoid oops for passive FTP").
But as IPVS does not set the IPS_SRC_NAT and IPS_DST_NAT bits,
checking for IPS_NAT_MASK prevents PASV response to be properly
mangled and blocks the transfer. Remove the check as it is not
needed after 3.12 commit 41d73ec053d2 ("netfilter: nf_conntrack:
make sequence number adjustments usuable without NAT") which
changes nfct_nat() with nfct_seqadj() and especially after 3.13
commit b25adce16064 ("ipvs: correct usage/allocation of seqadj
ext in ipvs").

Thanks to Li Shuang and Florian Westphal for reporting the problem!

Reported-by: Li Shuang <shuali@redhat.com>
Fixes: be7be6e161a2 ("netfilter: ipvs: fix incorrect conflict resolution")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipvs/ip_vs_ftp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -260,7 +260,7 @@ static int ip_vs_ftp_out(struct ip_vs_ap
 		buf_len = strlen(buf);
 
 		ct = nf_ct_get(skb, &ctinfo);
-		if (ct && (ct->status & IPS_NAT_MASK)) {
+		if (ct) {
 			bool mangled;
 
 			/* If mangling fails this function will return 0
