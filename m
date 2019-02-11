Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACC921B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfBKQtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:20 -0500
Received: from koef.zs64.net ([212.12.50.230]:13427 "EHLO koef.zs64.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfBKQtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:20 -0500
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 11:49:18 EST
Received: from koef.zs64.net (koef.zs64.net [212.12.50.230])
        by 0ons.org (8.15.2/8.15.2) with ESMTP id x1BGSMM4048139
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:28:22 GMT
        (envelope-from cracauer@koef.zs64.net)
Received: (from cracauer@localhost)
        by koef.zs64.net (8.15.2/8.15.2/Submit) id x1BGSMJd048136
        for linux-kernel@vger.kernel.org; Mon, 11 Feb 2019 11:28:22 -0500 (EST)
        (envelope-from cracauer)
Date:   Mon, 11 Feb 2019 11:28:22 -0500
From:   Martin Cracauer <cracauer@cons.org>
To:     linux-kernel@vger.kernel.org
Subject: Possibe NFS mm problem: client page-in errors with ZFS Linux server
Message-ID: <20190211162821.GA38018@cons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks.  I suspect that this isn't actually a ZFS bug but a general
memory manager problem.  I would appreciate input from mm folks.  I
parked the detailed bug report here for now:
https://github.com/zfsonlinux/zfs/issues/8396

Short story:

When running a ZFS on a Linux 4.19/4.20 NFS server the clients are
occasionally unsuccessful in perfectly normal page-in on mapped files.

Example: executable on NFS mounted filesystem.  Some executable-mapped
page is referenced.  The page is supposed to be retrieved on demand if
not resident yet.  This occasionally fails with recent Linux or ZoL
code.

The semantics of the error are identical to what is legitimately
happening when you have a page fault in a NFS client mapped file after
that file has been unlinked on the server side.  Here it is happening
without the unlinking.

I suspect this might be a general Linux mm problem because I
cross-checked with a FreeBSD server with very similar ZFS code.
Although I cannot track when the error started appearing I know it is
about within the last 6 months and I read all commits to ZoL that
manage pages and couldn't see anything suspicious off-hand.  On the
other hand the errors do not appear when moving the server side file
tree to ext4fs.

The errors get more frequent with uptime of the server and are not
impressed by drop_caches or by trying to evict ZFS' own caches with
memory pressure.

Details with a line of reasoning why I blame the server and all other
info I am collecting:
https://github.com/zfsonlinux/zfs/issues/8396

Thanks
Martin
-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Martin Cracauer <cracauer@cons.org>   http://www.cons.org/cracauer/
