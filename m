Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E620C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F120673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="u2lwoN+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2F120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbeG0VPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:15:46 -0400
Received: from imap.thunk.org ([74.207.234.97]:36640 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389448AbeG0VPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SZ/z/adV9WezuxXT/wlnLw2t3LX8Icd8NV/fIVHAMsg=; b=u2lwoN+80oeEL7a7NlBXALBQKT
        AgS4L/AM+9Z7FNPq8/DMag4D+cLF7qc6ST/VKceb88Siqe16f/H+JzNKJwHvg3Pr5tdfDbDxe+PEJ
        +Ucd01nBZpFJyqPna/NxMUJCw7znaFVAnIObqP1T8FEsVO/j0KtB+uFwbiSTJl7bodh0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fj8mh-0000zG-Vq; Fri, 27 Jul 2018 19:52:20 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4FB907A6163; Fri, 27 Jul 2018 15:52:13 -0400 (EDT)
Date:   Fri, 27 Jul 2018 15:52:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     adilger.kernel@dilger.ca, wen.xu@gatech.edu,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Remounting filesystem read-only
Message-ID: <20180727195213.GE13922@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sodagudi Prasad <psodagud@codeaurora.org>, adilger.kernel@dilger.ca,
        wen.xu@gatech.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <366cf3ac534bbadaaa61714a43006ac7@codeaurora.org>
 <e9869d6cd358e9de395d730ab7b3aa60@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9869d6cd358e9de395d730ab7b3aa60@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:26:25PM -0700, Sodagudi Prasad wrote:
> On 2018-07-26 18:04, Sodagudi Prasad wrote:
> > Hi All,
> > 
> 
> +linux-kernel@vger.kernel.org list.
> 
> Hi All,
> 
> Observing the following issue with one of the partition on android device
> with 4.14.56 kernel.  When I try to remount this partition using the command
> - mount -o rw,remount /vendor/dsp, it is remounting as read-only.
> 
> [  191.364358] EXT4-fs error (device sde9): ext4_has_uninit_itable:3108:
> comm mount: Inode table for bg 0 marked as needing zeroing
> [  191.364762] Aborting journal on device sde9-8.
> [  191.365226] EXT4-fs (sde9): Remounting filesystem read-only
> [  191.365232] EXT4-fs (sde9): re-mounted. Opts: data=ordere
> 
> If I revert this commit [1] -"ext4: only look at the bg_flags field if it is
> valid", the issue is not observed. It is just giving following warning
> message.
> [1] - https://patchwork.ozlabs.org/patch/929239/.
> 
> [  123.373456] EXT4-fs (sde9): warning: mounting fs with errors, running
> e2fsck is recommendedt
> [  123.389649] EXT4-fs (sde9): re-mounted. Opts: data=ordered
> 
> Can you provide some inputs what could be the issue with this partition?

The error should be pretty clear: "Inode table for bg 0 marked as
needing zeroing".  That should never happen.  The warning "mounting fs
with errors" means the file system was corrupted.  The commit is now
telling more about how the file system was corrupted, and is
protecting you from further data loss.  (You shoud never, ever, ever,
allow a file system to be mounted read/write with corruptions.  The
file system should have been checked using fsck.ext4, aka e2fsck,
before the file system was allowed to be mounted.)

       	   	       	   	      - Ted
