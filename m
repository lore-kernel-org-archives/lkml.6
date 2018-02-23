Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBWOtv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:49:51 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:40943 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBWOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:49:49 -0500
X-Google-Smtp-Source: AH8x225Ihz84w0P/2NsbTZn+17dcP5IaL7QS4nn8epen8yIfUUkD1hNsu7AH85Issn7/aO0CfDC76Q==
Subject: Re: [PATCH 4/9] drm/xen-front: Implement Xen event channel handling
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-5-git-send-email-andr2000@gmail.com>
 <395cdaef-db7e-139c-bbf1-28cb33f41f58@oracle.com>
 <5145287f-40b0-c8e2-1b37-36d7e8cac908@gmail.com>
 <7d8ab151-e90d-baef-93b6-8ca1c7e42908@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <63c64a2f-211e-2f62-21e7-289f0cc69df0@gmail.com>
Date: Fri, 23 Feb 2018 16:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7d8ab151-e90d-baef-93b6-8ca1c7e42908@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 04:44 PM, Boris Ostrovsky wrote:
> On 02/23/2018 02:00 AM, Oleksandr Andrushchenko wrote:
>> On 02/23/2018 01:50 AM, Boris Ostrovsky wrote:
>>> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>>>> +
>>>> +static irqreturn_t evtchnl_interrupt_ctrl(int irq, void *dev_id)
>>>> +{
>>>> +    struct xen_drm_front_evtchnl *evtchnl = dev_id;
>>>> +    struct xen_drm_front_info *front_info = evtchnl->front_info;
>>>> +    struct xendispl_resp *resp;
>>>> +    RING_IDX i, rp;
>>>> +    unsigned long flags;
>>>> +
>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>> +
>>>> +    if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
>>>> +        goto out;
>>> Do you need to check the state under lock? (in other routines too).
>> not really, will move out of the lock in interrupt handlers
>> other places (I assume you refer to be_stream_do_io)
>
> I was mostly referring to evtchnl_interrupt_evt().
ah, then we are on the same page: I will move the check
in interrupt handlers
> -boris
>
>
>> it is set under lock as a part of atomic operation, e.g.
>> we get a new request pointer from the ring and reset completion
>> So, those places still seem to be ok
