Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeBWR7W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:59:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeBWR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:59:20 -0500
Date: Fri, 23 Feb 2018 12:58:11 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v3 6/8] x86/pti: don't mark the user PGD with
 _PAGE_NX.
Message-ID: <20180223175811.GO8252@char.us.oracle.com>
References: <1515612500-14505-1-git-send-email-w@1wt.eu>
 <1515612500-14505-7-git-send-email-w@1wt.eu>
 <CA+55aFxyx2-m8Rd5vBoncd2u-UOF=QQ-By7XwzWEfHtA=Lqp5A@mail.gmail.com>
 <CALCETrUH6s8=w6O67g39B45of6XBJv2CTt24Xw-darfb6KB42A@mail.gmail.com>
 <1515616106.22302.237.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1515616106.22302.237.camel@amazon.co.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1NHxQ03005851

On Wed, Jan 10, 2018 at 08:28:26PM +0000, Woodhouse, David wrote:
> On Wed, 2018-01-10 at 11:59 -0800, Andy Lutomirski wrote:
> > On Wed, Jan 10, 2018 at 11:54 AM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > 
> > > On Wed, Jan 10, 2018 at 11:28 AM, Willy Tarreau <w@1wt.eu> wrote:
> > > > 
> > > > Since we're going to keep running on the same PGD when returning to
> > > > userspace for certain performance-critical tasks, we'll need the user
> > > > pages to be executable. So this code disables the extra protection
> > > > that was added consisting in marking user pages _PAGE_NX so that this
> > > > pgd remains usable for userspace.
> > > Yeah, no. This is wrong.
> > > 
> > > Sure, SMEP gives the same thing in most cases, but not for older CPU's.
> > > 
> > > So NX is a really nice way to make sure that PTI really does protect
> > > against user-space gadgets.
> > > 
> > > We don't break that, and we definitely don't break that just because
> > > of some broken notion of "let's make page table isolation per-thread".
> > > 
> > If we're going to have a thread without PTI off, that thread needs to
> > run with the same page tables for kernel and user, so it needs NX off
> > on the user part.  I don't see any way around it.
> > 
> > We could nix the entire concept of fine-grained PTI control, or we
> > could make it require SMEP, I suppose.
> 
> We've been bashing out the precise requirements for RSB clearing (for
> pre-SKL to avoid bogus entries) or stuffing (for SKL+ to avoid
> underflow causing the BTB to be used).
> 
> It looks like we can avoid the RSB clearing on kernel entry if we have
> SMEP. And PTI setting NX on userspace pages is equivalent to SMEP for
> this purpose — so the RSB clearing basically ended up being AMD-only
> (!SMEP && !PTI).
> 
> We also need to clear the RSB on vmexit, as documented. And if we
> really want 100% support for retpoline on SKL+ instead of saying "use
> IBRS if you're paranoid", then there are a few more cases where we need
> to stuff it to avoid underflow (which is the same operation, but Arjan
> insists we should differentiate the two, which is reasonable enough).

Are these cases documented somewhere along with what approaches are taken?

I do remember Thomas's email from Feb 4th titled:
Re: [RFC 09/10] x86/enter: Create macros to restrict/unrestrict Indirect Branch Speculation                                                          

which outlined a pretty nifty idea on this, but not sure where that has gone?
