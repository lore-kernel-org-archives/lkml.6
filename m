Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCZQoy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:44:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35521 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCZQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:44:51 -0400
X-Google-Smtp-Source: AIpwx48zmtyJllvJXK5oizgX8f7jWohylsCLhvgiG9VHGGjEMu7+M4YV5aF5O2h1mg9wYLNbwjj0AQ==
From: Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH v5 3/3] Bluetooth: hci_qca: Add serdev support
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-4-thierry.escande@linaro.org>
 <7097660B-DC63-4685-B095-4D5C37ECD89E@holtmann.org>
Message-ID: <48a11dfb-5869-58f1-a57d-f18c5eb7aec6@linaro.org>
Date: Mon, 26 Mar 2018 18:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7097660B-DC63-4685-B095-4D5C37ECD89E@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 20/03/2018 16:49, Marcel Holtmann wrote:
> Hi Thierry,
> 
>> Add support for Qualcomm serial slave devices. Probe the serial device,
>> retrieve its maximum speed and register a new hci uart device.
>>
>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>> ---
>>
>> v5:
>> - Use gpio new name 'enable'
>>
>> v4:
>> - Rename divclk4 as susclk (its name in the bt chip)
>> - Use gpiod_set_value_cansleep()
>> - Replace #include <linux/of.h> with <linux/mod_devicetable.h>
>> - Restore dependency on BT_HCIUART
>>
>> v3:
>> - Remove redundant call to gpiod_set_value() after devm_gpiod_get()
>> - Check returned values for clk_set_rate() and clk_prepare_enable()
>> - Use clk_disable_unprepare()
>>
>> v2:
>> - Fix author email
>>
>> drivers/bluetooth/Kconfig   |   1 +
>> drivers/bluetooth/hci_qca.c | 109 +++++++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 108 insertions(+), 2 deletions(-)
>>

<snip>

> 
> so this a more generic question. Does the clk setup has to be done in serdev probe or can we just do that within qca_open callback. I asked because I really want to move towards btuart.c and integrate the vendor specific pieces there nicely. So what I did was that I posted a v2 that has the vendor abstraction build in and it would be super simple to add qca support to it. However I have no vendor specific handling from within the probe callback. If that is not needed and we can do all the clk and GPIO setup in the vendor open callback, then it should be fairly simple to do (I am ignoring IBS support for now, but I realize it is there).
I did test that and doing clk and gpio setups in qca_open seems ok.

> 
> That all said, the hci_qca.c code has __serial_clock_on() and __serial_clock_off() empty stubs. Is this about the susclk or is that something totally different?
afaiu these stubs are used to control host UART clock. The susclk 
concerns the bt chip itself.

Regards,
Thierry

> 
> Regards
> 
> Marcel
> 
