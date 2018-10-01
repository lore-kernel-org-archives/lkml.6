Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC2C208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC2C208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeJAVnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:43:05 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:44932 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbeJAVnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:43:05 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w91F4h89002432;
        Mon, 1 Oct 2018 16:04:43 +0100
Date:   Mon, 1 Oct 2018 16:04:42 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     TongZhang <ztong@vt.edu>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20181001160442.47c798bc@alans-desktop>
In-Reply-To: <20181001002521.GM31060@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
        <20180926013329.GD31060@dastard>
        <20180926192426.472360ea@alans-desktop>
        <20180927013812.GF31060@dastard>
        <20180930151652.6975610c@alans-desktop>
        <20181001002521.GM31060@dastard>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>         /* only root can play with this */
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EACCES;
> 
> Think about it - if DM control ioctls only require CAP_SYS_ADMIN,
> then if have that cap you can use DM to remap any block in a block
> device to any other block. You don't need to the filesystem to move
> stuff around, it can be moved around without the filesystem knowing
> anything about it.

Yes - I am not surprised the XFS is not the only problem area. The fact
XFS also isn't going via the security hooks so security hooks can fix it
just makes it worse.

> > That's what people said about setuid shell scripts.  
> 
> Completely different. setuid shell scripts got abused as a hack for
> the lazy to avoid setting up permissions properly and hence were
> easily exploited.

Sounds to me like an accurate description of the current capabilities
mess in the kernel (and not just XFS and not just file systems)

> Systems restricted by LSMs to the point where CAP_SYS_ADMIN is not
> trusted have exactly the same issues. i.e. there's nobody trusted by
> the kernel to administer the storage stack, and nobody has defined a
> workable security model that can prevent untrusted users from
> violating the existing storage trust model....

With a proper set of LSM checks you can lock the filesystem management
and enforcement to a particular set of objects. You can build that model
where for example only an administrative login from a trusted console may
launch processes to do that management.

Or you could - if things were not going around the LSM hooks.

Alan
