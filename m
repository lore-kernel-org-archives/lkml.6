Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbeBRNPo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:15:44 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40833 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeBRNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:15:43 -0500
X-Google-Smtp-Source: AH8x224Bp7IqkV1Ymb3JjbND5BpMtI/XThejOVbWJpg/iytT8DQZDUzWUloTbI2z28E6ZmLQtcRZNA==
Date: Sun, 18 Feb 2018 14:15:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/2] jump_label: Explicitly disable jump labels in
 __init code
Message-ID: <20180218131538.5nmfce2aepcg2bpr@gmail.com>
References: <cover.1518798288.git.jpoimboe@redhat.com>
 <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
 <20180217103848.yiutigxpukxfbtze@gmail.com>
 <20180217134035.67jzcc5rwtyyufix@treble>
 <alpine.DEB.2.21.1802172108240.2087@nanos.tec.linutronix.de>
 <20180218130520.3mmosubvt443756v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180218130520.3mmosubvt443756v@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 2) code robustness 
> 
> For example:
> 
>         for (i = 0; i < 10; i++)
>                 if (foo)
>                         bar(i);
>                 baz(i);
> 
> Is probably buggy code, although technically it's valid syntax and will compile 
> just fine.
> 
> If all multi-line statements have curly braces then this type of bug cannot occur:
> 
>         for (i = 0; i < 10; i++) {
>                 if (foo)
>                         bar(i);
>                 baz(i);
> 	}

Note that newer versions of GCC will warn about this pattern:

     warning: this ‘for’ clause does not guard
              this statement, but the latter is misleadingly indented as if it were guarded by the ‘for’

But the warning is pretty restrictive and GCC won't warn about slightly more 
complex patterns like:

          for (i = 0; i < 10; i++)
                  if (foo)
                          bar(i);
//                debug_fn();
                  baz(i);

Thanks,

	Ingo
