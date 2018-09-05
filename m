Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1348C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5F0206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5F0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeIETXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:23:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbeIETXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:23:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85EnTRC114410
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 10:53:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mag85kwnp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 10:53:20 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 10:53:19 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 10:53:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85ErDBB43057314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 14:53:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A04E6B2066;
        Wed,  5 Sep 2018 10:52:00 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80E84B205F;
        Wed,  5 Sep 2018 10:52:00 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 10:52:00 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BF20316C2DF5; Wed,  5 Sep 2018 07:53:12 -0700 (PDT)
Date:   Wed, 5 Sep 2018 07:53:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090514-0072-0000-0000-0000039D9805
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083931; UDB=6.00559417; IPR=6.00863931;
 MB=3.00023126; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 14:53:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090514-0073-0000-0000-000049517735
Message-Id: <20180905145312.GI4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:33:08PM +0900, Akira Yokosawa wrote:
> On 2018/09/05 09:21:51 +0200, Andrea Parri wrote:
> > On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
> >> On Tue, 4 Sep 2018, Andrea Parri wrote:
> >>> Heh, your confusion might be the reflection of mine... ;-)  That was
> >>> indeed a long and not conclusive discussion (meaning there're pending
> >>> issues); and I cannot claim to find "arguments" such as:
> >>>
> >>>   "More than one kernel developer has expressed the opinion that
> >>>    the LKMM should enforce ordering of writes by locking."
> >>>
> >>> particularly helpful (I do tend to be convinced by arguments rather
> >>> than by opinions).  In fact, you can take the following as my only
> >>> current "constructive argument" against the patch [1,2]:
> >>>
> >>>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
> >>>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
> >>
> >> Do you have any concrete suggestions (i.e., some actual text) for 
> >> improvements to the patch description?  Earlier in your message you 
> >> mentioned that Will's comment:
> >>
> >> 	LKMM offers stronger guarantees that can portably be relied upon
> >> 	in the codebase.
> >>
> >> would make a good addition.  Suitably edited, it could be added to the
> >> description.  I can think of a few other things myself, but I'd like to 
> >> hear your thoughts.  Anything else?
> > 
> > Yes: I do sometimes have the impression that your "rules" for trimming
> > text in emails/replies are too aggressive...
> 
> Andrea, by saying "Yes:", do you mean you have something else to be added?
> I don't think you do, but want to make sure.
> 
> I'm a bit surprised to see all you wanted was the amendment of the
> commit log...

My guess is that Andrea would prefer that locking acquire/release and
load-store-RMW acquire/release to have the same ordering rules (which
Will has argued against), and that Andrea's "Yes" above is expressing
irritation that some point he wished to reiterate was trimmed somewhere
in the exchange.  And yes, both the act of replying to emails and
of establishing multi-architecture ordering rules can be a bit messy
at times.

Andrea's patch had no Signed-off-by and does not apply to the -rcu tree's
dev branch, so I am guessing that he was thinking in terms of replacing
some subset of the patches that are currently queued, presumably including
Alan's patch that Will reviewed and Peter acked.  (I don't yet have a
new lkmm branch because I need to sort out a few of the commits first.)

If replacement is the intent, the people Andrea needs to convince include
Alan, Peter, and Will.

							Thanx, Paul

