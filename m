Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F8EC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6AF217C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6AF217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbeHDLGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:06:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeHDLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:06:52 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CC5B89C;
        Sat,  4 Aug 2018 09:06:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 013/124] mm: vmalloc: avoid racy handling of debugobjects in vunmap
Date:   Sat,  4 Aug 2018 11:00:02 +0200
Message-Id: <20180804082702.944352727@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chintan Pandya <cpandya@codeaurora.org>

[ Upstream commit f3c01d2f3ade6790db67f80fef60df84424f8964 ]

Currently, __vunmap flow is,
 1) Release the VM area
 2) Free the debug objects corresponding to that vm area.

This leave some race window open.
 1) Release the VM area
 1.5) Some other client gets the same vm area
 1.6) This client allocates new debug objects on the same
      vm area
 2) Free the debug objects corresponding to this vm area.

Here, we actually free 'other' client's debug objects.

Fix this by freeing the debug objects first and then releasing the VM
area.

Link: http://lkml.kernel.org/r/1523961828-9485-2-git-send-email-cpandya@codeaurora.org
Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1460,7 +1460,7 @@ static void __vunmap(const void *addr, i
 			addr))
 		return;
 
-	area = remove_vm_area(addr);
+	area = find_vmap_area((unsigned long)addr)->vm;
 	if (unlikely(!area)) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
@@ -1470,6 +1470,7 @@ static void __vunmap(const void *addr, i
 	debug_check_no_locks_freed(addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(addr, get_vm_area_size(area));
 
+	remove_vm_area(addr);
 	if (deallocate_pages) {
 		int i;
 


