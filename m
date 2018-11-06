Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AB820862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OW7sRjVJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OW7sRjVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AB820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbeKFWJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:09:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbeKFWJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:09:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2DAA6038E; Tue,  6 Nov 2018 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541508282;
        bh=H7k2718FlCiAqf+cl1gUDgKIAkUYsMI7izgXsc+9Q/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OW7sRjVJtA43Gs2Jt9VYLkuZP0FasG9eONjdDisM52B+hPPZBFJSl8h8n1Cbo47VB
         grBg4uPaOWR2C/f285mVmmbhJYOg456ebdMc9lfZtA4NVDr+Z2dX/k36bkBC/4fsqj
         my92HdAfLVIsgR5qd4EidhKEuuDCyTZBeirCcev8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E589B6038E;
        Tue,  6 Nov 2018 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541508282;
        bh=H7k2718FlCiAqf+cl1gUDgKIAkUYsMI7izgXsc+9Q/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OW7sRjVJtA43Gs2Jt9VYLkuZP0FasG9eONjdDisM52B+hPPZBFJSl8h8n1Cbo47VB
         grBg4uPaOWR2C/f285mVmmbhJYOg456ebdMc9lfZtA4NVDr+Z2dX/k36bkBC/4fsqj
         my92HdAfLVIsgR5qd4EidhKEuuDCyTZBeirCcev8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 06 Nov 2018 18:14:41 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 3/4] Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE
 flag
In-Reply-To: <462C4F58-E6E2-4B20-B074-72DDFA6D7364@holtmann.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-4-bgodavar@codeaurora.org>
 <462C4F58-E6E2-4B20-B074-72DDFA6D7364@holtmann.org>
Message-ID: <170e0419929840109d349b5df5e38364@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-11-06 18:03, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>> During hci down we are sending reset command to chip, which
>> is not required for wcn3990, as hdev->shutdown() will turn off the
>> regulators.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> drivers/bluetooth/hci_qca.c | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 8301663f0004..97b57e0f4725 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1190,6 +1190,7 @@ static int qca_setup(struct hci_uart *hu)
>> 		 */
>> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>> 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> +		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>> 		hu->hdev->shutdown = qca_power_off;
>> 		ret = qca_wcn3990_init(hu);
>> 		if (ret)
> 
> I am pretty certain that you didn’t want this quirk:
> 
>         /* When this quirk is set, the HCI Reset command is send when
> 
>          * closing the transport instead of when opening it.
> 
> This quirk is for Bluetooth 1.0b devices where the HCI_Reset behavior
> was not clear or for devices that actually misbehave with the initial
> HCI_Reset.
> 
> In addition, you commit message is totally misleading. That is not
> what is happening with this quirk.
> 
> Regards
> 
> Marcel

My intention was reset command is not required when we do an hci down.
this is because of hdev->shutdown will turn off the regulators.
It is like turning off the chip. sending reset command after turning off 
the chip is not required.

I understand the usage of the quirk, will update the commit text.


-- 
Regards
Balakrishna.
