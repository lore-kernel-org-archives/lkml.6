Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F20C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeK1Gux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:50:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:37211 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeK1Gux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:50:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 11:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="91395942"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2018 11:51:54 -0800
Date:   Tue, 27 Nov 2018 11:51:53 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Jan Beulich' <JBeulich@suse.com>, "mingo@elte.hu" <mingo@elte.hu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86: modernize sync_bitops.h
Message-ID: <20181127195153.GE27075@linux.intel.com>
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
 <5B30C2C302000000000FA99B@prv1-mh.provo.novell.com>
 <5B30C2C302000078001FE5A0@prv1-mh.provo.novell.com>
 <5BF52F4D02000078001FE5C1@prv1-mh.provo.novell.com>
 <92f590595593498eaa1f91a17875126f@AcuMS.aculab.com>
 <5BF5577202000078001FE7AC@prv1-mh.provo.novell.com>
 <47f7dfd9b32f4425ac8466c8b0065c6e@AcuMS.aculab.com>
 <5BF56EA502000078001FE90E@prv1-mh.provo.novell.com>
 <9dc88b57164e481184dfbb4b2079086e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dc88b57164e481184dfbb4b2079086e@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:53:05PM +0000, David Laight wrote:
> 
> 
> > -----Original Message-----
> > From: Jan Beulich [mailto:JBeulich@suse.com]
> > Sent: 21 November 2018 14:42
> > To: David Laight
> > Cc: mingo@elte.hu; tglx@linutronix.de; Boris Ostrovsky; Juergen Gross; linux-kernel@vger.kernel.org;
> > hpa@zytor.com
> > Subject: RE: [PATCH v2] x86: modernize sync_bitops.h
> > 
> > >>> On 21.11.18 at 14:49, <David.Laight@ACULAB.COM> wrote:
> > > From: Jan Beulich
> > >> Sent: 21 November 2018 13:03
> > >>
> > >> >>> On 21.11.18 at 12:55, <David.Laight@ACULAB.COM> wrote:
> > >> > From: Jan Beulich
> > >> >> Sent: 21 November 2018 10:11
> > >> >>
> > >> >> Add missing insn suffixes and use rmwcc.h just like was (more or less)
> > >> >> recently done for bitops.h as well.
> > >> >
> > >> > Why? bts (etc) on memory don't really have an 'operand size'.
> > >>
> > >> Of course they do - depending on operand size they operate on
> > >> 2-, 4-, or 8-byte quantities. When the second operand is a
> > >> register, the suffix is redundant (but doesn't hurt), but when
> > >> the second operand is an immediate, the assembler (in AT&T
> > >> syntax) has no way of knowing what operand size you mean.
> > >
> > > You need to RTFM.
> > 
> > Excuse me? How about you look at this table from the SDM
> > (format of course comes out better in the .pdf):
> > 
> > 0F AB /r BTS r/m16, r16 MR Valid Valid Store selected bit in CF flag and set.
> > 0F AB /r BTS r/m32, r32 MR Valid Valid Store selected bit in CF flag and set.
> > REX.W + 0F AB /r BTS r/m64, r64 MR Valid N.E. Store selected bit in CF flag and set.
> > 0F BA /5 ib BTS r/m16, imm8 MI Valid Valid Store selected bit in CF flag and set.
> > 0F BA /5 ib BTS r/m32, imm8 MI Valid Valid Store selected bit in CF flag and set.
> > REX.W + 0F BA /5 ib BTS r/m64, imm8 MI Valid N.E. Store selected bit in CF flag and set.
> > 
> > Please read manuals yourself before making such statements.
> > 
> > > Regardless of the 'operand size' the 'bit' instructions do a 32 bit aligned
> > > 32 bit wide read/modify/write cycle.
> > >
> > > The 'operand size' does affect whether the bit number (which is signed)
> > > comes from %cl (8 bits), %cx (16 bits), %rcx (32 bits) or (%ecx) 64 bits.
> > > But that is implicit in the register name used.
> > 
> > There is no form with %cl as operand. Instead there are forms with
> > an immediate operand.
> 
> See also section 3.1.1.9 (in the copy of 325462.pdf I have):
> (edited out references to the figures)
> 
> Bit(BitBase, BitOffset) — Returns the value of a bit within a bit string.
>    The bit string is a sequence of bits in memory or a register. Bits are
>    numbered from low-order to high-order within registers and within memory
>    bytes. If the BitBase is a register, the BitOffset can be in the range 0
>    to [15, 31, 63] depending on the mode and register size.
> 
>    If BitBase is a memory address, the BitOffset can range has different ranges
>    depending on the operand size (see Table 3-2).
> 
>    The addressed bit is numbered (Offset MOD 8) within the byte at address
>    (BitBase + (BitOffset DIV 8)) where DIV is signed division with rounding
>    towards negative infinity and MOD returns a positive number.
> 
> Table 3-2. Range of Bit Positions Specified by Bit Offset Operands
> Operand Size Immediate BitOffset   Register BitOffset
>     16             0 to 15         2**15 to 2**15 − 1
>     32             0 to 31         2**31 to 2**31 − 1
>     64             0 to 63         2**63 to 2**63 − 1
> 
> For Bit test it says:
> 
> When accessing a bit in memory, the processor may access 4 bytes starting from
> the memory address for a 32-bit operand size, using by the following relationship:
>     Effective Address + (4 ∗ (BitOffset DIV 32))
> Or, it may access 2 bytes starting from the memory address for a 16-bit operand, using this relationship:
>     Effective Address + (2 ∗ (BitOffset DIV 16))
> It may do so even when only a single byte needs to be accessed to reach the given bit.

This agrees with what Jan is saying, e.g. "4 bytes ... for a 32-bit op size"
and "2 bytes ... for a 16-bit op size".  For whatever reason the 64-bit op
size is omitted, but the normal behavior applies.

> 
> (That is the text I remember being in the old docs, but I don't think it
> used to refer to the address being aligned.
> My 8086, 286 and 386 books are all at home.)
> 
> The other instructions (eg btc) say:
> 
> If the bit base operand specifies a memory location, the operand represents the
> address of the byte in memory that contains the bit base (bit 0 of the specified byte)
> of the bit string. The range of the bit position that can be
> referenced by the offset operand depends on the operand size.
> 
> So the 'operand size' gives the size of the bit offset, not the size of
> the memory cycle.

No, it determines both.  Here's rough pseudocode for how the op size
affects what memory is read.  Note that there isn't alignment per se,
but rather the memory accessed is offset by a modulo calculation of
the bit number, i.e. by the bits "above" the op_size.  This doesn't
apply to the imm8 encoding because bits above the op_size are ignored.

	mem = decode_mem(op1);

	if (is_reg(op2)) {
		bit = read_reg(op2);

		/* sign-extend and align the offset */
		offset = sign_extend(bit, op_size);
		if (op_size == 2)
			offset &= ~0x1;
		else if (op_size == 4)
			offset &= ~0x3;
		else if (op_size == 8)
			offset &= ~0x7;

		/* memory displacement adjusted by offset */
		mem.displacement += offset;
	} else {
		bit = decode_imm(op2);
	}

	/* imm8 ignores bits above op_size, reg adjusts offset (above) */
	if (op_size == 2)
		bit &= 0xf;
	else if (op_size == 4)
		bit &= 0x1f;
	else if (op_size == 8)
		bit &= 0x3f;

	tmp = read_mem(mem, op_size);
	tmp = bit_op(tmp, bit);
	write_mem(mem, op_size);

> Maybe I'll run some instructions against a PCIe slave and monitor the TLPs.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
