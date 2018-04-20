Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AIpwx4+ylgTVO0DsFE2+fPRP4vCQlsVVYTE8QE6WyLD7FsW3x9fK5Zghs+H3xrdhhykm1Wrg2XOh
ARC-Seal: i=1; a=rsa-sha256; t=1524209521; cv=none;
        d=google.com; s=arc-20160816;
        b=aYyR207vAEQKZ87/KUh+PXG5duzKCJK0hFxnWRdF4n6+kXMqpAWodckhYElECVj1GV
         lr98kD1H8UCiGK7g3YYlR4ocreL3lQkbJeQJk+fsHEtzlDXnLg5ROSiIkIlaEEu5l/Su
         15q5L3LHMj58GazqhwV9wYbDyvqpI0aT1bdIyCJb3aPczCKbeLca8YFuhEzkKKz/RdLK
         iIw+BzWJwZQQqCfGU7hoOUMY3FMWHhsOMnyEI/JuC+s+X3wx24yy3vsM1z3dV1Dpc5ZM
         asMJATPFZSMR9UYxb+ueLYcMn5v13YBXtrubWe330TvDX3NiBbE8sizLUmAhSYdjLQJD
         tFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NOhLn90SSLmIvnjfyeAtYtowN0zsMJOmNl7BPIYrNoo=;
        b=MqhzZNbOWgEHjwO/2/oTOCwNytZkNmXETy92zCt/iVwJfjiKCtGNRFXSwVT9ekDYPu
         JWzCcuXoect0w+X+FUZ05pEIhap13T6AsBt2KTbT8pyxwpuri2YLazil100BKkU9ceSF
         +myJVaOByAoX1dYP8X6LG8qQN/G4ykIvIhsuATJui8OuZOx6WYLnD8PNKg8kFh47KA2M
         IC4/kNRlTQ+frX8LwjT2a+IVLvbunhxSEYN4rPLsYhfcAJLZFy2Izac2SSpnPzLTyeSo
         EwXooatOgK1TBrewdj4bVgYJ0pY1Q9MetqPSudXRealrZlLdZjRzY/cBxV+WARR9egjG
         SquQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Fri, 20 Apr 2018 09:31:58 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Eric Biggers <ebiggers3@gmail.com>, Al Viro <viro@ZenIV.linux.org.uk>,
	syzbot <syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, linux-fsdevel@vger.kernel.org
Subject: Re: general protection fault in kernfs_kill_sb
Message-ID: <20180420073158.GS17484@dhcp22.suse.cz>
References: <20180420024440.GB686@sol.localdomain>
 <20180420033450.GC686@sol.localdomain>
 <201804200529.w3K5TdvM009951@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804200529.w3K5TdvM009951@www262.sakura.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563980561316248?=
X-GMAIL-MSGID: =?utf-8?q?1598249523757411449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 20-04-18 14:29:39, Tetsuo Handa wrote:
> Eric Biggers wrote:
> > But, there is still a related bug: when mounting sysfs, if register_shrinker()
> > fails in sget_userns(), then kernfs_kill_sb() gets called, which frees the
> > 'struct kernfs_super_info'.  But, the 'struct kernfs_super_info' is also freed
> > in kernfs_mount_ns() by:
> > 
> >         sb = sget_userns(fs_type, kernfs_test_super, kernfs_set_super, flags,
> >                          &init_user_ns, info);
> >         if (IS_ERR(sb) || sb->s_fs_info != info)
> >                 kfree(info);
> >         if (IS_ERR(sb))
> >                 return ERR_CAST(sb);
> > 
> > I guess the problem is that sget_userns() shouldn't take ownership of the 'info'
> > if it returns an error -- but, it actually does if register_shrinker() fails,
> > resulting in a double free.
> > 
> > Here is a reproducer and the KASAN splat.  This is on Linus' tree (87ef12027b9b)
> > with vfs/for-linus merged in.
> 
> I'm waiting for response from Michal Hocko regarding
> http://lkml.kernel.org/r/201804111909.EGC64586.QSFLFJFOVHOOtM@I-love.SAKURA.ne.jp .

I didn't plan to respond util all the Al's concerns with the existing
scheme are resolved. This is not an urgent thing to fix so better fix it
properly. Your API change is kinda ugly so it would be preferable to do
it properly as suggested by Al. Maybe that will be more work but my
understanding is that the resulting code would be better. If that is not
the case then I do not really have any fundamental objection to your
patch except it is ugly.
-- 
Michal Hocko
SUSE Labs
