Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B0A20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B0A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeGLMww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:52:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34646 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGLMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:52:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdawQ-0005AW-HK; Thu, 12 Jul 2018 12:43:26 +0000
Date:   Thu, 12 Jul 2018 13:43:26 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [RFC][PATCH 01/42] drm_mode_create_lease_ioctl(): fix open-coded
 filp_clone_open()
Message-ID: <20180712124326.GA19272@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk>
 <20180711161540.GS30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711161540.GS30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:15:40PM +0100, Al Viro wrote:

> Actually, looking at the entire thing, I'm rather tempted to go for
> 	alloc_empty_file(f_flags, cred)
> setting both f_flags and f_flags-derived part of f_mode, making
> 	alloc_file_pseudo(inode, mnt, name, f_flags, ops)
> 	alloc_file_clone(base, f_flags, ops)
> do the same automatically as they call alloc_empty_file().

See vfs.git#work.open3; one commit added just before "pass creds
to get_empty_filp(), make sure dentry_open() passes the right creds",
one just after.

The first one ("alloc_file(): switch to passing O_... flags instead of
 FMODE_... mode") pulls ->f_flags assignments into preceding alloc_file(),
the second ("pass ->f_flags value to alloc_empty_file()") makes
alloc_empty_file() set ->f_flags and ->f_flags-derived part of ->f_mode,
with do_dentry_open() leaving these parts of ->f_mode alone.

The rest is pretty much identical to the previous iteration of the
series, except that alloc_file wrappers inherit the switch to passing
O_...

A question regarding the customs in such situations - are previous
Reviewed-by/Acked-by normally kept across rebases like that?
