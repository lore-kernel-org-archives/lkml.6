Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA642C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B0C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B0C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbeGXGWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:22:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39052 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeGXGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:22:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fhphO-0000ao-GU; Tue, 24 Jul 2018 05:17:26 +0000
Date:   Tue, 24 Jul 2018 06:17:26 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: Re: KASAN: use-after-free Read in link_path_walk
Message-ID: <20180724051726.GH30522@ZenIV.linux.org.uk>
References: <20180724034542.GA19283@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724034542.GA19283@dragonet>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:45:42PM +0900, Dae R. Jeong wrote:
> Diagnosis:
> We think that it is possible that link_path_walk() dereferences a
> freed pointer when cleanup_mnt() is executed between path_init() and
> link_path_walk().
> 
> Since I'm not an expert on a file system and don't fully understand
> the crash, please see a executed program and a crash log below in
> case that my understanding is wrong.
> 
> 
> Executed Program:
> Thread0                     Thread1
> mkdir("./file0")
>      |--------------------------|
>      |                      mount("./file0", "./file0", "devpts", 0x0, "")
>      |                          |
> openat(AT_FDCWD,            chroot("./file0")
> "/dev/vcs", 0x200, 0x0)     umount("./file0", 0x2)
> 
> openat(), chroot(), umount() syscalls are executed after mount() syscall.
> We think a race occurs between openat() and chroot() because RaceFuzzer
> executed openat() and chroot() concurrently.
> 
> 
> (Possible) Thread interleaving:
> CPU0 (path_openat)                      CPU1 (cleanup_mnt)
> =====                                   =====
> s = path_init(nd, flags);
> if (IS_ERR(s)) {
>           put_filp(file);
>                   return ERR_CAST(s);
> }
> 
>                                         deactivate_super(mnt->mnt.mnt_sb);
> 
> while (!(error = link_path_walk(s, nd)) &&
> 
> // (in link_path_walk())
> struct dentry *parent = nd->path.dentry;
> nd->flags &= ~LOOKUP_JUMPED;
> if (unlikely(parent->d_flags & DCACHE_OP_HASH)) { // UAF occured

Do we have LOOKUP_RCU in nd->flags at that point?  And how in hell
did we get that dentry there?  In LOOKUP_RCU mode no freeing should
be happening until after we call rcu_read_unlock(), unless the final
dput() has happened before rcu_read_lock().  In which case we shouldn't
have gotten to that dentry in the first place.  And in non-LOOKUP_RCU
mode we are bloody well holding references to everything (vfsmount
and dentry alike), so that deactivate_super() shouldn't have been
called as long as we are holding that reference.

Details, please.  Ideally - how to reproduce that.
