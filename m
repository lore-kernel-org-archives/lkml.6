Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeCNJJ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:09:57 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:49499 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750855AbeCNJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:09:56 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <6c1b7482-2cde-40e3-eff4-e4b94794a63e@theobroma-systems.com>
Date: Wed, 14 Mar 2018 10:09:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b4f644dc-265e-01e0-acaa-88cc8f3f69f5@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.18 08:51, Marc Kleine-Budde wrote:
>> +		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
>> +
>> +	/* don't count error frames as real packets */
>> +	if (!(canid & CAN_ERR_FLAG)) {
>> +		stats->rx_packets++;
>> +		stats->rx_bytes += cf->can_dlc;
>> +	}
> Please count them, too.

We do count them, as errors!

This is what happens when you transmit a single CAN frame with nothing 
connected: "TX errors" shoots up but "RX packets" stays zero.

> root@rk3399-q7:~# ip -details -statistics link show can0
[...]
>     RX: bytes  packets  errors  dropped overrun mcast
>     0          0        0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        20425   0       0       0
