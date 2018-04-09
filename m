Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeDIQnc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:43:32 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:35718 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753612AbeDIQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:43:31 -0400
Subject: Re: [PATCH v4 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180403143514.24200-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180403143514.24200-2-jakob.unterwurzacher@theobroma-systems.com>
 <b887637b-6e15-ac2a-1dac-385167595beb@grandegger.com>
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Openpgp: preference=signencrypt
Message-ID: <bb575aba-3f5c-c27c-6421-6ae4d4564271@theobroma-systems.com>
Date: Mon, 9 Apr 2018 18:43:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b887637b-6e15-ac2a-1dac-385167595beb@grandegger.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Wolfgang,

thank you for the review, we have the update ready but we will test a
while it before sending V5.

Regarding your question on the firmware behavior, find the answer inline
below.
> Hello Jacob,
>
> just a few minor issues and a question about bus-off handling...
>
> Am 03.04.2018 um 16:35 schrieb Jakob Unterwurzacher:
>> The UCAN driver supports the microcontroller-based USB/CAN
>> adapters from Theobroma Systems. There are two form-factors
>> that run essentially the same firmware:
>>
>> * Seal: standalone USB stick ( https://www.theobroma-systems.com/seal )
>>
>> * Mule: integrated on the PCB of various System-on-Modules from
>>   Theobroma Systems like the A31-µQ7 and the RK3399-Q7
>>   ( https://www.theobroma-systems.com/rk3399-q7 )
>>
[..snip..]
>> +
>> +	/* we switched into a worse state */
>> +	up->can.state = new_state;
>> +	switch (new_state) {
>> +	case CAN_STATE_BUS_OFF:
>> +		can_stats->bus_off++;
>> +		can_bus_off(up->netdev);
> How does the CAN controller firmware handle bus-off? Does it recover
> automatically? "can_bus_off()" will restart the CAN controller after
> "restart-ms" or manually via netlink "restart" command by calling
> "ucan_set_mode(CAN_START_MODE)":
>
>   # ip link set canX type can restart-ms 100
>   # ip link set canX type can restart
>
> See also:
>
>   https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L597
1) Once a bus-off condition is detected, the device sends an error
   message do indicate the bus state change (the same happens
   also for bus state changes into ERROR_ACTIVE/WARNING/PASSIVE).
2) The device will not restart the bus itself (to give application
   control how to handle this event).
3) The device initiates a bus of recovery upon receiving the control
   message UCAN_COMMAND_RESTART (see ucan_set_mode())
4) The Linux CAN framework handles sending a CAN_ERR_RESTARTED message
   and calling ucan_set_mode().
5) Once the device completes the recovery, it sends a state change
   message indicating that it is in ERROR_ACTIVE state (see 1).
6) During BUS-OFF no error frames or normal frames are set from the
   device to the host.
7) If the device receives a frame from the host when in bus-off (e.g.:
   just after detecting the condition) the device confirms reception by
   sending an TX_COMPLETE with and error indicator and drops the frame.
   Finally the driver calls can_free_echo_skb() upon reception of the
   TX_COMPLETE message (see ucan_tx_complete_msg()).

The protocol documentation will be updated accordingly

[..snip..]
> Thanks for your contribution!
>
> Wolfgang.
>
Best regards
Martin

-- 
Martin Elshuber
Theobroma Systems Design und Consulting GmbH
Seestadtstraße 27 (Aspern IQ), 1220 Wien, Austria
Phone: +43 1 236 98 93-405, Fax: +43 1 236 98 93-9
http://www.theobroma-systems.com
