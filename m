Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8FFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E11921A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E11921A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbeHFTtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:49:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732388AbeHFTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:49:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76HYXeu067103
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 13:39:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kprpynsw3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:39:32 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 6 Aug 2018 13:39:31 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 13:39:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76HdS3g7143794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 17:39:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 758B8B2068;
        Mon,  6 Aug 2018 13:38:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 621A6B2067;
        Mon,  6 Aug 2018 13:38:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Aug 2018 13:38:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1470016CA7E9; Mon,  6 Aug 2018 10:39:30 -0700 (PDT)
Date:   Mon, 6 Aug 2018 10:39:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: FYI, critical bug in rcutorture
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18080617-0064-0000-0000-000003361FA0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009496; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070389; UDB=6.00550845; IPR=6.00849614;
 MB=3.00022541; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-06 17:39:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080617-0065-0000-0000-00003A35802E
Message-Id: <20180806173930.GA29642@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=772 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David,

So I have updated rcutorture to include need_resched()-protected calls to
cond_resched() in a tight loop that includes an RCU read-side critical
section on each pass.  This loop runs for five seconds by default and
complains bitterly if grace periods did not complete during that time.

But my over-the-weekend rcutorture run completed 30 hours on each of 16
RCU scenario without any errors whatsoever, not even forward-progress
failures (see below).  Since I know that there have to be bugs somewhere
in RCU, this result represents a critical bug against rcutorture.
Fortunately, I do have a list of things to improve rcutorture.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

 --- Fri Aug  3 15:53:08 PDT 2018 Test summary:
Results directory: /home/paulmck/public_git/linux-rcu/tools/testing/selftests/rcutorture/res/2018.08.03-15:53:08
tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 43 --duration 1800
SRCU-N ------- 15203951 GPs (140.777/s) [srcu: g195826884 f0x0 ]
SRCU-P ------- 7528468 GPs (69.708/s) [srcud: g87633528 f0x0 ]
SRCU-t ------- 21870375 GPs (202.503/s) [srcu: g1 f0x0 ]
SRCU-u ------- 21374470 GPs (197.912/s) [srcud: g1 f0x0 ]
TASKS01 ------- 395438 GPs (3.66146/s) [tasks: g0 f0x0 ]
TASKS02 ------- 412989 GPs (3.82397/s) [tasks: g0 f0x0 ]
TASKS03 ------- 421585 GPs (3.90356/s) [tasks: g0 f0x0 ]
TINY01 ------- 12811682 GPs (118.627/s) [rcu: g0 f0x0 ]
TINY02 ------- 11254299 GPs (104.206/s) [rcu: g0 f0x0 ]
TREE01 ------- 2090954 GPs (19.3607/s) [rcu: g38972161 f0x0 ]
TREE02 ------- 3073826 GPs (28.4614/s) [rcu: g64778613 f0x0 ]
TREE03 ------- 3511639 GPs (32.5152/s) [rcu: g64357389 f0x2 ]
TREE04 ------- 1106148 GPs (10.2421/s) [rcu: g44600225 f0x0 ]
TREE05 ------- 3999197 GPs (37.0296/s) [rcu: g65814873 f0x0 ]
TREE07 ------- 624753 GPs (5.78475/s) [rcu: g44894817 f0x0 ]
TREE09 ------- 9566891 GPs (88.5823/s) [rcu: g420697921 f0x0 ]

