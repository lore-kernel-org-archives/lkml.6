Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBHEJG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 23:09:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750806AbeBHEJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 23:09:05 -0500
Date: Wed, 7 Feb 2018 20:09:10 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>, josh@joshtriplett.org,
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
 <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
 <20180207083104.GK3617@linux.vnet.ibm.com>
 <20180207085700.393f90d0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207085700.393f90d0@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020804-0056-0000-0000-000004178450
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008494; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000249; SDB=6.00986543; UDB=6.00500676; IPR=6.00765907;
 BA=6.00005819; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019434; XFM=3.00000015;
 UTC=2018-02-08 04:09:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020804-0057-0000-0000-0000084EF46C
Message-Id: <20180208040910.GP3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 08:57:00AM -0500, Steven Rostedt wrote:
> On Wed, 7 Feb 2018 00:31:04 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > I see problems.  We would then have two different names for exactly the
> > same thing.
> > 
> > Seems like it would be a lot easier to simply document the existing
> > kfree_rcu() behavior, especially given that it apparently already works.
> > The really doesn't seem to me to be worth a name change.
> 
> Honestly, I don't believe this is an RCU sub-system decision. This is a
> memory management decision.

I couldn't agree more!

To that end, what are your thoughts on this patch?

https://lkml.kernel.org/r/1513895570-28640-1-git-send-email-rao.shoaib@oracle.com

Advantages include the ability to optimize based on sl[aou]b state,
getting rid of the 4K offset hack in __is_kfree_rcu_offset(), better
cache localite, and, as you say, putting the naming responsibility
in the memory-management domain.

> If we have kmalloc(), vmalloc(), kfree(), vfree() and kvfree(), and we
> want kmalloc() to be freed with kfree(), and vmalloc() to be freed with
> vfree(), and for strange reasons, we don't know how the data was
> allocated we have kvfree(). That's an mm decision not an rcu one. We
> should have kfree_rcu(), vfree_rcu() and kvfree_rcu(), and honestly,
> they should not depend on kvfree() doing the same thing for everything.
> Each should call the corresponding member that they represent. Which
> would change this patch set.
> 
> Why? Too much coupling between RCU and MM. What if in the future
> something changes and kvfree() goes away or changes drastically. We
> would then have to go through all the users of RCU to change them too.
> 
> To me kvfree() is a special case and should not be used by RCU as a
> generic function. That would make RCU and MM much more coupled than
> necessary.

And that is one reason I am viewing the name-change patch with great
suspicion, especially given that there seems to be some controversy
among the memory-management folks as to exactly what the names should be.

							Thanx, Paul
