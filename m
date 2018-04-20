Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524192213; cv=none;
        d=google.com; s=arc-20160816;
        b=xhilAXUmMDTWmv8WSh/ckALD9l+NDLzM+AgVXyhad32EI9808X9BVTp1MwE8heGE8J
         KpJ8GTW36ne1xyC0BJ/umundhW2fV0I9BkuJVifJL/wR8bVJP/fbWRCEzNnV79yOa2I0
         tyO3TQc1riq9fivHMgSEzYJbUoQVvFgG2Ft5cCnG6OHXKXrcg19Ss6ALIunff3q3cnvN
         cq3hwvmtUWmuDvj372e5+dbSAcQ3cp/VLj/utcIHZ6LbsShUlkbPkdr0ecUiZEEtoJfc
         tkuRTBlOwBhEbgQ1p1d8iSndqDvkPq2xopYhbLGSdK5y9yIm4jwu9uB3Y+r3JpfZN9wO
         SiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ItY1Br28iKL+t9Vm/HOxL5o+TI22ywFwMKncDz+yJv8=;
        b=r0ZuQAyzzsgcqKBu61DMCg/GUg1YsvvutRmkX/jnc+P2/ufh5telbh4UR3H+XBdt4V
         mrPBwmaGa5XfyMGs4KPSOb9t8YaWHKkJR9AjY+bfIL18BCqdlgH2647z+o6xCItZPiK+
         khGW9MpYE9VGYC+HSJwr+ifiqMHAN8ksa+gwIVgrYMBp/8mgRjV8E71K/SbjZkPBSzHb
         X2HdHk2wRy/9hCjTOnZCEhumbcfDZcEXCxEFwsD6KqRbM58SvdM5VRcZr5TwmDlMPVK3
         afsZbbOHDJuYCjg9OYdxB3zePdPGyQ3OGFxDdXGE9D+mNCHo7GGZqPhE26skbg3zCCjS
         o8WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mgwML+Qw;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mgwML+Qw;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+o9ckzfFnyQPJJnR0GWhhis/0wIaRVmoiUbveLJ8aw+mTfRCq9rOgM6O2LfuiwlYzTH7cKnw==
Date: Thu, 19 Apr 2018 19:44:40 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, linux-fsdevel@vger.kernel.org
Subject: Re: general protection fault in kernfs_kill_sb
Message-ID: <20180420024440.GB686@sol.localdomain>
References: <94eb2c0546040ebb4d0568cc6bdb@google.com>
 <821c80d2-0b55-287a-09aa-d004f4ac4215@I-love.SAKURA.ne.jp>
 <20180402143415.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402143415.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563980561316248?=
X-GMAIL-MSGID: =?utf-8?q?1598231374537994322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 03:34:15PM +0100, Al Viro wrote:
> On Mon, Apr 02, 2018 at 07:40:22PM +0900, Tetsuo Handa wrote:
> 
> > That commit assumes that calling kill_sb() from deactivate_locked_super(s)
> > without corresponding fill_super() is safe. We have so far crashed with
> > rpc_mount() and kernfs_mount_ns(). Is that really safe?
> 
> 	Consider the case when fill_super() returns an error immediately.
> It is exactly the same situation.  And ->kill_sb() *is* called in cases
> when fill_super() has failed.  Always had been - it's much less boilerplate
> that way.
> 
> 	deactivate_locked_super() on that failure exit is the least painful
> variant, unfortunately.
> 
> 	Filesystems with ->kill_sb() instances that rely upon something
> done between sget() and the first failure exit after it need to be fixed.
> And yes, that should've been spotted back then.  Sorry.
> 
> Fortunately, we don't have many of those - kill_{block,litter,anon}_super()
> are safe and those are the majority.  Looking through the rest uncovers
> some bugs; so far all I've seen were already there.  Note that normally
> we have something like
> static void affs_kill_sb(struct super_block *sb)
> {
>         struct affs_sb_info *sbi = AFFS_SB(sb);
>         kill_block_super(sb);
>         if (sbi) {
>                 affs_free_bitmap(sb);
>                 affs_brelse(sbi->s_root_bh);
>                 kfree(sbi->s_prefix);
>                 mutex_destroy(&sbi->s_bmlock);
>                 kfree(sbi);
>         }
> }
> which basically does one of the safe ones augmented with something that
> takes care *not* to assume that e.g. ->s_fs_info has been allocated.
> Not everyone does, though:
> 
> jffs2_fill_super():
>         c = kzalloc(sizeof(*c), GFP_KERNEL);
>         if (!c)
>                 return -ENOMEM;
> in the very beginning.  So we can return from it with NULL ->s_fs_info.
> Now, consider
>         struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
>         if (!(sb->s_flags & MS_RDONLY))
>                 jffs2_stop_garbage_collect_thread(c);
> in jffs2_kill_sb() and
> void jffs2_stop_garbage_collect_thread(struct jffs2_sb_info *c)
> {
>         int wait = 0;
>         spin_lock(&c->erase_completion_lock);
>         if (c->gc_task) {
> 
> IOW, fail that kzalloc() (or, indeed, an allocation in register_shrinker())
> and eat an oops.  Always had been there, always hard to hit without
> fault injectors and fortunately trivial to fix.
> 
> Similar in nfs_kill_super() calling nfs_free_server().
> Similar in v9fs_kill_super() with v9fs_session_cancel()/v9fs_session_close() calls.
> Similar in hypfs_kill_super(), afs_kill_super(), btrfs_kill_super(), cifs_kill_sb()
> (all trivial to fix)
> 
> Aha... nfsd_umount() is a new regression.
> 
> orangefs: old, trivial to fix.
> 
> cgroup_kill_sb(): old, hopefully easy to fix.  Note that kernfs_root_from_sb()
> can bloody well return NULL, making cgroup_root_from_kf() oops.  Always had been
> there.
> 
> AFAICS, after discarding the instances that do the right thing we are left with:
> hypfs_kill_super, rdt_kill_sb, v9fs_kill_super, afs_kill_super, btrfs_kill_super,
> cifs_kill_sb, jffs2_kill_sb, nfs_kill_super, nfsd_umount, orangefs_kill_sb,
> proc_kill_sb, sysfs_kill_sb, cgroup_kill_sb, rpc_kill_sb.
> 
> Out of those, nfsd_umount(), proc_kill_sb() and rpc_kill_sb() are regressions.
> So are rdt_kill_sb() and sysfs_kill_sb() (victims of the issue you've spotted
> in kernfs_kill_sb()).  The rest are old (and I wonder if syzbot had been
> catching those - they are also dependent upon a specific allocation failing
> at the right time).
> 

Fix for the kernfs bug is now queued in vfs/for-linus:

#syz fix: kernfs: deal with early sget() failures

syzkaller just recently (3 weeks ago) gained the ability to mount filesystem
images, so that's the main reason for the increase in filesystem bug reports.
Each time syzkaller is updated to cover more code, bugs are found.

- Eric
