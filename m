Date: Wed, 28 Mar 2018 21:22:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Manoj Gupta <manojgupta@chromium.org>, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328192242.GA1404@kroah.com>
References: <20180327235553.210165-1-mka@chromium.org>
 <20180328061616.GA8212@kroah.com>
 <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
 <20180328180556.GB32098@kroah.com>
 <20180328181456.GA87376@google.com>
 <20180328181936.GA3522@kroah.com>
 <20180328185009.GB87376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328185009.GB87376@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:50:09AM -0700, Matthias Kaehlcke wrote:
> El Wed, Mar 28, 2018 at 08:19:36PM +0200 Greg Kroah-Hartman ha dit:
> 
> > On Wed, Mar 28, 2018 at 11:14:56AM -0700, Matthias Kaehlcke wrote:
> > > El Wed, Mar 28, 2018 at 08:05:56PM +0200 Greg Kroah-Hartman ha dit:
> > > 
> > > > 
> > > > A: Because it messes up the order in which people normally read text.
> > > > Q: Why is top-posting such a bad thing?
> > > > A: Top-posting.
> > > > Q: What is the most annoying thing in e-mail?
> > > > 
> > > > A: No.
> > > > Q: Should I include quotations after my reply?
> > > > 
> > > > http://daringfireball.net/2007/07/on_top
> > > > 
> > > > On Wed, Mar 28, 2018 at 07:47:53AM -0700, Manoj Gupta wrote:
> > > > > Please note that there is nothing wrong in the generated code, just
> > > > > that it confuses objtool.
> > > > 
> > > > Then fix the tool, the C code is correct :)
> > > > 
> > > > > Clang has simply omitted the statement where NULL is returned since
> > > > > the pointer was always dereferenced post inlining.
> > > > 
> > > > Then tell clang not to do that, like we tell gcc not to do that as that
> > > > is a foolish thing for a compiler to do when building the kernel.
> > > 
> > > Thanks all for your input, we'll try to get
> > > -fno-delete-null-pointer-checks or a similar flag to be added to
> > > clang.
> > 
> > Wait, clang does not have that?
> 
> Nope, clang doesn't currently have such a flag.
> 
> > That's crazy, how has this not been hit yet when building the
> > kernel?
> 
> IIRC this patch was needed to work around the lack of the flag:
> 
> commit beaec533fc2701a28a4d667f67c9f59c6e4e0d13
> Author: Alexander Potapenko <glider@google.com>
> Date:   Wed Jul 19 20:27:30 2017 +0200
> 
>     llist: clang: introduce member_address_is_nonnull()
> 
>     Currently llist_for_each_entry() and llist_for_each_entry_safe() iterate
>     until &pos->member != NULL.  But when building the kernel with Clang,
>     the compiler assumes &pos->member cannot be NULL if the member's offset
>     is greater than 0 (which would be equivalent to the object being
>     non-contiguous in memory).  Therefore the loop condition is always true,
>     and the loops become infinite.
> 
>     To work around this, introduce the member_address_is_nonnull() macro,
>     which casts object pointer to uintptr_t, thus letting the member pointer
>     to be NULL.
> 
>     Signed-off-by: Alexander Potapenko <glider@google.com>
>     Tested-by: Sodagudi Prasad <psodagud@codeaurora.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> 
> Other than that I am not aware of any known issues.

I think you have gotten lucky :)

greg k-h
