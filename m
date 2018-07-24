Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F143C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A4220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A4220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGXGeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:34:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39254 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGXGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:34:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fhpt3-0000zK-6p; Tue, 24 Jul 2018 05:29:29 +0000
Date:   Tue, 24 Jul 2018 06:29:29 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: Re: KASAN: use-after-free Read in link_path_walk
Message-ID: <20180724052929.GI30522@ZenIV.linux.org.uk>
References: <20180724034542.GA19283@dragonet>
 <20180724051726.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724051726.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 06:17:26AM +0100, Al Viro wrote:
> On Tue, Jul 24, 2018 at 12:45:42PM +0900, Dae R. Jeong wrote:
> > Diagnosis:
> > We think that it is possible that link_path_walk() dereferences a
> > freed pointer when cleanup_mnt() is executed between path_init() and
> > link_path_walk().
> > 
> > Since I'm not an expert on a file system and don't fully understand
> > the crash, please see a executed program and a crash log below in
> > case that my understanding is wrong.
> > 
> > 
> > Executed Program:
> > Thread0                     Thread1
> > mkdir("./file0")
> >      |--------------------------|
> >      |                      mount("./file0", "./file0", "devpts", 0x0, "")
> >      |                          |
> > openat(AT_FDCWD,            chroot("./file0")
> > "/dev/vcs", 0x200, 0x0)     umount("./file0", 0x2)
> > 
> > openat(), chroot(), umount() syscalls are executed after mount() syscall.
> > We think a race occurs between openat() and chroot() because RaceFuzzer
> > executed openat() and chroot() concurrently.
> > 
> > 
> > (Possible) Thread interleaving:
> > CPU0 (path_openat)                      CPU1 (cleanup_mnt)

Wait a bloody minute.  Where does cleanup_mnt() come from in that thing?
You are doing lazy-umount of the thing you've chrooted into; if it ends
up with zero refcount on that mount, we are already in deep, deep trouble,
races with open() on not.  Simply following that with stat / (in thread 1,
without thread0 at all) would end up accessing the same vfsmount.  And
if it's been freed, we are well and truly fucked, race or no race.

I really want details.  *Is* cleanup_mnt() called by thread 1 in your
reproducer before the use-after-free hits?  And what's the root of
thread 0 at that point?
