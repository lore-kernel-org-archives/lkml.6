Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF11D21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF11D21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbeHNUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:33:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728642AbeHNUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:32:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EHiW6R113357
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:44:47 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv1db6dff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:44:47 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 14 Aug 2018 13:44:46 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 13:44:43 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EHigC78585736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 17:44:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08D89B2068;
        Tue, 14 Aug 2018 13:43:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0A3B2064;
        Tue, 14 Aug 2018 13:43:57 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 13:43:57 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1CF5916C2EBE; Tue, 14 Aug 2018 10:44:43 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:44:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180814162448.GA20414@linux.vnet.ibm.com>
 <20180814124945.5cf1753f@gandalf.local.home>
 <20180814170618.GA24813@linux.vnet.ibm.com>
 <20180814132453.093a4921@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814132453.093a4921@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18081417-0052-0000-0000-0000031EF0C5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073483; UDB=6.00553122; IPR=6.00853441;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 17:44:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081417-0053-0000-0000-00005DB997C2
Message-Id: <20180814174443.GG24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:24:53PM -0400, Steven Rostedt wrote:
> On Tue, 14 Aug 2018 10:06:18 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> 
> > > >  #define __SRCU_STRUCT_INIT(name, pcpu_name)				\
> > > > -	{								\
> > > > -		.sda = &pcpu_name,					\
> > > > -		.lock = __SPIN_LOCK_UNLOCKED(name.lock),		\
> > > > -		.srcu_gp_seq_needed = 0 - 1,				\
> > > > -		__SRCU_DEP_MAP_INIT(name)				\
> > > > -	}
> > > > +{									\
> > > > +	.sda = &pcpu_name,						\
> > > > +	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
> > > > +	.srcu_gp_seq_needed = 0 - 1,					\  
> > > 
> > > Interesting initialization of -1. This was there before, but still
> > > interesting none the less.  
> > 
> > If I recall correctly, this subterfuge suppresses compiler complaints
> > about initializing an unsigned long with a negative number.  :-/
> 
> Did you try:
> 
> 	.srcu_gp_seq_needed = -1UL,
> 
> ?

Works for my compiler, not sure what set of complaints pushed me in that
direction.

							Thanx, Paul

