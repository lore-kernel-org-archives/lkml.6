Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeBGIU1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:20:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750815AbeBGIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:20:25 -0500
Date: Wed, 7 Feb 2018 00:20:29 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <20180207050200.GH3617@linux.vnet.ibm.com>
 <20180207075409.GA5726@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207075409.GA5726@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020708-2213-0000-0000-00000268E743
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008489; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00986147; UDB=6.00500439; IPR=6.00765514;
 BA=6.00005816; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019419; XFM=3.00000015;
 UTC=2018-02-07 08:20:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020708-2214-0000-0000-000059076B38
Message-Id: <20180207082029.GJ3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:54:09PM -0800, Josh Triplett wrote:
> On Tue, Feb 06, 2018 at 09:02:00PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 06, 2018 at 08:23:34PM -0800, Matthew Wilcox wrote:
> > > On Tue, Feb 06, 2018 at 06:17:03PM -0800, Paul E. McKenney wrote:
> > > > So it is OK to kvmalloc() something and pass it to either kfree() or
> > > > kvfree(), and it had better be OK to kvmalloc() something and pass it
> > > > to kvfree().
> > > > 
> > > > Is it OK to kmalloc() something and pass it to kvfree()?
> > > 
> > > Yes, it absolutely is.
> > > 
> > > void kvfree(const void *addr)
> > > {
> > >         if (is_vmalloc_addr(addr))
> > >                 vfree(addr);
> > >         else
> > >                 kfree(addr);
> > > }
> > > 
> > > > If so, is it really useful to have two different names here, that is,
> > > > both kfree_rcu() and kvfree_rcu()?
> > > 
> > > I think it's handy to have all three of kvfree_rcu(), kfree_rcu() and
> > > vfree_rcu() available in the API for the symmetry of calling kmalloc()
> > > / kfree_rcu().
> > > 
> > > Personally, I would like us to rename kvfree() to just free(), and have
> > > malloc(x) be an alias to kvmalloc(x, GFP_KERNEL), but I haven't won that
> > > fight yet.
> > 
> > But why not just have the existing kfree_rcu() API cover both kmalloc()
> > and kvmalloc()?  Perhaps I am not in the right forums, but I am not hearing
> > anyone arguing that the RCU API has too few members.  ;-)
> 
> I don't have any problem with having just `kvfree_rcu`, but having just
> `kfree_rcu` seems confusingly asymmetric.

I don't understand why kmalloc()/kvfree_rcu() would seem any less
asymmetric than kvmalloc()/kfree_rcu().

> (Also, count me in favor of having just one "free" function, too.)

We agree on that much, anyway.  ;-)

							Thanx, Paul
