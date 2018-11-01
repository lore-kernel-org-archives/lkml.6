Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ED52081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="cQ6nP1rq";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YjQfs1/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ED52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeKBClw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:41:52 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:46920 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbeKBClw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:41:52 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 3CDF92115A;
        Thu,  1 Nov 2018 20:37:54 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9Eetnn9lym-br785SsF;
        Thu, 01 Nov 2018 20:37:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541093874; bh=9NSKQD9TC6CWOvQJHMbTYziFeV12lZg9YoYRZ3Vv2jQ=;
        h=Subject:From:To:Date:Message-ID;
        b=cQ6nP1rqfCJuNrTHvm5j/it7y/lCJV9JrOxuiHnaMCWsbhlrr+VejkxJ5S/0nDbvs
         V0FGi5LWm46kPtrQvlWTxsT/GScMIDXY6x/IWWVozKjlVAsiB17F2LHoAUmjchpYRC
         2ocHJrX0ZYmui+oCLVvHRZlXfxjNBIanM77f7gsQ=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2bn0JepsrD-brJ8svCg;
        Thu, 01 Nov 2018 20:37:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541093873; bh=9NSKQD9TC6CWOvQJHMbTYziFeV12lZg9YoYRZ3Vv2jQ=;
        h=Subject:From:To:Date:Message-ID;
        b=YjQfs1/oojFxHwS1lXBorLFoxTAGLzobHNmKCP/+F440FQQq2Jpj6j5fk8UX/+CyH
         wFP4++cZNNp7Fxtecq/HagLwBnbYcIjni+T2HkTBS/OOzIo1bxdOSqty+xIKEJPz+h
         9lvSL9inm3MHqUTUa737CDN2P9nDPbDWLssisC6M=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH RFC] mm: do not start node_reclaim for page order > MAX_ORDER
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 20:37:52 +0300
Message-ID: <154109387197.925352.10499549042420271600.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page allocator has check in __alloc_pages_slowpath() but nowdays
there is earlier entry point into reclimer without such check:
get_page_from_freelist() -> node_reclaim().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/vmscan.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 62ac0c488624..52f672420f0b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4117,6 +4117,12 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 {
 	int ret;
 
+	/*
+	 * Do not scan if allocation will never succeed.
+	 */
+	if (order >= MAX_ORDER)
+		return NODE_RECLAIM_NOSCAN;
+
 	/*
 	 * Node reclaim reclaims unmapped file backed pages and
 	 * slab pages if we are over the defined limits.

