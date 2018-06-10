Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2EvRM3KtHFuzEgAAmS7hNA
	; Sun, 10 Jun 2018 04:58:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E054607BB; Sun, 10 Jun 2018 04:58:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0294601C3;
	Sun, 10 Jun 2018 04:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0294601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeFJE6E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 00:58:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53784 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeFJE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 00:58:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRsPY-0002ql-IZ; Sun, 10 Jun 2018 04:57:17 +0000
Date: Sun, 10 Jun 2018 05:57:04 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
Message-ID: <20180610045657.GM30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604084904.GF11333@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:49:04AM -0700, Christoph Hellwig wrote:
> On Tue, May 29, 2018 at 04:43:07PM +0200, Miklos Szeredi wrote:
> > This is needed by the stacked ioctl implementation in overlayfs.
> 
> EXPORT_SYMBOL_GPL for exporting random internals, please.  Same
> for any following patches.

*blink*

Christoph, get real and RTFS - vfs_ioctl() simply calls ->unlocked_ioctl();
all there is to it.

This isn't even a case of "using that function establishes that the
caller is a derived work" - *anyone* who can see definition of
file_operations can bloody well open-code it.  There isn't anything
establishing derivation here.

Hell, it could've been a static inline in include/linux/fs.h and it would
neither differ from many other inlines in there nor need an export at all.

This is really getting close to lxo-worthy levels of bogosity...

More interesting question is why do we want to pass those ioctls to layers
in the first place, especially if it's something with different availability
(or, worse yet, argument layouts) before and after copyup.
