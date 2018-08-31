Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1374CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F4D20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F4D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeHaEOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:14:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbeHaEOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:14:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7V09WVR055462
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 20:09:57 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6q877e6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 20:09:57 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 20:09:56 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 20:09:51 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7V09o0G22610036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Aug 2018 00:09:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCEBFB2066;
        Thu, 30 Aug 2018 20:08:44 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC0E1B2064;
        Thu, 30 Aug 2018 20:08:44 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 20:08:44 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5176616C064F; Thu, 30 Aug 2018 17:09:52 -0700 (PDT)
Date:   Thu, 30 Aug 2018 17:09:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH tip/core/rcu 3/3] srcu: Make early-boot call_srcu() reuse
 workqueue lists
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829215616.1c10e476@vmware.local.home>
 <20180830020701.GE4225@linux.vnet.ibm.com>
 <20180829224609.5ffdc9ec@vmware.local.home>
 <20180830032315.GG4225@linux.vnet.ibm.com>
 <20180830124444.6bb9faac@gandalf.local.home>
 <20180830173509.GL4225@linux.vnet.ibm.com>
 <20180830173742.GA17677@linux.vnet.ibm.com>
 <20180830143617.2fb85e23@gandalf.local.home>
 <20180830231211.GW4225@linux.vnet.ibm.com>
 <20180830195322.18ece5df@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830195322.18ece5df@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18083100-0052-0000-0000-00000328E603
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009641; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081254; UDB=6.00557804; IPR=6.00861238;
 MB=3.00023023; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-31 00:09:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083100-0053-0000-0000-00005DE92C9B
Message-Id: <20180831000952.GZ4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808310000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 07:53:22PM -0400, Steven Rostedt wrote:
> On Thu, 30 Aug 2018 16:12:11 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> 
> > > > -	WARN_ON_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INIT);  
> > > 
> > > Well it boots without warning ;-)
> > > 
> > > Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> > 
> > Thank you again!  I applied this to 1/3 and 3/3 on the assumption that
> > you did not run rcutorture.  ;-)
> 
> No rcutorture. Just reverted the tracepoint SRCU delay patch and it
> boots with the trace event enabled.

Very good, then I did get it right.  1/3 and 3/3, but not 2/3.

							Thanx, Paul

