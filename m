Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A608FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F03B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aQ/OxBfH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VX1a34x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F03B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeH1SZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:25:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeH1SZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:25:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1892460445; Tue, 28 Aug 2018 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535466786;
        bh=g4U5J9PguuQNhpVwCWp0SU3mmfZtzQFF8tMbaf9Bt2s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aQ/OxBfHTpJ/Nf8WB2e+uF+y77Sg1SzHNW+huxeA8t9z9ZEGAaZ9zhqxrhVdoRvv8
         BNaD37tesoV0Ik1BeFvK8zWgPiALAYcWg2X2YEpoK4LOeKXP84jkHvAZE+bxpbJ4XE
         Voqa0UXXoCyshe45CRw4BG1vfOS4+7SKv1RqDnkw=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D32656021C;
        Tue, 28 Aug 2018 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535466785;
        bh=g4U5J9PguuQNhpVwCWp0SU3mmfZtzQFF8tMbaf9Bt2s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VX1a34x4NUP5K36Epyrgjt8m/fFzfasghxLiHtBd+D5xIFKGMXaLeKfX59fhIbkJ7
         0fgD6ITe+3N2KI+55atQWrgnB5+gz3EZTSmeEIXeu2py/6nmEMh0ymWnx0RLyeNXSf
         3xWV9kiW+qYZ9u9UKIfUHsydhRxDgtbZpKiD7ur4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D32656021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Brian Norris <briannorris@chromium.org>, govinds@codeaurora.org,
        linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
References: <20180810233948.144792-1-briannorris@chromium.org>
        <5B6F2A47.7070502@broadcom.com>
        <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
        <5B71CDFB.60408@broadcom.com>
Date:   Tue, 28 Aug 2018 17:33:01 +0300
In-Reply-To: <5B71CDFB.60408@broadcom.com> (Arend van Spriel's message of
        "Mon, 13 Aug 2018 20:29:15 +0200")
Message-ID: <878t4qftnm.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 8/13/2018 7:14 PM, Brian Norris wrote:
>> On Sat, Aug 11, 2018 at 11:26 AM Arend van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>>
>>> On 8/11/2018 1:39 AM, Brian Norris wrote:
>>>> Devices may provide their own MAC address via system firmware (e.g.,
>>>
>>> You got me confused by using just "firmware" in the subject.
>>
>> Yeah...I started by writing this patch with device tree specifically
>> (of_get_mac_address()), and then later found that there were generic
>> "device" helpers for this, which can assist with other sorts of
>> firmware nodes. It was easier to put a name on a device tree patch
>> than on a "device" patch. I suppose "system firmware" might be a
>> better description?
>>
>>>> device tree), especially in the case where the device doesn't have a
>>>> useful EEPROM on which to store its MAC address (e.g., for integrated
>>>> Wifi).
>>>>
>>>> Use the generic device helper to retrieve the MAC address, and (if
>>>> present) honor it above the MAC address advertised by the card.
>>>
>>> But this put me back on track ;-)
>>
>> Let me know if you have a better way to clarify. I can resend with a
>> slightly modified subject (s/firmware/system firmware/), or let Kalle
>> do it, if that's the only thing to change.
>
> "system firmware" substitution works for me.

What about:

ath10k: retrieve MAC address from Device Tree if provided

Because from ath10k point of view we use Device Tree functions and don't
care if it's delivered by pidgeons or by system firmware :)

I can change this before I commit.

-- 
Kalle Valo
