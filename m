Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46252C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F012B2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F012B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeIEOYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:24:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:49140 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbeIEOYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:24:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 02:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,333,1531810800"; 
   d="scan'208";a="78123468"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 05 Sep 2018 02:54:52 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Sep 2018 12:54:51 +0300
Date:   Wed, 5 Sep 2018 12:54:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 1/3] thunderbolt: Make the driver less verbose
Message-ID: <20180905095451.GI2283@lahna.fi.intel.com>
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
 <20180903133304.70362-2-mika.westerberg@linux.intel.com>
 <20180905090510.fvryu6ivxagdzoyx@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905090510.fvryu6ivxagdzoyx@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:05:10AM +0200, Lukas Wunner wrote:
> On Mon, Sep 03, 2018 at 04:33:02PM +0300, Mika Westerberg wrote:
> > Currently the driver logs quite a lot to the system message buffer even
> > when doing normal operations. This information is not useful for
> > ordinary users and might even annoy some.
> 
> No, the verbose logging is done on purpose to aid us in reverse-engineering
> the protocol.  For example ...
> 
> > -	tb_port_info(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
> > -		     hop->unknown1, hop->unknown2, hop->unknown3);
> 
> ... why do you think we're logging these seemingly stupid unknown
> bitfields?  Because whenever someone posts dmesg output they
> inadvertantly post the contents of those unknown fields and we can
> then google the value of those fields on various controllers and
> machines and deduce their possible meaning.

And the majority of people get tons of completely useless messages
filling their dmesgs? No, I don't think that's a good thing.

> By muting those messages, you're taking away our reverse enginering aids
> without having released the spec, which would indeed obviate the need
> for them.  Please don't do that.  Release the spec, *then* you can
> mute the messages.  Not the other way round.

All the possible messages are most likely logged already and available
by Googling so even if we mute the driver now, you still can find those
messages in the wild. Anything running on Alpine Ridge and higher does
not require reverse-engineering (even on Apple systems) because those
are already supported in the driver.
