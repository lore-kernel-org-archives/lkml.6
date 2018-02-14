Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031949AbeBNWw2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:52:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031852AbeBNWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:52:27 -0500
Date: Wed, 14 Feb 2018 14:52:38 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
 <20180210010703.GE3617@linux.vnet.ibm.com>
 <0ad5ff99-32e9-df65-70d3-ba4e9ec0f6c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad5ff99-32e9-df65-70d3-ba4e9ec0f6c9@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021422-0044-0000-0000-000003E41AC4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008535; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000253; SDB=6.00989797; UDB=6.00502622; IPR=6.00769151;
 MB=3.00019557; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-14 22:52:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021422-0045-0000-0000-000008141AF5
Message-Id: <20180214225238.GV3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140269
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 07:20:35AM +0900, Akira Yokosawa wrote:
> On 2018/02/09 17:07:03 -0800, Paul E. McKenney wrote:
> > On Sat, Feb 10, 2018 at 08:46:25AM +0900, Akira Yokosawa wrote:
> >> >From 7c1f497a9a51e8db1a94c8a7ef0b74b235aaab88 Mon Sep 17 00:00:00 2001
> >> From: Akira Yokosawa <akiyks@gmail.com>
> >> Date: Fri, 9 Feb 2018 04:51:05 -0800
> >> Subject: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-" -> "_")
> >>
> >> As of herd7 7.47, these '-'s are not permitted and end up in
> >> errors such as:
> >>
> >>     File "./linux-kernel.def", line 44, characters 29-30:
> >>     unexpected '-' (in macros)
> >>
> >> Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
> >> identifiers match ASPLOS paper") in the repository at
> >> https://github.com/aparri/memory-model can restore the compatibility
> >> with herd7 7.47.
> >>
> >> Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
> >> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> >> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> >> ---
> >> Paul,
> >>
> >> FWIW, this is a squashed version relative to patch 07/10 in the RFC series.
> > 
> > Thank you, Akira!
> > 
> > I am going to hold off on this for a bit to see if we can instead get
> > a new release of herd7, but if we can't. this might well be a very good
> > way to go.
> 
> So, herdtools7.7.48 is now available by "opam update; opam upgrade".
> Maybe mentioning the required version of herdtools7 in README would help.

Or have some way for the memory model's .cat files to state what version
they need, but in the meantime please see the patch below.  But even with
such version specification, we probably want to have the version in the
README...

> One glitch I'm aware of is one of the output of klitmus7 fails to
> compile on kernels prior to 4.14, because of smp_mb__after_spinlock()
> used in Z6.0+pooncelock+poonceLock+pombonce.litmus.

This is one advantage of having the memory model in the kernel source
itself -- the versions match.  And people can always fire up a different
kernel version (for example, within a VM) to run the output of klitmus7.

> And there is a question I want to ask.
> 
> Z6.0+pooncelock+pooncelock+pombonce.litmus, which doesn't have
> smp_mb__after_spinlock(), has a comment of:
> 
> (*
>  * Result: Never
>  *
>  * This example demonstrates that a pair of accesses made by different
>  * processes each while holding a given lock will not necessarily be
>  * seen as ordered by a third process not holding that lock.
>  *)
> 
> The result was changed from "Sometimes" to "Never" in response to
> Alan's feedback the other day, but the following comment indicates
> the result should be "Sometimes". And the current model gives the
> result of "Sometimes".
> 
> As I have no idea of the pending patches, I'd like to know once
> the pending patches are applied, would 
> Z6.0+pooncelock+pooncelock+pombonce.litmus and
> Z6.0+pooncelock+poonceLock+pombonce.litmus become identical?

Let's see, examining the Z6 litmus tests and running on herd7 version 7.48:

Z6.0+pooncelock+pooncelock+pombonce Sometimes 1 7
Z6.0+pooncelock+poonceLock+pombonce Never 0 7
Z6.0+pooncerelease+poacquirerelease+mbonceonce Sometimes 1 7

But Alan stated that the result of the test would be changed by one of
the patches in our "pending" list.  I ran with all the patches currently
applied, so I am guessing that Alan was refering to one of the changes
that we have discussed but not yet created.

Alan, enlightenment?

							Thanx, Paul

------------------------------------------------------------------------

commit dad94d8dc78e50bab91b313a67232e85ee22a733
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Feb 14 14:37:22 2018 -0800

    tools/memory-model: Add required herd7 version to README file
    
    LKMM and the herd7 tool are co-evolving, and out-of-date herd7 tools
    produce inaccurate results, often with no obvious error messages.  This
    commit therefore adds the required herd7 version to the LKMM README file.
    
    Longer term, it would be good if .cat files could specify the required
    version in a manner allowing herd7 to produce clear diagnostics.
    
    Suggested-by: Akira Yokosawa <akiyks@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 91414a49fac5..ea950c566ffd 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,7 +20,8 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-The "herd7" and "klitmus7" tools must be downloaded separately:
+Version 7.48 of the "herd7" and "klitmus7" tools must be downloaded
+separately:
 
   https://github.com/herd/herdtools7
 
