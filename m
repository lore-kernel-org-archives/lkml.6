Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221E0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3C920645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3C920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIENe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:34:27 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:41825 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIENe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:34:27 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 485E62801C0A7;
        Wed,  5 Sep 2018 11:05:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E67F0449B24; Wed,  5 Sep 2018 11:05:10 +0200 (CEST)
Date:   Wed, 5 Sep 2018 11:05:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 1/3] thunderbolt: Make the driver less verbose
Message-ID: <20180905090510.fvryu6ivxagdzoyx@wunner.de>
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
 <20180903133304.70362-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903133304.70362-2-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:33:02PM +0300, Mika Westerberg wrote:
> Currently the driver logs quite a lot to the system message buffer even
> when doing normal operations. This information is not useful for
> ordinary users and might even annoy some.

No, the verbose logging is done on purpose to aid us in reverse-engineering
the protocol.  For example ...

> -	tb_port_info(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
> -		     hop->unknown1, hop->unknown2, hop->unknown3);

... why do you think we're logging these seemingly stupid unknown
bitfields?  Because whenever someone posts dmesg output they
inadvertantly post the contents of those unknown fields and we can
then google the value of those fields on various controllers and
machines and deduce their possible meaning.

By muting those messages, you're taking away our reverse enginering aids
without having released the spec, which would indeed obviate the need
for them.  Please don't do that.  Release the spec, *then* you can
mute the messages.  Not the other way round.

Thanks,

Lukas
