Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDIKYR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:24:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeDIKYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:24:15 -0400
Date: Mon, 9 Apr 2018 03:24:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Subject: Re: Race-free unlinking of directory entries
Message-ID: <20180409102414.GA23471@infradead.org>
References: <20171220191844.wnb3bgkpreg2tjia@pali>
 <20180409074241.2ibvhh3g5lzxnt4g@pali>
 <20180409095919.GA9621@infradead.org>
 <20180409101009.6kxd47jeowef7wt2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409101009.6kxd47jeowef7wt2@pali>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:10:09PM +0200, Pali Rohár wrote:
> I do not think it is enough, specially in cases when hard links are in
> use. Example:
> 
> fd = open("/a")
> link("/a", "/b")
> link("/a", "/c")
> unlink("/a")
> 
> And now I want to call funlink for "fd". Which file should be unlinked?
> "/b" or "/c" or none or both?

'/a' as that is what fd refers to.

> 
> Another example:
> 
> fd = open("/a")
> link("/a", "/b")
> unlink("/a")
> 
> Calling funlink for fd should unlink "/b" or it should fail?

It should fail, as '/a' doesn't refer to name that is visible in the
namespace.

> And another example:
> 
> fd = open("/a")
> rename("/a", "/b")
> 
> What should funlink do for fd now?

remove the directory entry refering to '/b' as that is what fd refers
to.

> Note that there is difference which symlink is shown in /proc/<pid>/fd
> between last two examples -- even those two examples results in the same
> state (if there is no race). For last example <fd> points to "/b", for
> previous <fd> points to "/a (deleted)".

Yes, that is fully expected.
