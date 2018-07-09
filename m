Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF7D2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF7D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeGIWqh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:46:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933025AbeGIWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:46:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69MhbPl088530
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 18:46:34 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4ehr85wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 18:46:34 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jul 2018 18:46:32 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 18:46:30 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69MkTfP45744338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 22:46:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D78DB205F;
        Mon,  9 Jul 2018 18:46:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0749B2067;
        Mon,  9 Jul 2018 18:46:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 18:46:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DD32F16C2F11; Mon,  9 Jul 2018 15:48:47 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:48:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Daniel Colascione <dancol@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, fengc <fengc@google.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com>
 <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <566257859.2699.1531172134285.JavaMail.zimbra@efficios.com>
 <20180709221903.GK3593@linux.vnet.ibm.com>
 <20180709221954.zo4626ggufija4g2@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709221954.zo4626ggufija4g2@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070922-0060-0000-0000-00000289B9F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009341; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059021; UDB=6.00543480; IPR=6.00836941;
 MB=3.00022077; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 22:46:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070922-0061-0000-0000-000045BD82AA
Message-Id: <20180709224847.GN3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:19:55PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 09, 2018 at 03:19:03PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 09, 2018 at 05:35:34PM -0400, Mathieu Desnoyers wrote:
> > > 
> > > 
> > > ----- On Jul 9, 2018, at 5:09 PM, Alexei Starovoitov alexei.starovoitov@gmail.com wrote:
> > > 
> > > > On Sun, Jul 08, 2018 at 04:54:38PM -0400, Mathieu Desnoyers wrote:
> > > >> ----- On Jul 7, 2018, at 4:33 PM, Joel Fernandes joelaf@google.com wrote:
> > > >> 
> > > >> > On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
> > > >> >> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
> > > >> >> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
> > > >> >> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
> > > >> >> > RCU data structure operations with respect to active programs. For
> > > >> >> > example, userspace can update a map->map entry to point to a new map,
> > > >> >> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> > > >> >> > complete, and then drain the old map without fear that BPF programs
> > > >> >> > may still be updating it.
> > > >> >> > 
> > > >> >> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > >> >> > ---
> > > >> >> >  include/uapi/linux/bpf.h |  1 +
> > > >> >> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
> > > >> >> >  2 files changed, 15 insertions(+)
> > > >> >> > 
> > > >> >> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > >> >> > index b7db3261c62d..4365c50e8055 100644
> > > >> >> > --- a/include/uapi/linux/bpf.h
> > > >> >> > +++ b/include/uapi/linux/bpf.h
> > > >> >> > @@ -98,6 +98,7 @@ enum bpf_cmd {
> > > >> >> >  	BPF_BTF_LOAD,
> > > >> >> >  	BPF_BTF_GET_FD_BY_ID,
> > > >> >> >  	BPF_TASK_FD_QUERY,
> > > >> >> > +	BPF_SYNCHRONIZE,
> > > >> >> >  };
> > > >> >> >  
> > > >> >> >  enum bpf_map_type {
> > > >> >> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > >> >> > index d10ecd78105f..60ec7811846e 100644
> > > >> >> > --- a/kernel/bpf/syscall.c
> > > >> >> > +++ b/kernel/bpf/syscall.c
> > > >> >> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *,
> > > >> >> > uattr, unsigned int, siz
> > > >> >> >  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> > > >> >> >  		return -EPERM;
> > > >> >> >  
> > > >> >> > +	if (cmd == BPF_SYNCHRONIZE) {
> > > >> >> > +		if (uattr != NULL || size != 0)
> > > >> >> > +			return -EINVAL;
> > > >> >> > +		err = security_bpf(cmd, NULL, 0);
> > > >> >> > +		if (err < 0)
> > > >> >> > +			return err;
> > > >> >> > +		/* BPF programs are run with preempt disabled, so
> > > >> >> > +		 * synchronize_sched is sufficient even with
> > > >> >> > +		 * RCU_PREEMPT.
> > > >> >> > +		 */
> > > >> >> > +		synchronize_sched();
> > > >> >> > +		return 0;
> > > >> >> 
> > > >> >> I don't think it's necessary. sys_membarrier() can do this already
> > > >> >> and some folks use it exactly for this use case.
> > > >> > 
> > > >> > Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
> > > >> > though. No where does the manpage say membarrier should be implemented this
> > > >> > way so what happens if the implementation changes?
> > > >> > 
> > > >> > Further, membarrier manpage says that a memory barrier should be matched with
> > > >> > a matching barrier. In this use case there is no matching barrier, so it
> > > >> > makes it weirder.
> > > >> > 
> > > >> > Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
> > > >> > fragile to depend on it for this?
> > > >> > 
> > > >> >        case MEMBARRIER_CMD_GLOBAL:
> > > >> >                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
> > > >> >                if (tick_nohz_full_enabled())
> > > >> >                        return -EINVAL;
> > > >> >                if (num_online_cpus() > 1)
> > > >> >                        synchronize_sched();
> > > >> >                return 0;
> > > >> > 
> > > >> > 
> > > >> > Adding Mathieu as well who I believe is author/maintainer of membarrier.
> > > >> 
> > > >> See commit 907565337
> > > >> "Fix: Disable sys_membarrier when nohz_full is enabled"
> > > >> 
> > > >> "Userspace applications should be allowed to expect the membarrier system
> > > >> call with MEMBARRIER_CMD_SHARED command to issue memory barriers on
> > > >> nohz_full CPUs, but synchronize_sched() does not take those into
> > > >> account."
> > > >> 
> > > >> So AFAIU you'd want to re-use membarrier to issue synchronize_sched, and you
> > > >> only care about kernel preempt off critical sections.
> > > >> 
> > > >> Clearly bpf code does not run in user-space, so it would "work".
> > > >> 
> > > >> But the guarantees provided by membarrier are not to synchronize against
> > > >> preempt off per se. It's just that the current implementation happens to
> > > >> do that. The point of membarrier is to turn user-space memory barriers
> > > >> into compiler barriers.
> > > >> 
> > > >> If what you need is to wait for a RCU grace period for whatever RCU flavor
> > > >> ebpf is using, I would against using membarrier for this. I would rather
> > > >> recommend adding a dedicated BPF_SYNCHRONIZE so you won't leak
> > > >> implementation details to user-space, *and* you can eventually change you
> > > >> RCU implementation for e.g. SRCU in the future if needed.
> > > > 
> > > > The point about future changes to underlying bpf mechanisms is valid.
> > > > There is work already on the way to reduce the scope of preempt_off+rcu_lock
> > > > that currently lasts the whole prog. We will have new prog types that won't
> > > > have such wrappers and will do rcu_lock/unlock and preempt on/off only
> > > > when necessary.
> > > > So something like BPF_SYNCHRONIZE will break soon, since the kernel cannot have
> > > > guarantees on when programs finish. Calling this command BPF_SYNCHRONIZE_PROG
> > > > also won't make sense for the same reason.
> > > > What we can do it instead is to define synchronization barrier for
> > > > programs accessing maps. May be call it something like:
> > > > BPF_SYNC_MAP_ACCESS ?
> > > > uapi/bpf.h would need to have extensive comment what this barrier is doing.
> > > > Implementation should probably call synchronize_rcu() and not play games
> > > > with synchronize_sched(), since that's going too much into implementation.
> > > > Also should such sys_bpf command be root only?
> > > > I'm not sure whether dos attack can be made by spamming synchronize_rcu()
> > > > and synchronize_sched() for that matter.
> > > 
> > > Adding Paul E. McKenney in CC. He may want to share his thoughts on the matter.
> > 
> > Let's see...
> > 
> > Spamming synchronize_rcu() and synchronize_sched() should be a non-event,
> > at least aside from the CPUs doing the spamming.  The reason for this
> > is that a given task can only fire off a single synchronize_sched or
> > synchronize_rcu() per few milliseconds, so you need a -lot- of tasks
> > to have much effect, at which point the sheer number of tasks is much
> > more a problem than the large number of outstanding synchronize_rcu()
> > or synchronize_sched() invocations.
> > 
> > I very strongly agree that usermode should have a operation that
> > synchronizes with whatever eBPF uses, rather than something that forces
> > a specific type of RCU grace period.
> > 
> > Finally, in a few releases, synchronize_sched() will be retiring in favor
> > of synchronize_rcu(), which will wait on preemption-disabled regions of
> > code in addition to waiting on RCU read-side critical sections.  Not a
> > big deal, as I expect to enlist Coccinelle's aid in this.
> > 
> > Did I manage to hit all the high points?
> 
> Thanks. It's ok for new cmd being unpriv then.

Yes.  After all, users can cause RCU far more pain by doing close(open())
in a tight loop.  ;-)

							Thanx, Paul

