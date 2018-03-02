Date: Fri, 2 Mar 2018 09:31:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Jason Baron <jbaron@akamai.com>,
	Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 1/3] livepatch: add sample cumulative patch
Message-ID: <20180302083132.GA9636@kroah.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
 <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
 <CAOFm3uF8HT=5gRG_AvvZwHnVDgrV1HxByG+Gxaqc+uEFYFnFxw@mail.gmail.com>
 <alpine.LSU.2.21.1802271243160.19255@pobox.suse.cz>
 <CAOFm3uEJAY4T7yRxmbXBuTXa-x5LokLVe+-66tZJF6kHLYyKQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uEJAY4T7yRxmbXBuTXa-x5LokLVe+-66tZJF6kHLYyKQA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 05:19:28PM -0800, Philippe Ombredanne wrote:
> Miroslav,
> 
> On Tue, Feb 27, 2018 at 3:54 AM, Miroslav Benes <mbenes@suse.cz> wrote:
> > On Sat, 24 Feb 2018, Philippe Ombredanne wrote:
> >
> >> Joe,
> >>
> >> On Fri, Feb 23, 2018 at 1:33 PM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >> > Add a simple atomic replace / cumulative livepatch example.
> >> >
> >> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> >> > ---
> >> >  samples/livepatch/Makefile               |   1 +
> >> >  samples/livepatch/livepatch-cumulative.c | 216 +++++++++++++++++++++++++++++++
> >> >  2 files changed, 217 insertions(+)
> >> >  create mode 100644 samples/livepatch/livepatch-cumulative.c
> >> >
> >> > diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> >> > index 2472ce39a18d..dd0e2a8af1af 100644
> >> > --- a/samples/livepatch/Makefile
> >> > +++ b/samples/livepatch/Makefile
> >> > @@ -5,3 +5,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
> >> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
> >> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
> >> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
> >> > +obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
> >> > diff --git a/samples/livepatch/livepatch-cumulative.c b/samples/livepatch/livepatch-cumulative.c
> >> > new file mode 100644
> >> > index 000000000000..ab036439e08c
> >> > --- /dev/null
> >> > +++ b/samples/livepatch/livepatch-cumulative.c
> >> > @@ -0,0 +1,216 @@
> >> > +/*
> >> > + * Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> >> > + *
> >> > + * This program is free software; you can redistribute it and/or
> >> > + * modify it under the terms of the GNU General Public License
> >> > + * as published by the Free Software Foundation; either version 2
> >> > + * of the License, or (at your option) any later version.
> >> > + *
> >> > + * This program is distributed in the hope that it will be useful,
> >> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > + * GNU General Public License for more details.
> >> > + *
> >> > + * You should have received a copy of the GNU General Public License
> >> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> >> > + */
> >>
> >> May be you could use the new SPDX tags instead of this fine but long
> >> legalese? [1]
> >> This would replace ~12 lines of comment by a single line with the same effect.
> >> Thanks!
> >
> > I don't know about that. How come it is perceived as equivalent? I mean,
> > we have a well-established way how to say that a particular source
> > code/file is distributed with GPL license. Well-established means that
> > it's been tested in court AFAIK many times. Even the license itself (found
> > in COPYING file) mentions this as way how to attach the license to a file.
> >
> > Now you want it to be replaced with a tag. Does it say the same? It might.
> > It might not. Do we know? Have you got a court ruling which would say that
> > this is also a way how to attach a license to a file? I doubt it. It may
> > seem trivially clear, but there are no such things in the legal world.
> >
> > Don't make me wrong. I don't like that copyright thingie much. I don't
> > like that you can find even different versions of the text in the kernel
> > source code (and not only there).
> >
> > However I'd prefer to leave at least a note there that the file is still
> > distributed under the terms of GPL found in COPYING file. The tag can be
> > there too, if it makes someone happy.
> >
> > Regards,
> > Miroslav
> >
> >> [1]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> >> --
> >> Philippe
> >>
> >
> 
> To the best of my knowledge, this has been debated in person and on
> list among maintainers and agreed to.
> This has also been reviewed by the LF lawyers. The result of is the
> documentation in [1]
> You are welcomed not to agree of course, but this would make your
> contributions stand out with its legalese boilerplate when we are
> trying to get of it.
> 
> Greg, anything else to add?

Yes, do not add new "boiler plate" license code in new files, otherwise
you will just have to rip them out again later on.  If you have
questions about this, please contact your company's lawyers, as they
know all about this issue and last I heard, agreed with it.

thanks,

greg k-h
