Date: Wed, 28 Mar 2018 08:16:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Manoj Gupta <manojgupta@chromium.org>
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328061616.GA8212@kroah.com>
References: <20180327235553.210165-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327235553.210165-1-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 04:55:53PM -0700, Matthias Kaehlcke wrote:
> debugfs_real_fops() returns a NULL pointer when it is invoked without a
> prior call to debugfs_file_get(). In code paths including this call it
> is not strictly necessary to check the return value of
> debugfs_real_fops(). However clang inlines debugfs_real_fops(), detects
> the invalid dereferencing of the NULL pointer and drops the code path.

Wait, what?  Why would it do that, because it thinks dereferencing NULL
is undefined behaviour and it can just do whatever it wants to?

That feels crazy, as for these calls we "know" it will never be NULL
because the previous call to debugfs_file_get() will always ensure it
will be correct.

So this is a case of the compiler trying to be smarter than it really
is, and getting things totally wrong :(

Has anyone reported this to the clang developers?

Papering over compiler foolishness is not something I like to do in
kernel code if at all possible...

thanks,

greg k-h
