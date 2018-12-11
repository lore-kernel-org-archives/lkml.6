Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEABC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726D62145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543306;
	bh=+MHfQRR70XAfTjncgdsYePr26YS5fI7Fxzo56QxNWIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1vMJaYet8iFgGav2jgmZsi62SjDOVMXK4hE01eiyVGIVwmFToKLzpHNB0SnfC2Z2I
	 OUS01X7kSWVxh9Zgt1CKIoo3BNrhsW9sHGgUHthMKQyPfZwz6aErYAq/z5fVAoCqyL
	 geJHZH9xLWcY8HGKOesHqAwoDs7ZOSIZdLdV4npE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726D62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeLKPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbeLKPsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEF520989;
        Tue, 11 Dec 2018 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543301;
        bh=+MHfQRR70XAfTjncgdsYePr26YS5fI7Fxzo56QxNWIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ptogyc4FnAjLgn1NK1DhnXr+xAmq0H5qqBvxXfWnpy7Ce5rX3TPXq9V+mI3C/9nsf
         1vBmsVC1SrZc2Y7v3ARb+22RCVWwTAY784SE2uvkUJSF+NSWXUhoGOmRrigZrz1GL0
         dwFrl8Z0K2C/1hWE1HP9R7YqTDsnkLLt2yKAyFDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric B Munson <emunson@akamai.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.4 55/91] mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock2(,MLOCK_ONFAULT)
Date:   Tue, 11 Dec 2018 16:41:14 +0100
Message-Id: <20181211151610.493454417@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Simon Guo <wei.guo.simon@gmail.com>

commit b155b4fde5bdde9fed439cd1f5ea07173df2ed31 upstream.

When one vma was with flag VM_LOCKED|VM_LOCKONFAULT (by invoking
mlock2(,MLOCK_ONFAULT)), it can again be populated with mlock() with
VM_LOCKED flag only.

There is a hole in mlock_fixup() which increase mm->locked_vm twice even
the two operations are on the same vma and both with VM_LOCKED flags.

The issue can be reproduced by following code:

  mlock2(p, 1024 * 64, MLOCK_ONFAULT); //VM_LOCKED|VM_LOCKONFAULT
  mlock(p, 1024 * 64);  //VM_LOCKED

Then check the increase VmLck field in /proc/pid/status(to 128k).

When vma is set with different vm_flags, and the new vm_flags is with
VM_LOCKED, it is not necessarily be a "new locked" vma.  This patch
corrects this bug by prevent mm->locked_vm from increment when old
vm_flags is already VM_LOCKED.

Link: http://lkml.kernel.org/r/1472554781-9835-3-git-send-email-wei.guo.simon@gmail.com
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Alexey Klimov <klimov.linux@gmail.com>
Cc: Eric B Munson <emunson@akamai.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mlock.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -504,6 +504,7 @@ static int mlock_fixup(struct vm_area_st
 	int nr_pages;
 	int ret = 0;
 	int lock = !!(newflags & VM_LOCKED);
+	vm_flags_t old_flags = vma->vm_flags;
 
 	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm))
@@ -538,6 +539,8 @@ success:
 	nr_pages = (end - start) >> PAGE_SHIFT;
 	if (!lock)
 		nr_pages = -nr_pages;
+	else if (old_flags & VM_LOCKED)
+		nr_pages = 0;
 	mm->locked_vm += nr_pages;
 
 	/*


