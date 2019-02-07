Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E783EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3BA21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBGL16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:27:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:27:58 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1grhqP-0007ow-3T; Thu, 07 Feb 2019 12:27:49 +0100
Date:   Thu, 7 Feb 2019 12:27:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 12/22] x86/fpu: Only write PKRU if it is different from
 current
Message-ID: <20190207112748.kzjd3cagqgecamp7@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-13-bigeasy@linutronix.de>
 <c4a862a0-b29f-b511-9cde-d7f609792940@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4a862a0-b29f-b511-9cde-d7f609792940@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 10:09:24 [-0800], Dave Hansen wrote:
> On 1/9/19 3:47 AM, Sebastian Andrzej Siewior wrote:
> > +static inline void __write_pkru(u32 pkru)
> > +{
> > +	/*
> > +	 * Writting PKRU is expensive. Only write the PKRU value if it is
> > +	 * different from the current one.
> > +	 */
> 
> I'd say:
> 
> 	WRPKRU is relatively expensive compared to RDPKRU.
> 	Avoid WRPKRU when it would not change the value.
> 
> In the grand scheme of things, WRPKRU is cheap.  It's certainly not an
> "expensive instruction" compared to things like WBINVD.

Okay.

> > +	if (pkru == __read_pkru())
> > +		return;
> > +	__write_pkru_insn(pkru);
> > +}
> 
> Is there a case where we need __write_pkru_insn() directly?  Why not
> just put the inline assembly in here?

There is no user of __write_pkru_insn(). I had one in the past I think.
Let me merge it for now.

Sebastian
