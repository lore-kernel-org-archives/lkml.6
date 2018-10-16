Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6172A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsvAjp1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6172A2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeJQBHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbeJQBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320E420866;
        Tue, 16 Oct 2018 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710147;
        bh=H6EavX5kiUCwTlL0B0Zfx15VmRJQcvrg+RR0MJm222k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsvAjp1NJq3QsSlbVFkGC83x1zHdRqx8hxYYPDk8Meg89JP0EpPGsjzirup7TRmi5
         UKhD67Na5vS2gzAuNtLuXtpEoxxJ0SGlZhR4fUIKO5PkMYrFjb7PWfbbCY0Se4vndk
         cvxyTh+b58UAM4IjybcYbW4aOkgkX4fuCIlTFNFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 4.18 117/135] percpu: stop leaking bitmap metadata blocks
Date:   Tue, 16 Oct 2018 19:05:47 +0200
Message-Id: <20181016170523.386357636@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

commit 6685b357363bfe295e3ae73665014db4aed62c58 upstream.

The commit ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
introduced bitmap metadata blocks. These metadata blocks are allocated
whenever a new chunk is created, but they are never freed. Fix it.

Fixes: ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/percpu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1204,6 +1204,7 @@ static void pcpu_free_chunk(struct pcpu_
 {
 	if (!chunk)
 		return;
+	pcpu_mem_free(chunk->md_blocks);
 	pcpu_mem_free(chunk->bound_map);
 	pcpu_mem_free(chunk->alloc_map);
 	pcpu_mem_free(chunk);


