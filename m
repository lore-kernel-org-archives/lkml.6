Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeENNhX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:37:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753027AbeENNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:37:22 -0400
Date: Mon, 14 May 2018 06:38:49 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
 <20180514125725.uobtf2nf4corisea@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514125725.uobtf2nf4corisea@linux-x5ow.site>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051413-0008-0000-0000-000003073C45
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009024; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032185; UDB=6.00527665; IPR=6.00811316;
 MB=3.00021105; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 13:37:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051413-0009-0000-0000-0000393EC80B
Message-Id: <20180514133849.GV26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 02:57:25PM +0200, Johannes Thumshirn wrote:
> On Mon, May 14, 2018 at 05:42:30AM -0700, Christoph Hellwig wrote:
> > >  extern unsigned int nvme_io_timeout;
> > >  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> > > @@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > >  {
> > >  	struct nvme_ns_head *head = ns->head;
> > >  
> > > -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> > > +	if (head &&
> > > +	    ns == rcu_dereference_protected(head->current_path,
> > > +				lockdep_is_held(&ns->ctrl->subsys->lock)))
> > >  		rcu_assign_pointer(head->current_path, NULL);
> > >  }
> > >  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
> > 
> > We don't really dereference it at all in fact, but just check the
> > pointers for equality.  I wonder if there is a better way to do this,
> > as my ANA patches add a caller without the lock (and withou SRU
> > protection either now that I think of it) - for a pure pointer compare
> > we really should not need any sort of protection.
> 
> Uff maybe, but are you sure a comparison of two pointer is always
> atomic (on all architectures)?
> 
> Paul, can you shed some light on us mere mortal, whether the above
> rcu_dereference_protected() is needed or if a simple ns ==
> head->current_path is sufficient.

One approach is the following:

static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
{
	struct nvme_ns_head *head = ns->head;
 
	if (head && ns == rcu_access_pointer(head->current_path))
		rcu_assign_pointer(head->current_path, NULL);
}

Without the rcu_access_pointer(), sparse (and thus the 0-day test robot)
will complain that you are accessing an RCU-protected pointer without
using RCU.  However, rcu_access_pointer() won't ever give any lockdep
splats about there being no RCU read-side critical section.

You might still want rcu_dereference_protected() because it will yell
at you if the lock is not held.  Yes, the comparison will still be valid
without the lock (at least at the exact moment when the load occurred),
but the rcu_assign_pointer() might be a bit problematic if that lock is
not held, right?

But it is your guys' code, so I must defer to you for the intent.

							Thanx, Paul
