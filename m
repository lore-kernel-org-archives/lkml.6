Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E91D20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfBUPwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:52:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbfBUPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:52:30 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LFnCT3109618
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:52:28 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qsxt30pwd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:52:28 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Feb 2019 15:52:28 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 15:52:20 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LFqJOx21627134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:52:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20695B2068;
        Thu, 21 Feb 2019 15:52:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E64EB2065;
        Thu, 21 Feb 2019 15:52:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.207.192])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 15:52:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9BF7616C63FE; Thu, 21 Feb 2019 07:52:18 -0800 (PST)
Date:   Thu, 21 Feb 2019 07:52:18 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221153117.GT32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022115-0064-0000-0000-000003ACA6B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010638; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01164314; UDB=6.00608005; IPR=6.00944899;
 MB=3.00025682; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-21 15:52:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022115-0065-0000-0000-00003C7D12FB
Message-Id: <20190221155218.GZ11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:31:17PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 10:21:39AM -0500, Joel Fernandes wrote:
> > On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > > > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> > > >  	if (WARN_ON(!data || !func))
> > > >  		return;
> > > >  
> > > > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > > > +	rcu_read_lock();
> > > > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > > > +		rcu_read_unlock();
> > > >  		return;
> > > > +	}
> > > > +	rcu_read_unlock();
> > > >  
> > > >  	data->func = func;
> > > >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> > > 
> > > This doesn't make any kind of sense to me.
> > > 
> > 
> > As per the rcu_assign_pointer() line, I inferred that
> > cpufreq_update_util_data is expected to be RCU protected. Reading the pointer
> > value of RCU pointers generally needs to be done from RCU read section, and
> > using rcu_dereference() (or using rcu_access()).
> > 
> > In this patch, I changed cpufreq_update_util_data to be __rcu annotated to
> > avoid the sparse error thrown by rcu_assign_pointer().
> > 
> > Instead of doing that, If your intention here is RELEASE barrier, should I
> > just replace in this function:
> > 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> > with:
> > 	smp_store_release(per_cpu(cpufreq_update_util_data, cpu), data))
> > ?
> > 
> > It would be nice IMO to be explicit about the intention of release/publish
> > semantics by using smp_store_release().
> 
> No, it is RCU managed, it should be RCU. The problem is that the hunk
> above is utter crap.
> 
> All that does is read the pointer, it never actually dereferences it.

For whatever it is worth, in that case it could use rcu_access_pointer().
And this primitive does not do the lockdep check for being within an RCU
read-side critical section.  As Peter says, if there is no dereferencing,
there can be no use-after-free bug, so the RCU read-side critical is
not needed.

Good eyes, Peter!  ;-)

							Thanx, Paul

