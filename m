Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E4A2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XFBRcjKt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BQZlx2sL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E4A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeITTcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:32:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITTcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:32:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5FAD60BF5; Thu, 20 Sep 2018 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537451306;
        bh=VsHiiJTvaNC5j/T3pLkuYeNuK8lzmSMeb8Q/nSKjONA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XFBRcjKtioknlVxSK6KqHmG7KWdzPXfmVFf9cKqwVIWqRaOCJwguDfa2SdT72Q5HV
         skJTY5Iqg2f46Bb/ciFHiaveE65WaaH951ipfzL75lquTtwyJjtW1iC0ajgNRj0qzl
         doWUtw9wLhS7lb552IlxZ4kgNenA400uu3nZhWds=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DC9EB607F7;
        Thu, 20 Sep 2018 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537451305;
        bh=VsHiiJTvaNC5j/T3pLkuYeNuK8lzmSMeb8Q/nSKjONA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BQZlx2sLoXE19ILxm2Jg28ZiIvSYhD/fleeLQ+Rvd4wbzENhWGg40tjsZ3GI2SgSb
         tPvbRZ3wU+HvICXANtZf0uMdC0FVa2GVYcBqJDOn0gogegO+YCvLCUtVfbAf5ettik
         UmN/vuACEoOTOqV9kSBeDlxxwCydkm8v/dfEXDXs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 19:18:25 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
In-Reply-To: <20180919172137.GQ22824@google.com>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
 <20180919152113.7611-2-bgodavar@codeaurora.org>
 <20180919172137.GQ22824@google.com>
Message-ID: <47d7644bfaf5844c9194ff7739ea1762@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-09-19 22:51, Matthias Kaehlcke wrote:
> On Wed, Sep 19, 2018 at 08:51:13PM +0530, Balakrishna Godavarthi wrote:
>> This patch enables power off support for hci down and power on support
>> for hci up. As wcn3990 power sources are ignited by regulators, we 
>> will
>> turn off them during hci down, i.e. an complete power off of wcn3990.
>> So while hci up, we will call vendor specific open/close and setup 
>> which
>> will turn on the regulators, requests BT chip version and download the
>> firmware.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 74f5fede0274..c3038afa42af 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -168,6 +168,7 @@ struct qca_serdev {
>> 
>>  static int qca_power_setup(struct hci_uart *hu, bool on);
>>  static void qca_power_shutdown(struct hci_uart *hu);
>> +static int qca_power_off(struct hci_dev *hdev);
>> 
>>  static void __serial_clock_on(struct tty_struct *tty)
>>  {
>> @@ -1099,8 +1100,26 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  static int qca_wcn3990_init(struct hci_uart *hu)
>>  {
>>  	struct hci_dev *hdev = hu->hdev;
>> +	struct qca_serdev *qcadev;
>>  	int ret;
>> 
>> +	/* Check for vregs status, may be hci0 down has turned
>> +	 * off the vregs.
>> +	 */
> 
> nit: it's not necessarily 'hci0', there may be systems with more than
> one Bluetooth controller. You could say hciN instead, you might also
> want to put quotes around 'hciN down' to make clearer this is
> referring to a command.
> 
[Bala]: will update.

>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +	if (qcadev->bt_power->vregs_on == false) {
> 
> nit:
> 	if (!qcadev->bt_power->vregs_on) {
> 
> is more common and easier to read IMO
> 

[Bala]: will update.

>> +		serdev_device_close(hu->serdev);
>> +		ret = qca_power_setup(hu, true);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = serdev_device_open(hu->serdev);
>> +		if (ret) {
>> +			bt_dev_err(hu->hdev, "failed to open port");
> 
> switch the regulators off again?

[Bala]: it is not required to call the regulators off, when the serdev 
open fails.
         as the non zero return status will call the hci_dev_do_close() 
i.e. hdev->shutdown()
> 
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	/* Forcefully enable wcn3990 to enter in to boot mode. */
>>  	host_set_baudrate(hu, 2400);
>>  	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
>> @@ -1152,6 +1171,12 @@ static int qca_setup(struct hci_uart *hu)
>> 
>>  	if (qcadev->btsoc_type == QCA_WCN3990) {
>>  		bt_dev_info(hdev, "setting up wcn3990");
>> +
>> +		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
>> +		 * setup for every hci0 up.
> 
> nit: 'hciN up'?

[Bala]: will update.

> 
>> +		 */
>> +		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>> +		hu->hdev->shutdown = qca_power_off;
>>  		ret = qca_wcn3990_init(hu);
>>  		if (ret)
>>  			return ret;
>> @@ -1242,6 +1267,14 @@ static void qca_power_shutdown(struct hci_uart 
>> *hu)
>>  	qca_power_setup(hu, false);
>>  }
>> 
>> +static int qca_power_off(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +
>> +	qca_power_shutdown(hu);
> 
> Would it make sense to add a return value qca_power_shutdown() now
> that it is called by a non-void function? Might not be worth the
> hassle though, hci_dev_do_close() - the only caller of
> hdev->shutdown() - doesn't check the return value either.
> 

[Bala]: even i felt the same, but hci_dev_do_close() is not checking for 
the status.

> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
