Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E642AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6204A2439A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6204A2439A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeFVOxD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:53:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37084 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932973AbeFVOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:53:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fWNQp-0002hD-7B; Fri, 22 Jun 2018 14:52:59 +0000
Date:   Fri, 22 Jun 2018 15:52:59 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: 4.18-rc1 regression in /proc/self xattr handling
Message-ID: <20180622145259.GZ30522@ZenIV.linux.org.uk>
References: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:37:00AM -0700, Casey Schaufler wrote:
> There is a regression in behavior regarding xattrs in /proc after:
> 
> commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Wed May 2 21:26:16 2018 -0400
> 
>     procfs: get rid of ancient BS in pid_revalidate() uses
>     
> 
> Prior to this change lgetxattr() would provide the correct attributes
> for entries in /proc. With this change I see that while the behavior
> remains correct if the procid is specified, it is not when "self" is
> used. On a system with Smack enabled, where the shell has the Smack label
> "Crackle" I see: 
> 
> [root@localhost linux]# attr -S -g SMACK64 /proc/self/attr/current
> Attribute "SMACK64" had a 1 byte value for /proc/self/attr/current:
> _
> [root@localhost linux]# attr -S -g SMACK64 /proc/$BASHPID/attr/current
> Attribute "SMACK64" had a 7 byte value for /proc/1716/attr/current:
> Crackle

Wait a sec - the former will be that of attr, the latter - of bash;
it's not the same file at all.

> These should be the same, and in the past have been. I don't know
> what SELinux expects as far as attributes in /proc, so I can't say
> if the problem is manifest with SELinux.

Very interesting...  About the only thing changed here seems to be
the relative order of smack_d_instantiate() and smack_task_to_inode()...

Would setting SMK_INODE_INSTANT in isp->smk_flags in smack_task_to_inode()
be the right thing to do, anyway?
