Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBUWZU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:25:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750811AbeBUWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:25:16 -0500
Date: Wed, 21 Feb 2018 14:25:34 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, nborisov@suse.com
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180221190543.GM3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211419350.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211419350.2032-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022122-2213-0000-0000-00000273A45E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008572; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993145; UDB=6.00504618; IPR=6.00772489;
 MB=3.00019678; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 22:25:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022122-2214-0000-0000-00005931D27C
Message-Id: <20180221222534.GP3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210268
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 02:27:04PM -0500, Alan Stern wrote:
> On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> 
> > > > +ISA2+pooncelock+pooncelock+pombonce.litmus
> > > > +	Tests whether the ordering provided by a lock-protected S litmus
> > > 
> > > Call it an ISA2 litmus test, not an S litmus test!
> > 
> > Given the structure of the test, the relationship to S is important
> > because it helps motivate why anyone might care.  But yes, having ISA2
> > only in the filename is a bit obtuse.  How about the following?
> > 
> > ISA2+pooncelock+pooncelock+pombonce.litmus
> > 	Tests whether the ordering provided by a lock-protected S
> > 	litmus test is visible to an external process whose accesses are
> > 	separated by smp_mb().	This addition of an external process to
> > 	S is otherwise known as ISA2.
> 
> Okay, that's somewhat better.
> 
> However, I still don't understand why you think of this as a form of S.  
> In S, the first variable written by P0 is the same as the variable
> written by P1.  In this test, no variable other than the spinlock gets
> written twice.  To me that seems like a pretty fundamental difference.

There is a chain of processes connected by variables, similar to
a snap-together toy.  If you "disconnect" S at the end and snap in
a process having a pair of reads separated by a full memory barrier,
you get ISA2.  And yes, this does rename one of S's variables, but that
is OK because in this view, each variable is defined by the connection
between a given pair of pair of processes.

Unconventional perhaps, but then again remember who you are emailing
with.  ;-)

Another (perhaps more conventional) way to think of this is in terms of
Andrea's python script that identified equivalent litmus tests.  For that
script, both the variable names and process numbers are irrelevant.

							Thanx, Paul
