Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AIpwx48ksjRxNxLZR1lL8xZlgb1+LkNdnOvJipH7GBgnywCgybk6dmYMOfauCI4rrAcsrAAd21zr
ARC-Seal: i=1; a=rsa-sha256; t=1522679660; cv=none;
        d=google.com; s=arc-20160816;
        b=Q1oLwLgOgKtb99lnqIZzye2mWj2ukmHyMrvr2PsMaZp0/f3Vnj7b+pbNR9NmodeRf3
         kqgl/t25nG+eomrLIjuuBg1pi79fKnZTq1OaroH+1i8G1Cv5SSiIhVSD0Xt4nAQdWbvF
         e7CeTE28i8xDVILJ2FyGfaQSUL/RzOJpFXo9KJRfkzuj8FthKnDHfjNo1vlGmmirF8j6
         PDW5ohgGd2jwQEnY7FGu4BRNePLhUz5ONWISl8yvYij/rNA1Gk/lXH6Y5FgyY3kWaBbZ
         2hX3C9iocJO8MaTyipVruyHfLk5UhpZOmcQX6d9WHcGJdaupzLim8EJ5Tk1azklTXXSJ
         WHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=75GOtpNDANXT2tnKszDuBp3qWso9/RtxaUNBZGGolkA=;
        b=ZvLi/3+aSbjgUPAGwP7BBb8SWMsjNWuVd6SsinNP21ZXTuqk7S213+Qu6bm4nsl97D
         hYnRyiTDhVgXCnurubZiB7SA9jrAsylD8HHNdncYJdSLVvxAN8uCWabEzprZkFyMVl5D
         scWEpXJUboe+n/JdZlI5Ckof0f+inx06stdMQmUYiOnY1UIDcUK3H6iq+/5KDFVuuraG
         Pa3/ffZvvu8G4cfIFHm0phCcwLA48KEDKabkM3Z2y6okpijHf1BQqkMphcJb9BSHzWpI
         +r3X9W+yq2mSAqpyhKKpcUaGGfqOUIGDToLClZyBe5wsGHHkbSpMBBaLZpuT8TMJ63bO
         n46g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Mon, 2 Apr 2018 15:34:15 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, linux-fsdevel@vger.kernel.org
Subject: Re: general protection fault in kernfs_kill_sb
Message-ID: <20180402143415.GC30522@ZenIV.linux.org.uk>
References: <94eb2c0546040ebb4d0568cc6bdb@google.com>
 <821c80d2-0b55-287a-09aa-d004f4ac4215@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821c80d2-0b55-287a-09aa-d004f4ac4215@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563980561316248?=
X-GMAIL-MSGID: =?utf-8?q?1596645347453081351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 07:40:22PM +0900, Tetsuo Handa wrote:

> That commit assumes that calling kill_sb() from deactivate_locked_super(s)
> without corresponding fill_super() is safe. We have so far crashed with
> rpc_mount() and kernfs_mount_ns(). Is that really safe?

	Consider the case when fill_super() returns an error immediately.
It is exactly the same situation.  And ->kill_sb() *is* called in cases
when fill_super() has failed.  Always had been - it's much less boilerplate
that way.

	deactivate_locked_super() on that failure exit is the least painful
variant, unfortunately.

	Filesystems with ->kill_sb() instances that rely upon something
done between sget() and the first failure exit after it need to be fixed.
And yes, that should've been spotted back then.  Sorry.

Fortunately, we don't have many of those - kill_{block,litter,anon}_super()
are safe and those are the majority.  Looking through the rest uncovers
some bugs; so far all I've seen were already there.  Note that normally
we have something like
static void affs_kill_sb(struct super_block *sb)
{
        struct affs_sb_info *sbi = AFFS_SB(sb);
        kill_block_super(sb);
        if (sbi) {
                affs_free_bitmap(sb);
                affs_brelse(sbi->s_root_bh);
                kfree(sbi->s_prefix);
                mutex_destroy(&sbi->s_bmlock);
                kfree(sbi);
        }
}
which basically does one of the safe ones augmented with something that
takes care *not* to assume that e.g. ->s_fs_info has been allocated.
Not everyone does, though:

jffs2_fill_super():
        c = kzalloc(sizeof(*c), GFP_KERNEL);
        if (!c)
                return -ENOMEM;
in the very beginning.  So we can return from it with NULL ->s_fs_info.
Now, consider
        struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
        if (!(sb->s_flags & MS_RDONLY))
                jffs2_stop_garbage_collect_thread(c);
in jffs2_kill_sb() and
void jffs2_stop_garbage_collect_thread(struct jffs2_sb_info *c)
{
        int wait = 0;
        spin_lock(&c->erase_completion_lock);
        if (c->gc_task) {

IOW, fail that kzalloc() (or, indeed, an allocation in register_shrinker())
and eat an oops.  Always had been there, always hard to hit without
fault injectors and fortunately trivial to fix.

Similar in nfs_kill_super() calling nfs_free_server().
Similar in v9fs_kill_super() with v9fs_session_cancel()/v9fs_session_close() calls.
Similar in hypfs_kill_super(), afs_kill_super(), btrfs_kill_super(), cifs_kill_sb()
(all trivial to fix)

Aha... nfsd_umount() is a new regression.

orangefs: old, trivial to fix.

cgroup_kill_sb(): old, hopefully easy to fix.  Note that kernfs_root_from_sb()
can bloody well return NULL, making cgroup_root_from_kf() oops.  Always had been
there.

AFAICS, after discarding the instances that do the right thing we are left with:
hypfs_kill_super, rdt_kill_sb, v9fs_kill_super, afs_kill_super, btrfs_kill_super,
cifs_kill_sb, jffs2_kill_sb, nfs_kill_super, nfsd_umount, orangefs_kill_sb,
proc_kill_sb, sysfs_kill_sb, cgroup_kill_sb, rpc_kill_sb.

Out of those, nfsd_umount(), proc_kill_sb() and rpc_kill_sb() are regressions.
So are rdt_kill_sb() and sysfs_kill_sb() (victims of the issue you've spotted
in kernfs_kill_sb()).  The rest are old (and I wonder if syzbot had been
catching those - they are also dependent upon a specific allocation failing
at the right time).
