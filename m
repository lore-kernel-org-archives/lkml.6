Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935806AbeEXWhH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:37:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755191AbeEXWhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:37:06 -0400
Date: Thu, 24 May 2018 15:38:39 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] rcu: Speed up calling of RCU tasks callbacks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-2-joel@joelfernandes.org>
 <20180523155734.GK3803@linux.vnet.ibm.com>
 <20180523124531.7b0e972a@gandalf.local.home>
 <20180523170303.GR3803@linux.vnet.ibm.com>
 <20180523151337.469bba34@gandalf.local.home>
 <20180523200458.GD3803@linux.vnet.ibm.com>
 <20180524174752.0928d562@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524174752.0928d562@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052422-0056-0000-0000-00000454A45E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 22:37:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052422-0057-0000-0000-00000898C1D6
Message-Id: <20180524223839.GU3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 05:47:52PM -0400, Steven Rostedt wrote:
> On Wed, 23 May 2018 13:04:58 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Looks plausible to me!
> > 
> 
> BTW looking at the code:
> 
> > 		/* Invoke the callbacks. */
> > 		while (list) {
> > 			next = list->next;
> > 			local_bh_disable();
> > 			list->func(list);
> > 			local_bh_enable();
> > 			list = next;
> > 			cond_resched();
> > 		}
> > 		schedule_timeout_uninterruptible(HZ/10);
> 
> What's the purpose of this final sleep?

To avoid any possibility of rcu_tasks_kthread() getting into a tight loop.

							Thanx, Paul
