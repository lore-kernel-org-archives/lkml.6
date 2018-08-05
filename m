Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA47C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 06:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333D5217B4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 06:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333D5217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeHEIO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 04:14:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:14365 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725729AbeHEIO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 04:14:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2018 23:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,446,1526367600"; 
   d="scan'208";a="59907097"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2018 23:11:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8E494301BDB; Sat,  4 Aug 2018 23:11:32 -0700 (PDT)
Date:   Sat, 4 Aug 2018 23:11:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/7] x86/mm/init: pass unconverted symbol addresses to
 free_init_pages()
Message-ID: <20180805061132.GD4238@tassilo.jf.intel.com>
References: <20180802225823.4711C55B@viggo.jf.intel.com>
 <20180802225828.89B2D0E2@viggo.jf.intel.com>
 <alpine.LSU.2.11.1808031650050.4436@eggly.anvils>
 <CA+55aFzd-F65GVBq8a-vTaU4G5UwddDcOdcd3SV9YVdB6qDGdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzd-F65GVBq8a-vTaU4G5UwddDcOdcd3SV9YVdB6qDGdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [ Goes around and rummages ]
> 
> Oh, never mind, looking around reminded me why: we want to map the
> kernel text in the top 31 bits, so that we can use the faster
> -mcmodel=kernel because all symbols fit in sign-extended 32 bits.
> 
> Maybe there was some other reason too, but I think that's it.

No that was the only reason.

Large code model would be extremely expensive, and PIC linked
kernel also had some issues. So we ended up with this set up.

-Andi
