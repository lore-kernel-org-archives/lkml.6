Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeDQLIL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:08:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34847 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbeDQLIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:08:09 -0400
Subject: Re: [PATCH v2 2/5] ALSA: xen-front: Read sound driver configuration
 from Xen store
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-3-andr2000@gmail.com>
 <451f4f4b-646e-0058-e24f-d9ae918f583f@suse.com>
 <2c37fff3-9dfe-f904-d06f-7751d5e9e002@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <9e875172-cbc2-7019-9971-34f88ecc8d18@suse.com>
Date: Tue, 17 Apr 2018 13:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2c37fff3-9dfe-f904-d06f-7751d5e9e002@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 10:42, Oleksandr Andrushchenko wrote:
> On 04/16/2018 03:55 PM, Juergen Gross wrote:
>> On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
>>> +        goto fail;
>>> +    }
>>> +
>>> +    if (!strncasecmp(str, XENSND_STREAM_TYPE_PLAYBACK,
>>> +             sizeof(XENSND_STREAM_TYPE_PLAYBACK))) {
>>> +        stream = &pcm_instance->streams_pb[(*cur_pb)++];
>>> +    } else if (!strncasecmp(str, XENSND_STREAM_TYPE_CAPTURE,
>>> +                  sizeof(XENSND_STREAM_TYPE_CAPTURE))) {
>>> +        stream = &pcm_instance->streams_cap[(*cur_cap)++];
>>> +    } else {
>>> +        ret = -EINVAL;
>>> +        goto fail;
>>> +    }
>> Until here this function looks very much like cfg_get_stream_type().
>> Can't they use a common sub-function?
> Not really, because cfg_get_stream_type uses kasprintf
> for strings and this one devm_kasprintf. Trying to make
> a common sub-func doesn't make sense to me

Aah, okay. Didn't spot that.

>>> +    /* start from default PCM HW configuration for the card */
>>> +    cfg_read_pcm_hw(xb_dev->nodename, NULL, &cfg->pcm_hw);
>>> +
>>> +    cfg->pcm_instances =
>>> +            devm_kcalloc(&front_info->xb_dev->dev, num_devices,
>>> +                     sizeof(struct xen_front_cfg_pcm_instance),
>>> +                     GFP_KERNEL);
>>> +    if (!cfg->pcm_instances)
>>> +        return -ENOMEM;
>>> +
>>> +    for (i = 0; i < num_devices; i++) {
>>> +        ret = cfg_device(front_info, &cfg->pcm_instances[i],
>>> +                 &cfg->pcm_hw, xb_dev->nodename, i, stream_cnt);
>>> +        if (ret < 0)
>>> +            return ret;
>> Who will free all the memory allocated until now in case of an error?
> The memory is allocated with devm_xxx functions, so it will
> be freed on device destructions automatically
>>
>> And I think when removing the device freeing the memory is missing, too.
> Same as above, the kernel will take care of it while destroying the device

Okay, thanks.


Juergen
