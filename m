Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeCNTHw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:07:52 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:52820 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751379AbeCNTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:07:50 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
 <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
 <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
 <92e559b1-d392-015e-1aa1-0497cbd4c071@grandegger.com>
 <5b3df9d5-3e65-1114-4b51-9dcc329cbc31@theobroma-systems.com>
 <b5bf52e2-0843-a2b3-b039-c39fb9c634e3@grandegger.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <1bd41545-facb-9314-005b-4e742c4c61da@theobroma-systems.com>
Date: Wed, 14 Mar 2018 20:07:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5bf52e2-0843-a2b3-b039-c39fb9c634e3@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.18 11:04, Wolfgang Grandegger wrote:
>>>  (000.000443)  can0  20000034   [8]  00 0C 00 00 00 00 78 00   ERRORFRAME
>>>     controller-problem{rx-error-warning,tx-error-warning}
>>>     transceiver-status
>>>     no-acknowledgement-on-tx
>>>     error-counter-tx-rx{{120}{0}}
>>>  (000.000444)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
>>>     controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive} 
> 
> Just,
> 
>        controller-problem{rx-error-passive,tx-error-passive} 
>[...]
> 
> Back to error active is missing!?

That was indeed missing. We have fixed the missing back-to-error-active 
in our firmware.

Also, we no longer send the controller status in every error frame, but 
only on state changes (see below) which seems to be how other drivers 
are handling things.

Thanks,
Jakob

*** test output ***

Disconnect cable, send one frame

> root@rk3399-q7:~# candump -td -e any,0:0,#FFFFFFFF | head -n 100
>  (000.000000)  can0  6E7   [2]  7A F9
>  (000.000558)  can0  20000030   [8]  00 00 00 00 00 00 08 00   ERRORFRAME
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{8}{0}}
[...]
>  (000.000567)  can0  20000034   [8]  00 0C 00 00 00 00 60 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{96}{0}}
[...]
>  (000.000527)  can0  20000034   [8]  00 30 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{rx-error-passive,tx-error-passive}
> 	transceiver-status
> 	no-acknowledgement-on-tx
> 	error-counter-tx-rx{{128}{0}}
[...]

Reconnect cable

>  (000.000687)  can1  6E7   [2]  7A F9
>  (000.000015)  can0  20000004   [8]  00 0C 00 00 00 00 7F 00   ERRORFRAME
> 	controller-problem{rx-error-warning,tx-error-warning}
> 	error-counter-tx-rx{{127}{0}}

Send more frames

>  (046.485245)  can0  61B   [2]  E2 D8
>  (000.000621)  can1  61B   [2]  E2 D8
[...]
>  (000.199224)  can0  3E6   [0]
>  (000.000477)  can1  3E6   [0]
>  (000.000044)  can0  20000004   [8]  00 40 00 00 00 00 5F 00   ERRORFRAME
> 	controller-problem{back-to-error-active}
> 	error-counter-tx-rx{{95}{0}}
