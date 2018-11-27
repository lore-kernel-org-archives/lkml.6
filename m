Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21AF2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21AF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeK0TI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:08:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbeK0TI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:08:28 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAR84FR7102474
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:11:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p10ghm874-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:11:23 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 27 Nov 2018 08:11:21 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 08:11:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAR8BHs660162296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 08:11:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EB114C04E;
        Tue, 27 Nov 2018 08:11:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FE734C040;
        Tue, 27 Nov 2018 08:11:17 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Nov 2018 08:11:17 +0000 (GMT)
Date:   Tue, 27 Nov 2018 09:11:15 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18112708-0016-0000-0000-0000022D3DCD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112708-0017-0000-0000-000032859514
Message-Id: <20181127081115.GB3625@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with the glibc self-tests I was able to trigger the "this should not
happen" warning ;) below on s390 (with panic_on_warn=1 set). It looks
like it is hardly reproducible.

This one happened with commit d146194f31c9 for compiling the kernel.
Config can be re-created with "make ARCH=s390 performance_defconfig".

[  649.596938] WARNING: CPU: 0 PID: 58886 at kernel/futex.c:1418 do_futex+0xa9a/0xc50
[  649.596946] Kernel panic - not syncing: panic_on_warn set ...
[  649.596951] CPU: 0 PID: 58886 Comm: ld64.so.1 Not tainted 4.20.0-20181125.rc3.git0.d146194f31c9.300.fc29.s390x+git #1
[  649.596953] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
[  649.596956] Call Trace:
[  649.596963] ([<0000000000113050>] show_stack+0x58/0x70)
[  649.596970]  [<0000000000a62a92>] dump_stack+0x7a/0xa8
[  649.596975]  [<0000000000144012>] panic+0x11a/0x258
[  649.596978]  [<0000000000143e70>] __warn+0xf8/0x118
[  649.596981]  [<0000000000a61c20>] report_bug+0xd8/0x150
[  649.596985]  [<00000000001014ac>] do_report_trap+0xc4/0xe0
[  649.596988]  [<0000000000101680>] illegal_op+0x138/0x150
[  649.596994]  [<0000000000a82bec>] pgm_check_handler+0x1cc/0x220
[  649.596998]  [<00000000001e89b2>] do_futex+0xa9a/0xc50
[  649.597002] ([<00000000001e8b16>] do_futex+0xbfe/0xc50)
[  649.597006]  [<00000000001e8c4c>] sys_futex+0xe4/0x170
[  649.597010]  [<0000000000a82800>] system_call+0xdc/0x2c8

Thanks,
Heiko

