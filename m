Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC1AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCDD20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCDD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbeGSN5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:57:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:63075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731532AbeGSN5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:57:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 06:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="76092498"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 06:14:10 -0700
Date:   Thu, 19 Jul 2018 21:20:03 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
Message-ID: <20180719132003.GA30981@sandybridge-desktop>
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
Not this one. I've sent v2 of this patch set which
explain more on this:
https://patchwork.kernel.org/patch/10532935/
Let me paste the log here:

1. (This is not to compare with uswsusp but other
    tools) One advantage is: Users do not have to
    encrypt the whole swap partition as other tools.

2. Ideally kernel memory should be encrypted by the
   kernel itself. We have uswsusp to support user
   space hibernation, however doing the encryption
   in kernel space has more advantages:
   2.1 Not having to transfer plain text kernel memory to
       user space. Per Lee, Chun-Yi, uswsusp is disabled
       when the kernel is locked down:
       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/
       linux-fs.git/commit/?h=lockdown-20180410&
       id=8732c1663d7c0305ae01ba5a1ee4d2299b7b4612
       due to:
       "There have some functions be locked-down because
       there have no appropriate mechanisms to check the
       integrity of writing data."
       https://patchwork.kernel.org/patch/10476751/
 
   2.2 Not having to copy each page to user space
       one by one not in parallel, which might introduce
       significant amount of copy_to_user() and it might
       not be efficient on servers having large amount of DRAM.
   2.3 Distribution has requirement to do snapshot
       signature for verification, which can be built
       by leveraging this patch set.
   2.4 The encryption is in the kernel, so it doesn't
       have to worry too much about bugs in user space
       utilities and similar, for example.
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
Joey Lee and I had a discussion on his previous work at
https://patchwork.kernel.org/patch/10476751
We collaborate on this task and his snapshot signature
feature can be based on this patch set.

Thanks,
Yu

