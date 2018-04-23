Date: Mon, 23 Apr 2018 09:15:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	stable@kernel.org, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180423071520.GC28186@kroah.com>
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135213.491879480@linuxfoundation.org>
 <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 11:28:52PM +0100, Ben Hutchings wrote:
> On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Theodore Ts'o <tytso@mit.edu>
> > 
> > commit 8ef35c866f8862df074a49a93b0309725812dea8 upstream.
> > 
> > Until the primary_crng is fully initialized, don't initialize the NUMA
> > crng nodes.  Otherwise users of /dev/urandom on NUMA systems before
> > the CRNG is fully initialized can get very bad quality randomness.  Of
> > course everyone should move to getrandom(2) where this won't be an
> > issue, but there's a lot of legacy code out there.  This related to
> > CVE-2018-1108.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly...")
> > Cc: stable@kernel.org # 4.8+
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> In 4.9 (and probably older branches too) this leads to a deadlock:
> 
> crng_reseed(primary_crng, ...) takes primary_crng.lock
> -> numa_rcng_init()
>    -> crng_initialize()
>       -> get_random_bytes()
>          -> extract_crng()
>             -> _extract_crng(primary_crng, ...) tries to take primary_crng.lock
> 
> I think this can be fixed by backporting commit 4a072c71f49b
> "random: silence compiler warnings and fix race" but I'm not sure
> whether that depends on other changes.

According to Tetsuo Handa, it's also causing problems in mainline :(

Ted, any thoughts as to what to do here?

thanks,

greg k-h
