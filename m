Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14E5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3EE20821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfBKIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:42:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:42834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbfBKIm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:42:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C83D6ACB8;
        Mon, 11 Feb 2019 08:42:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A6211E09A8; Mon, 11 Feb 2019 09:42:25 +0100 (CET)
Date:   Mon, 11 Feb 2019 09:42:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] udf: Fix corrupt on-disk integrity descriptor
 following sync()
Message-ID: <20190211084225.GB19029@quack2.suse.cz>
References: <20190208173455.20151-1-steve@digidescorp.com>
 <7ce9c657-efba-5dbb-441d-acb00a13044b@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce9c657-efba-5dbb-441d-acb00a13044b@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-02-19 22:06:59, Steve Magnani wrote:
> On 2/8/19 11:34 AM, Steve Magnani wrote:
> > In cases where the next unique ID or file/directory count of the
> > in-core Logical Volume Integrity Descriptor have been updated,
> > a sync() causes a (corrupt) LVID with a stale CRC to be written to disk.
> > 
> > Ordinarily, this is corrected by an update of the on-disk LVID that occurs
> > when the filesystem is unmounted. However, if power is lost or the
> > filesystem resides on a device that is surprise-removed, the corrupt LVID
> > remains and can complicate later remounting or fsck/chkdsk.

Thanks for the patches! I've added them to my tree. Just they seem to be
based on some relatively old kernel which required me to fixup some patch
conflicts. Please try to base your patches on current upstream kernel if
possible. Thanks!

> "Complicate later remounting" turns out to be an understatement.
> Actually it seems that this one event can trigger more silent corruption
> of the filesystem on future remounts.
> 
> The driver will mount without complaint a filesystem that lacks a valid LVID.
> But in this scenario, every time lvid_get_unique_id() is called to generate
> an ID for a new inode or link, it returns zero. It appears that callers
> happily assign this zero to all new inodes or links, with no indication to
> the user or in the syslog that a problem is brewing.
> 
> I lost the entire contents of a flash disk to what was probably an
> instance of this kind of corruption, when I told Windows chkdsk to
> repair it.

Ah, I'm sorry to hear that.

> I'll try to solve that in a separate followon patchset.
> The simplest solution I can think of is to force read-only mount when
> no LVID is available.

Agreed. OSTA UDF standard requires LVID to be present so forcing read-only
mount is perfectly fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
