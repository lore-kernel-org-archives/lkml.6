Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF6CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735F720652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735F720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeJXAqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:46:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43222 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeJXAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:46:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEzRT-0000jl-GW; Tue, 23 Oct 2018 16:22:03 +0000
Date:   Tue, 23 Oct 2018 17:22:03 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
Message-ID: <20181023162203.GZ32577@ZenIV.linux.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <df9e6cd1-415b-4ad1-b506-79e9604e6b68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9e6cd1-415b-4ad1-b506-79e9604e6b68@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:19:35PM +0100, Alan Jenkins wrote:

> I think there's another small hole.  It is possible to move a sub-mount from
> a detached tree (instead of moving the root of the tree).  Then
> do_move_mount() calls attach_recursive_mnt() with a non-NULL parent_path.
> 
> This causes it to skip count_mounts().  So, it doesn't count the number of
> attached mounts, and it allows you to exceed sysctl_mount_max.

That's trivial to repair, fortunately - we just need to check source_mnt->mnt_ns
instead of parent_path.
