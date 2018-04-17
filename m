Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeDQP4K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:56:10 -0400
Received: from www381.your-server.de ([78.46.137.84]:32807 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeDQPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:55:54 -0400
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
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
Date: Tue, 17 Apr 2018 17:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 04:53 PM, Peter Ujfalusi wrote:
> On 2018-04-17 16:58, Lars-Peter Clausen wrote:
>>>> There are two options.
>>>>
>>>> Either you extend the generic interfaces so it can cover your usecase in a
>>>> generic way. E.g. the ability to attach meta data to transfer.
>>>
>>> Fwiw I have this patch as part of a bigger work to achieve similar results:
>>
>> That's good stuff. Is this in a public tree somewhere?
> 
> Not atm. I can not send the user of the new API and I did not wanted to
> send something like this out of the blue w/o context.
> 
> But as it is a generic patch, I can send it as well. The only thing is
> that the need for the memcpy, so I might end up with
> ptr = get_metadata_ptr(desc, &size); /* size: in RX the valid size */
> 
> and set_metadata_size(); /* in TX to tell how the client placed */
> 
> Or something like that, the attach_metadata() as it is works just fine,
> but high throughput might not like the memcpy.
> 

In the most abstracted way I'd say metadata and data are two different data
streams that are correlated and send/received at the same time.

Think multi-planar transfer, like for audio when the right and left channel
are in separate buffers and not interleaved. Or video with different
color/luminance components in separate buffers. This is something that is at
the moment not covered by the dmaengine API either.

>>>> Or you can implement a interface that is specific to your DMA controller and
>>>> any client using this interface knows it is talking to your DMA controller.
>>>
>>> Hrm, so we can have DMA driver specific calls? The reason why TI's keystone 2
>>> navigator DMA support was rejected that it was introducing NAV specific calls
>>> for clients to configure features not yet supported by the framework.
>>
>> In my opinion it is OK, somebody else might have different ideas. I mean it
>> is not nice, but it is better than the alternative of overloading the
>> generic API with driver specific semantics or introducing some kind of IOCTL
>> catch all callback.
> 
> True, but the generic API can be extended as well to cover new grounds,
> features. Like this metadata thing.
> 
>> If there is tight coupling between the DMA core and client and there is no
>> intention of using a generic client the best solution might even be to no
>> use DMAengine at all.
> 
> This is how the knav stuff ended up. Well it is only used by networking
> atm, so it is 'fine' to have custom API, but it is not portable.

I totally agree generic APIs are better, but not everybody has the resources
to rewrite the whole framework just because they want to do this tiny thing
that isn't covered by the framework yet. In that case it is better to go
with a custom API (that might evolve into a generic API), rather than
overloading the generic API and putting a strain on everybody who works on
the generic API.
