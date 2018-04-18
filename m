Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeDRMmg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:42:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43494 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeDRMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:42:33 -0400
X-Google-Smtp-Source: AIpwx499RtXzWku5QOVTFdTuPjU+EggnJGBxhdqyDvepg5wjQoLwg1rIlJ6qyVgAKulExx9z0x5tbw==
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Paul Durrant <Paul.Durrant@citrix.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Matt Roper <matthew.d.roper@intel.com>
References: <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <7d6710a76b9a42299139d7914358ed52@AMSPEX02CL03.citrite.net>
 <46489b33-e6fc-b874-6cd4-dbb94c002ef8@gmail.com>
 <20180418105526.a4qtlhofrn3gubsl@MacBook-Pro-de-Roger.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <11ec6f16-6eff-6439-2e66-f1ef14cdff21@gmail.com>
Date: Wed, 18 Apr 2018 15:42:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418105526.a4qtlhofrn3gubsl@MacBook-Pro-de-Roger.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 01:55 PM, Roger Pau Monné wrote:
> On Wed, Apr 18, 2018 at 01:39:35PM +0300, Oleksandr Andrushchenko wrote:
>> On 04/18/2018 01:18 PM, Paul Durrant wrote:
>>>> -----Original Message-----
>>>> From: Xen-devel [mailto:xen-devel-bounces@lists.xenproject.org] On Behalf
>>>> Of Roger Pau Monné
>>>> Sent: 18 April 2018 11:11
>>>> To: Oleksandr Andrushchenko <andr2000@gmail.com>
>>>> Cc: jgross@suse.com; Artem Mygaiev <Artem_Mygaiev@epam.com>;
>>>> Dongwon Kim <dongwon.kim@intel.com>; airlied@linux.ie;
>>>> Oleksandr_Andrushchenko@epam.com; linux-kernel@vger.kernel.org; dri-
>>>> devel@lists.freedesktop.org; Potrola, MateuszX
>>>> <mateuszx.potrola@intel.com>; xen-devel@lists.xenproject.org;
>>>> daniel.vetter@intel.com; boris.ostrovsky@oracle.com; Matt Roper
>>>> <matthew.d.roper@intel.com>
>>>> Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy
>>>> helper DRM driver
>>>>
>>>> On Wed, Apr 18, 2018 at 11:01:12AM +0300, Oleksandr Andrushchenko
>>>> wrote:
>>>>> On 04/18/2018 10:35 AM, Roger Pau Monné wrote:
>>>> After speaking with Oleksandr on IRC, I think the main usage of the
>>>> gntdev extension is to:
>>>>
>>>> 1. Create a dma-buf from a set of grant references.
>>>> 2. Share dma-buf and get a list of grant references.
>>>>
>>>> I think this set of operations could be broken into:
>>>>
>>>> 1.1 Map grant references into user-space using the gntdev.
>>>> 1.2 Create a dma-buf out of a set of user-space virtual addresses.
>>>>
>>>> 2.1 Map a dma-buf into user-space.
>>>> 2.2 Get grefs out of the user-space addresses where the dma-buf is
>>>>       mapped.
>>>>
>>>> So it seems like what's actually missing is a way to:
>>>>
>>>>    - Create a dma-buf from a list of user-space virtual addresses.
>>>>    - Allow to map a dma-buf into user-space, so it can then be used with
>>>>      the gntdev.
>>>>
>>>> I think this is generic enough that it could be implemented by a
>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>> something similar to this.
>> Ok, so just to summarize, xen-zcopy/hyper-dmabuf as they are now,
>> are no go from your POV?
> My opinion is that there seems to be a more generic way to implement
> this, and thus I would prefer that one.
>
>> Instead, we have to make all that fancy stuff
>> with VAs <-> device-X and have that device-X driver live out of drivers/xen
>> as it is not a Xen specific driver?
> That would be my preference if feasible, simply because it can be
> reused by other use-cases that need to create dma-bufs in user-space.
There is a use-case I have: a display unit on my target has a DMA
controller which can't do scatter-gather, e.g. it only expects a
single starting address of the buffer.
In order to create a dma-buf from grefs in this case
I allocate memory with dma_alloc_xxx and then balloon pages of the
buffer and finally map grefs onto this DMA buffer.
This way I can give this shared buffer to the display unit as its bus
addresses are contiguous.

With the proposed solution (gntdev + device-X) I won't be able to 
achieve this,
as I have no control over from where gntdev/balloon drivers get the pages
(even more, those can easily be out of DMA address space of the display 
unit).

Thus, even if implemented, I can't use this approach.
>
> In any case I just knew about dma-bufs this morning, there might be
> things that I'm missing.
>
> Roger.
