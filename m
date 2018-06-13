Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0126BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D54D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwsf4ut7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D54D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbeFME7Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933611AbeFME7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:59:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE852086A;
        Wed, 13 Jun 2018 04:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528865955;
        bh=PYkZgmkiMP4jtBtIzJArYafvX4+KnJWWru+jtyp1NYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwsf4ut79h/XBOyXAM6Ufs2OdmbcvzSNEG4EtjU7oQ8oHEnb5kM4PHXBySJHij9Ak
         T4ByG/6gJNtWRRQ5WjhZesiHIP8ccLTJnFtmnsTn/bMYVAdKfyljzXNXzyvr0zdcTh
         pWK7ZIMg6i3A/VJFKZnYCSN9YZ5qYkGneMc4q67g=
Date:   Wed, 13 Jun 2018 06:58:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: REGRESSION?: debugfs: inode: debugfs_create_dir uses mode
 permission from parent
Message-ID: <20180613045853.GB1246@kroah.com>
References: <CALAqxLVCpyKzGJPVtBuipnZbGbDC_Z0rPBrn-J2mkMsQsSvdtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVCpyKzGJPVtBuipnZbGbDC_Z0rPBrn-J2mkMsQsSvdtA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:40:41PM -0700, John Stultz wrote:
> Hey all,
>   I noticed recently that linus/master (plus patches) stopped booting
> to UI on HiKey960, and I bisected the issue down to:
> 92170b62f1c1 ("debugfs: inode: debugfs_create_dir uses mode permission
> from parent")
> 
> On the HiKey960 board, we mount debugfs via:
>    mount debugfs /sys/kernel/debug /sys/kernel/debug mode=755
> 
> But since the change, it seems most of the nodes in /sys/kernel/debug
> are: drwx------
> 
> Which ends up breaking the egl library, keeping it from loading.

While the debugfs change is now reverted in Linus's tree, I find it
"odd" that a debugfs change would cause egl from loading entirely.  No
userspace code should depend on debugfs files being there or not.  If it
does, that's a bug as debugfs is for _debugging_ stuff, it should not be
an interface between user/kernel that userspace requires for basic
functionality like booting.

And yes, I know all about the crazy qualcom batter api, where they
shoved it into debugfs and ignored the built-in kernel api, that should
be fixed now.  If this is a new one-of-those types of problem, I need to
know so it can get resolved.

thanks,

greg k-h
