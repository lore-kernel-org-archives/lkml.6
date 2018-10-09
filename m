Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE671C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749232077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749232077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:09:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbeJIQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:09:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w998njpw061782
        for <linux-kernel@vger.kernel.org>; Tue, 9 Oct 2018 04:53:34 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n0rmmseua-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:53:33 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 9 Oct 2018 09:53:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Oct 2018 09:53:27 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w998rQGR7864780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Oct 2018 08:53:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF761AE055;
        Tue,  9 Oct 2018 11:52:11 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD21AAE051;
        Tue,  9 Oct 2018 11:52:09 +0100 (BST)
Received: from skywalker (unknown [9.124.31.179])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  9 Oct 2018 11:52:09 +0100 (BST)
Received: (nullmailer pid 15387 invoked by uid 1000);
        Tue, 09 Oct 2018 08:53:23 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com
Subject: Re: general protection fault in __handle_mm_fault
In-Reply-To: <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
References: <0000000000009d47b2057782bab4@google.com> <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com> <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
Date:   Tue, 09 Oct 2018 14:23:23 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18100908-0020-0000-0000-000002D17442
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100908-0021-0000-0000-0000211FDDD5
Message-Id: <87va6bwlfg.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> On Mon, Oct 8, 2018 at 12:10 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> On Fri, Oct 5, 2018 at 6:27 PM syzbot
>> <syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com> wrote:
>> >
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    25bcda3e8b9f Add linux-next specific files for 20181004
>> > git tree:       linux-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=130e3bf1400000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=603d7f9140c3368a
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=1577fbe983d20fe2e88f
>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127e88d6400000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cdb67e400000
>>
>> > RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20
>> > arch/x86/lib/copy_user_64.S:180
>> > Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f
>> > 80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f
>> > 1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
>> > RSP: 0018:ffff8801bbe675b8 EFLAGS: 00010202
>> > RAX: 0000000000000000 RBX: 0000000000007a50 RCX: 0000000000001b40
>> > RDX: 0000000000007a50 RSI: 0000000020077000 RDI: ffff8801ce615f10
>> > RBP: ffff8801bbe675f0 R08: ffffed0039cc2f4a R09: ffffed0039cc2f4a
>> > R10: ffffed0039cc2f49 R11: ffff8801ce617a4f R12: 0000000020078b40
>> > R13: 00000000200710f0 R14: ffff8801ce610000 R15: 00007ffffffff000
>> >   _copy_from_iter_full+0x263/0xc20 lib/iov_iter.c:724
>> >   copy_from_iter_full include/linux/uio.h:124 [inline]
>> >   skb_do_copy_data_nocache include/net/sock.h:1951 [inline]
>> >   skb_copy_to_page_nocache include/net/sock.h:1977 [inline]
>> >   tcp_sendmsg_locked+0x159e/0x3f90 net/ipv4/tcp.c:1338
>>
>> This started on next-20181004. It still happens as of next-20181008.
>>
>> It does not trigger on next 20181003. It does not occur if
>> CONFIG_DEBUG_KOBJECT is disabled.
>
> Bisected to commit e4d0c281a4c9 ("mm/memory.c: recheck page table
> entry with page table lock held").
>
> Verified to not trigger on next-20181008 after reverting that commit.


Can you check with this patch

diff --git a/mm/memory.c b/mm/memory.c
index fa8894c70575..15c417e8e31d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3505,14 +3505,17 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
 	if (!vma->vm_ops->fault) {
-
 		/*
-		 * pmd entries won't be marked none during a R/M/W cycle.
+		 * If we find a migration pmd entry or a none pmd entry, which
+		 * should never happen, return SIGBUS
 		 */
-		if (unlikely(pmd_none(*vmf->pmd)))
+		if (unlikely(!pmd_present(*vmf->pmd)))
 			ret = VM_FAULT_SIGBUS;
 		else {
-			vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
+						       vmf->pmd,
+						       vmf->address,
+						       &vmf->ptl);
 			/*
 			 * Make sure this is not a temporary clearing of pte
 			 * by holding ptl and checking again. A R/M/W update
@@ -3520,12 +3523,12 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 			 * we don't have concurrent modification by hardware
 			 * followed by an update.
 			 */
-			spin_lock(vmf->ptl);
 			if (unlikely(pte_none(*vmf->pte)))
 				ret = VM_FAULT_SIGBUS;
 			else
 				ret = VM_FAULT_NOPAGE;
-			spin_unlock(vmf->ptl);
+
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
 		}
 	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);

