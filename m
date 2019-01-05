Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBEDC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8C62085A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hRoiQ7uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfAEOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 09:22:02 -0500
Received: from pb-sasl21.pobox.com ([173.228.157.49]:54707 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 09:22:01 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2019 09:21:57 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl21.pobox.com (Postfix) with ESMTP id BA624206FC;
        Sat,  5 Jan 2019 09:14:25 -0500 (EST)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=6SjZ3XtcDrYM
        A8XtApDh303B+OE=; b=hRoiQ7uK2G5gpf+Z/gg2COXeM00YbuLbG9t5yCr7Xb24
        hQIOBQeD+SoLT1vc5VNbq7KmBEIChT+sYFfQGCQWdJAizq/wvjhJ2OKrNaCg3NrI
        DUy/YwhvDI0VGw/SrOMQ3gxJYUQBGHkwSdAuw0ZoVPBSpX/pn4/FVUcx5Kuck9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZsrhaD
        sOqU3TPLuyEiEs6tkZ0egRypGmjAZRTKL1GhfYBk/11yPp7YeZGCJKmf8knR/NKo
        cFrYYdZ/cJjfTgOA+cRjxQYn2a8Ru4VB2FMmsDC+0MNwYP9+9BiTfTO1KSiZWD25
        8zAUV+Rqdxp1eem4ehXyWOe02k7fShyFeZtUw=
Received: from pb-sasl21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-sasl21.pobox.com (Postfix) with ESMTP id B1029206FB;
        Sat,  5 Jan 2019 09:14:25 -0500 (EST)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.53.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl21.pobox.com (Postfix) with ESMTPSA id 9A8F4206FA;
        Sat,  5 Jan 2019 09:14:22 -0500 (EST)
        (envelope-from mlord@pobox.com)
Subject: r8152: data corruption in various scenarios
To:     Ansis Atteka <aatteka@nicira.com>,
        Hayes Wang <hayeswang@realtek.com>
Cc:     David Miller <davem@davemloft.net>,
        "greg@kroah.com" <greg@kroah.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
From:   Mark Lord <mlord@pobox.com>
Message-ID: <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
Date:   Sat, 5 Jan 2019 09:14:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 3385DBF8-10F4-11E9-9219-B0A4589248B8-82205200!pb-sasl21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of years back, I reported data corruption resulting from
a change in kernel 3.16 which enabled hardware checksums in the r8152 driver.
This was happening on an embedded system that was using a r8152 USB dongle.

At the time, it was very difficult to figure out what could possibly be causing it,
other than that re-enabling software checksums prevented corrupted packets from
resulting in more serious issues.

Since that time, more and more reports of similar corruption and issues
have been trickling in.  Eg.

   https://lore.kernel.org/patchwork/patch/873920/

Note that there are reports in the thread above that the issues
are not limited to only the built-in ethernet chip of the dock.

There is even now a special hack in the upstream r8152.c to attempt to detect
a Dell TB16 dock and disable RX Aggregation in the driver to prevent such issues.

Well.. I have a WD15 dock, not a TB16, and that same hack also catches my dock
in its net:

    [5.794641] usb 4-1.2: Dell TB16 Dock, disable RX aggregation

So one issue is that the code is not correctly identifying the dock,
and the WD15 is claimed to be immune from the r8152 issues.

One of the symptoms of the r8152 issue, reported by Ansis Atteka,
were messages like this:

   xhci_hcd 0000:39:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 13
comp_code 1

I just got that exact message above, with the r8152 in my 1-day old WD15 dock,
with the TB16 "workaround" enabled in Linux kernel 4.20.0.

From this I conclude that the workaround is not 100% complete yet.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
