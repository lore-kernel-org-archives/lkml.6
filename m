Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48206C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DB02172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DB02172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeHUIRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:17:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbeHUIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:17:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7L4re6m046037
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 00:58:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m09pm4mqa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 00:58:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 21 Aug 2018 05:58:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 05:58:39 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7L4wcmj37879822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 04:58:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D829B42045;
        Tue, 21 Aug 2018 07:58:40 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4ABA4203F;
        Tue, 21 Aug 2018 07:58:39 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 21 Aug 2018 07:58:39 +0100 (BST)
Date:   Mon, 20 Aug 2018 21:58:36 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kobject: Access kobject name with caution if state is
 not initialized
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1534784987-16107-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180820192247.GA20101@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180820192247.GA20101@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082104-4275-0000-0000-000002AC7F8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082104-4276-0000-0000-000037B5B3B7
Message-Id: <20180821045836.GA33230@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [2018-08-20 21:22:47]:

> On Mon, Aug 20, 2018 at 10:39:47PM +0530, Srikar Dronamraju wrote:
> > A stupid module test like
> > https://github.com/srikard/tests/blob/master/modules/kobject_test.c
> > can panic the system.
> 
> Lots of stupid modules can do dumb things.  Just don't do that.  The
> kernel is not built to keep you from doing stupid things in kernel code
> :)
> 

Completely agree. kernel/module code is not for doing stupid things.
However we seem to be hitting this once in a while in a weird case with
a slightly older kernel with no out of tree modules.

crash> bt
PID: 54813  TASK: c000000c4c76c160  CPU: 40  COMMAND: "lvm"
 #0 [c00000004ac0eb50] crash_kexec at c0000000001a1be4
 #1 [c00000004ac0eb80] die at c000000000025668
 #2 [c00000004ac0ec20] bad_page_fault at c00000000005d7a0
 #3 [c00000004ac0ec90] handle_page_fault at c000000000009608
 Data Access [300] exception frame:
 R0:  c000000000521cb4    R1:  c00000004ac0ef80    R2:  c000000001274800   
 R3:  0000000200000000    R4:  ffffffffffffffff    R5:  0000000200000000   
 R6:  0000000000000000    R7:  ffffffffffffffff    R8:  ffffffffffffffff   
 R9:  0000000000000004    R10: c000000000521c90    R11: c000000001434800   
 R12: c0000000000e3750    R13: c000000007b16800    R14: 00003fff85970520   
 R15: 00003fffd442c6c0    R16: 0000000000000000    R17: 000000000000005c   
 R18: 00003fff859797c8    R19: 00003fff859a28f0    R20: 00000100333c2400   
 R21: 00000100333c23d0    R22: 0000000000000025    R23: c00000000143a648   
 R24: 00000000000003e0    R25: 0000000000000020    R26: c00000004ac0f140   
 R27: 0000000000000000    R28: 0000000200000000    R29: ffffffffffffffff   
 R30: c00000000143aa28    R31: c00000000143a654   
 NIP: c00000000051bda8    MSR: 8000000100009033    OR3: c0000000000093ec
 CTR: c000000000521c90    LR:  c00000000051e7b8    XER: 0000000000000000
 CCR: 0000000088048444    MQ:  0000000000000000    DAR: 0000000200000000
 DSISR: 0000000040000000     Syscall Result: 0000000000000000
 #4 [c00000004ac0ef80] strnlen at c00000000051bda8
 [Link Register] [c00000004ac0ef80] string at c00000000051e7b8
 #5 [c00000004ac0efd0] vsnprintf at c000000000521cb4
 #6 [c00000004ac0f050] vscnprintf at c0000000005226e0
 #7 [c00000004ac0f080] vprintk_default at c0000000000e381c
 #8 [c00000004ac0f0f0] printk at c000000000a2047c
 #9 [c00000004ac0f110] kobject_put at c000000000510c34
