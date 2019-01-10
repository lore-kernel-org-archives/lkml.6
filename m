Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD6F21783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hxonHDkP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="efgbsdor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfAJOwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:52:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfAJOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:52:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 683FA608C6; Thu, 10 Jan 2019 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547131935;
        bh=hIXiILI5C4y24hHeAtwGojns8dRLrMtEJ59Jiir/WD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hxonHDkPp8KqnmgBL/HrSvemr9grkclvhEsYENJvQ0MyupkBj/JNgNsk+p7mb5KUj
         B1tuoI3pVX6Eyj/ztKhWL4mVWc2RF2HsF01atHHt5hqbSiILuijS0krgC1dzOzClKv
         dqeNACmwwbvCZPPGoEHMxzbjhN86oUGyslXfzBqI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B239B6092B;
        Thu, 10 Jan 2019 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547131933;
        bh=hIXiILI5C4y24hHeAtwGojns8dRLrMtEJ59Jiir/WD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=efgbsdorTh9YFK+uZdmYj/6/sQCXyfv8GPN2/0VOg98V76oIdnwTRjsvZ3wgjaE/Z
         qrs7M1tjEmzsTuKOKspda8EX7nrroOWlnTemR4bYkE3qn9IPB7XJWXuxLiq/lNg86s
         vuYP3D92KWExm9nDO8JtRvdSYPrNTTNWXkPpvGtI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 20:22:12 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20190110143928.GE3430@localhost>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
Message-ID: <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2019-01-10 20:09, Johan Hovold wrote:
> On Thu, Jan 10, 2019 at 08:04:12PM +0530, Balakrishna Godavarthi wrote:
>> Hi Johan,
>> 
>> On 2019-01-09 20:22, Johan Hovold wrote:
>> > On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
>> >> This patch will help to stop frame reassembly errors while changing
>> >> the baudrate. This is because host send a change baudrate request
>> >> command to the chip with 115200 bps, Whereas chip will change their
>> >> UART clocks to the enable for new baudrate and sends the response
>> >> for the change request command with newer baudrate, On host side
>> >> we are still operating in 115200 bps which results of reading garbage
>> >> data. Here we are pulling RTS line, so that chip we will wait to send
>> >> data
>> >> to host until host change its baudrate.
> 
>> >> +		/* Deassert RTS while changing the baudrate of chip and host.
>> >> +		 * This will prevent chip from transmitting its response with
>> >> +		 * the new baudrate while the host port is still operating at
>> >> +		 * the old speed.
>> >> +		 */
>> >> +		qcadev = serdev_device_get_drvdata(hu->serdev);
>> >> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> >> +			serdev_device_set_rts(hu->serdev, false);
>> >> +
>> >
>> > This may not do what you want unless you also disable hardware flow
>> > control.
> 
>> Here my requirement here is to block the chip to send its data before
>> HOST changes it is baudrate. So if i disable flow control lines of
>> HOST which will be in low state.  so that the chip will send it data
>> before HOST change the baudrate of HOST. which results in frame
>> reassembly error.
> 
> Not sure I understand what you're trying to say above. My point is that
> you cannot reliable control RTS when you have automatic flow control
> enabled (i.e. it is managed by hardware and it's state reflects whether
> there's room in the UART receive FIFO).
> 
> Johan

[Bala]: Yes i got your point, but our driver will not support automatic 
flow control (based on the FIFO status)
         unless we explicitly enabled via software. i.e. if we enable the 
flow, hardware will look for it.
         else it will not looks for CTS or RTS Line.

-- 
Regards
Balakrishna.
