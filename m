Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbeD0NDT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932322AbeD0NDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:03:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34292184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZqj8DRAgzoEzNuWLd6icWHmCp/TR/+23guDMJgt4U2tZsU5juVrIkPKkLPCENJtncHP5tYGSU0E/iM9YhrIRv4=
MIME-Version: 1.0
In-Reply-To: <ba081812-f532-5ebd-b052-cdeb1f02bff1@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com> <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
 <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com> <ba081812-f532-5ebd-b052-cdeb1f02bff1@xilinx.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 27 Apr 2018 08:02:55 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+3WnGNM0ip_v75s8f5-Wq_9ht19-T-MHyhKjzcU6jtdg@mail.gmail.com>
Message-ID: <CAL_Jsq+3WnGNM0ip_v75s8f5-Wq_9ht19-T-MHyhKjzcU6jtdg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] of: base: Introduce of_alias_check_id() to check
 alias IDs
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Alexander Graf <agraf@suse.de>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 1:10 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 27.4.2018 04:39, Rob Herring wrote:
>> On Thu, Apr 26, 2018 at 9:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> The function travers the lookup table to check if the request alias
>>> id is compatible with the device driver match structure.
>>> This function will be used by serial drivers to check if requested alias
>>> is allocated or free to use.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>>  drivers/of/base.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/of.h |  2 ++
>>>  2 files changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index 848f549164cd..382de01acc72 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -1892,6 +1892,55 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>>  }
>>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>>
>>> +/**
>>> + * of_alias_check_id - Check alias id for the give compatibility
>>> + * @matches:   Array of of device match structures to search in
>>> + * @stem:      Alias stem of the given device_node
>>> + * @id:                Alias ID for checking
>>> + *
>>> + * The function travers the lookup table to check if the request alias id
>>> + * is compatible with the device driver match structure
>>> + *
>>> + * Return true if ID is allocated, return false if not
>>> + */
>>> +bool of_alias_check_id(const struct of_device_id *matches, const char *stem,
>>> +                      int id)
>>
>> Wouldn't it be simpler to just return a bitmap of all allocated ids
>> that match rather than trying to build that up 1 bit at a time?
>
> Is alias list stable or can dt overlay change it?

Stable. If you use an id and then an overlay adds that id as an alias,
what should the kernel do? The only choice is ignore the suggestion.

> What should be the expected flow? Find out maximum number of aliases of
> the same kind and allocate bitmap and return it with length.

I think we can assume <32 so just return a bitmap in a unsigned long
or u32. Use that to initialize a bitmap in the driver. For un-aliased
devices, find the first unset bit, use that id and set the bit.

> Anyway if you look at that patches I sent then I call in the driver
> of_alias_get_highest_id("serial") which doesn't take care if alias match
> with actual driver. It means having information about max alias ID which
> match actual driver that would be helpful but I am not quite sure what
> should be the flow.

I'm a bit confused as to why you use of_alias_get_highest_id and
of_alias_check_id. of_alias_get_highest_id is really intended if  you
want to start dynamic allocations above all the alias ids.

I guess the need to match devices is based on each serial driver
having it's own major and /dev name. IMO, we should get rid of those
and every serial driver use ttySn (with the exception of things like
USB serial). Then you'd just need to find all serial aliases. But you
can support both with this function. Just return a bitmap of all
aliases if match is NULL.

> Any link to similar function would be good to understand how the flow is
> supposed to work.

I don't think there's a good model. The pl011 code looks broken to me.
The warning about devices with and without aliases should be fixed.
That is perfectly valid and should be supported. You should really
only need an alias for your console.

Rob
