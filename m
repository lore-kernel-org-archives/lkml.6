Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC26C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E2720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BvgSvZxV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m4R569eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E2720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeKJBX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:23:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKJBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:23:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A1B2603D2; Fri,  9 Nov 2018 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541778141;
        bh=TQjAHrzvDnq9+pZD3X2MXvL2nTtsgLLyHQM/S4grXTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvgSvZxVdRRd4w4MxEH4USQ4i/sNPj/w2B+uD4Kk+SvID9aXwff9pamL7v2x//6Ld
         KpmAHAck40ZYfXCo4nEiRDcUWG9GyVO7XPvdPekP/03MvE/j/ObfZkRZ8mYFyfgWHu
         azPaHmOrbErniRpr9l1fzSOAf6vt44WsFHioTk8g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 588E8603D2;
        Fri,  9 Nov 2018 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541778140;
        bh=TQjAHrzvDnq9+pZD3X2MXvL2nTtsgLLyHQM/S4grXTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m4R569eRbAwH64F/+MzE+JUWkUHu2Be5y4/HINrPa1ek0YdMihMHRfe3mRjPCMQyP
         WmiOKLKOQ+sGkSqwIavTvni8Zx48oRyKP5fF+8x3sJeF2MSXFU7IRxVbldOYqZDaWN
         m5EaogZidIPM2gm9ocS2U5XRk+EV9e9wcvYgP5nY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Nov 2018 21:12:20 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v3 4/4] mm: Remove managed_page_count spinlock
In-Reply-To: <20181108101400.GU27423@dhcp22.suse.cz>
References: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
 <1541665398-29925-5-git-send-email-arunks@codeaurora.org>
 <20181108083400.GQ27423@dhcp22.suse.cz>
 <4e5e2923a424ab2e2c50e56b2e538a3c@codeaurora.org>
 <20181108101400.GU27423@dhcp22.suse.cz>
Message-ID: <4eded31079a6bc3b275ef619204c3509@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 15:44, Michal Hocko wrote:
> On Thu 08-11-18 15:33:06, Arun KS wrote:
>> On 2018-11-08 14:04, Michal Hocko wrote:
>> > On Thu 08-11-18 13:53:18, Arun KS wrote:
>> > > Now totalram_pages and managed_pages are atomic varibles. No need
>> > > of managed_page_count spinlock.
>> >
>> > As explained earlier. Please add a motivation here. Feel free to reuse
>> > wording from
>> > http://lkml.kernel.org/r/20181107103630.GF2453@dhcp22.suse.cz
>> 
>> Sure. Will add in next spin.
> 
> Andrew usually updates changelogs if you give him the full wording.
> I would wait few days before resubmitting, if that is needed at all.
> 0day will throw a lot of random configs which can reveal some 
> leftovers.

0day sent one more failure. Will fix that and resend one more version.

Regards,
Arun
