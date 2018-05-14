Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeENKaV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751487AbeENKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:30:20 -0400
Date: Mon, 14 May 2018 12:30:13 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Andre Wild <wild@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] 051f3ca02e46 "Introduce NUMA identity node sched
 domain" breaks fake NUMA on s390
References: <20180512100233.GB3738@osiris>
 <20180514093909.GO12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20180514093909.GO12217@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
x-cbid: 18051410-0044-0000-0000-0000055242CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051410-0045-0000-0000-00002893A093
Message-Id: <20180514103013.GA3603@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:39:09AM +0200, Peter Zijlstra wrote:
> On Sat, May 12, 2018 at 12:02:33PM +0200, Heiko Carstens wrote:
> > Hello,
> > 
> > Andre Wild reported that fake NUMA doesn't work on s390 anymore. Doesn't
> > work means it crashed for Andre, or it is in an endless loop within
> > init_sched_groups_capacity() for me (sg != sd->groups is always true).
> > 
> > I could reproduce this with a very simple setup with only two nodes, where
> > each node has only one CPU. This allowed me to bisect it down to commit
> > 051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain").
> > 
> > With that commit reverted the system comes up again and the scheduling
> > domains look like this:
> > 
> > [    0.148592] smp: Bringing up secondary CPUs ...
> > [    0.148984] smp: Brought up 2 nodes, 2 CPUs
> > [    0.149097] CPU0 attaching sched-domain(s):
> > [    0.149099]  domain-0: span=0-1 level=NUMA
> > [    0.149101]   groups: 0:{ span=0 }, 1:{ span=1 }
> > [    0.149106] CPU1 attaching sched-domain(s):
> > [    0.149107]  domain-0: span=0-1 level=NUMA
> > [    0.149108]   groups: 1:{ span=1 }, 0:{ span=0 }
> > [    0.149111] span: 0-1 (max cpu_capacity = 1024)
> > 
> > Any idea what's going wrong?
> 
> Not yet; still trying to decipher your fake nume implementation.
> 
> But meanwhile; could you provide me with:
> 
> $ cat /sys/devices/system/node/node*/distance
> $ cat /sys/devices/system/node/node*/cpulist

Yes, of course:

$ cat /sys/devices/system/node/node0/distance
0 10
$ cat /sys/devices/system/node/node1/distance
10 0

$ cat /sys/devices/system/node/node0/cpulist
0
$ cat /sys/devices/system/node/node1/cpulist
1
