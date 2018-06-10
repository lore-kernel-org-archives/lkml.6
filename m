Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JTp8M5+lHFt/aAAAmS7hNA
	; Sun, 10 Jun 2018 04:36:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C0CCF607BB; Sun, 10 Jun 2018 04:36:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 528FF601D2;
	Sun, 10 Jun 2018 04:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 528FF601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbeFJEgs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 00:36:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53530 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeFJEgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 00:36:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRs5S-0002Pz-Dw; Sun, 10 Jun 2018 04:36:20 +0000
Date: Sun, 10 Jun 2018 05:36:17 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/39] vfs: add path_open()
Message-ID: <20180610043610.GK30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-5-mszeredi@redhat.com>
 <20180604084609.GC11333@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604084609.GC11333@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:46:09AM -0700, Christoph Hellwig wrote:
> > +EXPORT_SYMBOL(path_open);
> 
> EXPORT_SYMBOL_GPL, please.

	No.

	If interface makes sense, export it.  If it doens't, don't.
Don't mix "it's a shit API, but we need it for some in-kernel module"
with "out-of-tree code should be GPL, especially if it uses this".
For non-trivial work I will, teeth gritting, accept that kind of
stuff.  For anything as trivial as this - fuck, no.

	In this particular case, it *is* a dubious API - AFAICS,
ovl_open_realfile() could just pass vfsmount/dentry from the right
layer to vfs_open().  We might or might not need path_open() for the
duration of the series (I hadn't looked into the PITA it would be
to reorder), but it really looks like it could disappear by the end
of it, along with the temporary export.
