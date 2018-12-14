Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD90C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EBD20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o9ouC+mC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ewahheGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EBD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeLNMcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:32:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbeLNMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:32:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D9A560722; Fri, 14 Dec 2018 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790761;
        bh=XekRt2hOofubrQgZvxE6EGgbsMq2ApkjU2sMqT1r22k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o9ouC+mC9AG4D3UWAv9YGiN8d+PtntqTZSc+YWKajn9Gdxo3NKG+WVsbs5iaIY7UI
         +TwC6sDaGSDJfvkz669UZ5Ys6y5v7Qnsq1WQ3MCAEnSOhhQs8b6StQNjxZT7VYVe4P
         MDKpXkUTitvX7K/gIGqfvW1cz34nzHt0VZ+KHUKc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C730C601C3;
        Fri, 14 Dec 2018 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790760;
        bh=XekRt2hOofubrQgZvxE6EGgbsMq2ApkjU2sMqT1r22k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ewahheGZZvnWEw1MD28ruUWcGcNCI1jvpQZ1iO6FFDxy4tgJG4gGsu1b9WTOtw1ES
         KoU8S2FnINRIsaPdngEtY/oHRWDKeQaihmCmomljbb5HgnfzBijUYsIe72/1zpEMZO
         e1MhMn4ijisTuP9TrGN17g6WPeqtQRERsd+H4khE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Dec 2018 18:02:40 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181212164251.GI3500@localhost>
References: <20181130150247.26294-1-bgodavar@codeaurora.org>
 <20181130150247.26294-2-bgodavar@codeaurora.org>
 <20181205062503.GG18087@localhost>
 <c9bcbaed89a18499fe42463b20367499@codeaurora.org>
 <20181212164251.GI3500@localhost>
Message-ID: <53775e90cb3803cee9cfff2325cb7429@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2018-12-12 22:12, Johan Hovold wrote:
> On Thu, Dec 06, 2018 at 04:10:07PM +0530, Balakrishna Godavarthi wrote:
>> Hi Johan,
>> 
>> On 2018-12-05 11:55, Johan Hovold wrote:
>> > On Fri, Nov 30, 2018 at 08:32:44PM +0530, Balakrishna Godavarthi wrote:
> 
>> >> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
>> >
>> > You're still using 0 as a timeout here which is broken, as I already
>> > told you.
>> 
>> [Bala]: got the change now will update to timeout to non zero value.
>> 
>> > From 4.21 this will result in an indefinite timeout, but currently
>> > implies not to wait for a full write buffer to drain at all.
>> >
>> > As I also mentioned, you need to to make sure to call
>> > serdev_device_write_wakeup() in the write_wakup() path if you are going
>> > to use serdev_device_write() at all.
>> 
>> [Bala]: this where i am confused.
>>          calling serdev_device_write is calling an wakeup internally.
>> below is the flow
>> 
>>          ttyport_write_buf:
>>                * calling serdev_device_write() will call write_buf() 
>> in
>> this call we are enabling bit "TTY_DO_WRITE_WAKEUP" and calling 
>> write()
>>                  i.e. uart_write() where we call in start_tx. this 
>> will
>> go to the vendor specific write where in isr we call 
>> uart_write_wakeup()
>> 
>> https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/qcom_geni_serial.c#L756
>> 
>> 
>> uart_write_wakeup()->ttyport_write_wakeup()->serdev_controller_write_wakeup()->hci_uart_write_wakeup()->hci_uart_tx_wakeup()
>> 
>>          the above is flow when serdev_device_write() is called, it is
>> indirectly calling serdev_write_wakeup().
> 
> No, serdev_device_write_wakeup() is currently not called in this path,
> which means you cannot use serdev_device_write().
> 
>>          Why actual we need to call an serdev_write_wakeup() is this
>> wakeup related to the UART port or for the BT chip.
> 
> serdev_device_write_wakeup() is where a writer blocked on a full write
> buffer in serdev_device_write() is woken up.
> 
> Johan

Is it preferred to use and serdev_device_write_buf() followed by 
serdev_device_wait_until_sent()
or do we required an write_wakeup() called before writing into 
serdev_device_write_buf()

-- 
Regards
Balakrishna.
