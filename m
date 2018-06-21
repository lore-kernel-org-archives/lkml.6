Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD0CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD83221A8D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD83221A8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeFUUhU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:37:20 -0400
Received: from gateway30.websitewelcome.com ([192.185.192.34]:19050 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932885AbeFUUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:37:18 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id C3481DD25
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:12:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W5wEfOFd4bXuJW5wHfajMK; Thu, 21 Jun 2018 15:12:19 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=43934 helo=[192.168.1.71])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fW5wE-001R1p-DM; Thu, 21 Jun 2018 15:12:14 -0500
Subject: Re: [PATCH] fs/super.c: Fix lock/unlock imbalance in sget_fc
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180620131059.GA28925@embeddedor.com>
 <20180621002358.GS30522@ZenIV.linux.org.uk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <57951f9c-0c49-9066-4739-d117858ce9ca@embeddedor.com>
Date:   Thu, 21 Jun 2018 15:12:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621002358.GS30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fW5wE-001R1p-DM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.250.65.56]:43934
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Certainly, I never checked grab_super. Lesson learned.

Thanks a lot for taking the time to write this master class. I really 
appreciate it. :)

--
Gustavo

> a reproducer), we have some other crap going on and need to investigate
> that, but even in that case, the patch is wrong]
> 
> As for how to investigate that kind of thing...  Look:
> 
> The code in question is
>                          if (fc->user_ns != old->s_user_ns) {
>                                  spin_unlock(&sb_lock);
>                                  if (s) {
>                                          up_write(&s->s_umount);
>                                          destroy_unused_super(s);
>                                  }
>                                  return ERR_PTR(-EBUSY);
>                          }
>                          if (!grab_super(old))
>                                  goto retry;
>                          if (s) {
>                                  up_write(&s->s_umount);
>                                  destroy_unused_super(s);
>                                  s = NULL;
>                          }
>                          return old;
> 
> Your hypothesis is that we can get to that return old; with sb_lock
> held.  That would almost certainly be a bad thing, since elsewhere
> in the same function we have
>          spin_unlock(&sb_lock);
>          get_filesystem(s->s_type);
>          register_shrinker(&s->s_shrink);
>          return s;
> which appears to return an object with sb_lock dropped, with no obvious
> way for a caller to tell one from another.  Even if such a way existed
> (it does, actually), that kind of calling conventions would be highly
> bug-prone.
> 
> The next question is, when would we get to that return old; with
> sb_lock held?  We do, apparently, hold it before the if (fc->...)
> above (again, strictly speaking not proven yet, but that's the
> most likely assumption).  So if grab_super(old) returns true and
> we are holding sb_lock, either we do have a problem, or something
> subtle is going on.
> 
> The obvious next target of examination is grab_super().  Which comes
> with
> /**
>   *      grab_super - acquire an active reference
>   *      @s: reference we are trying to make active
>   *
>   *      Tries to acquire an active reference.  grab_super() is used when we
>   *      had just found a superblock in super_blocks or fs_type->fs_supers
>   *      and want to turn it into a full-blown active reference.  grab_super()
>                                                                   ^^^^^^^^^^^^
>   *      is called with sb_lock held and drops it.  Returns 1 in case of
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   *      success, 0 if we had failed (superblock contents was already dead or
>   *      dying when grab_super() had been called).  Note that this is only
>   *      called for superblocks not in rundown mode (== ones still on ->fs_supers
>   *      of their type), so increment of ->s_count is OK here.
>   */
> and looking for references to sb_lock yields the underscored sentence.  Now,
> if that is true (which is not guaranteed - comments can become stale), we do
> not need to drop sb_lock after the call of grab_super() - it's already been
> dropped by grab_super() itself.
> 
> And looking at the actual code we have
> static int grab_super(struct super_block *s) __releases(sb_lock)
> {
>          s->s_count++;
>          spin_unlock(&sb_lock);
> 	^^^^^^^^^^^^^^^^^^^^^---------- dropped, indeed
>          down_write(&s->s_umount);
>          if ((s->s_flags & SB_BORN) && atomic_inc_not_zero(&s->s_active)) {
>                  put_super(s);
>                  return 1;
>          }
>          up_write(&s->s_umount);
>          put_super(s);
>          return 0;
> }
> ... and not regained, unless put_super() does something fishy.
> static void put_super(struct super_block *sb)
> {
>          spin_lock(&sb_lock);
>          __put_super(sb);
>          spin_unlock(&sb_lock);
> }
> OK, put_super() definitely returns with sb_lock not held, and therefore so does
> grab_super().  In other words, the comment does match the reality and trying
> to drop sb_lock right after the call of grab_super() would be 100% wrong.
> 
> That disproves your hypothesis.  For the sake of completeness, let's finish the
> analysis of sget_fc() wrt sb_lock.
> struct super_block *sget_fc(struct fs_context *fc,
>                              int (*test)(struct super_block *, struct fs_context *),
>                              int (*set)(struct super_block *, struct fs_context *))
> {
>          if (!(fc->sb_flags & SB_KERNMOUNT) &&
>              fc->purpose != FS_CONTEXT_FOR_SUBMOUNT) {
>                  /* Don't allow mounting unless the caller has CAP_SYS_ADMIN
>                   * over the namespace.
>                   */
>                  if (!(fc->fs_type->fs_flags & FS_USERNS_MOUNT) &&
>                      !capable(CAP_SYS_ADMIN))
>                          return ERR_PTR(-EPERM);
>                  else if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN))
>                          return ERR_PTR(-EPERM);
>          }
> retry:
>          spin_lock(&sb_lock);
> 
> OK, we definitely do not want to call that with sb_lock held - doing so would
> either return ERR_PTR(-EPERM) or deadlock.  So the calling conventions include
> "caller is not holding sb_lock".  If so, everything up to retry: should be
> executed without sb_lock held, and subsequent code is with sb_lock held.
>          if (test) {
>                  hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
>                          if (!test(old, fc))
>                                  continue;
> 'test' callback should be callable with sb_lock held.  Note that
> at least in case when it returns false it must not have dropped
> sb_lock - the list we are walking is protected by sb_lock.
>                          if (fc->user_ns != old->s_user_ns) {
>                                  spin_unlock(&sb_lock);
> ... in which case we also want sb_lock not dropped by test() since we
> drop it ourselves.
>                                  if (s) {
>                                          up_write(&s->s_umount);
>                                          destroy_unused_super(s);
> destroy_unused_super() is called without sb_lock here and examination
> shows that it doesn't touch sb_lock itself.
>                                  }
>                                  return ERR_PTR(-EBUSY);
>                          }
> ... and in this case we also want sb_lock not dropped by test() either,
> since grab_super() will drop it.
>                          if (!grab_super(old))
>                                  goto retry;
> we either go back to 'retry:' with sb_lock not held (same as in the
> case of reaching retry: without goto) or coninue to
>                          if (s) {
>                                  up_write(&s->s_umount);
>                                  destroy_unused_super(s);
> same as above, called without sb_lock, doesn't touch it.
>                                  s = NULL;
>                          }
>                          return old;
> ... and we return without sb_lock held.
>                  }
>          }
> 
> Here (after the if (test) body) we do hold sb_lock
>          if (!s) {
>                  spin_unlock(&sb_lock);
> drop and call alloc_super(), which doesn't touch sb_lock
>                  s = alloc_super(fc);
>                  if (!s)
>                          return ERR_PTR(-ENOMEM);
>                  goto retry;
> ... and either return without sb_lock or go back to retry:, with
> the same conditions as on other paths leading there.  Incidentally,
> since alloc_super() very clearly blocks (GFP_USER kzalloc the very
> first thing in there), the calling conventions for sget_fc() include
> not just "must not be holding sb_lock" but "must not be holding any
> spinlock".
>          }
>          s->s_fs_info = fc->s_fs_info;
>          err = set(s, fc);
> OK, so 'set()' is also called under sb_lock.
>          if (err) {
>                  s->s_fs_info = NULL;
>                  spin_unlock(&sb_lock);
> ... and at least in case of error must not drop it, since we'd do that
> ourselves.
>                  up_write(&s->s_umount);
>                  destroy_unused_super(s);
>                  return ERR_PTR(err);
> same as in earlier cases
>          }
>          fc->s_fs_info = NULL;
>          s->s_type = fc->fs_type;
>          strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
>          list_add_tail(&s->s_list, &super_blocks);
>          hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
>          spin_unlock(&sb_lock);
> 
> OK, so 'set()' must not drop sb_lock in any cases.  And from that point
> on sb_lock is not held (neither get_filesystem() nor register_shrinker()
> touch it)
> 
>          get_filesystem(s->s_type);
>          register_shrinker(&s->s_shrink);
>          return s;
> }
> 
> So we arrive to the following:
> 
> * sget_fc() must not be called with any spinlocks (sb_lock included) held.
> * in all cases it returns with sb_lock not held.
> * test() and set() callbacks are always called under sb_lock and should not
> drop it.
> 
> Looking at the shape of that code strengthens the last one to "even
> drop-and-retake is not allowed".  With that kind of loop over hlist, dropping
> and retaking sb_lock in test() might blow up.  And as for set() callback,
> we clearly don't want to create a new instance when an existing one would
> satisfy the test() predicate.  And dropping/retaking sb_lock would've
> allowed another caller to come and insert a new instance while our
> set() has not been holding sb_lock, ending up with just that once we
> return and get to hlist_add_head() there.
> 
> In other words,
> 	* called without any spinlocks held
> 	* returns with no spinlocks held
> 	* callbacks are always called under sb_lock and must not touch it.
> 
> Verifying that callers (and all possible callbacks) satisfy those rules
> is left as an exercise for reader...
> 
