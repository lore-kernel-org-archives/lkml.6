Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2269C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3120658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F3120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH0Pc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:32:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeH0PcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:32:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE2CF804B9F1;
        Mon, 27 Aug 2018 11:46:05 +0000 (UTC)
Received: from localhost (unknown [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2784F2026D6B;
        Mon, 27 Aug 2018 11:46:01 +0000 (UTC)
Date:   Mon, 27 Aug 2018 13:45:57 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH ghak10 v5 2/2] timekeeping/ntp: Audit clock/NTP params
 adjustments
Message-ID: <20180827114557.GN27091@localhost>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180824120001.20771-3-omosnace@redhat.com>
 <20180824194703.h3mbuhrxzixmna4e@madcap2.tricolour.ca>
 <CAFqZXNvD_7psR+wM-GTXQ4bwK3w8=t7UnBidojB5XbmbE_K2oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNvD_7psR+wM-GTXQ4bwK3w8=t7UnBidojB5XbmbE_K2oA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 27 Aug 2018 11:46:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 27 Aug 2018 11:46:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mlichvar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:35:09PM +0200, Ondrej Mosnacek wrote:
> On Fri, Aug 24, 2018 at 9:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > It appears this time_tai use of "constant" is different than
> > time_constant, the former not mentioned by Miroslav Lichvar.  What is it
> > and is it important to log for security?  It sounds like it is
> > important.

> The TAI offset is the offset of the clock from the International
> Atomic Time, so basically the time zone offset. I suppose it can't
> influence the audit timestamps, but changing timezones can still cause
> all sorts of confusion throughout the system, so intuitively I would
> say we should log it.

It's not related to timezones. ADJ_TAI sets the offset of the system
TAI clock (CLOCK_TAI) relative to the standard UTC clock
(CLOCK_REALTIME). CLOCK_TAI is rarely used by applications. Setting
the TAI offset effectively injects a whole-second offset to the TAI
time. 

-- 
Miroslav Lichvar
