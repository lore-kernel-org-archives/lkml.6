Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABE4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6CB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6CB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeGSPmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:42:38 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:59647 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbeGSPmh (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 19 Jul 2018 11:42:37 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 19 Jul 2018 16:58:57 +0200
Date:   Thu, 19 Jul 2018 22:58:47 +0800
From:   joeyli <jlee@suse.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yu Chen <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
Message-ID: <20180719145847.GJ18419@linux-l9pv.suse>
References: <cover.1531924968.git.yu.c.chen@intel.com>
 <20180718202235.GA4132@amd>
 <20180718235851.GA22170@sandybridge-desktop>
 <20180719110149.GA4679@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719110149.GA4679@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 19, 2018 at 01:01:49PM +0200, Pavel Machek wrote:
> On Thu 2018-07-19 07:58:51, Yu Chen wrote:
> > Hi,
> > On Wed, Jul 18, 2018 at 10:22:35PM +0200, Pavel Machek wrote:
> > > On Thu 2018-07-19 00:38:06, Chen Yu wrote:
> > > > As security becomes more and more important, we add the in-kernel
> > > > encryption support for hibernation.
> > > 
> > > Sorry, this does not really explain what security benefit it is
> > > supposed have to against what attack scenarios.
> > > 
> > > Which unfortunately means it can not reviewed.
> > > 
> > > Note that uswsusp already provides encryption. If this is supposed to
> > > have advantages over it, please say so.
> > > 
> > The advantages are described in detail in 
> > [PATCH 1/4]'s log, please refer to that.
> 
> Are you refering to this?
> 
> # Generally the advantage is: Users do not have to
> # encrypt the whole swap partition as other tools.
> # After all, ideally kernel memory should be encrypted
> # by the kernel itself.
> 
> Sorry, this does not really explain what security benefit it is
> supposed have to against what attack scenarios.
> 
> Note that uswsusp already provides encryption. If this is supposed to
> have advantages over it, please say so.
> 
> Also note that joeyli <jlee@suse.com> has patch series which encrypts
> both in-kernel and uswsusp hibernation methods. His motivation is
> secure boot. How does this compare to his work?
> 

My patchset signs and encrypts the snapshot image pages in memory. The
main logic is applied to snapshot.c

https://github.com/joeyli/linux-s4sign/commit/bae39460393ada4c0226dd07cd5e3afcef86b71f

The pros of my solution is that the signed/encrypted snapshot image can 
be stored to anywhere. Both in-kernel and userspace.

Yu's patch is encrypt the page buffer before sending to block io layer
for writing to swap. The main logic is applied to swap.c. It's against
the swap solution in-kernel.

The pros of Yu's solution is that it encrypts the compressed image data.
So, for the huge system memory case, it has better performance.

Yu's plan is using the sysfs to switch different encrypt/sign solutions.
And, we will share encrypt/sign helper and key manager in the above two
solutions.

Thanks a lot!
Joey Lee
