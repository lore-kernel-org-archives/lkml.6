Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D62C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97232081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97232081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeLIWS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:18:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35630 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72r-0002ie-9t; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003fu-VC; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Daniel Black" <daniel@linux.ibm.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Kenneth Penza" <kpenza@gmail.com>,
        "Konstantin Khlebnikov" <khlebnikov@openvz.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.434131563@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 303/328] mm: madvise(MADV_DODUMP): allow hugetlbfs pages
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/madvise.c | 2 +-
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

