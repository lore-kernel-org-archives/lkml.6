Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E37206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E37206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIFPWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:22:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:55938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIFPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:22:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 03:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,337,1531810800"; 
   d="scan'208";a="260329959"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 06 Sep 2018 03:47:45 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 06 Sep 2018 13:47:46 +0300
Date:   Thu, 6 Sep 2018 13:47:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 1/3] thunderbolt: Make the driver less verbose
Message-ID: <20180906104746.GW2283@lahna.fi.intel.com>
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
 <20180903133304.70362-2-mika.westerberg@linux.intel.com>
 <20180905090510.fvryu6ivxagdzoyx@wunner.de>
 <20180905095451.GI2283@lahna.fi.intel.com>
 <20180906084143.sah4njyft7z5squb@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906084143.sah4njyft7z5squb@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:41:43AM +0200, Lukas Wunner wrote:
> On Wed, Sep 05, 2018 at 12:54:51PM +0300, Mika Westerberg wrote:
> > On Wed, Sep 05, 2018 at 11:05:10AM +0200, Lukas Wunner wrote:
> > > On Mon, Sep 03, 2018 at 04:33:02PM +0300, Mika Westerberg wrote:
> > > > Currently the driver logs quite a lot to the system message buffer even
> > > > when doing normal operations. This information is not useful for
> > > > ordinary users and might even annoy some.
> > > 
> > > No, the verbose logging is done on purpose to aid us in reverse-engineering
> > > the protocol.  For example ...
> > > 
> > > > -	tb_port_info(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
> > > > -		     hop->unknown1, hop->unknown2, hop->unknown3);
> > > 
> > > ... why do you think we're logging these seemingly stupid unknown
> > > bitfields?  Because whenever someone posts dmesg output they
> > > inadvertantly post the contents of those unknown fields and we can
> > > then google the value of those fields on various controllers and
> > > machines and deduce their possible meaning.
> > 
> > And the majority of people get tons of completely useless messages
> > filling their dmesgs? No, I don't think that's a good thing.
> 
> As you know the OS-controlled tunnel manager is far from feature
> complete.  I think the "majority of people" are perfectly willing
> to accept verbose logging if it helps us fill in those gaps.
> 
> You make it sound like logfiles are spammed all the time, but
> messages are in fact only logged on driver initialization and hotplug.

And every time the controller runtime suspends/resumes. Every
suspend/resume. Every time ring gets initialized/teared when you connect
cable between computers. It is way too much for a driver that is part of
production operating system.

> We wouldn't be in this situation if we had a proper Thunderbolt spec.
> It wasn't *my* idea to keep it under wraps.

Please don't start that again.

I can't affect when the spec is released, really. I'm just a poor driver
guy trying to get this working as good as possible.

> So please leave the messages at info level so as not to hinder our work.
> 
> As for your claim that the "majority of people" find the messages
> useless", I rather suspect that you, personally, find them useless
> because you complained about noisiness of the driver before:
> 
>    "I don't think we want to log anything with info level to be honest.
>     The driver currently already is pretty noisy so adding even more
>     information there just makes it worse ;-)
>     I would rather convert debugging information to use tracepoints and
>     get rid of the tb_*_info() things completely."
>     https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1401181.html
> 
> And guess what I responded:
> 
>    "The noisiness has value in that it helps with reverse-engineering:
>     Just google for dmesg output and check what other machines are
>     reporting for unknown registers. :-)
>     If there was public documentation available or Intel would be okay
>     with answering specific questions (as you've done with the 0x30
>     attribute id), then the value obviously diminishes."

It is not just me, see here:

https://lkml.org/lkml/2017/10/31/864

And I fully agree.

Andreas was fine at the time to silence the driver. I just did not have
time to do that until now.

Andreas, let me know if you have objections about this patch.
