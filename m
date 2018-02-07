Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeBGCRA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 21:17:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752859AbeBGCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 21:16:59 -0500
Date: Tue, 6 Feb 2018 18:17:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020702-0056-0000-0000-00000416B8A7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008488; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00986026; UDB=6.00500366; IPR=6.00765393;
 BA=6.00005813; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019412; XFM=3.00000015;
 UTC=2018-02-07 02:16:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020702-0057-0000-0000-0000084E27CE
Message-Id: <20180207021703.GC3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 01:19:29PM +0300, Kirill Tkhai wrote:
> Recent times kvmalloc() begun widely be used in kernel.
> Some of such memory allocations have to be freed after
> rcu grace period, and this patchset introduces a generic
> primitive for doing this.
> 
> Actually, everything is made in [1/2]. Patch [2/2] is just
> added to make new kvfree_rcu() have the first user.
> 
> The patch [1/2] transforms kfree_rcu(), its sub definitions
> and its sub functions into kvfree_rcu() form. The most
> significant change is in __rcu_reclaim(), where kvfree()
> is used instead of kfree(). Since kvfree() is able to
> have a deal with memory allocated via kmalloc(), vmalloc()
> and kvmalloc(); kfree_rcu() and vfree_rcu() may simply
> be defined through this new kvfree_rcu().

Interesting.

So it is OK to kvmalloc() something and pass it to either kfree() or
kvfree(), and it had better be OK to kvmalloc() something and pass it
to kvfree().

Is it OK to kmalloc() something and pass it to kvfree()?

If so, is it really useful to have two different names here, that is,
both kfree_rcu() and kvfree_rcu()?

Also adding Jesper and Rao on CC for their awareness.

							Thanx, Paul

> ---
> 
> Kirill Tkhai (2):
>       rcu: Transform kfree_rcu() into kvfree_rcu()
>       mm: Use kvfree_rcu() in update_memcg_params()
> 
> 
>  include/linux/rcupdate.h   |   31 +++++++++++++++++--------------
>  include/linux/rcutiny.h    |    4 ++--
>  include/linux/rcutree.h    |    2 +-
>  include/trace/events/rcu.h |   12 ++++++------
>  kernel/rcu/rcu.h           |    8 ++++----
>  kernel/rcu/tree.c          |   14 +++++++-------
>  kernel/rcu/tree_plugin.h   |   10 +++++-----
>  mm/slab_common.c           |   10 +---------
>  8 files changed, 43 insertions(+), 48 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
