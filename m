Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB136C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A218B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVWeHqXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A218B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeJKXHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F7B21470;
        Thu, 11 Oct 2018 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272364;
        bh=JlTHsjzQyQ3mxFVl+WuCKq9Sg8wTKFIC1BkBPYQIkso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVWeHqXVOorc8NSyjJ+6uENBZeZrbrbWrtQbj1kv+Xl1osGSYI6BsaorbCEyqUWo3
         rZmB0MBbAyrGv62Lo3qbPoQs3H0aPJubXaWu6WZFGwLmcb7oae0arJEgLDV1Afelyh
         3wxB9NeK1uj8S732+YpPfYaMvR64pC/i8niqOfUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kenneth Penza <kpenza@gmail.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3.18 083/120] mm: madvise(MADV_DODUMP): allow hugetlbfs pages
Date:   Thu, 11 Oct 2018 17:34:24 +0200
Message-Id: <20181011152553.222996309@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
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

From: Daniel Black <daniel@linux.ibm.com>

commit d41aa5252394c065d1f04d1ceea885b70d00c9c6 upstream.

Reproducer, assuming 2M of hugetlbfs available:

Hugetlbfs mounted, size=2M and option user=testuser

  # mount | grep ^hugetlbfs
  hugetlbfs on /dev/hugepages type hugetlbfs (rw,pagesize=2M,user=dan)
  # sysctl vm.nr_hugepages=1
  vm.nr_hugepages = 1
  # grep Huge /proc/meminfo
  AnonHugePages:         0 kB
  ShmemHugePages:        0 kB
  HugePages_Total:       1
  HugePages_Free:        1
  HugePages_Rsvd:        0
  HugePages_Surp:        0
  Hugepagesize:       2048 kB
  Hugetlb:            2048 kB

Code:

  #include <sys/mman.h>
  #include <stddef.h>
  #define SIZE 2*1024*1024
  int main()
  {
    void *ptr;
    ptr = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_HUGETLB | MAP_ANONYMOUS, -1, 0);
    madvise(ptr, SIZE, MADV_DONTDUMP);
    madvise(ptr, SIZE, MADV_DODUMP);
  }

Compile and strace:

  mmap(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_HUGETLB, -1, 0) = 0x7ff7c9200000
  madvise(0x7ff7c9200000, 2097152, MADV_DONTDUMP) = 0
  madvise(0x7ff7c9200000, 2097152, MADV_DODUMP) = -1 EINVAL (Invalid argument)

hugetlbfs pages have VM_DONTEXPAND in the VmFlags driver pages based on
author testing with analysis from Florian Weimer[1].

The inclusion of VM_DONTEXPAND into the VM_SPECIAL defination was a
consequence of the large useage of VM_DONTEXPAND in device drivers.

A consequence of [2] is that VM_DONTEXPAND marked pages are unable to be
marked DODUMP.

A user could quite legitimately madvise(MADV_DONTDUMP) their hugetlbfs
memory for a while and later request that madvise(MADV_DODUMP) on the same
memory.  We correct this omission by allowing madvice(MADV_DODUMP) on
hugetlbfs pages.

[1] https://stackoverflow.com/questions/52548260/madvisedodump-on-the-same-ptr-size-as-a-successful-madvisedontdump-fails-wit
[2] commit 0103bd16fb90 ("mm: prepare VM_DONTDUMP for using in drivers")

Link: http://lkml.kernel.org/r/20180930054629.29150-1-daniel@linux.ibm.com
Link: https://lists.launchpad.net/maria-discuss/msg05245.html
Fixes: 0103bd16fb90 ("mm: prepare VM_DONTDUMP for using in drivers")
Reported-by: Kenneth Penza <kpenza@gmail.com>
Signed-off-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/madvise.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -75,7 +75,7 @@ static long madvise_behavior(struct vm_a
 		new_flags |= VM_DONTDUMP;
 		break;
 	case MADV_DODUMP:
-		if (new_flags & VM_SPECIAL) {
+		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
 			error = -EINVAL;
 			goto out;
 		}


