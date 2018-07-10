Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D8BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C7820B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C7820B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbeGJUoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:44:20 -0400
Received: from complete.lackof.org ([198.49.126.79]:38868 "EHLO
        complete.lackof.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGJUoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:44:19 -0400
Received: from localhost (c-73-78-137-212.hsd1.co.comcast.net [73.78.137.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by complete.lackof.org (Postfix) with ESMTPSA id EBE1133E0027;
        Tue, 10 Jul 2018 14:43:29 -0600 (MDT)
Date:   Tue, 10 Jul 2018 14:43:29 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanaijie@huawei.com,
        colin.king@canonical.com, kamal.mostafa@canonical.com,
        ike.pan@canonical.com
Subject: Re: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
Message-ID: <20180710204329.GB20459@xps13.dannf>
References: <20180706174324.GA3049@xps13.dannf>
 <20180707041018.GB3546@thunk.org>
 <20180710165143.GA20459@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710165143.GA20459@xps13.dannf>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Virus-Scanned: clamav-milter 0.100.0 at complete.lackof.org
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:51:43AM -0600, dann frazier wrote:
> On Sat, Jul 07, 2018 at 12:10:18AM -0400, Theodore Y. Ts'o wrote:
> > On Fri, Jul 06, 2018 at 11:43:24AM -0600, dann frazier wrote:
> > > Hi,
> > >   We're seeing a regression triggered by the stress-ng[*] "chdir" test
> > > that I've bisected to:
> > > 
> > > 044e6e3d74a3 ext4: don't update checksum of new initialized bitmaps
> > > 
> > > So far we've only seen failures on servers based on HiSilicon's family
> > > of ARM64 SoCs (D05/Hi1616 SoC, D06/Hi1620 SoC). On these systems it is
> > > very reproducible.
> > 
> > Thanks for the report.  Can you verify whether or not this patch fixes
> > things for you?
> 
> hey Ted,
>   Sorry for the delayed response - was afk for a long weekend.
> Your patch does seem to fix the issue for me - after applying the
> patch, I was able to survive 20 iterations (and counting), where
> previously it would always fail the first time.
> 
> However, I've received a conflicting report from a colleague who
> appears to still be seeing errors. I'll get back to you ASAP once I am
> able to (in-?)validate that observation.

OK - I believe I found an explanation for my colleague's continued
test failures after applying the patch. The filesystem being used may
have already been corrupted from a previous run, and the test w/ your
patch just tripped over it. Details are here starting in comment #9 if
you'd like to look them over:

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1780137

  -dann
