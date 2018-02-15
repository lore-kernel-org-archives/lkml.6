Date: Thu, 15 Feb 2018 15:04:27 +0100
From: Greg KH <greg@kroah.com>
To: Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
Message-ID: <20180215140427.GB31443@kroah.com>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble>
 <20180214224525.esxiqt7yjjjpzyz4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214224525.esxiqt7yjjjpzyz4@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+Kees

On Wed, Feb 14, 2018 at 04:45:25PM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
> > On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
> > > Hi Josh,
> > > 
> > > I recently did some randconfig testing with a plain 4.14-stable kernel
> > > and gcc-7.3.0, and came across three distinct objtool warnings:
> > > 
> > > drivers/misc/lkdtm_bugs.o: warning: objtool:
> > > lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame
> 
> While this is probably an objtool bug, the code is very odd:
> 
> 00000000000001a8 <lkdtm_CORRUPT_LIST_ADD>:
>  1a8:   e8 00 00 00 00          callq  1ad <lkdtm_CORRUPT_LIST_ADD+0x5>
>                         1a9: R_X86_64_PC32      __fentry__-0x4
>  1ad:   55                      push   %rbp
>  1ae:   48 89 e5                mov    %rsp,%rbp
>  1b1:   48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
>  1b5:   48 83 ec 20             sub    $0x20,%rsp
>  1b9:   48 89 ec                mov    %rbp,%rsp
>  1bc:   5d                      pop    %rbp
>  1bd:   c3                      retq
> 
> The function just allocates/aligns its stack space and then returns.  It
> seems like GCC was too smart for its own good here, as the function
> doesn't test what it's supposed to.  Can you share the config for this
> one?

lkdtm is a "interesting" module in that it tries to do bad things to
test for various stuff.  Kees, does the above look like it is doing the
correct thing?

thanks,

greg k-h
