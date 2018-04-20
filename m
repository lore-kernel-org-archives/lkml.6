Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524246916; cv=none;
        d=google.com; s=arc-20160816;
        b=HXs3qaYOuVr/irV565tW4RDZ4H5gmQoMf8d62p2woIHOgAvj3kqbkJs1NWWy2qdIdV
         d06NLoa96LgBPrAj1GkzHt1rmgOzVn+UFF6Bs0zoQae5ZX9Z9CduZiHp6FFRlbBDTIWP
         G21MAuP+EcMGL+s0S1LxEeqJjJhVPYIJ/axL95lSVFjHc9yHq7lj91waioZLY38oYK0H
         bqe068JiCp6pyZnevMMBwapa2tgUA0fqB8QwaHfNU9GVMsQ+sGFLDQSVsDRnfhNW2Qjl
         aYnIA+Tzxc7ORveZL64zmZu3YBOUpYOU2Y0Nu+qXVHK/IEdTtIcM6zkn6+Jh8M3thXVX
         AQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=SVfY8HyUoKT/4MrGfs2oI1nrvlnSDxFdfFAus6EkrCg=;
        b=EUGw4SyKm3s6W7oT4K0LxgWolu7X8qMs50Dd8v8wqkty7dZixjlviFkFc7kfJ/6m3R
         AV1NdyZpOzKsTFyEuOCiuh2EDjF/NZcXMZQoNfGtuVqnQrO+XLcv7uAED9QUz7D0BjzE
         1V0/+VgJGjsWu0H2SQFJ4552JBRKD4EpUD7LZixcoAcTsU/2yWuHqgkOyYzvP+Rf+fRk
         TJc1x5vACMhiTzqfN54i2ONsNCIDzzmZh1tkLdy2zdtY7IOuM4ktge8EpzbLRmMlUlFT
         OJE1HeL1MpAds/X5sLpBbuWqITFqJKgUDcO+gYuQ8sMBycRkNGzAYMzDLmgL3VcttFEe
         bo2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sR7VGGx/;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sR7VGGx/;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+aBNrK0IgHQW6y4HEU9Z+fl2+Afn/upVNdCYAo87WbskhzHxdw/t3AQcXaxC0MXcBSNzCSMQ==
Date: Fri, 20 Apr 2018 10:55:13 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	syzbot <syzbot+151de3f2be6b40ac8026@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de, linux-fsdevel@vger.kernel.org
Subject: Re: general protection fault in kernfs_kill_sb
Message-ID: <20180420175513.GA16820@gmail.com>
References: <20180420024440.GB686@sol.localdomain>
 <20180420033450.GC686@sol.localdomain>
 <201804200529.w3K5TdvM009951@www262.sakura.ne.jp>
 <20180420073158.GS17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420073158.GS17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596563980561316248?=
X-GMAIL-MSGID: =?utf-8?q?1598288734339771538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 09:31:58AM +0200, Michal Hocko wrote:
> On Fri 20-04-18 14:29:39, Tetsuo Handa wrote:
> > Eric Biggers wrote:
> > > But, there is still a related bug: when mounting sysfs, if register_shrinker()
> > > fails in sget_userns(), then kernfs_kill_sb() gets called, which frees the
> > > 'struct kernfs_super_info'.  But, the 'struct kernfs_super_info' is also freed
> > > in kernfs_mount_ns() by:
> > > 
> > >         sb = sget_userns(fs_type, kernfs_test_super, kernfs_set_super, flags,
> > >                          &init_user_ns, info);
> > >         if (IS_ERR(sb) || sb->s_fs_info != info)
> > >                 kfree(info);
> > >         if (IS_ERR(sb))
> > >                 return ERR_CAST(sb);
> > > 
> > > I guess the problem is that sget_userns() shouldn't take ownership of the 'info'
> > > if it returns an error -- but, it actually does if register_shrinker() fails,
> > > resulting in a double free.
> > > 
> > > Here is a reproducer and the KASAN splat.  This is on Linus' tree (87ef12027b9b)
> > > with vfs/for-linus merged in.
> > 
> > I'm waiting for response from Michal Hocko regarding
> > http://lkml.kernel.org/r/201804111909.EGC64586.QSFLFJFOVHOOtM@I-love.SAKURA.ne.jp .
> 
> I didn't plan to respond util all the Al's concerns with the existing
> scheme are resolved. This is not an urgent thing to fix so better fix it
> properly. Your API change is kinda ugly so it would be preferable to do
> it properly as suggested by Al. Maybe that will be more work but my
> understanding is that the resulting code would be better. If that is not
> the case then I do not really have any fundamental objection to your
> patch except it is ugly.

Okay, the fix was merged already as commit 8e04944f0ea8b8 ("mm,vmscan: Allow
preallocating memory for register_shrinker().").  Thanks Tetsuo!

- Eric
