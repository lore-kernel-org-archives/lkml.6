Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeBGIbB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:31:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753491AbeBGIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:31:00 -0500
Date: Wed, 7 Feb 2018 00:31:04 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Matthew Wilcox <willy@infradead.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, mingo@redhat.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, brouer@redhat.com, rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <20180207050200.GH3617@linux.vnet.ibm.com>
 <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020708-2213-0000-0000-00000268E81F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008489; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00986151; UDB=6.00500441; IPR=6.00765517;
 BA=6.00005816; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019419; XFM=3.00000015;
 UTC=2018-02-07 08:30:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020708-2214-0000-0000-0000590770AE
Message-Id: <20180207083104.GK3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:57:28AM +0300, Kirill Tkhai wrote:
> On 07.02.2018 08:02, Paul E. McKenney wrote:
> > On Tue, Feb 06, 2018 at 08:23:34PM -0800, Matthew Wilcox wrote:
> >> On Tue, Feb 06, 2018 at 06:17:03PM -0800, Paul E. McKenney wrote:
> >>> So it is OK to kvmalloc() something and pass it to either kfree() or
> >>> kvfree(), and it had better be OK to kvmalloc() something and pass it
> >>> to kvfree().
> >>>
> >>> Is it OK to kmalloc() something and pass it to kvfree()?
> >>
> >> Yes, it absolutely is.
> >>
> >> void kvfree(const void *addr)
> >> {
> >>         if (is_vmalloc_addr(addr))
> >>                 vfree(addr);
> >>         else
> >>                 kfree(addr);
> >> }
> >>
> >>> If so, is it really useful to have two different names here, that is,
> >>> both kfree_rcu() and kvfree_rcu()?
> >>
> >> I think it's handy to have all three of kvfree_rcu(), kfree_rcu() and
> >> vfree_rcu() available in the API for the symmetry of calling kmalloc()
> >> / kfree_rcu().
> >>
> >> Personally, I would like us to rename kvfree() to just free(), and have
> >> malloc(x) be an alias to kvmalloc(x, GFP_KERNEL), but I haven't won that
> >> fight yet.
> > 
> > But why not just have the existing kfree_rcu() API cover both kmalloc()
> > and kvmalloc()?  Perhaps I am not in the right forums, but I am not hearing
> > anyone arguing that the RCU API has too few members.  ;-)
> 
> People, far from RCU internals, consider kfree_rcu() like an extension
> of kfree(). And it's not clear it's need to dive into kfree_rcu() comments,
> when someone is looking a primitive to free vmalloc'ed memory.

Seems like a relatively simple lesson to teach.

> Also, construction like
> 
> obj = kvmalloc();
> kfree_rcu(obj);
> 
> makes me think it's legitimately to use plain kfree() as pair bracket to kvmalloc().

So it all works as is, then.

> So the significant change of kfree_rcu() behavior will complicate stable backporters
> life, because they will need to keep in mind such differences between different
> kernel versions.

If I understood your construction above, that significant change in
kfree_rcu() behavior has already happened.

> It seems if we are going to use the single primitive for both kmalloc()
> and kvmalloc() memory, it has to have another name. But I don't see problems
> with having both kfree_rcu() and kvfree_rcu().

I see problems.  We would then have two different names for exactly the
same thing.

Seems like it would be a lot easier to simply document the existing
kfree_rcu() behavior, especially given that it apparently already works.
The really doesn't seem to me to be worth a name change.

							Thanx, Paul
