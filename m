Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0792F208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDMsNyPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0792F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeKIHft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbeKIHfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:42 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00AB21019;
        Thu,  8 Nov 2018 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714294;
        bh=Jg/4NBMu7SJ95kBOi4gtxCvwKNez21QjGDz9XT834UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDMsNyPACGLQBOo7updBW8nUuMVFq1Ytd0j1DXCTIY98avIhXHEbFiEJ2ZojkDXsr
         HHBs9FzzCzwLlAD889zJWNSCB1RJhzD78rq9OL+R9qivqTJ0WBmBmYhMhcezDV9gKH
         +hTAEO5WzSkA2frgszwJ+VcMIHNXXTufPtgVOtdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 3.18 129/144] /proc/iomem: only expose physical resource addresses to privileged users
Date:   Thu,  8 Nov 2018 13:51:40 -0800
Message-Id: <20181108215107.454226384@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 51d7b120418e99d6b3bf8df9eb3cc31e8171dee4 upstream.

In commit c4004b02f8e5b ("x86: remove the kernel code/data/bss resources
from /proc/iomem") I was hoping to remove the phyiscal kernel address
data from /proc/iomem entirely, but that had to be reverted because some
system programs actually use it.

This limits all the detailed resource information to properly
credentialed users instead.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/resource.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -104,16 +104,25 @@ static int r_show(struct seq_file *m, vo
 {
 	struct resource *root = m->private;
 	struct resource *r = v, *p;
+	unsigned long long start, end;
 	int width = root->end < 0x10000 ? 4 : 8;
 	int depth;
 
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
+
+	if (file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN)) {
+		start = r->start;
+		end = r->end;
+	} else {
+		start = end = 0;
+	}
+
 	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
 			depth * 2, "",
-			width, (unsigned long long) r->start,
-			width, (unsigned long long) r->end,
+			width, start,
+			width, end,
 			r->name ? r->name : "<BAD>");
 	return 0;
 }


