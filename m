Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AN+aDCW6HFsiUgAAmS7hNA
	; Sun, 10 Jun 2018 05:42:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AAD5360795; Sun, 10 Jun 2018 05:42:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22D79601C3;
	Sun, 10 Jun 2018 05:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22D79601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753759AbeFJFmg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:42:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54310 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeFJFmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:42:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRt76-0003wX-78; Sun, 10 Jun 2018 05:42:10 +0000
Date: Sun, 10 Jun 2018 06:42:04 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/39] ovl: add helper to return real file
Message-ID: <20180610054156.GP30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-16-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-16-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:15PM +0200, Miklos Szeredi wrote:
> In the common case we can just use the real file cached in
> file->private_data.  There are two exceptions:
> 
> 1) File has been copied up since open: in this unlikely corner case just
> use a throwaway real file for the operation.  If ever this becomes a
> perfomance problem (very unlikely, since overlayfs has been doing most fine
> without correctly handling this case at all), then we can deal with that by
> updating the cached real file.

See the ovl_mmap() problem.  FWIW, I would probably suggest something along
the lines of
	->private_data either points to struct file, or is 1 | address of
2-element array of struct file *
	odd value => mask bit 0 away, cast to struct file ** and dereference
	even value and it's still in the right layer => use that
	even value and it is in the wrong layer =>
		allocate a two-pointer array
		open in the right layer
		stick that into array[0] and original - into array[1]
		cmpxchg array | 1 into ->private_data
		if that succeeds
			return array[0]
		else
			fput array[0], free array, then use the value returned
			by cmpxchg - mask bit 0 away, cast and dereference
