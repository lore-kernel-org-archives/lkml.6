Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeENNYR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:24:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752296AbeENNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:24:16 -0400
Date: Mon, 14 May 2018 06:25:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, rostedt@goodmis.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, stefani@seibold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Is read barrier missed in kfifo?
Reply-To: paulmck@linux.vnet.ibm.com
References: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
 <20180511083242.GJ12217@hirez.programming.kicks-ass.net>
 <20180511162053.GY26088@linux.vnet.ibm.com>
 <20180514065755.GM12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514065755.GM12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051413-0052-0000-0000-000002EE3FB7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009024; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032180; UDB=6.00527662; IPR=6.00811312;
 MB=3.00021105; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 13:24:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051413-0053-0000-0000-00005CADF361
Message-Id: <20180514132541.GS26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 08:57:55AM +0200, Peter Zijlstra wrote:
> On Fri, May 11, 2018 at 09:20:53AM -0700, Paul E. McKenney wrote:
> > On Fri, May 11, 2018 at 10:32:42AM +0200, Peter Zijlstra wrote:
> > > On Fri, May 11, 2018 at 03:25:18PM +0800, Xiao Guangrong wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > Currently, there is no read barrier between reading the index
> > > > (kfifo.in) and fetching the real data from the fifo.
> > > > 
> > > > I am afraid that will cause the vfifo is observed as not empty
> > > > however the data is not actually ready for read. Right?
> > > 
> > > That code is decidedly dodgy indeed. I can only see smp_wmb() but no
> > > matching barriers at all -- therefore the code is almost certainly as
> > > good as not having any barriers at all.
> > > 
> > > I would suggest you try and convert the code to smp_store_release() and
> > > smp_load_acquire() while you're at it.
> > 
> > Isn't this one of the places where we rely on control dependencies?
> 
> Then it bloody well should have a comment. But at least one side of the
> fifo needs a read barrier I think. We can rely on a ctrl-dep on the
> write side, where we read the head/tail values, compute space and then
> conditionally allow writes to happen.
> 
> But on the read side it's all reads and ctrl-dep doesn't help anything.

Agreed, for a control depdendency to help, there does need to be a
control dependency.  ;-)

							Thanx, Paul
