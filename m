Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDIKf7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:35:59 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:40578 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeDIKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:35:56 -0400
X-Google-Smtp-Source: AIpwx4/xUzVNsOtvnJh3d0Yy2dZ4TytgKvJ1vg7WhW5zUHWMH6nA8rJ27QjKBlIBTuK6ir9+ZE6YQA==
Date: Mon, 9 Apr 2018 12:35:54 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: Race-free unlinking of directory entries
Message-ID: <20180409103554.64flwtm5xamhrkkp@pali>
References: <20171220191844.wnb3bgkpreg2tjia@pali>
 <20180409074241.2ibvhh3g5lzxnt4g@pali>
 <20180409095919.GA9621@infradead.org>
 <20180409101009.6kxd47jeowef7wt2@pali>
 <20180409102414.GA23471@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409102414.GA23471@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 April 2018 03:24:14 Christoph Hellwig wrote:
> On Mon, Apr 09, 2018 at 12:10:09PM +0200, Pali Rohár wrote:
> > Another example:
> > 
> > fd = open("/a")
> > link("/a", "/b")
> > unlink("/a")
> > 
> > Calling funlink for fd should unlink "/b" or it should fail?
> 
> It should fail, as '/a' doesn't refer to name that is visible in the
> namespace.
> 
> > And another example:
> > 
> > fd = open("/a")
> > rename("/a", "/b")
> > 
> > What should funlink do for fd now?
> 
> remove the directory entry refering to '/b' as that is what fd refers
> to.

Why it should differ in these two cases? Calling /bin/ln /a /b followed by
/bin/rm /a results in the same state as calling /bin/mv /a /b. This is
something which works in POSIX systems.

I think it is strange that new possible funlink call would work only if
external applications uses /bin/mv and would fail if /bin/ln and /bin/rm
are used.

This is reason why I suggested two parameters funlink, it takes fd for
unlinking and pathname which must contain same inode as fd. So when you
call it with fd+"/b" it unlink "/b" without failing.

-- 
Pali Rohár
pali.rohar@gmail.com