#10 [c00000004ac0f1a0] of_node_put at c000000000813034
#11 [c00000004ac0f1c0] pci_release_of_node at c0000000005ae724
#12 [c00000004ac0f1f0] pci_release_dev at c00000000056ff60
#13 [c00000004ac0f220] device_release at c00000000065a468
#14 [c00000004ac0f2a0] kobject_put at c000000000510abc
#15 [c00000004ac0f330] put_device at c00000000065aaf4
#16 [c00000004ac0f350] scsi_host_dev_release at c0000000006a2f10
#17 [c00000004ac0f390] device_release at c00000000065a468
#18 [c00000004ac0f410] kobject_put at c000000000510abc
#19 [c00000004ac0f4a0] put_device at c00000000065aaf4
#20 [c00000004ac0f4c0] scsi_target_dev_release at c0000000006b2bb4
#21 [c00000004ac0f4f0] device_release at c00000000065a468
#22 [c00000004ac0f570] kobject_put at c000000000510abc
#23 [c00000004ac0f600] put_device at c00000000065aaf4
#24 [c00000004ac0f620] scsi_device_dev_release_usercontext at c0000000006b8790
#25 [c00000004ac0f670] execute_in_process_context at c0000000001185b4
#26 [c00000004ac0f6a0] scsi_device_dev_release at c0000000006b8644
#27 [c00000004ac0f6c0] device_release at c00000000065a468
#28 [c00000004ac0f740] kobject_put at c000000000510abc
#29 [c00000004ac0f7d0] put_device at c00000000065aaf4
#30 [c00000004ac0f7f0] scsi_device_put at c00000000069ff98
#31 [c00000004ac0f820] sd_release at d000000008013f4c [sd_mod]
#32 [c00000004ac0f8a0] __blkdev_put at c0000000003a7318
#33 [c00000004ac0f900] dm_put_table_device at d000000006ed09fc [dm_mod]
#34 [c00000004ac0f940] dm_put_device at d000000006ed663c [dm_mod]
#35 [c00000004ac0f9b0] linear_dtr at d000000006eda2d4 [dm_mod]
#36 [c00000004ac0f9e0] dm_table_destroy at d000000006ed7380 [dm_mod]
#37 [c00000004ac0fa70] dev_suspend at d000000006edf114 [dm_mod]
#38 [c00000004ac0faf0] ctl_ioctl at d000000006edc2e0 [dm_mod]
#39 [c00000004ac0fcf0] dm_ctl_ioctl at d000000006edc548 [dm_mod]
#40 [c00000004ac0fd10] do_vfs_ioctl at c00000000035a9a8
#41 [c00000004ac0fdd0] sys_ioctl at c00000000035aea4
#42 [c00000004ac0fe30] system_call at c00000000000a284
 System Call [c00] exception frame:
 R0:  0000000000000036    R1:  00003fffd442c4b0    R2:  00003fff858a7400   
 R3:  0000000000000006    R4:  00000000c138fd06    R5:  00000100333c23d0   
 R6:  0000000000000004    R7:  00003fff8597a2f0    R8:  0000000000000006   
 R9:  0000000000000000    R10: 0000000000000000    R11: 0000000000000000   
 R12: 0000000000000000    R13: 00003fff85b42ff0    R14: 00003fff85970520   
 R15: 00003fffd442c6c0    R16: 0000000000000000    R17: 000000000000005c   
 R18: 00003fff859797c8    R19: 00003fff859a28f0    R20: 00000100333c2400   
 R21: 00000100333c23d0    R22: 00003fff859a40e8    R23: 00003fff85970520   
 R24: 00003fff85970520    R25: 00003fff85970520    R26: 0000000000000007   
 R27: 00000100333c2480    R28: 00003fff85970520    R29: 0000000106da8290   
 R30: 00003fff85970520    R31: 00000100333bdb00   
 NIP: 00003fff857d9ecc    MSR: 800000010000d033    OR3: 0000000000000006
 CTR: 0000000000000000    LR:  00003fff8596dc08    XER: 0000000000000000
 CCR: 0000000044022444    MQ:  0000000000000001    DAR: 0000010033dae5d0
 DSISR: 0000000042000000     Syscall Result: 0000000000000004


Since this happens once in a bluemoon, there is no point in trying with
a newer/later kernel.

> So I fail to see why this patch is needed.  What in-kernel code path is
> trying to print a kobject's name before it is initialized?  Why not fix
> that obvious bug instead of forcing the kernel core to protect from
> stupid code?

By the time it has crashed, we don't have a clue on who created the
kobject, which thread tried to delete the object.

To see if two threads were racing, I looked at stack traces from other
threads but no other thread is in kobject_* calls. So there is a genuine
bug in a genuine module/kernel. The point that kobject state in
uninitialized itself means that the call was unexpected. So the question
now is should we detect and abort gracefully or should we allow it to
panic. By aborting, we are not masking the problem.

-- 
Thanks and Regards
Srikar

