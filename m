Date: Tue, 20 Mar 2018 08:05:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, devel@driverdev.osuosl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	arve@android.com,
	syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com,
	ben@decadent.org.uk
Subject: Re: [PATCH] staging: android: ashmem: Fix possible deadlock in
 ashmem_ioctl
Message-ID: <20180320070500.GA3268@kroah.com>
References: <1519801162-52182-1-git-send-email-xieyisheng1@huawei.com>
 <CAEi0qN=BTpY0hZQe=r_dZkmX1K0MaHQOw1O3RoXF=xVygCa8yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEi0qN=BTpY0hZQe=r_dZkmX1K0MaHQOw1O3RoXF=xVygCa8yQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 03:16:51PM -0700, Joel Fernandes (Google) wrote:
> On Tue, Feb 27, 2018 at 10:59 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> > ashmem_mutex may create a chain of dependencies like:
> >
> > CPU0                                    CPU1
> >  mmap syscall                           ioctl syscall
> >  -> mmap_sem (acquired)                 -> ashmem_ioctl
> >  -> ashmem_mmap                            -> ashmem_mutex (acquired)
> >     -> ashmem_mutex (try to acquire)       -> copy_from_user
> >                                               -> mmap_sem (try to acquire)
> >
> > There is a lock odering problem between mmap_sem and ashmem_mutex causing
> > a lockdep splat[1] during a syzcaller test. This patch fixes the problem
> > by move copy_from_user out of ashmem_mutex.
> >
> > [1] https://www.spinics.net/lists/kernel/msg2733200.html
> >
> > Fixes: ce8a3a9e76d0 (staging: android: ashmem: Fix a race condition in pin ioctls)
> > Reported-by: syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com
> > Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> 
> Greg,
> Could you take this patch for the stable trees? I do see it in staging
> already. I couldn't find it in stable so wanted to bring it to your
> attention. If you already aware of it, please ignore my note.

Ah, I didn't realize this needed to be added to the stable trees, I'll
queue it up after this current round of releases happen in a few days.

thanks,

greg k-h
