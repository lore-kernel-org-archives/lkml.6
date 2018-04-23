Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeDWMKl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:10:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36777 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754746AbeDWMKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:10:39 -0400
X-Google-Smtp-Source: AB8JxZogZxTtBG5cwhvBPNaCOFDvFpUuhjCY7LbRmf4uKgUvLn6srunA+UcB/pE4tUlznMCk2C7gmQ==
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Wei Liu <wei.liu2@citrix.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        jgross@suse.com, Artem Mygaiev <Artem_Mygaiev@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>, konrad.wilk@oracle.com,
        airlied@linux.ie,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        xen-devel@lists.xenproject.org, daniel.vetter@intel.com,
        boris.ostrovsky@oracle.com
References: <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
Date: Mon, 23 Apr 2018 15:10:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423115242.ywdwqblj2aseu3fr@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2018 02:52 PM, Wei Liu wrote:
> On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko wrote:
>>>>      the gntdev.
>>>>
>>>> I think this is generic enough that it could be implemented by a
>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>> something similar to this.
>>> You can't just wrap random userspace memory into a dma-buf. We've just had
>>> this discussion with kvm/qemu folks, who proposed just that, and after a
>>> bit of discussion they'll now try to have a driver which just wraps a
>>> memfd into a dma-buf.
>> So, we have to decide either we introduce a new driver
>> (say, under drivers/xen/xen-dma-buf) or extend the existing
>> gntdev/balloon to support dma-buf use-cases.
>>
>> Can anybody from Xen community express their preference here?
>>
> Oleksandr talked to me on IRC about this, he said a few IOCTLs need to
> be added to either existing drivers or a new driver.
>
> I went through this thread twice and skimmed through the relevant
> documents, but I couldn't see any obvious pros and cons for either
> approach. So I don't really have an opinion on this.
>
> But, assuming if implemented in existing drivers, those IOCTLs need to
> be added to different drivers, which means userspace program needs to
> write more code and get more handles, it would be slightly better to
> implement a new driver from that perspective.
If gntdev/balloon extension is still considered:

All the IOCTLs will be in gntdev driver (in current xen-zcopy terminology):
  - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
  - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
  - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE

Balloon driver extension, which is needed for contiguous/DMA
buffers, will be to provide new *kernel API*, no UAPI is needed.

> Wei.
Thank you,
Oleksandr
