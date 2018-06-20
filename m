Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B38AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D918C20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D918C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754707AbeFTT1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:27:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754577AbeFTT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:27:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KJPiut132200
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:27:04 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqv6ea3rc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:27:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 15:27:03 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 15:27:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KJR0KT8454638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 19:27:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108F9B2066;
        Wed, 20 Jun 2018 15:26:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6DB4B205F;
        Wed, 20 Jun 2018 15:26:47 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 15:26:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5977E16C4293; Wed, 20 Jun 2018 12:29:01 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:29:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: WARN_ON_ONCE() in process_one_work()?
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062019-0064-0000-0000-0000031E11CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009228; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049844; UDB=6.00537971; IPR=6.00828816;
 MB=3.00021763; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 19:27:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062019-0065-0000-0000-000039A8FC61
Message-Id: <20180620192901.GA9956@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=734 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have hit this WARN_ON_ONCE() in process_one_work:

	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
		     raw_smp_processor_id() != pool->cpu);

This looks like it is my rcu_gp workqueue (see splat below), and it
appears to be intermittent.  This happens on rcutorture scenario SRCU-N,
which does random CPU-hotplug operations (in case that helps).

Is this related to the recent addition of WQ_MEM_RECLAIM?  Either way,
what should I do to further debug this?

							Thanx, Paul

[  828.791694] WARNING: CPU: 2 PID: 3 at /home/paulmck/public_git/linux-rcu/kernel/workqueue.c:2069 process_one_work+0x49/0x3c0
[  828.794850] Modules linked in:
[  828.795748] CPU: 2 PID: 3 Comm: rcu_gp Not tainted 4.18.0-rc1+ #1
[  828.797436] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  828.800059] Workqueue:            (null) (rcu_gp)
[  828.801373] RIP: 0010:process_one_work+0x49/0x3c0
[  828.802690] Code: 00 00 00 00 4c 0f 44 e0 49 8b 44 24 08 44 8b a8 00 01 00 00 41 83 e5 20 f6 45 10 04 75 0e 65 8b 05 6c 99 79 68 3b 45 04 74 02 <0f> 0b 48 ba eb 83 b5 80 46 86 c8 61 48 0f af d6 48 c1 ea 3a 48 8b
[  828.807871] RSP: 0000:ffff8a3c400e7e70 EFLAGS: 00010002
[  828.809314] RAX: 0000000000000002 RBX: ffff88acdfc206e0 RCX: ffff88acdfc206e0
[  828.811307] RDX: ffff88acdfc206d8 RSI: ffff88acdfc197b8 RDI: ffff88acde80c6c0
[  828.813253] RBP: ffff88acdfc206c0 R08: 0000000000000000 R09: 0000000000000000
[  828.815239] R10: ffff8a3c400e7e48 R11: 0000000000000000 R12: ffff88acdfc24900
[  828.817073] R13: 0000000000000000 R14: ffff88acde80c6c0 R15: ffff88acde80c6e8
[  828.819071] FS:  0000000000000000(0000) GS:ffff88acdfd00000(0000) knlGS:0000000000000000
[  828.821361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  828.822971] CR2: 00000000000000b0 CR3: 000000001040a000 CR4: 00000000000006e0
[  828.824935] Call Trace:
[  828.825653]  rescuer_thread+0x201/0x320
[  828.826744]  kthread+0xf3/0x130
[  828.827618]  ? process_one_work+0x3c0/0x3c0
[  828.828758]  ? kthread_destroy_worker+0x40/0x40
[  828.830019]  ret_from_fork+0x35/0x40
[  828.831028] ---[ end trace 4197eb078bf0edac ]---

