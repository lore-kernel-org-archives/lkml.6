Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755DDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD02082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Q2Yv6WhC";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="O7mA1xUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAD02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeKATLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:11:44 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:56149 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbeKATLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:11:44 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 3AF6220F0C;
        Thu,  1 Nov 2018 13:09:23 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id k7wV3VC2aP-9MZqCVTh;
        Thu, 01 Nov 2018 13:09:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541066963; bh=5XyzUiMc6T9KjaZost3Qv29MAeVGLlXihBR3zRuGc4E=;
        h=Subject:From:To:Date:Message-ID:In-Reply-To:References;
        b=Q2Yv6WhCmQ+F34s9zZGoMDNi2IDjGNzQZ1M66CH15Wl1kGTxguVoO5KXjKbzBVZDB
         4wLbIYRekvmAUiv88vPDF0/2cwZMgVfcBRgxc/3jntjHTeaYOZgVCM6PnlajKQj7oE
         W7XCJonCoVdMVOarIKcutasw5M+bOvRUSpuFQf5w=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id nCvYi4GcmH-9MJ8BSDV;
        Thu, 01 Nov 2018 13:09:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541066962; bh=5XyzUiMc6T9KjaZost3Qv29MAeVGLlXihBR3zRuGc4E=;
        h=Subject:From:To:Date:Message-ID:In-Reply-To:References;
        b=O7mA1xUJuXTZqsufyCHdYxUxBmtGItp3qxsibGuQJmIBayfBr4ARHMnVTV21O50nM
         VW5s6HTnr7zT77K478PZc5Fhi/rz3kxo/auhlgKVtFQeiKnhH99oadJeAK53iKJQL/
         RkCcpTBc0rt2Sin45D6hjv63Yx5XJifk8EeJ4TqU=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH 2] mm/kvmalloc: do not call kmalloc for size >
 KMALLOC_MAX_SIZE
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 13:09:16 +0300
Message-ID: <154106695670.898059.5301435081426064314.stgit@buzz>
In-Reply-To: <154106356066.887821.4649178319705436373.stgit@buzz>
References: <154106356066.887821.4649178319705436373.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocations over KMALLOC_MAX_SIZE could be served only by vmalloc.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/util.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..f5f04fa22814 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -392,6 +392,9 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	gfp_t kmalloc_flags = flags;
 	void *ret;
 
+	if (size > KMALLOC_MAX_SIZE)
+		goto fallback;
+
 	/*
 	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
 	 * so the given set of flags has to be compatible.
@@ -422,6 +425,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
+fallback:
 	return __vmalloc_node_flags_caller(size, node, flags,
 			__builtin_return_address(0));
 }

