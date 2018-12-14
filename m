Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD2CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8B220643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OGR0J6Qn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d88BVR1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeLNNlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:41:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:41:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 82AA260734; Fri, 14 Dec 2018 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544794873;
        bh=K3r5RFGlpa6obUW0b3/Ju40YiduwaHkpPsh/DsOQdf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OGR0J6Qn8SozdcF5P6GxhNOMFkuhULlIYVh9peglI/SNwXJhjpURfqpewDdYbTZfC
         fE0SExAtqsTF7tIcnBTn/P7v4whBu780lQ1LNkdM5AcAj0ah68oeiki97cXvA3NshG
         9xAvJRHknYbShPWRZI2n1LTI4yTRxCI/OJjHOBko=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9B3C6601D3;
        Fri, 14 Dec 2018 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544794872;
        bh=K3r5RFGlpa6obUW0b3/Ju40YiduwaHkpPsh/DsOQdf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d88BVR1H9PKXuGsnZM+ddH2PApJ+d+Ux7yawqS2Hqfgleb7XOzvstXruIBP4a+9m4
         VCE65WoxmGFuU1pVcd8G8aEKp4/A4jVvJWQHB2FcA3dXc0cwREZJC1nrj9GqMEJH4p
         ZhWCP/7UCJyFLyqjmoPgsYTTWmIMAOjLv9jX9JKA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Dec 2018 19:11:12 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181214131619.GD20658@localhost>
References: <20181130150247.26294-1-bgodavar@codeaurora.org>
 <20181130150247.26294-2-bgodavar@codeaurora.org>
 <20181205062503.GG18087@localhost>
 <c9bcbaed89a18499fe42463b20367499@codeaurora.org>
 <20181212164251.GI3500@localhost>
 <53775e90cb3803cee9cfff2325cb7429@codeaurora.org>
 <20181214131619.GD20658@localhost>
Message-ID: <908712e67aae78acfc2dcf619aedf075@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2018-12-14 18:46, Johan Hovold wrote:
> On Fri, Dec 14, 2018 at 06:02:40PM +0530, Balakrishna Godavarthi wrote:
>> Hi Johan,
>> 
>> On 2018-12-12 22:12, Johan Hovold wrote:
>> > On Thu, Dec 06, 2018 at 04:10:07PM +0530, Balakrishna Godavarthi wrote:
> 
>> >> uart_write_wakeup()->ttyport_write_wakeup()->serdev_controller_write_wakeup()->hci_uart_write_wakeup()->hci_uart_tx_wakeup()
>> >>
>> >>          the above is flow when serdev_device_write() is called, it is
>> >> indirectly calling serdev_write_wakeup().
>> >
>> > No, serdev_device_write_wakeup() is currently not called in this path,
>> > which means you cannot use serdev_device_write().
>> >
>> >>          Why actual we need to call an serdev_write_wakeup() is this
>> >> wakeup related to the UART port or for the BT chip.
>> >
>> > serdev_device_write_wakeup() is where a writer blocked on a full write
>> > buffer in serdev_device_write() is woken up.
>> >
>> > Johan
>> 
>> Is it preferred to use and serdev_device_write_buf() followed by
>> serdev_device_wait_until_sent()
> 
> That's up to the driver author and depends on what you want to achieve.
> 

[Bala]: During the BT on & of, we need to send the commands to the 
controller
at a specific baudrate. as the data is getting queued in the buffer we 
see some times
the data is transmitting on the newer baudrate instead of the actual 
baudrate.
we want to achieve an synchronous data transfer for some commands to 
over come byte corruptions.

> If you want to do something synchronously, you always have to call
> serdev_device_wait_until_sent() after, as both 
> serdev_device_write_buf()
> and serdev_device_write() only buffer the data.
> 
> If you use serdev_device_write_buf() you also have to make sure that 
> you
> can handle incomplete buffering yourself (e.g. when the underlying tty
> driver buffer is getting full).
> 
> serdev_device_write() was added as a convenience helper for this, but
> depends on serdev_device_write_wakeup() being called in the 
> write_wakeup
> path to make forward progress.
> 

[Bala]: Thanks for the info, now i understood the usage of the both 
write() and write_buf().

>> or do we required an write_wakeup() called before writing into
>> serdev_device_write_buf()
> 
> No, that doesn't make any sense. serdev_device_write_wakeup() needs to
> be called in the write-wakeup path, but only if you use
> serdev_device_write().
> 
> Please see the documentation of these function that I added to
> linux-next (and that I linked to earlier).
> 

> Johan

Thanks Johan for the detailed info.

-- 
Regards
Balakrishna.
