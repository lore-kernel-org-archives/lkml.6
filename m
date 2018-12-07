Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8684BC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3739F20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3739F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeLGR6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:58:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60282 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeLGR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:58:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gVKOC-0005l0-3C; Fri, 07 Dec 2018 17:58:12 +0000
Date:   Fri, 7 Dec 2018 17:58:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Subject: Re: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags
Message-ID: <20181207175811.GZ2217@ZenIV.linux.org.uk>
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 05:10:15PM +0100, Alexander Lochmann wrote:
> 
> inode.i_flags might be altered without proper
> synchronisation when the inode belongs to devtmpfs.
> blkdev_write_iter() starts writing via __generic_file_write_iter()
> which sets S_NOSEC bit without any synchronisation.
> The following stacktrace shows how to get there:
> 13: entry_SYSENTER_32:460
> 12: do_fast_syscall_32:410
> 11: _static_cpu_has:146
> 10: do_syscall_32_irqs_on:322
> 09: SyS_pwrite64:636
> 08: SYSC_pwrite64:650
> 07: fdput:38
> 06: vfs_write:560
> 05: __vfs_write:512
> 04: new_sync_write:500
> 03: blkdev_write_iter:1977
> 02: __generic_file_write_iter:2897
> 01: file_remove_privs:1818
> 00: inode_has_no_xattr:3163
> If S_NOSEC is *not* set, i_rwsem is acquired around
> __generic_file_write_iter().

> +	 * Ensure excl. access to i_flags in __generic_file_write_iter().
> +	 * Otherwise, it would race with chmod adding SUID bit.
> +	 */

_What_ SUID bit?  We are talking about a write to block device, for fsck sake...
