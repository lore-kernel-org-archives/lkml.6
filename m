Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A59A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YlsKT+2w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8TkQYrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A59A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeK0R6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:58:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeK0R6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:58:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9AC7D607EB; Tue, 27 Nov 2018 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543302066;
        bh=99s0G9gWfBRo6sOq7eQpfEBnrtKMP6fHiXwBohT5Y8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YlsKT+2wCaRaYPTe80oPBcmK3W5AfdIO2wv+6QoJWSPXLxH1yrXOALhVmOTZf6n0o
         sqvCvCBcHVi+ln9Tnv3KrCpXk9oQk9dLPfmMZVQ7eVNv2g162Day/830kRj7woCedL
         0kpGDxQQ+hcU9CdWh0LJDd5fdriicVUDUDaUPCv0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A9FCB607EB;
        Tue, 27 Nov 2018 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543302065;
        bh=99s0G9gWfBRo6sOq7eQpfEBnrtKMP6fHiXwBohT5Y8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h8TkQYrnNs/Zj58oAk9XiA9/6CodgFpjPdXpz7a196CvVHRCFhE6EhrDXsT8xN5i2
         dGVOLZoSxDiH3JIPkOnPCmJQNjkL5dlM0Je+sOjL9mXYJN/hbEfBHKIJ/7pt/vmMIp
         Wx0FRnYZTctw4cP0LRgOByOVWnW0ePBg4ylFo4ZE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Nov 2018 12:31:05 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
In-Reply-To: <20181127002744.GZ22824@google.com>
References: <20181122121512.13136-1-bgodavar@codeaurora.org>
 <20181122121512.13136-4-bgodavar@codeaurora.org>
 <20181127000950.GY22824@google.com> <20181127002744.GZ22824@google.com>
Message-ID: <7453751357b0708af05c1ff3de8f1a2d@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-11-27 05:57, Matthias Kaehlcke wrote:
> On Mon, Nov 26, 2018 at 04:09:50PM -0800, Matthias Kaehlcke wrote:
>> On Thu, Nov 22, 2018 at 05:45:12PM +0530, Balakrishna Godavarthi 
>> wrote:
>> > During initalization of wcn3990, we observed UART is reading some
>> > stray bytes on the Rx line. This is logging Frame reassembly errors
>> > on the serial console. This could be because of tristate of Tx line
>> > of wcn3990 during boot up.
>> >
>> > [  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
>> > [  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
>> > [  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
>> > [  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
>> > [  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
>> >
>> > Now we enable a flag during bootup to stop executing proto receive
>> > function and clear it back once the initialization is done.
>> >
>> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> > ---
>> > v2:
>> >  * Updated commit text & comments.
>> > v1:
>> >  * initial patch
>> > ---
>> >  drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
>> >  1 file changed, 18 insertions(+)
>> >
>> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > index ed905ea1c58a..2f3d9e16ba5a 100644
>> > --- a/drivers/bluetooth/hci_qca.c
>> > +++ b/drivers/bluetooth/hci_qca.c
>> > @@ -56,6 +56,7 @@
>> >
>> >  /* Controller states */
>> >  #define STATE_IN_BAND_SLEEP_ENABLED	1
>> > +#define STATE_DISCARD_RX		2
>> >
>> >  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>> >  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>> > @@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
>> >  		} else {
>> >  			hu->init_speed = qcadev->init_speed;
>> >  			hu->oper_speed = qcadev->oper_speed;
>> > +			set_bit(STATE_DISCARD_RX, &qca->flags);
>> >  			ret = qca_power_setup(hu, true);
>> >  			if (ret) {
>> >  				destroy_workqueue(qca->workqueue);
>> > @@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
>> >  	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>> >  		return -EUNATCH;
>> >
>> > +	/* We discard Rx data received while device is in booting
>> > +	 * stage, This is because of BT chip Tx line is in tristate.
>> > +	 * Due to this we read some garbage data on UART Rx.
>> > +	 */
>> > +	if (test_bit(STATE_DISCARD_RX, &qca->flags))
>> > +		return 0;
>> > +
>> >  	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
>> >  				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
>> >  	if (IS_ERR(qca->rx_skb)) {
>> > @@ -1193,6 +1202,7 @@ static int qca_setup(struct hci_uart *hu)
>> >  		if (ret)
>> >  			return ret;
>> >
>> > +		clear_bit(STATE_DISCARD_RX, &qca->flags);
>> >  		ret = qca_read_soc_version(hdev, &soc_ver);
>> >  		if (ret)
>> >  			return ret;
>> > @@ -1269,6 +1279,14 @@ static const struct qca_vreg_data qca_soc_data = {
>> >
>> >  static void qca_power_shutdown(struct hci_uart *hu)
>> >  {
>> > +	struct qca_data *qca = hu->priv;
>> > +
>> > +	/* From this point we go into power off state,
>> > +	 * disable IBS and discard all the queued data.
>> > +	 */
>> > +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> 
>> Is IBS actually related to the frame reassembly errors or is this
>> addressing a different issue? In 100 iteratios of 'hciconfig up/down'
>> without clearing the flag I didn't observe any frame reassembly
>> errors.
> 
> Looks like this addresses the "Bluetooth: Received HCI_IBS_SLEEP_IND
> in rx state 0" messages that are seen when the interface is brought up
> on a system with firmware binaries (with IBS support?). Please spin
> this out into a separate patch.
> 

[Bala]: "Bluetooth: Received HCI_IBS_SLEEP_IND in rx state 0 is an 
different issue.
          i suspect that is due to mismatch of ibs timers over flow value 
between wcn3990 & HOST.
          clearing ibs is required, to stop ibs state machine while we do 
hci close
          this is intern help in resolving the frame reassembly errors 
during close (in rare case observed)
          anyways will send this a separate patch.

> Thanks
> 
> Matthias


-- 
Regards
Balakrishna.
