Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDKQTC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:19:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752894AbeDKQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:19:01 -0400
Date: Wed, 11 Apr 2018 09:19:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Reply-To: paulmck@linux.vnet.ibm.com
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041116-0040-0000-0000-0000041507B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008837; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016408; UDB=6.00518333; IPR=6.00795656;
 MB=3.00020523; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-11 16:18:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041116-0041-0000-0000-000008162320
Message-Id: <20180411161956.GQ3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110151
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 01:15:58PM +0200, Paolo Bonzini wrote:
> On 10/04/2018 23:34, Paul E. McKenney wrote:
> > Glad it helps, and I have queued it for the next merge window.  Of course,
> > if a further improvement comes to mind, please do not keep it a secret.  ;-)
> 
> Yes, there are several changes that could be included:
> 
> - SV could be added to the prior operation case as well?  It should be
> symmetric
> 
> - The *_relaxed() case also applies to void RMW
> 
> - smp_store_mb() is missing
> 
> - smp_rmb() orders prior reads fully against subsequent RMW because SV
> applies between the two parts of the RMW; likewise smp_wmb() orders prior
> RMW fully against subsequent writes
> 
> 
> I am going submit these changes separately, but before doing that I can show
> also my rewrite of the cheat sheet.
> 
> The advantage is that, at least to me, it's clearer (and gets rid of
> "Self" :)).
> 
> The disadvantage is that it's much longer---almost twice the lines, even if
> you discount the splitting out of cumulative/propagating to a separate table
> (which in turn is because to me it's a different level of black magic).
> 
> ---------------------
> Memory operations are listed in this document as follows:
> 
> 	R:	Read portion of RMW
> 	W:	Write portion of RMW
> 	DR:	Dependent read (address dependency)
> 	DW:	Dependent write (address, data, or control dependency)
> 	RMW:	Atomic read-modify-write operation
> 	SV	Other accesses to the same variable
> 
> 
> Memory access operations order other memory operations against themselves as
> follows:
> 
>                                    Prior Operation   Subsequent Operation
>                                    ---------------   ---------------------
>                                    R  W  RMW  SV     R  W  DR  DW  RMW  SV
>                                    -  -  ---  --     -  -  --  --  ---  --
> Store, e.g., WRITE_ONCE()                      Y                         Y
> Load, e.g., READ_ONCE()                        Y            Y   Y        Y
> Unsuccessful RMW operation                     Y            Y   Y        Y
> *_relaxed() or void RMW operation              Y            Y   Y        Y
> rcu_dereference()                              Y            Y   Y        Y
> Successful *_acquire()                         Y      r  r  r   r    r   Y
> Successful *_release()             w  w    w   Y                         Y
> smp_store_mb()                     Y  Y    Y   Y      Y  Y   Y   Y   Y   Y
> Successful full non-void RMW       Y  Y    Y   Y      Y  Y   Y   Y   Y   Y
> 
> Key:	Y:	Memory operation provides ordering
> 	r:	Cannot move past the read portion of the *_acquire()
> 	w:	Cannot move past the write portion of the *_release()
> 
> 
> Memory barriers order prior memory operations against subsequent memory
> operations.  Two operations are ordered if both have non-empty cells in
> the following table:
> 
>                                    Prior Operation   Subsequent Operation
>                                    ---------------   --------------------
>                                    R  W  RMW         R  W  DR  DW  RMW
>                                    -  -  ---         -  -  --  --  ---
> smp_rmb()                          Y      r          Y      Y       Y
> smp_wmb()                             Y   Y             Y       Y   w
> smp_mb() & synchronize_rcu()       Y  Y   Y          Y  Y   Y   Y   Y
> smp_mb__before_atomic()            Y  Y   Y          a  a   a   a   Y
> smp_mb__after_atomic()             a  a   Y          Y  Y   Y   Y
> 
> 
> Key:	Y:	Barrier provides ordering
> 	r:	Barrier provides ordering against the read portion of RMW
> 	w:	Barrier provides ordering against the write portion of RMW
> 	a:	Barrier provides ordering given intervening RMW atomic operation
> 
> 
> Finally the following describes which operations provide cumulative and
> propagating fences:
> 
>                                      Cumulative         Propagates
>                                      ----------         ----------
> Store, e.g., WRITE_ONCE()
> Load, e.g., READ_ONCE()
> Unsuccessful RMW operation
> *_relaxed() or void RMW operation
> rcu_dereference()
> Successful *_acquire()
> Successful *_release()                   Y
> smp_store_mb()                           Y                  Y
> Successful full non-void RMW             Y                  Y
> smp_rmb()
> smp_wmb()
> smp_mb() & synchronize_rcu()             Y                  Y
> smp_mb__before_atomic()                  Y                  Y
> smp_mb__after_atomic()                   Y                  Y
> ----------
> 
> Perhaps you can see some obvious improvements.  Otherwise I'll send patches
> for the above issues.

Splitting it as you have done might indeed have some advantages.  What do
others think?

On the last table, would it make sense to leave out the rows having neither
"Cumulative" nor "Propagates"?

							Thanx, Paul
