Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3638CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE3620676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE3620676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeIYXny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:43:54 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:50414 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIYXnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:43:53 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1g4rEt-00051V-0g; Tue, 25 Sep 2018 19:35:11 +0200
Date:   Tue, 25 Sep 2018 19:35:11 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925173510.273hshp4iapd6dcd@angband.pl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180925154627.GC2933@thunk.org>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:46:27AM -0400, Theodore Y. Ts'o wrote:
> P.S.  One thought: it might be cool if there was some way for
> userspace applications to mark files with "nuke if not closed" flag,
> such that if the system crashes, the file systems would automatically
> unlink the file after a reboot or if the process was killed or exits
> without an explicit close(2).  For networked/remote file systems that
> supported this flag, after the client comes back up after a reboot, it
> could notify the server that all files created previously from that
> client should be unlinked.
> 
> Unlike O_TMPFILE, this would require file system changes to support,
> so maybe it's not worth having something which automatically cleans up
> files that were in the middle of being written at the time of a system
> crash.

Isn't this what the snippet for O_TMPFILE in "man 2 open" does?:

                  char path[PATH_MAX];
                  fd = open("/path/to/dir", O_TMPFILE | O_RDWR,
                                          S_IRUSR | S_IWUSR);

                  /* File I/O on 'fd'... */

                  snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
                  linkat(AT_FDCWD, path, AT_FDCWD, "/path/for/file",
                                          AT_SYMLINK_FOLLOW);


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 10 people enter a bar:
⣾⠁⢰⠒⠀⣿⡁ • 1 who understands binary,
⢿⡄⠘⠷⠚⠋⠀ • 1 who doesn't,
⠈⠳⣄⠀⠀⠀⠀ • and E who prefer to write it as hex.
