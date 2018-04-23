Date: Mon, 23 Apr 2018 12:37:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+db48ce201b524603190a@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	weiping zhang <zhangweiping@didichuxing.com>,
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in debugfs_remove (2)
Message-ID: <20180423103716.GA16081@kroah.com>
References: <000000000000fbda89056a818f20@google.com>
 <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 07:34:45PM +0900, Tetsuo Handa wrote:
> >From be88e559ec13f49b1c3aec2457c14c70f6b1926a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 23 Apr 2018 11:21:03 +0900
> Subject: [PATCH] bdi: Fix use after free bug in debugfs_remove()
> 
> syzbot is reporting use after free bug in debugfs_remove() [1].
> 
> This is because fault injection made memory allocation for
> debugfs_create_file() from bdi_debug_register() from bdi_register_va()
> fail and continued with setting WB_registered. But when debugfs_remove()
> is called from debugfs_remove(bdi->debug_dir) from bdi_debug_unregister()
>  from bdi_unregister() from release_bdi() because WB_registered was set
> by bdi_register_va(), IS_ERR_OR_NULL(bdi->debug_dir) == false despite
> debugfs_remove(bdi->debug_dir) was already called from bdi_register_va().
> 
> Fix this by making IS_ERR_OR_NULL(bdi->debug_dir) == true.
> 
> [1] https://syzkaller.appspot.com/bug?id=5ab4efd91a96dcea9b68104f159adf4af2a6dfc1
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+049cb4ae097049dac137@syzkaller.appspotmail.com>
> Fixes: 97f07697932e6faf ("bdi: convert bdi_debug_register to int")
> Cc: weiping zhang <zhangweiping@didichuxing.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
