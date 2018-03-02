Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163260AbeCBBAY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 20:00:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1163173AbeCBBAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:00:23 -0500
Date: Thu, 1 Mar 2018 17:00:48 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Clean up rcu_init_nohz() by removing unnecessary
 statements
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519808695-28097-1-git-send-email-byungchul.park@lge.com>
 <20180228184106.GN3777@linux.vnet.ibm.com>
 <166b5b47-8b6f-4b35-df4c-b42b47a173da@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166b5b47-8b6f-4b35-df4c-b42b47a173da@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030201-0008-0000-0000-000002DE07AE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008609; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00997031; UDB=6.00506927; IPR=6.00776349;
 MB=3.00019807; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-02 01:00:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030201-0009-0000-0000-0000386E4DB6
Message-Id: <20180302010048.GM3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803020008
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 09:01:19AM +0900, Byungchul Park wrote:
> On 3/1/2018 3:41 AM, Paul E. McKenney wrote:
> >On Wed, Feb 28, 2018 at 06:04:55PM +0900, Byungchul Park wrote:
> >>Since the commit 44c65ff2e3b0(rcu: Eliminate NOCBs CPU-state Kconfig
> >>options) made nocb-cpus identified only through the rcu_nocbs= boot
> >>parameter, we don't have to care NOCBs CPU-state Kconfig options
> >>anymore, which means now we can just rely on rcu_nocb_mask to
> >>decide whether going ahead in rcu_init_nohz().
> >>
> >>Remove the deprecated code.
> >>
> >>Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >
> >Good catch!  However, you missed a (relatively harmless) bug in my commit
> >44c65ff2e3b0, namely that if neither the nohz_full= nor the rcu_nocbs=
> >kernel boot parameters specify any CPUs, we don't need to allocate
> >rcu_nocb_mask.  (That is, when both of those parameters are omitted.)
> >
> >Now, if the rcu_nocbs= kernel boot parameter was specified, we know that
> >rcu_nocb_mask was already allocated in rcu_nocb_setup().  So in
> >rcu_init_nohz() we only need to do the allocation if NO_HZ_FULL needs
> >some NOCBs CPUs, that is, when tick_nohz_full_running and when there
> >is at least one CPU specified in tick_nohz_full_mask.
> 
> Why didn't I catch it in advance? :)

I guess that sentiment goes well with my "why didn't I avoid that bug
in the first place?"  ;-)

> >So the change that is actually needed is to reverse the initialization
> >of need_rcu_nocb_mask, that is, to initialize it to false rather than
> >to true.  I annotated your patch with my reasoning and have a patch
> >below with your Reported-by.  Please take a look and let me know what
> >you think.
> 
> No doubt. I agree with you.
> 
> Acked-by: Byungchul Park <byungchul.park@lge.com>

Applied, thank you!

							Thanx, Paul

> >If I am not too confused, the only effect of this bug was to needlessly
> >allocate rcu_nocb_mask and to initialize it to all zeros bits, but please
> >let me know if I missed something.
> 
> I think so as you.
> 
> -- 
> Thanks,
> Byungchul
> 
