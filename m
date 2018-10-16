Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F652C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8BE2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnlJkeTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8BE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbeJQBNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbeJQBNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:49 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA52120866;
        Tue, 16 Oct 2018 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710544;
        bh=9qFyNqRj8oA5dw9hh5gr/JREIodGl7jHFFeFT1+vMdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnlJkeTJQEmELURFFIVjr8RGHNnu0JxpVwd/Wf4odNFaIo4cipR8uy44ZcVl2RpQm
         SIsMKLm6LZ/FgPcOYIOjXnuxsHZ9MO48NnqYFhpp4YDHXRc6ztpk2IWvdwxvxXr69V
         wO+eXSPmKoMw5+1AqffiFz8I0KrFrbQ+BGiJAN9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 083/109] mm: treat indirectly reclaimable memory as free in overcommit logic
Date:   Tue, 16 Oct 2018 19:05:51 +0200
Message-Id: <20181016170529.536634030@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Roman Gushchin <guro@fb.com>

commit d79f7aa496fc94d763f67b833a1f36f4c171176f upstream.

Indirectly reclaimable memory can consume a significant part of total
memory and it's actually reclaimable (it will be released under actual
memory pressure).

So, the overcommit logic should treat it as free.

Otherwise, it's possible to cause random system-wide memory allocation
failures by consuming a significant amount of memory by indirectly
reclaimable memory, e.g.  dentry external names.

If overcommit policy GUESS is used, it might be used for denial of
service attack under some conditions.

The following program illustrates the approach.  It causes the kernel to
allocate an unreclaimable kmalloc-256 chunk for each stat() call, so
that at some point the overcommit logic may start blocking large
allocation system-wide.

  int main()
  {
  	char buf[256];
  	unsigned long i;
  	struct stat statbuf;

  	buf[0] = '/';
  	for (i = 1; i < sizeof(buf); i++)
  		buf[i] = '_';

  	for (i = 0; 1; i++) {
  		sprintf(&buf[248], "%8lu", i);
  		stat(buf, &statbuf);
  	}

  	return 0;
  }

This patch in combination with related indirectly reclaimable memory
patches closes this issue.

Link: http://lkml.kernel.org/r/20180313130041.8078-1-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/util.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/util.c
+++ b/mm/util.c
@@ -636,6 +636,13 @@ int __vm_enough_memory(struct mm_struct
 		free += global_node_page_state(NR_SLAB_RECLAIMABLE);
 
 		/*
+		 * Part of the kernel memory, which can be released
+		 * under memory pressure.
+		 */
+		free += global_node_page_state(
+			NR_INDIRECTLY_RECLAIMABLE_BYTES) >> PAGE_SHIFT;
+
+		/*
 		 * Leave reserved pages. The pages are not for anonymous pages.
 		 */
 		if (free <= totalreserve_pages)


