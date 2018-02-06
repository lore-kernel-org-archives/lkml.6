Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeBFXyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:54:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:14976 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754149AbeBFXyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:54:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,470,1511856000";
   d="scan'208";a="32651183"
Date: Tue, 6 Feb 2018 15:54:02 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing
 with PUSH/MOV instructions
Message-ID: <20180206235402.GN30338@tassilo.jf.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de>
 <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net>
 <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason for that complexity is purely the system call fastpath case
> that no longer exists, I think.
> 
> Am I missing something?

Yes merging the macros should be fine without fast path. 

But for push, on older CPUs (older AMD, most Atoms, really old Intel big core) 
sub+mov is a lot faster than push because push has additional dependencies
causing pipeline bubbles. So you would make these cases slower if you
use PUSH.

That is no different between fast path and slow path.

-Andi

PS it was never fully clear to me why we removed the fast path. After all it 
could still be useful on the future CPUs with Spectre hardware fixes.
