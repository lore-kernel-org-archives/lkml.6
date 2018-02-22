Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeBVXzQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:55:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751283AbeBVXzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:55:15 -0500
Date: Thu, 22 Feb 2018 15:55:32 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
 <20180207174513.5cc9b503@redhat.com>
 <20180207181055.GB12446@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207181055.GB12446@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022223-0056-0000-0000-00000422A8CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008579; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993655; UDB=6.00504921; IPR=6.00772995;
 MB=3.00019696; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 23:55:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022223-0057-0000-0000-00000864AF76
Message-Id: <20180222235532.GA11181@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220296
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:10:55AM -0800, Matthew Wilcox wrote:
> On Wed, Feb 07, 2018 at 05:45:13PM +0100, Jesper Dangaard Brouer wrote:
> > On Wed, 7 Feb 2018 08:57:00 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > To me kvfree() is a special case and should not be used by RCU as a
> > > generic function. That would make RCU and MM much more coupled than
> > > necessary.
> > 
> > For the record, I fully agree with Steve here. 
> > 
> > And being a performance "fanatic" I don't like to have the extra branch
> > (and compares) in the free code path... but it's a MM-decision (and
> > sometimes you should not listen to "fanatics" ;-))
> 
> While free_rcu() is not withut its performance requirements, I think it's
> currently dominated by cache misses and not by branches.  By the time RCU
> gets to run callbacks, memory is certainly L1/L2 cache-cold and probably
> L3 cache-cold.  Also calling the callback functions is utterly impossible
> for the branch predictor.

This seems to have fallen by the wayside.

To get things going again, I suggest starting out by simply replacing
the kfree() in __rcu_reclaim() with kvfree().  If desired, a kvfree_rcu()
can also be defined as a synonym for kfree_rcu().

This gets us a very simple and small patch which provides the ability
to dispose of kvmalloc() memory after a grace period.

								Thanx, Paul
