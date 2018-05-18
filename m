Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeERRvo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:51:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55079 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeERRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:51:41 -0400
X-Google-Smtp-Source: AB8JxZqTUSjjQMKcCc+OKOKCpy30dpX3/v8CCZI6pphz0cJYrQAcOPPUr4/rKhNrd8qbMcqflSN3+A==
Date: Fri, 18 May 2018 20:51:36 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [PATCH] objtool: Detect assembly code falling through to INT3
 padding
Message-ID: <20180518175136.GB2055@avx2>
References: <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
 <20180516033044.odb74pdgcn5nacwb@treble>
 <20180517134934.eog2fgoby5azq5a7@treble>
 <20180518071814.GB26358@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518071814.GB26358@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:18:14AM +0200, Ingo Molnar wrote:
> The concept of built-in kernel tooling working at the machine code level is just 
> so powerful - we should have added our own KCC compiler 20 years ago.

...for two very serious reasons

* C as a language moves very slowly, last help from the comittee were
  C99 intializers which are OK, but, say, memory model was explictly
  rejected. However the project expands and becomes more complex much
  faster than C working group sets up meetings. Compiler authors help
  with extensions but ultimately can not be relied on (see "inline" saga).

  Recently everyone was celebrating new and improved min() and max()
  macros admiring creativity and knowledge of intricate language details
  (me too, don't get this wrong).

  Now this is how it can be done in a language which is not stupid:

	constexpr int min(int a, int b)
	{
		return a < b ? a : b;
	}

  That's literally all. And you can also do

	template<typename T>
	void min(T a, char b) = delete;

	template<typename T>
	void min(char a, T b) = delete;

  because "char" is char.

  Having control over compiler things like that can be addded more
  quickly.


* insulating the project from the whims of compiler authors who every
  once in a while use "undefined behaviour" or other kinds of language
  lawyering to do strange things.

  Other serious projects do this too. Database people use O_DIRECT
  to insulate themselves from kernel people for the very same reasons.
