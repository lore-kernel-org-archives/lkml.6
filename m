Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966552AbeCAItM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:49:12 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36986 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965838AbeCAItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:49:11 -0500
X-Google-Smtp-Source: AG47ELuIWvjzCfDJssUd5SYDu36HjmGYPl0gut0ccUmtSt4xdc3jzaVuRJ6zgLpGjvFGp7qlyDbevA==
Subject: Re: [PATCH 0/9] drm/xen-front: Add support for Xen PV display
 frontend
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <4c7e6f65-1787-3815-22b5-f9495e388c06@gmail.com>
 <7e265c53-db9a-0946-6b1c-b946bcbb4100@gmail.com>
 <20180301082648.frnslqyhffj2bkwl@sirius.home.kraxel.org>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <c2620fe6-53ee-ffe6-61b1-06d72f377b78@gmail.com>
Date: Thu, 1 Mar 2018 10:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301082648.frnslqyhffj2bkwl@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 10:26 AM, Gerd Hoffmann wrote:
>    Hi,
>
>> 1. Possible security issues - VirtIO devices are PCI bus masters, thus
>> allowing real device (running, for example, in untrusted driver domain)
>> to get control over guest's memory by writing to its memory
>>
>> 2. VirtIO currently uses GFNs written into the shared ring, without Xen
>> grants support. This will require generic grant-mapping/sharing layer
>> to be added to VirtIO.
>>
>> 3. VirtIO requires QEMU PCI emulation for setting up a device. Xen PV
>> (and PVH) domains don't use QEMU for platform emulation in order to
>> reduce attack surface.  (PVH is in the process of gaining PCI config
>> space emulation though, but it is optional, not a requirement)
> Well, that is wrong.  virtio doesn't require pci.  There are other
> transports (mmio, ccw), and it should be possible to create a xen
> specific transport which uses grant tables properly.
You are correct, PCI is not a requirement here
>    Seems there even
> was an attempt to implement that in 2011, see
> https://wiki.xenproject.org/wiki/Virtio_On_Xen
And even more, that was also raised at Linux Plumbers
Conference 2013 [1]. But still, there is no implementation
available
>> 4. Most of the PV drivers a guest uses at the moment are Xen PV drivers,
>> e.g. net,
>> block, console, so only virtio-gpu will require QEMU to run.
> You are not forced to use qemu, you can certainly create an alternative
> host side implementation (and still use on the existing virtio guest
> drivers).
Yes, this is true. We also discussed virtio with Xen
community, Stefano Stabellini says:
"the issues with virtio are (in order of seriousness):

1) virtio assumes that the backend is able to map any page in memory
In other words, it is not possible to do driver domains with virtio

2) virtio doesn't work with PV guests, only HVM (I think PVH would have
   the same issue)
Virtio does synchronous IO emulation. QEMU for PV guests is not capable
of handling synchronous IO requests. The infratructure is just not
there.

3) virtio performance is poor with Xen
There are multiple reasons for this, but the main one is that the
backends are in QEMU, running in Dom0. They become the bottleneck
quickly.
"
> Whenever writing a xenbus implementation for both guest and host or
> writing a virtio implementation for the host only is better -- dunno.
> The virtio path obviously needs some infrastructure work for virtio
> support in Xen, which may pay off long term.  Your call.
Well, I do agree that long term virtio might be a better choice.
But at the moment I still tend to have a dedicated Xen PV DRM
implementation.

That being said, I would kindly ask DRI community to review
the driver and consider it for inclusion.
> cheers,
>    Gerd
>
Thank you,
Oleksandr Andrushchenko

[1] https://www.youtube.com/watch?v=FcVDHBQInxA
