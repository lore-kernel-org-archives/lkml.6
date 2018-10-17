Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39432ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0297F21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0297F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJRHbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:31:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38508 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRHbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:31:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCvJJ-00027C-Gw; Wed, 17 Oct 2018 23:33:05 +0000
Date:   Thu, 18 Oct 2018 00:33:05 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Phillip Potter' <phil@philpotter.co.uk>,
        "dushistov@mail.ru" <dushistov@mail.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181017233305.GC32577@ZenIV.linux.org.uk>
References: <20181017100809.GA9070@pathfinder>
 <fc2004614b7e4a35a67eb93a007a60f8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2004614b7e4a35a67eb93a007a60f8@AcuMS.aculab.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:11:47AM +0000, David Laight wrote:
> From: Phillip Potter
> > Sent: 17 October 2018 11:08
> > 
> > Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> > header and replace with simple assignment. For each case, S_IFx >> 12
> > is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> > us the correct file type. For invalid cases, upper layer validation
> > catches this anyway, so this improves readability and arguably
> > performance by assigning (mode & S_IFMT) >> 12 directly.
> > 
> ...
> > -	case S_IFIFO:
> > -		de->d_u.d_44.d_type = DT_FIFO;
> > -		break;
> > -	default:
> > -		de->d_u.d_44.d_type = DT_UNKNOWN;
> > -	}
> > +	de->d_u.d_44.d_type = (mode & S_IFMT) >> S_SHIFT;
> 
> This requires that the two sets of constants are correctly aligned.

They are.  BSD folks had (sanely, IMO) put the 'type' bits of st_mode
into directory entry verbatim.  Again, "symbolic constant" != "can be
expected to change"...  If, e.g., some port decides to change S_IFIFO,
they'll have no end of fun accessing ext*, xfs, ufs, etc. since that
value is stored in the on-disk inode and in effect pinned down by
that.

All S_... constants are universal and going to remain unchanged on
any Unices.
