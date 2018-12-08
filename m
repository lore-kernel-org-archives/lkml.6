Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC7C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C969D20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C969D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLHAts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:49:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36736 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:49:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gVQoS-0001mX-W8; Sat, 08 Dec 2018 00:49:45 +0000
Date:   Sat, 8 Dec 2018 00:49:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Subject: Re: [PATCH] Fix sync. in blkdev_write_iter() acessing i_flags
Message-ID: <20181208004944.GA2217@ZenIV.linux.org.uk>
References: <4903939e-d3d6-b0c2-9c33-0fea0a61213c@tu-dortmund.de>
 <20181207175811.GZ2217@ZenIV.linux.org.uk>
 <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c86e85f-0ad4-935a-3021-7046551f361f@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:49:16PM +0100, Alexander Lochmann wrote:

> > _What_ SUID bit?  We are talking about a write to block device, for fsck sake...
> > 
> That's the way I understood Jan's explanation:
> "
> Thinking more about this I'm not sure if this is actually the right
> solution. Because for example the write(2) can set S_NOSEC flag wrongly
> when it would race with chmod adding SUID bit. So probably we rather need
> to acquire i_rwsem in blkdev_write_iter() if file does not have S_NOSEC set
> (we don't want to acquire it unconditionally as that would heavily impact
> scalability of block device writes).

	IDGI.  We are talking about a block device here.  What business could
file_remove_privs() have doing _anything_ to it?  should_remove_suid() returns
to return 0 for those; what case do you have in mind?  Somebody setting
security.capabilities on a block device inode?

	IMO the bug here is file_remove_privs() not buggering off immediately
after having observed that we are dealing with a block device.  It really
has nothing useful to do.
