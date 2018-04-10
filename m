Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeDJUbU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:31:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752611AbeDJUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:31:17 -0400
Date: Tue, 10 Apr 2018 13:32:14 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409184258.GP3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041020-0040-0000-0000-00000414ABA9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008832; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016013; UDB=6.00518098; IPR=6.00795263;
 MB=3.00020507; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-10 20:31:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041020-0041-0000-0000-00000815C631
Message-Id: <20180410203214.GA19606@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 11:42:58AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 09, 2018 at 06:50:15PM +0200, Paolo Bonzini wrote:
> > "RWM" should be "RMW", and that's more or less the extent to which I
> > can claim to change the document. :)  In particular, "Self" is not
> > documented and the difference between "Self" and "SV" is not clear
> > to me.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Applied, though without the questions.  ;-)
> 
> "Self" is for things like smp_load_acquire() and smp_store_release()
> that order themselves against later and earlier accesses, respectively.
> This ordering applies to later/earlier access to all variables, not
> just the one that smp_load_acquire()/smp_store_release() accessed.
> In contrast, things like smp_mb() order only other accesses, not
> themselves.  Or at least it is impossible to proves whether or not they
> order themselves because they are not separately visible to other CPUs.
> 
> "SV" is "same variable", which applies to pretty much anything that
> accesses a variable, but not to things like smp_mb() which do not.
> 
> Does that help?

On the perhaps naive assumption that silence means assent, how about
the following patch?

							Thanx, Paul

------------------------------------------------------------------------

commit 818e46e8db6cacb099b8640b7f2945a3151c00ab
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 10 13:24:19 2018 -0700

    tools/memory-order: Improve key for SELF and SV
    
    The key for "SELF" was missing completely and the key for "SV" was
    a bit obtuse.  This commit therefore adds a key for "SELF" and improves
    the one for "SV".
    
    Reported-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index c0eafdaddfa4..d502993ac7d2 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
 	DR:	Dependent read (address dependency)
 	DW:	Dependent write (address, data, or control dependency)
 	RMW:	Atomic read-modify-write operation
-	SV	Same-variable access
+	SELF:	Orders self, as opposed to accesses both before and after
+	SV:	Orders later accesses to the same variable
