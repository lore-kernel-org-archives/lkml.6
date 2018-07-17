Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1C7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817BA20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817BA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeGQRmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:42:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729708AbeGQRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:42:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HH6Tpx073094
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:08:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9m16hd0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:08:23 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 13:08:22 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 13:08:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HH8Hm44129528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 17:08:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2689B2064;
        Tue, 17 Jul 2018 13:08:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 836C0B206B;
        Tue, 17 Jul 2018 13:08:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 13:08:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3832B16C86E3; Tue, 17 Jul 2018 10:10:42 -0700 (PDT)
Date:   Tue, 17 Jul 2018 10:10:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH RFC tools/memory-model] Model effects of volatile on ctrl
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071717-0072-0000-0000-000003820BEC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009380; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062177; UDB=6.00545336; IPR=6.00840035;
 MB=3.00022173; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 17:08:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071717-0073-0000-0000-000048C034BF
Message-Id: <20180717171042.GA2299@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=1
 clxscore=1015 lowpriorityscore=0 mlxscore=1 impostorscore=0
 mlxlogscore=200 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit models the fact that compilers are not allowed to reorder
volatile accesses.  This modeling is at best approximate, although it
does correctly handle C-RomanPenyaev-list-rcu-rr.litmus from the litmus
github archive.  The approach is to extend control dependencies to
subsequent volatiles accesses.

Probable issues with this change:

1.	It does not correctly handle the case of identical WRITE_ONCE()
	invocations at the beginning of both legs of an "if" statement.
	(Of course, the current state does not correctly handle this
	either.)
    
2.	It might not correctly handle the ARMv8 conditional-move instruction.
    
3.	It is probably missing some handling of atomic RWM operations.
    
4.	It does not insist that the initial ctrl dependency end in
	a volatile access.  This is not yet a problem because we
	don't yet model unmarked accesses.

That said, this patch is not intended for inclusion, but rather in the
hope that it inspires someone to come up with something better.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 882fc33274ac..f745337ba10e 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -57,7 +57,9 @@ empty rmw & (fre ; coe) as atomic
 
 (* Preserved Program Order *)
 let dep = addr | data
-let rwdep = (dep | ctrl) ; [W]
+let volatile = [Once] | [Release] | [Acquire] (* No unmarked accesses. *)
+let ctrl-volatile = ctrl ; (po ; volatile)*
+let rwdep = (dep | ctrl-volatile) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
 let to-r = addr | (dep ; rfi)

