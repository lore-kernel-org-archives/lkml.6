Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C462086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C462086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKZN7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:59:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:24027 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:59:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2018 19:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,280,1539673200"; 
   d="scan'208";a="252530192"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2018 19:07:09 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id F41F6309C88; Sun, 25 Nov 2018 19:07:08 -0800 (PST)
Date:   Sun, 25 Nov 2018 19:07:08 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 21/28] x86/speculation: Prepare for conditional IBPB
 in switch_mm()
Message-ID: <20181126030708.GP13936@tassilo.jf.intel.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185005.466447057@linutronix.de>
 <20181125205330.GO13936@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 11:20:50PM +0100, Thomas Gleixner wrote:
> On Sun, 25 Nov 2018, Andi Kleen wrote:
> 
> > > The current check whether two tasks belong to the same context is using the
> > > tasks context id. While correct, it's simpler to use the mm pointer because
> > > it allows to mangle the TIF_SPEC_IB bit into it. The context id based
> > > mechanism requires extra storage, which creates worse code.
> > 
> > [We tried similar in some really early versions, but it was replaced
> > with the context id later.]
> > 
> > One issue with using the pointer is that the pointer can be reused
> > when the original mm_struct is freed, and then gets reallocated
> > immediately to an attacker. Then the attacker may avoid the IBPB.
> > 
> > Given it's probably hard to generate any reasonable leak bandwidth with
> > such a complex scenario, but it still seemed better to close the hole.
> 
> Sorry, but that's really a purely academic exercise. 

Ok fair enough. I guess it's acceptable if you add a comment explaining it.

-Andi
