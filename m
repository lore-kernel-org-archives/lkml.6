Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F78C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3121920895
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3121920895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeIZHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:43:51 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:40671 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbeIZHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:43:50 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 26 Sep 2018 11:03:29 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g4yhl-0006XV-4z; Wed, 26 Sep 2018 11:33:29 +1000
Date:   Wed, 26 Sep 2018 11:33:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     TongZhang <ztong@vt.edu>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20180926013329.GD31060@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:51:50PM -0400, TongZhang wrote:
> Hi,
> 
> I'm bringing up this issue again to let of LSM developers know the situation, and would like to know your thoughts.
> Several weeks ago I sent an email to the security list to discuss the issue where
> XFS's ioctl interface can do things like vfs_readlink without asking LSM's
> permission, which we think is kind of weird and this kind of operation should be
> audited by LSM.

These aren't user interfaces. They are filesystem maintenance and
extension interfaces.  They are intended for low level filesystem
utilities that require complete, unrestricted access to the
underlying filesystem via holding CAP_SYSADMIN in the initns.

i.e.  they are used to perform filesystem maintenance and extension
operations that need to be completely invisible to users from
userspace. e.g.  online file defragmentation (xfs_fsr), data
migration (e.g. HSM products), efficient backup of data (xfsdump),
metadata and data scrubbing, online repair, etc.

IOWs, I really don't think these interfaces are something the LSMs
should be trying to intercept or audit, because they are essentially
internal filesystem interfaces used by trusted code and not general
user application facing APIs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
