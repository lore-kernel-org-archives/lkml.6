Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeDIKKO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:10:14 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:37270 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeDIKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:10:12 -0400
X-Google-Smtp-Source: AIpwx4+LoMiBPtspHGREucKrB7YnPS/KSUMuXtDaHBgWUE3q5sk30FO6URVMV6gD9jixKkI8XVfxgQ==
Date: Mon, 9 Apr 2018 12:10:09 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: Race-free unlinking of directory entries
Message-ID: <20180409101009.6kxd47jeowef7wt2@pali>
References: <20171220191844.wnb3bgkpreg2tjia@pali>
 <20180409074241.2ibvhh3g5lzxnt4g@pali>
 <20180409095919.GA9621@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409095919.GA9621@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 April 2018 02:59:19 Christoph Hellwig wrote:
> On Mon, Apr 09, 2018 at 09:42:41AM +0200, Pali Rohár wrote:
> > Hi! I would like to remind this my older email about race free
> > unlinking. Is there any plan to provide such support?
> 
> Given that in Linux we know which directory entry a given fd refers to,
> we shouldn't even need a new syscall, but simply support the
> AT_EMPTY_PATH flag for funlinkat.

I do not think it is enough, specially in cases when hard links are in
use. Example:

fd = open("/a")
link("/a", "/b")
link("/a", "/c")
unlink("/a")

And now I want to call funlink for "fd". Which file should be unlinked?
"/b" or "/c" or none or both?

Another example:

fd = open("/a")
link("/a", "/b")
unlink("/a")

Calling funlink for fd should unlink "/b" or it should fail?

And another example:

fd = open("/a")
rename("/a", "/b")

What should funlink do for fd now?

Note that there is difference which symlink is shown in /proc/<pid>/fd
between last two examples -- even those two examples results in the same
state (if there is no race). For last example <fd> points to "/b", for
previous <fd> points to "/a (deleted)".

-- 
Pali Rohár
pali.rohar@gmail.com
