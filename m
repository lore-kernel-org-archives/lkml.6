Date: Wed, 25 Apr 2018 15:00:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com, Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	Vegard Nossum <vegard.nossum@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tty: Use __GFP_NOFAIL for tty_ldisc_get()
Message-ID: <20180425130039.GA11588@kroah.com>
References: <0000000000003471d40568c520bc@google.com>
 <172ab7af-23ac-0989-c132-e474a0ff11b6@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172ab7af-23ac-0989-c132-e474a0ff11b6@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 08:12:31PM +0900, Tetsuo Handa wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> syzbot is reporting crashes triggered by memory allocation fault injection
> at tty_ldisc_get() [1]. As an attempt to handle OOM in a graceful way, we
> have tried commit 5362544bebe85071 ("tty: don't panic on OOM in
> tty_set_ldisc()"). But we reverted that attempt by commit a8983d01f9b7d600
> ("Revert "tty: don't panic on OOM in tty_set_ldisc()"") due to reproducible
> crash. We should spend resource for finding and fixing race condition bugs
> rather than complicate error paths for 2 * sizeof(void *) bytes allocation
> failure.
> 
> [1] https://syzkaller.appspot.com/bug?id=489d33fa386453859ead58ff5171d43772b13aa3
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+40b7287c2dc987c48c81@syzkaller.appspotmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vegard Nossum <vegard.nossum@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/tty/tty_ldisc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 050f4d6..971a37e 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -176,12 +176,11 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
>  			return ERR_CAST(ldops);
>  	}
>  
> -	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL);
> -	if (ld == NULL) {
> -		put_ldops(ldops);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> +	/*
> +	 * There is no way to handle allocation failure of only 16 bytes.
> +	 * Let's simplify error handling and save more memory.
> +	 */
> +	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL | __GFP_NOFAIL);
>  	ld->ops = ldops;
>  	ld->tty = tty;
>  

Yes, this is the thing to do, thanks, I'll go queue this up now.

greg k-h
