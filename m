Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2619C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF29B205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF29B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeKYGk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:40:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52070 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeKYGk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:40:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gQdxV-00069L-Dc; Sat, 24 Nov 2018 19:51:17 +0000
Date:   Sat, 24 Nov 2018 19:51:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pan Bian <bianpan2016@163.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: free new_dentry late
Message-ID: <20181124195117.GB2217@ZenIV.linux.org.uk>
References: <1543051404-42498-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543051404-42498-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 05:23:24PM +0800, Pan Bian wrote:
> After calling dput(new_dentry), new_dentry is passed to fsnotify_move.
> This may result in a use-after-free bug. This patch moves the put
> operation late.
>
> Fixes: 49d31c2f389a("dentry name snapshots")

What does that commit have to do with anything?  The broken part is
                        fsnotify_move(new_dir, old_dir, old_dentry->d_name.name,
                                      new_is_dir, NULL, new_dentry);
and it predates that commit by 3 years - it came from da1ce0670c14 ("vfs: add
cross-rename")...
