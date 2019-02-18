Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799A72176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfBRKuz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:50:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50998 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:50:54 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 63B80CF2C7;
        Mon, 18 Feb 2019 11:58:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v11 0/3] Bug fixes for Qualcomm BT chip wcn3990
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190204150643.25165-1-bgodavar@codeaurora.org>
Date:   Mon, 18 Feb 2019 11:50:51 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CB022FBC-122B-41D8-A7C1-DD29276C3A3A@holtmann.org>
References: <20190204150643.25165-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> The below issues are found in our recent testing.
> 
> 1. Observed device is not going into off state or not responding.
>    As wcn3990 require a power pulses to turn on the irrespctive of
>    igniting regulators, it was observed that power on or power off
>    pulses are not in sync with respective to chip.
>    The below patch will help us to wait until byte is pushed on to wires.          
> 
>    * Bluetooth: hci_qca: use wait_until_sent() for power pulses
> 
> 2. Observed Chip responding when we are in sleep.
>   This is due to turn on flow control during change baudrate request.
>   The below patch will only pull the RTS line high instead of turning off
>   the flow.
> 
>   * Bluetooth: hci_qca: Pull RTS line high for baudrate change command.
> 
> 3. Disable IBS state machine and flush Tx buffer
>   We are disabling IBS and flushing the Tx buffer before turning off the chip.
> 
>   This is due to IBS state machine is active when we turn off the chip.
>   This will stop queuing IBS protocol bytes.
> 
>   * Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
> 
> Changes in v11:
> * added correct signatures for the patch.
> 
> Changes in v10:
> * Decreased wait time for power pulse to 100 ms instead of 1second.
> * enabling the flow control back when baudarte change request fails.
> * updated review comments.
> 
> Changes in v9:
> * Reverted the 100us delay and used msecs to jiffies inline call.
> * Disabling the flow control and enabling it back while setting the firmware.
> * Added spinlock while clearing the IBS state machine.
> 
> Changes in v8:
> * dropped inject the command complete event.
> * added one second time for the power pules instead of the indefinite time.
> 
> Changes in v7:
> * dropped frame reassmebly error patch.
> * dropped baudrate change wait time patch.
> * increased a wait to 5 ms for power pulses.
> 
> Changes in v6:
> * added serdev_device_write_flush in qca_send_power_pulse().
> * added new patch to update the baudrate change wait time.
> 
> Changes in V5:
> * added serdev_device_write_flush before sending the power off pulse
>   during shutdown.
> 
> Changes in v4:
> * used serdev_device_write_buf() instead of serdev_device_write().
> * added new patch to stop logging of 0xfc00 timeout on console.
> 
> Changes in v3:
> * moved IBS & qca_flush to different patch
> * updated comments in code fo Deassert RTS patch
> Balakrishna Godavarthi (3):
>  Bluetooth: hci_qca: use wait_until_sent() for power pulses
>  Bluetooth: hci_qca: Deassert RTS while baudrate change command
>  Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
> 
> drivers/bluetooth/hci_qca.c | 82 ++++++++++++++++++++-----------------
> 1 file changed, 44 insertions(+), 38 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

