Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0487C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E58B20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E8dlA/kz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gvj5tELY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E58B20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeICVLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeICVLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 009B960445; Mon,  3 Sep 2018 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993404;
        bh=9tPWLCMSgpuieD0ARdaDYsX/uNdWnAay1fLw/f0LQos=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=E8dlA/kzWopFwr107vCpWTVU7vYizcMvKuUeTaEmcpGd3IE0+Zkf435uD8QCY8sSc
         R0z+GNbOG1MNR8ETa/+LRqAJT3G6jL1pDnJWttJL50cuRnLfS5O+SArk/txNQp3Rev
         53E382Wuxb/p+gi8Q4gxHx+ggnpECKc7eoHHSR8U=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC7C760445;
        Mon,  3 Sep 2018 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535993403;
        bh=9tPWLCMSgpuieD0ARdaDYsX/uNdWnAay1fLw/f0LQos=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Gvj5tELYMlHvAQxIC6LIfyRt377fq1Z2nHFVCiVKF1dyO7E4HITPoI6J0NJrFcoOj
         GdRB7PXmz9qDbKmUSrJ3bz5fJwpymTfdkjAjpnYQw3ig475NDF4ucDbcd4YyHmI6xV
         4r9Hn63OIYUeGm7v3Hfa27wZ/UVEsXTH0lcg2UjM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC7C760445
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        govinds@codeaurora.org, linux-wireless@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
References: <20180810233948.144792-1-briannorris@chromium.org>
        <5B6F2A47.7070502@broadcom.com>
        <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
        <5B71CDFB.60408@broadcom.com>
        <878t4qftnm.fsf@kamboji.qca.qualcomm.com>
        <20180829001453.GA173345@ban.mtv.corp.google.com>
Date:   Mon, 03 Sep 2018 19:49:58 +0300
In-Reply-To: <20180829001453.GA173345@ban.mtv.corp.google.com> (Brian Norris's
        message of "Tue, 28 Aug 2018 17:14:54 -0700")
Message-ID: <87ftyq8r0p.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Tue, Aug 28, 2018 at 05:33:01PM +0300, Kalle Valo wrote:
>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>> 
>> > On 8/13/2018 7:14 PM, Brian Norris wrote:
>> >> On Sat, Aug 11, 2018 at 11:26 AM Arend van Spriel
>> >> <arend.vanspriel@broadcom.com> wrote:
>> >>>
>> >>> On 8/11/2018 1:39 AM, Brian Norris wrote:
>> >>>> Devices may provide their own MAC address via system firmware (e.g.,
>> >>>
>> >>> You got me confused by using just "firmware" in the subject.
>> >>
>> >> Yeah...I started by writing this patch with device tree specifically
>> >> (of_get_mac_address()), and then later found that there were generic
>> >> "device" helpers for this, which can assist with other sorts of
>> >> firmware nodes. It was easier to put a name on a device tree patch
>> >> than on a "device" patch. I suppose "system firmware" might be a
>> >> better description?
>> >>
>> >>>> device tree), especially in the case where the device doesn't have a
>> >>>> useful EEPROM on which to store its MAC address (e.g., for integrated
>> >>>> Wifi).
>> >>>>
>> >>>> Use the generic device helper to retrieve the MAC address, and (if
>> >>>> present) honor it above the MAC address advertised by the card.
>> >>>
>> >>> But this put me back on track ;-)
>> >>
>> >> Let me know if you have a better way to clarify. I can resend with a
>> >> slightly modified subject (s/firmware/system firmware/), or let Kalle
>> >> do it, if that's the only thing to change.
>> >
>> > "system firmware" substitution works for me.
>> 
>> What about:
>> 
>> ath10k: retrieve MAC address from Device Tree if provided
>> 
>> Because from ath10k point of view we use Device Tree functions and don't
>> care if it's delivered by pidgeons or by system firmware :)
>
> I don't care too much, but note that Device Tree is a loaded term,
> usually referring specifically to a method of describing system hardware
> via the Flattened Device Tree format. If I were specifically targeting
> Device Tree, I'd use helpers like of_get_mac_address() instead. (The
> 'of_*' prefix is a relic of OpenFirmware, an early firmware
> implementation that used the Device Tree format.)

My bad, I read your patch hastily and somehow understood you were using
of_get_mac_address() but you were actually using
device_get_mac_address(). So I'll change this to "system firmware" as
originally suggested.

Sorry for the confusion.

-- 
Kalle Valo
