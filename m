Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B505C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7DE216FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7DE216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeHOCi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:38:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:37279 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeHOCi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:38:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 16:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,240,1531810800"; 
   d="scan'208";a="254892378"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2018 16:48:55 -0700
Date:   Tue, 14 Aug 2018 17:49:40 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     wnukowski@google.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, yigitfiliz@google.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Bugfix for handling of shadow doorbell buffer.
Message-ID: <20180814234940.GB3224@localhost.localdomain>
References: <20180814221735.62804-1-wnukowski@google.com>
 <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 04:16:41PM -0700, Linus Torvalds wrote:
> On Tue, Aug 14, 2018 at 3:56 PM Keith Busch <keith.busch@linux.intel.com> wrote:
> >
> > You just want to ensure the '*dbbuf_db = value' isn't reordered, right?
> > The order dependency might be more obvious if done as:
> >
> >         WRITE_ONCE(*dbbuf_db, value);
> >
> >         if (!nvme_dbbuf_need_event(READ_ONCE(*dbbuf_ei), value, old_value))
> >                 return false;
> >
> > And 'volatile' is again redundant.
> 
> Yes, using READ_ONCE/WRITE_ONCE obviates the need for volatile, but it
> does *not* impose a memory ordering.
> 
> It imposes an ordering on the compiler, but not on the CPU, so you
> still want the "mb()" there

I mistakenly recalled memory-barriers.txt mentioned order was enforced
on the CPU, but that's true only for overlapping memory, which this is
not. Thanks for the correction.
