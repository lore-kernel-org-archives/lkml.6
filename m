Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB344C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB7421907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539758;
	bh=6Dm4Ne0Glu72l/k4hPcUbTtTwz8qsyl+nMTW5zxbRZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IrUNbJcNv8BZCJyGsT+US18Y/U3+XDS6ATWp9YgqukmD9WEmtuoi2454lAv6WUViU
	 6M3/COmPHtnCHgzfpRch27f95QC9dmTfnBcdGxa70i6WJ6+IkkXhi4DTefbm+Lsqb7
	 WLPZvOUasDkWHSLey7jamfI2lwYI9IcR1Q42JGnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBGLmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGLmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4EC21904;
        Thu,  7 Feb 2019 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539754;
        bh=6Dm4Ne0Glu72l/k4hPcUbTtTwz8qsyl+nMTW5zxbRZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fz/1m+gLnRLLxf5oDxkpQzhc+KQypg/gCeS+yfTJIqHCx9j8+vICOobyZftNOhjKJ
         GHvby1D2z2JGWLkfD4Nv8NJ5YwAgHaLNb9I6yYJL5lTeJz8CP213sQRFP8GmQFQXDZ
         VM+m9vFHsRQrgw4VwQdt+97Iv9MMpKScGzDPjd8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 03/34] inet: frags: refactor ipfrag_init()
Date:   Thu,  7 Feb 2019 12:41:45 +0100
Message-Id: <20190207113025.697349150@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 483a6e4fa055123142d8956866fe2aa9c98d546d upstream.

We need to call inet_frags_init() before register_pernet_subsys(),
as a prereq for following patch ("inet: frags: use rhashtables for reassembly units")

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -902,8 +902,6 @@ static struct pernet_operations ip4_frag
 
 void __init ipfrag_init(void)
 {
-	ip4_frags_ctl_register();
-	register_pernet_subsys(&ip4_frags_ops);
 	ip4_frags.hashfn = ip4_hashfn;
 	ip4_frags.constructor = ip4_frag_init;
 	ip4_frags.destructor = ip4_frag_free;
@@ -914,4 +912,6 @@ void __init ipfrag_init(void)
 	ip4_frags.frags_cache_name = ip_frag_cache_name;
 	if (inet_frags_init(&ip4_frags))
 		panic("IP: failed to allocate ip4_frags cache\n");
+	ip4_frags_ctl_register();
+	register_pernet_subsys(&ip4_frags_ops);
 }


