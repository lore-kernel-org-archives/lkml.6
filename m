Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FF3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D179248FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D179248FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeFVVYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:24:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754134AbeFVVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:24:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MLNlG0073314
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:24:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js4ef9h9p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:24:19 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 17:24:18 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 17:24:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MLODKu14156082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 21:24:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E257B2064;
        Fri, 22 Jun 2018 17:24:12 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27D66B205F;
        Fri, 22 Jun 2018 17:24:12 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 17:24:12 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EA02516C3BD3; Fri, 22 Jun 2018 14:26:15 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:26:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, dave@stgolabs.net
Cc:     linux-kernel@vger.kernel.org
Subject: Proposed changes to -rcu workflow
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062221-0052-0000-0000-00000302D9BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009242; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050844; UDB=6.00538571; IPR=6.00829813;
 MB=3.00021811; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 21:24:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062221-0053-0000-0000-00005D1B6ED1
Message-Id: <20180622212615.GA9735@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am proposing changes to how I set up my -rcu tree:

	The -rcu tree also takes LKMM patches, and I have been handling
	these completely separately, with one branch for RCU and another
	for LKMM. But this can be a bit inconvenient, and more important,
	can delay my response to patches to (say) LKMM if I am doing (say)
	extended in-tree RCU testing. So it is time to try something a
	bit different.

	My current thought is continue to have separate LKMM and RCU
	branches (or more often, sets of branches) containing the commits
	to be offered up to the next merge window. The -rcu branch lkmm
	would flag the LKMM branch (or, more often, merge commit) and
	a new -rcu branch rcu would flag the RCU branch (or, again more
	often, merge commit). Then the lkmm and rcu merge commits would
	be merged, with new commits on top. These new commits would be
	intermixed RCU and LKMM commits.

	The tip of the -rcu development effort (both LKMM and RCU)
	would be flagged with a new dev branch, with the old rcu/dev
	branch being retired. The rcu/next branch will continue to mark
	the commit to be pulled into the -next tree, and will point to
	the merge of the rcu and lkmm branches during the merge window.

	I will create the next-merge-window branches sometime around
	-rc1 or -rc2, as I have in the past. I will send RFC patches to
	LKML shortly thereafter. I will send a pull request for the rcu
	branch around -rc5, and will send final patches from the lkmm
	branch at about that same time.

Thoughts?

							Thanx, Paul

