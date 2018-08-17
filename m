Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB1C21A28
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB1C21A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeHQTfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:35:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61717 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727037AbeHQTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:35:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HGU359077587
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 12:31:47 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kx133t88b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 12:31:47 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 17 Aug 2018 12:31:46 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 12:31:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HGVhOW4456938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 16:31:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3075B2065;
        Fri, 17 Aug 2018 12:30:55 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9461FB205F;
        Fri, 17 Aug 2018 12:30:55 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 17 Aug 2018 12:30:55 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA4CA16C0FD2; Fri, 17 Aug 2018 09:31:43 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:31:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180814162448.GA20414@linux.vnet.ibm.com>
 <20180814124945.5cf1753f@gandalf.local.home>
 <20180814170618.GA24813@linux.vnet.ibm.com>
 <20180817160842.GK3978217@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817160842.GK3978217@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18081716-0052-0000-0000-00000320E113
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074895; UDB=6.00553970; IPR=6.00854853;
 MB=3.00022776; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 16:31:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081716-0053-0000-0000-00005DC25C75
Message-Id: <20180817163143.GX24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=826 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 09:08:42AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 14, 2018 at 10:06:18AM -0700, Paul E. McKenney wrote:
> > > Is there a way we could make a union, or reuse one of the other fields,
> > > as we know that synchronize_srcu() can't be used yet (and if it is,
> > > either warn, or just make it a nop). And when we call srcu_init() and
> > > remove the srcu_struct from the list, we can then initialize whatever
> > > we used as the temporary boot up list field.
> > 
> > I will take a look.  If nothing else, I could union it with the
> > struct work_struct, since it cannot be used that early anyway.  ;-)
> > 
> > Or I could just use the work_struct that is already inside the struct
> > work_struct.  Tejun, would you be OK with that?
> 
> Hmm... not super against it given how specialized the whole thing is
> but maybe just making it a union is cleaner?

The problem with making it be a union is that I cannnot determine how
to initialize it due to the possibility that someone will initialize it
early, but not use it until much later.  For example, if I initialize my
side of the union, but they don't actually use it until after rcu_init()
is invoked, I will end up passing a bogus work_struct to you.

In theory, I could straighten all this out at rcu_init() time, but that
would require linking all srcu_struct instances initialized at that
point, including the compile-time-initialized instances.  This can of
course be done, but not simply.

Or am I missing a trick here somewhere?

							Thanx, Paul

