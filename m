Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeESC1x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 22:27:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751117AbeESC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 22:27:49 -0400
Date: Fri, 18 May 2018 19:29:18 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: rostedt@goodmis.org, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051902-2213-0000-0000-000002A83448
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009050; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01034362; UDB=6.00528968; IPR=6.00813490;
 MB=3.00021194; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-19 02:27:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051902-2214-0000-0000-00005A2BE355
Message-Id: <20180519022918.GV3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805190025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:36:23AM -0700, Joel Fernandes wrote:
> Hi,
> 
> I was thinking about tasks-RCU and why its needed. Since preempt-RCU allows
> tasks to be preempted in read-sections, can we not just reuse that mechanism
> for the trampolines since we track all preempted tasks so we would wait on
> all tasks preempted within a trampoline?
> 
> I am trying to understand what will _not_ work if we did that.. I'm guessing
> the answer is that that would mean the trampoline has to be wrapped with
> rcu_read_{lock,unlock} which may add some overhead, but please let me know
> if I'm missing something else..
> 
> The advantage I guess is possible elimination of an RCU variant, and also
> possibly eliminating the tasks RCU thread that monitors.. Anyway I was
> thinking more in terms of the effort of reduction of the RCU flavors etc and
> reducing complexity ideas.

The problem is that if they are preempted while executing in a trampoline,
RCU-preempt doesn't queue them nor does it wait on them.

And the problem with wrapping them with rcu_read_{lock,unlock} is that
there would be a point before the trampoline executed rcu_read_lock()
but while it was on the trampoline.  Nothing good comes from this.  ;-)

							Thanx, Paul
