Date: Sat, 28 Apr 2018 08:00:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, Theodore Tso <tytso@mit.edu>,
	stable@kernel.org, Thierry Escande <thierry.escande@linaro.org>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH 4.16 163/196] random: fix crng_ready() test
Message-ID: <20180428060003.GB18371@kroah.com>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180422135112.655853962@linuxfoundation.org>
 <20180427163443.fdsixdsrwwkycuhh@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427163443.fdsixdsrwwkycuhh@xps>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:34:43AM -0500, Dan Rue wrote:
> On Sun, Apr 22, 2018 at 03:53:03PM +0200, Greg Kroah-Hartman wrote:
> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Theodore Ts'o <tytso@mit.edu>
> > 
> > commit 43838a23a05fbd13e47d750d3dfd77001536dd33 upstream.
> > 
> > The crng_init variable has three states:
> > 
> > 0: The CRNG is not initialized at all
> > 1: The CRNG has a small amount of entropy, hopefully good enough for
> >    early-boot, non-cryptographical use cases
> > 2: The CRNG is fully initialized and we are sure it is safe for
> >    cryptographic use cases.
> > 
> > The crng_ready() function should only return true once we are in the
> > last state.  This addresses CVE-2018-1108.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: e192be9d9a30 ("random: replace non-blocking pool...")
> > Cc: stable@kernel.org # 4.8+
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch has caused a regression on 4.16 using kselftest lib/printf.sh
> - specifically, when it runs "/sbin/modprobe test_printf". This
> regression has been detected on arm64 dragonboard 410c (not seen on
> other arm64 or x86_64 devices).
> 
>     /sbin/modprobe test_printf
>     [   22.725551] test_printf: hashing plain 'p' has unexpected format
>     [   22.726031] test_printf: failed 1 out of 236 tests
>     modprobe: ERROR: could not insert 'test_printf': Invalid argument
> 
> This problem has not been seen on 4.9 or 4.14 under the same
> conditions.

Does 4.17-rc2 also fail like this?

You all are testing the -rc releases, right?  :)

I think the random changes that will be in 4.17-rc3 should fix this, and
if so, I'll suck them in here too.  But testing that would be good to
see happen...

thanks,

greg k-h
