Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF08CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF72080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfBUR37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:29:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726311AbfBUR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:29:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LHOgKQ069402
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 12:29:57 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qsxqbdpm2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 12:29:57 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Feb 2019 17:29:56 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 17:29:49 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LHTmO924641626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 17:29:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6237B205F;
        Thu, 21 Feb 2019 17:29:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45749B2064;
        Thu, 21 Feb 2019 17:29:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.207.192])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 17:29:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 56BC416C3B5F; Thu, 21 Feb 2019 09:29:48 -0800 (PST)
Date:   Thu, 21 Feb 2019 09:29:48 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 3/5] sched/cpufreq: Fix incorrect RCU API usage
Reply-To: paulmck@linux.ibm.com
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
 <20190221091805.GX32477@hirez.programming.kicks-ass.net>
 <20190221152139.GB19213@google.com>
 <20190221153117.GT32494@hirez.programming.kicks-ass.net>
 <20190221155218.GZ11787@linux.ibm.com>
 <20190221161144.GU32494@hirez.programming.kicks-ass.net>
 <20190221171311.GA118415@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221171311.GA118415@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022117-0064-0000-0000-000003ACB109
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010638; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164346; UDB=6.00608024; IPR=6.00944932;
 MB=3.00025682; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-21 17:29:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022117-0065-0000-0000-00003C7D45F3
Message-Id: <20190221172948.GA11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:13:11PM -0500, Joel Fernandes wrote:
> On Thu, Feb 21, 2019 at 05:11:44PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 21, 2019 at 07:52:18AM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 21, 2019 at 04:31:17PM +0100, Peter Zijlstra wrote:
> > > > On Thu, Feb 21, 2019 at 10:21:39AM -0500, Joel Fernandes wrote:
> > > > > On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> > > > > > On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > > > > > > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> > > > > > >  	if (WARN_ON(!data || !func))
> > > > > > >  		return;
> > > > > > >  
> > > > > > > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > > > > > > +	rcu_read_lock();
> > > > > > > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > > > > > > +		rcu_read_unlock();
> > > > > > >  		return;
> > > > > > > +	}
> > > > > > > +	rcu_read_unlock();
> > > > > > >  
> > > > > > >  	data->func = func;
> > > > > > >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> > 
> > > For whatever it is worth, in that case it could use rcu_access_pointer().
> > > And this primitive does not do the lockdep check for being within an RCU
> > > read-side critical section.  As Peter says, if there is no dereferencing,
> > > there can be no use-after-free bug, so the RCU read-side critical is
> > > not needed.
> > 
> > On top of that, I suspect this is under the write-side lock (we're doing
> > assignment after all).
> 
> Yes it is under a policy->rwsem, just confirmed that.
> 
> And indeed rcu_read_lock() is not needed here in this patch, thanks for
> pointing that out. Sometimes the word "dereference" plays some visual tricks
> and in this case tempted me to add an RCU reader section ;-) Assuming you
> guys are in agreement with usage of rcu_access_pointer() here to keep sparse
> happy, I'll rework the patch accordingly and resubmit with that.

Works for me!

							Thanx, Paul

