Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61A320866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrlkOyYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61A320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbeKLJvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbeKLIR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE27521104;
        Sun, 11 Nov 2018 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975281;
        bh=vNa8hbAlRQCaqQa8Lg2MDvg9oBZog1Wkhtx8icx9nYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrlkOyYNhKNMWX41sXIL5KsZpzWAIxbR1Z2eMyK+DaPCul9Rxu+470fMQx4TBCJy0
         xsR+CTXP6rS/77fgU/WkKw5QJzGDcDkI7KYScnSXIdQOqqfe8QSKqT/EbrMaYuK/56
         A455+qnuk6AJFF0bf6kk36ktk1nn6mYDBURjQq6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.19 202/361] xen/balloon: Support xend-based toolstack
Date:   Sun, 11 Nov 2018 14:19:09 -0800
Message-Id: <20181111221648.682442311@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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
@@ -76,12 +76,15 @@ static void watch_target(struct xenbus_w
 
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


