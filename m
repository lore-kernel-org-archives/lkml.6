Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeBGDQZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 22:16:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752688AbeBGDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:16:24 -0500
Date: Tue, 6 Feb 2018 19:16:29 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: Can RCU stall lead to hard lockups?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180109035207.GD3668920@devbig577.frc2.facebook.com>
 <20180109042425.GS9671@linux.vnet.ibm.com>
 <20180109141114.GF3668920@devbig577.frc2.facebook.com>
 <20180109152234.GU9671@linux.vnet.ibm.com>
 <20180202234430.GA25611@mail.hallyn.com>
 <20180203205032.GN3617@linux.vnet.ibm.com>
 <20180207023303.GA10583@mail.hallyn.com>
 <20180207025337.GD3617@linux.vnet.ibm.com>
 <20180207025504.GA10892@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207025504.GA10892@mail.hallyn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020703-0024-0000-0000-0000031FCF55
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008488; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00986046; UDB=6.00500377; IPR=6.00765413;
 BA=6.00005813; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019413; XFM=3.00000015;
 UTC=2018-02-07 03:16:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020703-0025-0000-0000-000046E5CD09
Message-Id: <20180207031629.GF3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 08:55:04PM -0600, Serge E. Hallyn wrote:
> On Tue, Feb 06, 2018 at 06:53:37PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 06, 2018 at 08:33:03PM -0600, Serge E. Hallyn wrote:
> > > On Sat, Feb 03, 2018 at 12:50:32PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 02, 2018 at 05:44:30PM -0600, Serge E. Hallyn wrote:
> > > > > Quoting Paul E. McKenney (paulmck@linux.vnet.ibm.com):
> > > > > > On Tue, Jan 09, 2018 at 06:11:14AM -0800, Tejun Heo wrote:
> > > > > > > Hello, Paul.
> > > > > > > 
> > > > > > > On Mon, Jan 08, 2018 at 08:24:25PM -0800, Paul E. McKenney wrote:
> > > > > > > > > I don't know the RCU code at all but it *looks* like the first CPU is
> > > > > > > > > taking a sweet while flushing printk buffer while holding a lock (the
> > > > > > > > > console is IPMI serial console, which faithfully emulates 115200 baud
> > > > > > > > > rate), and everyone else seems stuck waiting for that spinlock in
> > > > > > > > > rcu_check_callbacks().
> > > > > > > > > 
> > > > > > > > > Does this sound possible?
> > > > > > > > 
> > > > > > > > 115200 baud?  Ouch!!!  That -will- result in trouble from console
> > > > > > > > printing, and often also in RCU CPU stall warnings.
> > > > > > > 
> > > > > > > It could even be slower than 115200, and we occassionally see RCU
> > > > > > > stall warnings caused by printk storms, for example, while the kernel
> > > > > > > is trying to dump a lot of info after an OOM.  That's an issue we
> > > > > > > probably want to improve from printk side; however, they don't usually
> > > > > > > lead to NMI hard lockup detector kicking in and crashing the machine,
> > > > > > > which is the peculiarity here.
> > > > > > > 
> > > > > > > Hmmm... show_state_filter(), the function which dumps all task
> > > > > > > backtraces, share a similar problem and it avoids it by explicitly
> > > > > > > calling touch_nmi_watchdog().  Maybe we can do something like the
> > > > > > > following from RCU too?
> > > > > > 
> > > > > > If this fixes things for you, I would welcome such a patch.
> > > > > 
> > > > > Hi - would this also be relevant to 4.9-stable and 4.4-stable, or
> > > > > has something elsewhere changed after 4.9 that actually triggers this?
> > > > 
> > > > As far as I can tell, slow console lines have been prone to RCU CPU stall
> > > > warnings for a very long time.
> > > 
> > > Ok, thanks Paul.
> > > 
> > > Tejun were you going to push this?
> > 
> > I have it queued for the next merge window.  3eea9623926f ("rcu: Call
> > touch_nmi_watchdog() while printing stall warnings") in -rcu.
> 
> D'oh - thanks!

Not a problem at all!  Had I lost this commit, it would not have been the
first time.  ;-)

							Thanx, Paul
