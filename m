Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B895C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413B214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wP6UyVV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6413B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbeKVFmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbeKVFmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C2A206BB;
        Wed, 21 Nov 2018 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827237;
        bh=vwsY/INc2uAMNcXcmRGFPyUWzCUrIoxiiYfh2k/2MV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wP6UyVV3bvCv7D9lRXkggzJnfb8JmkzwYy2VVCSznTY5LcJuVoF2y26RImvNrp50v
         W2lAHUghkS6uD+WzJMcBffdQjQx1d+xFr0B7k2x5j0jhuqao+R/9N7dn4rul5jl9J5
         3DBiJP54F8OgkU+COojubiDIc8DDT3RBjroSDYDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 08/42] sctp: not allow to set asoc prsctp_enable by sockopt
Date:   Wed, 21 Nov 2018 20:05:44 +0100
Message-Id: <20181121183148.331053310@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit cc3ccf26f0649089b3a34a2781977755ea36e72c ]

As rfc7496#section4.5 says about SCTP_PR_SUPPORTED:

   This socket option allows the enabling or disabling of the
   negotiation of PR-SCTP support for future associations.  For existing
   associations, it allows one to query whether or not PR-SCTP support
   was negotiated on a particular association.

It means only sctp sock's prsctp_enable can be set.

Note that for the limitation of SCTP_{CURRENT|ALL}_ASSOC, we will
add it when introducing SCTP_{FUTURE|CURRENT|ALL}_ASSOC for linux
sctp in another patchset.

v1->v2:
  - drop the params.assoc_id check as Neil suggested.

Fixes: 28aa4c26fce2 ("sctp: add SCTP_PR_SUPPORTED on sctp sockopt")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3958,32 +3958,16 @@ static int sctp_setsockopt_pr_supported(
 					unsigned int optlen)
 {
 	struct sctp_assoc_value params;
-	struct sctp_association *asoc;
-	int retval = -EINVAL;
 
 	if (optlen != sizeof(params))
-		goto out;
+		return -EINVAL;
 
-	if (copy_from_user(&params, optval, optlen)) {
-		retval = -EFAULT;
-		goto out;
-	}
+	if (copy_from_user(&params, optval, optlen))
+		return -EFAULT;
 
-	asoc = sctp_id2assoc(sk, params.assoc_id);
-	if (asoc) {
-		asoc->prsctp_enable = !!params.assoc_value;
-	} else if (!params.assoc_id) {
-		struct sctp_sock *sp = sctp_sk(sk);
+	sctp_sk(sk)->ep->prsctp_enable = !!params.assoc_value;
 
-		sp->ep->prsctp_enable = !!params.assoc_value;
-	} else {
-		goto out;
-	}
-
-	retval = 0;
-
-out:
-	return retval;
+	return 0;
 }
 
 static int sctp_setsockopt_default_prinfo(struct sock *sk,


