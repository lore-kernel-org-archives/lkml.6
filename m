Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C3AC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7240720856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kXQXFaq/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pDyFPPGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfAQQzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:55:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfAQQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:55:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F74660A31; Thu, 17 Jan 2019 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547744136;
        bh=RTpGQeuvcb5f3Ott/HNxLlLNxn36tu+Iomnxy8WHh18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kXQXFaq/YbKYqwMzqrUc9+KLe32K9/yPS+Qk6+Cgs5QtWi7YCjibJFZ98mqGZ7DXU
         trrUGbofFW+fSCm5olvfP/O5jnppFWro1nDXoc1RhiO1hdfNxxg1spNp8LzHiI+ACn
         DWaYoU25Is/tfnlCcQZhAwmTYeFtrfnA/fLSomT4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A0BED60A44;
        Thu, 17 Jan 2019 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547744134;
        bh=RTpGQeuvcb5f3Ott/HNxLlLNxn36tu+Iomnxy8WHh18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pDyFPPGTonbD/WD8pocLmSTYt7hmAwcrflfKvD14cOxmVhZoeM7el7Vj/kKsZYKt7
         YMFGZe55+5M8qqYYOOzpA/AOFomRgdJOnwySC49BVFTcDuPtQ3es9ZLwDPsc5kiOwM
         ADhDiLOIK8qw8XqGIBiswg2MmpQThaMvsYiCGgUQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 22:25:33 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20190117161331.GW3691@localhost>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
 <20190116114603.500-2-bgodavar@codeaurora.org>
 <20190116202253.GS261387@google.com>
 <482d8987d38f60dae1844bc30050cd06@codeaurora.org>
 <20190117161331.GW3691@localhost>
Message-ID: <21ac40f7314788e2d25b97628f998eb3@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-17 21:43, Johan Hovold wrote:
> On Thu, Jan 17, 2019 at 03:55:17PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2019-01-17 01:52, Matthias Kaehlcke wrote:
> 
>> >> -	/* Wait for 100 uS for SoC to settle down */
>> >> -	usleep_range(100, 200);
>> >> +	serdev_device_wait_until_sent(hu->serdev, timeout);
>> >> +	/* Wait of 5ms is required for assuring to send the byte on the Tx
>> >> +	 * line and also for the controller to settle down for the received
>> >> +	 * byte.
>> >> +	 */
>> >> +	usleep_range(5000, 6000);
>> >
>> > I incorrectly claimed that there might be still bytes sitting in the
>> > UART FIFO when serdev_device_wait_until_sent() returns, Johan
>> > corrected me on that (thanks!). So if it takes the SoC 100us to settle
>> > down we should be good with the original code.
>> 
>> [Bala]: sure will revert, i think he commented that wait_until_sent()
>> will only guarantee circular buffer is empty. if wait_until_sent()
>> guarantee us that the data was transmitted from the FIFO, then 100us
>> will work.
> 
> No, Matthias is correct; I claimed that the UART FIFO will be empty (at
> least as long as flow control is disabled, otherwise it may never empty
> and we therefore also have a time out).
> 
> Johan

[Bala]: Thanks Johan for clarification.
-- 
Regards
Balakrishna.
