Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDIHmr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:42:47 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35523 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeDIHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:42:45 -0400
X-Google-Smtp-Source: AIpwx49J0W6VdiwwhtHbjkke6WDbUoKdqChcOYhF7catGS/XVl2gRNRd0MPpxGcCZG7SMtfYilwzzA==
Date: Mon, 9 Apr 2018 09:42:41 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: Race-free unlinking of directory entries
Message-ID: <20180409074241.2ibvhh3g5lzxnt4g@pali>
References: <20171220191844.wnb3bgkpreg2tjia@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171220191844.wnb3bgkpreg2tjia@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I would like to remind this my older email about race free
unlinking. Is there any plan to provide such support?

On Wednesday 20 December 2017 20:18:44 Pali Rohár wrote:
> Hi!
> 
> Linux kernel currently does not provide any race-free way for calling
> unlink() syscall on file entry which points to opened file descriptor.
> 
> On the other hand Linux kernel already provides race-free way for
> creating file entry by linkat() syscall with AT_EMPTY_PATH or
> AT_SYMLINK_FOLLOW flags. unlinkat() does not.
> 
> There was already discussion about unlink issue in bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=93441
> 
> Because file descriptor describes inode number which can be stored in
> more directories as hard links, there is a proposed funlinkat() syscall
> with following API:
> 
> int funlinkat(int fd, int dirfd, const char *pathname, int flags);
> 
> It should atomically check if file descriptor fd and pathname (according
> to dirfd) are same, and if then just unlinkat(dirfd, pathname, flags).
> If are not same, throw error.
> 
> What userspace application basically needs:
> 
> Open file, test it stat (or probably content) and based on test result
> decide if file needs to be removed or not.
> 
> Or delete a file behind a file descriptor opened with O_PATH.
> 
> Both cases are currently not possible without introducing race condition
> between open/stat and unlink. Between those two calls, some other
> process can exchange files.

-- 
Pali Rohár
pali.rohar@gmail.com
