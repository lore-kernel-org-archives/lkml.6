Date: Fri, 30 Mar 2018 12:04:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v5] ANDROID: binder: change down_write to down_read
Message-ID: <20180330100407.GB19140@kroah.com>
References: <20180329065424.203172-1-minchan@kernel.org>
 <CADAEsF8Y2CJsuom=9au0-uvZAALvrLTdTnrkxrGjW9C9F6hTVg@mail.gmail.com>
 <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330012921.GB255979@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 10:29:21AM +0900, Minchan Kim wrote:
> Hi Ganesh,
> 
> On Fri, Mar 30, 2018 at 09:21:55AM +0800, Ganesh Mahendran wrote:
> > 2018-03-29 14:54 GMT+08:00 Minchan Kim <minchan@kernel.org>:
> > > binder_update_page_range needs down_write of mmap_sem because
> > > vm_insert_page need to change vma->vm_flags to VM_MIXEDMAP unless
> > > it is set. However, when I profile binder working, it seems
> > > every binder buffers should be mapped in advance by binder_mmap.
> > > It means we could set VM_MIXEDMAP in binder_mmap time which is
> > > already hold a mmap_sem as down_write so binder_update_page_range
> > > doesn't need to hold a mmap_sem as down_write.
> > >
> > > Android suffers from mmap_sem contention so let's reduce mmap_sem
> > > down_write.
> > 
> > Hi, Minchan:
> > 
> > It seems there is performance regression of this patch.
> 
> You mean "This patch aims for solving performance regression" not "This patch
> makes performance regression"?
> 
> > 
> > Do you have some test result of android app launch time or binderThroughput?
> 
> Unfortunately, I don't have any number. The goal is to reduce the number of
> call mmap_sem as write-side lock because it makes priority inversion of threads
> easily and that's one of clear part I spot that we don't need write-side lock.

Please always run the binderThroughput tests when making binder changes
(there is a binder test suite in the CTS Android tests), as that ensures
that you are not causing performance regressions as well as just normal
bug regressions :)

thanks,

greg k-h
