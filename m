Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA9FC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D21220877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D21220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJMNrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:47:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46780 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJMNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:47:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBD9J-0003oa-AN; Sat, 13 Oct 2018 06:11:41 +0000
Date:   Sat, 13 Oct 2018 07:11:41 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
Message-ID: <20181013061141.GR32577@ZenIV.linux.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
 <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 03:49:50PM +0100, Alan Jenkins wrote:
> > +SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
> > +{
> > +	struct fs_context *fc;
> > +	struct path target;
> > +	unsigned int lookup_flags;
> > +	int ret;
> > +
> > +	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
> > +		return -EPERM;
> 
> 
> This seems to accept basically any mount.  Specifically: are you sure it's
> OK to return a handle to a SB_NO_USER superblock?

Umm...  As long as we don't try to do pathname resolution from its ->s_root,
shouldn't be a problem and I don't see anything that would do that.  I might've
missed something, but...
