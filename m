Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756907AbeDXJvK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:51:10 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:57274 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeDXJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:51:04 -0400
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
To: Vinod Koul <vinod.koul@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
 <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
 <20180424035548.GA6014@localhost>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ee1dc551-7c11-6d10-651d-01bf6520f049@ti.com>
Date: Tue, 24 Apr 2018 12:50:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424035548.GA6014@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 06:55, Vinod Koul wrote:
> On Thu, Apr 19, 2018 at 02:40:26PM +0300, Peter Ujfalusi wrote:
>>
>> On 2018-04-18 16:06, Lars-Peter Clausen wrote:
>>>> Hrm, true, but it is hardly the metadata use case. It is more like
>>>> different DMA transfer type.
>>>
>>> When I look at this with my astronaut architect view from high high up above
>>> I do not see a difference between metadata and multi-planar data.
>>
>> I tend to disagree.
> 
> and we will love to hear more :)

It is getting pretty off topic from the subject ;) and I'm sorry about that.

Multi-planar data is _data_, the metadata is
parameters/commands/information on _how_ to use the data.
It is more like a replacement or extension of:
configure peripheral
send data

to

send data with configuration

In both cases the same data is sent, but the configuration,
parametrization is 'simplified' to allow per packet changes.

>>> Both split the data that is sent to the peripheral into multiple
>>> sub-streams, each carrying part of the data. I'm sure there are peripherals
>>> that interleave data and metadata on the same data stream. Similar to how we
>>> have left and right channel interleaved in a audio stream.
>>
>> Slimbus, S/PDIF?
>>
>>> What about metadata that is not contiguous and split into multiple segments.
>>> How do you handle passing a sgl to the metadata interface? And then it
>>> suddenly looks quite similar to the normal DMA descriptor interface.
>>
>> Well, the metadata is for the descriptor. The descriptor describe the
>> data transfer _and_ can convey additional information. Nothing is
>> interleaved, the data and the descriptor are different things. It is
>> more like TCP headers detached from the data (but pointing to it).
>>
>>> But maybe that's just one abstraction level to high.
>>
>> I understand your point, but at the end the metadata needs to end up in
>> the descriptor which is describing the data that is going to be moved.
>>
>> The descriptor is not sent as a separate DMA trasnfer, it is part of the
>> DMA transfer, it is handled internally by the DMA.
> 
> That is bit confusing to me. I thought DMA was transparent to meta data and
> would blindly collect and transfer along with the descriptor. So at high
> level we are talking about two transfers (probably co-joined at hip and you
> want to call one transfer)

At the end yes, both the descriptor and the data is going to be sent to
the other end.

As a reference see [1]

The metadata is not a separate entity, it is part of the descriptor
(Host Packet Descriptor - HPD).
Each transfer (packet) is described with a HPD. The HPD have optional
fields, like EPIB (Extended Packet Info Block), PSdata (Protocol
Specific data).

When the DMA reads the HPD, is going to move the data described by the
HPD to the entry point (or from the entry point to memory), copies the
EPIB/PSdata from the HPD to a destination HPD. The other end will use
the destination HPD to know the size of the data and to get the metadata
from the descriptor.

In essence every entity within the Multicore Navigator system have
pktdma, they all work in a similar way, but their capabilities might
differ. Our entry to this mesh is via the DMA.

> but why can't we visualize this as just a DMA
> transfers. maybe you want to signal/attach to transfer, cant we do that with
> additional flag DMA_METADATA etc..?

For the data we need to call dmaengine_prep_slave_* to create the
descriptor (HPD). The metadata needs to be present in the HPD, hence I
was thinking of the attach_metadata as per descriptor API.

If separate dmaengine_prep_slave_* is used for allocating the HPD and
place the metadata in it then the consequent dmaengine_prep_slave_* call
must be for the data of the transfer and it is still unclear how the
prepare call would have any idea where to look for the HPD it needs to
update with the parameters for the data transfer.

I guess the driver could store the HPD pointer in the channel data if
the prepare is called with DMA_METADATA and it would be mandatory that
the next prepare is for the data portion. The driver would pick the
pointer to the HPD we stored away and update the descriptor belonging to
different tx_desc.

But if we are here, we could have a flag like DMA_DESCRIPTOR and let
client drivers to allocate the whole descriptor, fill in the metadata
and give that to the DMA driver, which will update the rest of the HPD.

Well, let's see where this is going to go when I can send the patches
for review.

[1] http://www.ti.com/lit/ug/sprugr9h/sprugr9h.pdf

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
