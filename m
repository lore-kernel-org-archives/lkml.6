Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900CBC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3202175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3202175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeHMV0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729525AbeHMV0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:26:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEC16AE0B;
        Mon, 13 Aug 2018 18:43:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 365C5DA7C5; Mon, 13 Aug 2018 20:42:54 +0200 (CEST)
Date:   Mon, 13 Aug 2018 20:42:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naota@elisp.net>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
Message-ID: <20180813184251.GC24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naota@elisp.net>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20180809180450.5091-1-naota@elisp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 03:04:33AM +0900, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs.

Yay, thanks!

As this a RFC, I'll give you some. The code looks ok for what it claims
to do, I'll skip style and unimportant implementation details for now as
there are bigger questions.

The zoned devices bring some constraints so not all filesystem features
cannot be expected to work, so this rules out any form of in-place
updates like NODATACOW.

Then there's list of 'how will zoned device work with feature X'?

You disable fallocate and DIO. I haven't looked closer at the fallocate
case, but DIO could work in the sense that open() will open the file but
any write will fallback to buffered writes. This is implemented so it
would need to be wired together.

Mixed device types are not allowed, and I tend to agree with that,
though this could work in principle.  Just that the chunk allocator
would have to be aware of the device types and tweaked to allocate from
the same group. The btrfs code is not ready for that in terms of the
allocator capabilities and configuration options.

Device replace is disabled, but the changlog suggests there's a way to
make it work, so it's a matter of implementation. And this should be
implemented at the time of merge.

RAID5/6 + zoned support is highly desired and lack of it could be
considered a NAK for the whole series. The drive sizes are expected to
be several terabytes, that sounds be too risky to lack the redundancy
options (RAID1 is not sufficient here).

The changelog does not explain why this does not or cannot work, so I
cannot reason about that or possibly suggest workarounds or solutions.
But I think it should work in principle.

As this is first post and RFC I don't expect that everything is
implemented, but at least the known missing points should be documented.
You've implemented lots of the low-level zoned support and extent
allocation, so even if the raid56 might be difficult, it should be the
smaller part.
