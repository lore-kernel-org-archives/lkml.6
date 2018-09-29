Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7599CC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C48204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C48204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeI3Btp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:49:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:55674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbeI3Btp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:49:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD6C1AF02;
        Sat, 29 Sep 2018 19:20:07 +0000 (UTC)
Date:   Sat, 29 Sep 2018 21:20:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
In-Reply-To: <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
Message-ID: <nycvar.YFH.7.76.1809292118240.15880@cbobk.fhfr.pm>
References: <20180913033432.16336-1-baijiaju1990@gmail.com> <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm> <4c0096c6-3745-963c-5086-5f579792599b@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2018, Jia-Ju Bai wrote:

> >> picolcd_send_and_wait (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> >>
> >> picolcd_reset (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> >>
> >> lg4ff_play (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> >>
> >> lg4ff_set_autocenter_ffex (acquire a spinlock)
> >>    hid_hw_request
> >>      __hid_request
> >>        hid_alloc_report_buf(GFP_KERNEL)
> > Hm, so it's always drivers calling out into core in atomic context. So
> > either we take this, and put our bets on being able to allocate the buffer
> > without sleeping,
> 
> In my opinion, I prefer this way.

Why? Forcing all the report buffer to be limited to be non-sleeping 
allocations just because of two drivers, looks like an overkill, and 
actually calls for more issues (as GFP_ATOMIC is of course in principle 
less likely to succeed).

-- 
Jiri Kosina
SUSE Labs

