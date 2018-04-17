Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeDQN6d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:58:33 -0400
Received: from www381.your-server.de ([78.46.137.84]:53958 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDQN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:58:30 -0400
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
To: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>
Cc: "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
Date: Tue, 17 Apr 2018 15:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 03:46 PM, Peter Ujfalusi wrote:
> On 2018-04-17 15:54, Lars-Peter Clausen wrote:
>> On 04/17/2018 01:43 PM, Radhey Shyam Pandey wrote:
>>> Hi Vinod,
>>>
>>>> -----Original Message-----
>>>> From: Vinod Koul [mailto:vinod.koul@intel.com]
>>>> Sent: Wednesday, April 11, 2018 2:39 PM
>>>> To: Radhey Shyam Pandey <radheys@xilinx.com>
>>>> Cc: dan.j.williams@intel.com; michal.simek@xilinx.com; Appana Durga
>>>> Kedareswara Rao <appanad@xilinx.com>; Radhey Shyam Pandey
>>>> <radheys@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
>>>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
>>>> words to netdev dma client
>>>>
>>>> On Mon, Apr 02, 2018 at 04:09:02PM +0530, Radhey Shyam Pandey wrote:
>>>>
>>>>> +
>>>>> +		if (chan->xdev->has_axieth_connected) {
>>>>> +			seg = list_first_entry(&desc->segments,
>>>>> +					struct xilinx_axidma_tx_segment,
>>>> node);
>>>>> +			if (cb.callback_param) {
>>>>> +				app_w = (u32 *) cb.callback_param;
>>>>
>>>> why are you interpreting callback_param? This is plainly wrong.
>>>> we do not know what is the interpretation of callback_param and it is
>>>> internal to submitter.
>>> In design, if AXI DMA is connected to AXI Ethernet IP there are certain
>>> AXI4-Stream Status fields (RX) that we need to pass to ethernet driver
>>> along with data buffer. An example includes: checksum fields, packet
>>> length etc. To pass these control words there is a structure defined
>>> between dmaengine and client. Before calling the client callback
>>> stream control words are copied to dma client callback_param struct
>>> (only if axieth is connected).
>>>
>>> I understand it's not an ideal way and we shouldn't be interpreting
>>> callback_param but couldn't find any better alternative of passing
>>> custom information from dmaengine to client driver and still be 
>>> aligned to the framework.
>>>
>>>>
>>>> What exactly is the problem you are trying to solve?
>>> As mentioned above we need to pass AXI4-stream words(custom
>>> data) from dmaengine driver to dma client driver(ethernet) for
>>> each DMA descriptor. Current solution populates callback_param
>>> struct (only if axieth is connected). Please let me know if there is
>>> an alternate solution. 
>>
>> The standard interfaces need to work in a way that a client using them does
>> not have to know to which DMA controller it is connected. In a similar way
>> the DMA controller shouldn't have any client specific logic for the generic
>> interfaces. Otherwise there is no point of having a generic interface.
>>
>> There are two options.
>>
>> Either you extend the generic interfaces so it can cover your usecase in a
>> generic way. E.g. the ability to attach meta data to transfer.
> 
> Fwiw I have this patch as part of a bigger work to achieve similar results:

That's good stuff. Is this in a public tree somewhere?

>> Or you can implement a interface that is specific to your DMA controller and
>> any client using this interface knows it is talking to your DMA controller.
> 
> Hrm, so we can have DMA driver specific calls? The reason why TI's keystone 2
> navigator DMA support was rejected that it was introducing NAV specific calls
> for clients to configure features not yet supported by the framework.

In my opinion it is OK, somebody else might have different ideas. I mean it
is not nice, but it is better than the alternative of overloading the
generic API with driver specific semantics or introducing some kind of IOCTL
catch all callback.

If there is tight coupling between the DMA core and client and there is no
intention of using a generic client the best solution might even be to no
use DMAengine at all.
