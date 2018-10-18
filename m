Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A214C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57721480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EInfxGwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE57721480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbeJSCFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbeJSCFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:05:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472D921476;
        Thu, 18 Oct 2018 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885815;
        bh=TxGxvajX3NYJFkaW0Sf2IImg3jI0DNOvYnJatPW0uNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EInfxGwTW/sjcSc50Q+o6Du0ra6kK9bZCt7W7vAZdpR95XKonHOMZz16AhQ40CBwT
         vLwbmOc5QccH7eESsKEGZj9AA4CE25pXPJ8h5Lrs23cX/q80fCNXrKQzjeg99D20Sn
         P46ZsAGnOMbST6IwtC6SHu6VeZvern9vj7Cr5jOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Xin Long <lucien.xin@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 25/35] netfilter: check for seqadj ext existence before adding it in nf_nat_setup_info
Date:   Thu, 18 Oct 2018 19:54:54 +0200
Message-Id: <20181018175426.355176392@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit ab6dd1beac7be3c17f8bf3d38bdf29ecb7293f1e upstream.

Commit 4440a2ab3b9f ("netfilter: synproxy: Check oom when adding synproxy
and seqadj ct extensions") wanted to drop the packet when it fails to add
seqadj ext due to no memory by checking if nfct_seqadj_ext_add returns
NULL.

But that nfct_seqadj_ext_add returns NULL can also happen when seqadj ext
already exists in a nf_conn. It will cause that userspace protocol doesn't
work when both dnat and snat are configured.

Li Shuang found this issue in the case:

Topo:
   ftp client                   router                  ftp server
  10.167.131.2  <-> 10.167.131.254  10.167.141.254 <-> 10.167.141.1

Rules:
  # iptables -t nat -A PREROUTING -i eth1 -p tcp -m tcp --dport 21 -j \
    DNAT --to-destination 10.167.141.1
  # iptables -t nat -A POSTROUTING -o eth2 -p tcp -m tcp --dport 21 -j \
    SNAT --to-source 10.167.141.254

In router, when both dnat and snat are added, nf_nat_setup_info will be
called twice. The packet can be dropped at the 2nd time for DNAT due to
seqadj ext is already added at the 1st time for SNAT.

This patch is to fix it by checking for seqadj ext existence before adding
it, so that the packet will not be dropped if seqadj ext already exists.

Note that as Florian mentioned, as a long term, we should review ext_add()
behaviour, it's better to return a pointer to the existing ext instead.

Fixes: 4440a2ab3b9f ("netfilter: synproxy: Check oom when adding synproxy and seqadj ct extensions")
Reported-by: Li Shuang <shuali@redhat.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_nat_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -421,7 +421,7 @@ nf_nat_setup_info(struct nf_conn *ct,
 		else
 			ct->status |= IPS_DST_NAT;
 
-		if (nfct_help(ct))
+		if (nfct_help(ct) && !nfct_seqadj(ct))
 			if (!nfct_seqadj_ext_add(ct))
 				return NF_DROP;
 	}


