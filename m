Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E5ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722F32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722F32083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIODkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:40:04 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:42234 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbeIODkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:40:04 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 15 Sep 2018 07:53:37 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g0wUy-0008D2-G2; Sat, 15 Sep 2018 08:23:36 +1000
Date:   Sat, 15 Sep 2018 08:23:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Subject: Re: metadata operation reordering regards to crash
Message-ID: <20180914222336.GD16550@dastard>
References: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:06:44PM +0800, 焦晓冬 wrote:
> Hi, all,
> 
> A probably bit of complex question:
> Does nowadays practical filesystems, eg., extX, btfs, preserve metadata
> operation order through a crash/power failure?

Yes.

Behaviour is filesystem dependent, but we have tests in fstests that
specifically exercise order preservation across filesystem failures.

> What I know is modern filesystems ensure metadata consistency
> after crash/power failure. Journal filesystems like extX do that by
> write-ahead logging of metadata operations into transactions. Other
> filesystems do that in various ways as btfs do that by COW.
> 
> What I'm not so far clear is whether these filesystems preserve
> metadata operation order after a crash.
> 
> For example,
> op 1.  rename(A, B)
> op 2.  rename(C, D)
> 
> As mentioned above,  metadata consistency is ensured after a crash.
> Thus, B is either the original B(or not exists) or has been replaced by A.
> The same to D.
> 
> Is it possible that, after a crash, D has been replaced by C but B is still
> the original file(or not exists)?

Not for XFS, ext4, btrfs or f2fs. Other filesystems might be
different.

Cheers,

Dave,
-- 
Dave Chinner
david@fromorbit.com
