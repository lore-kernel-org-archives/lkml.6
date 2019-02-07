Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5671CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2403321908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539766;
	bh=bmHHXX7fye+jNjMXNZwH+I0sXudN+L2jUhvtjDLYef0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o05qA/7oEGdcom19fckjcfNffEk97XcusErpgWCcFOGlYx822vH24Kr4ye14Nskzq
	 DsV4PGV4fDBVJYaaeZprsSK8q8M2uXhyCKtAppFEtHGWPihF0rjmeHYk7rgk3hzt6z
	 xDLhJ7geIBgkXhULVgU+ogibSqnceBy2T2blG4oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBGLmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfBGLmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBAA218FE;
        Thu,  7 Feb 2019 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539760;
        bh=bmHHXX7fye+jNjMXNZwH+I0sXudN+L2jUhvtjDLYef0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfyObIgBdoQePLsr8Gf9yJFJEyZkrs2Bt23XY9GrvVjXeZYo4TBzPiyRXw6je5Q5W
         SMRDtWGvavV7pQbRtonxbZDq6PxPXDgtMqLyl5yR+ab+bVAKW8WtfjmmAUFnzEUyPm
         02P1Le9bmHc9DXFYtfLlR/WEzOPDnTP2U6QJxd/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 05/34] inet: frags: refactor lowpan_net_frag_init()
Date:   Thu,  7 Feb 2019 12:41:47 +0100
Message-Id: <20190207113025.778162679@linuxfoundation.org>
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

commit 807f1844df4ac23594268fa9f41902d0549e92aa upstream.

We want to call lowpan_net_frag_init() earlier.
Similar to commit "inet: frags: refactor ipv6_frag_init()"

This is a prereq to "inet: frags: use rhashtables for reassembly units"

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/reassembly.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -614,14 +614,6 @@ int __init lowpan_net_frag_init(void)
 {
 	int ret;
 
-	ret = lowpan_frags_sysctl_register();
-	if (ret)
-		return ret;
-
-	ret = register_pernet_subsys(&lowpan_frags_ops);
-	if (ret)
-		goto err_pernet;
-
 	lowpan_frags.hashfn = lowpan_hashfn;
 	lowpan_frags.constructor = lowpan_frag_init;
 	lowpan_frags.destructor = NULL;
@@ -632,11 +624,21 @@ int __init lowpan_net_frag_init(void)
 	lowpan_frags.frags_cache_name = lowpan_frags_cache_name;
 	ret = inet_frags_init(&lowpan_frags);
 	if (ret)
-		goto err_pernet;
+		goto out;
+
+	ret = lowpan_frags_sysctl_register();
+	if (ret)
+		goto err_sysctl;
 
+	ret = register_pernet_subsys(&lowpan_frags_ops);
+	if (ret)
+		goto err_pernet;
+out:
 	return ret;
 err_pernet:
 	lowpan_frags_sysctl_unregister();
+err_sysctl:
+	inet_frags_fini(&lowpan_frags);
 	return ret;
 }
 


