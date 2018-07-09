Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018F3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B920842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724B920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbeGIP4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:56:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54564 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933357AbeGIP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:56:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcYWR-0007LD-60; Mon, 09 Jul 2018 15:56:19 +0000
Date:   Mon, 9 Jul 2018 16:56:19 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH vfs/for-next 00/18] fs_context fixes
Message-ID: <20180709155618.GH30522@ZenIV.linux.org.uk>
References: <20180708234630.GB700@sol.localdomain>
 <20180708210154.10423-1-ebiggers3@gmail.com>
 <31355.1531150319@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31355.1531150319@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:31:59PM +0100, David Howells wrote:

> -int __mnt_is_readonly(struct vfsmount *mnt)
> +bool __mnt_is_readonly(struct vfsmount *mnt)
>  {
>  	if (mnt->mnt_flags & MNT_READONLY)
> -		return 1;
> +		return true;
>  	if (sb_rdonly(mnt->mnt_sb))
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;

Egads...  *If* you go for bool here, why not
	return (mnt->mnt_flags & MNT_READONLY) || sb_rdonly(mnt->mnt_sb);
and be done with that?
