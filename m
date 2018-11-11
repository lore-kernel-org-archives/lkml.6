Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy6exHjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4143A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390854AbeKLIt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390758AbeKLIWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:37 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEB6223D8;
        Sun, 11 Nov 2018 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975560;
        bh=ISyLzg5mLhtJo5BRc+RAvFW1dOV6cnQWISZWVbfs7Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hy6exHjCIqInjsQqVyPOqUdk2SS0Zdc+15sAFt/TUwpNCUqg6QoCuY9FDz8gdY3wb
         2494udNjnjiOD7UJs+AY107F2oR8ZJAAjHTKh1QduLNJ7dWVUh+XAhel8tvQj27FnU
         2iSi1hLulKiqRPL6Z/XzsAl/doeNFjW8FfrwzY20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 119/222] xen/balloon: Support xend-based toolstack
Date:   Sun, 11 Nov 2018 14:23:36 -0800
Message-Id: <20181111221658.366872342@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 3aa6c19d2f38be9c6e9a8ad5fa8e3c9d29ee3c35 upstream.

Xend-based toolstacks don't have static-max entry in xenstore. The
equivalent node for those toolstacks is memory_static_max.

Fixes: 5266b8e4445c (xen: fix booting ballooned down hvm guest)
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: <stable@vger.kernel.org> # 4.13
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/xen-balloon.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -75,12 +75,15 @@ static void watch_target(struct xenbus_w
 
 	if (!watch_fired) {
 		watch_fired = true;
-		err = xenbus_scanf(XBT_NIL, "memory", "static-max", "%llu",
-				   &static_max);
-		if (err != 1)
-			static_max = new_target;
-		else
+
+		if ((xenbus_scanf(XBT_NIL, "memory", "static-max",
+				  "%llu", &static_max) == 1) ||
+		    (xenbus_scanf(XBT_NIL, "memory", "memory_static_max",
+				  "%llu", &static_max) == 1))
 			static_max >>= PAGE_SHIFT - 10;
+		else
+			static_max = new_target;
+
 		target_diff = (xen_pv_domain() || xen_initial_domain()) ? 0
 				: static_max - balloon_stats.target_pages;
 	}


