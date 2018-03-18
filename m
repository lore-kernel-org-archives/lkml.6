Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754728AbeCRXq6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 19:46:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754579AbeCRXqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 19:46:53 -0400
Date: Sun, 18 Mar 2018 16:46:42 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180316214654.895E24EC@viggo.jf.intel.com>
 <20180316214656.0E059008@viggo.jf.intel.com>
 <20180317232425.GH1060@ram.oc3035372033.ibm.com>
 <alpine.DEB.2.21.1803181029220.1509@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803181029220.1509@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18031823-0040-0000-0000-0000042296DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031823-0041-0000-0000-00002625A8BB
Message-Id: <20180318234642.GI1060@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-18_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803180299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 10:30:48AM +0100, Thomas Gleixner wrote:
> On Sat, 17 Mar 2018, Ram Pai wrote:
> > On Fri, Mar 16, 2018 at 02:46:56PM -0700, Dave Hansen wrote:
> > > 
> > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > > 
> > > mm_pkey_is_allocated() treats pkey 0 as unallocated.  That is
> > > inconsistent with the manpages, and also inconsistent with
> > > mm->context.pkey_allocation_map.  Stop special casing it and only
> > > disallow values that are actually bad (< 0).
> > > 
> > > The end-user visible effect of this is that you can now use
> > > mprotect_pkey() to set pkey=0.
> > > 
> > > This is a bit nicer than what Ram proposed because it is simpler
> > > and removes special-casing for pkey 0.  On the other hand, it does
> > > allow applciations to pkey_free() pkey-0, but that's just a silly
> > > thing to do, so we are not going to protect against it.
> > 
> > So your proposal 
> > (a) allocates pkey 0 implicitly, 
> > (b) does not stop anyone from freeing pkey-0
> > (c) and allows pkey-0 to be explicitly associated with any address range.
> > correct?
> > 
> > My proposal
> > (a) allocates pkey 0 implicitly, 
> > (b) stops anyone from freeing pkey-0
> > (c) and allows pkey-0 to be explicitly associated with any address range.
> > 
> > So the difference between the two proposals is just the freeing part i.e (b).
> > Did I get this right?
> 
> Yes, and that's consistent with the other pkeys.
> 

ok.

Yes it makes pkey-0 even more consistent with the other keys, but not
entirely consistent.  pkey-0 still has the priviledge of being
allocated by default.


RP
