Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeDZAcL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:32:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45739 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDZAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:32:07 -0400
X-Google-Smtp-Source: AIpwx49GimdsHu2Wwa609EHQmTTwgE+MRRwotPs8Ni7NW9I7eDEcJkcf9qILYgZ/r6NIYypkUbeLoQ==
Subject: Re: [PATCH] of: overlay: Stop leaking resources on overlay removal
From: Frank Rowand <frowand.list@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
References: <097f1b01-6cb4-8dcb-0498-7b4c59a7ea53@siemens.com>
 <7aca82c1-a02c-2f84-bc32-6e8a118ba601@gmail.com>
 <90e7da9d-d40a-17f1-e627-873f58a3dce5@siemens.com>
 <b813ac8f-a1e3-3e27-2e44-0a576e05d01c@gmail.com>
Message-ID: <17561711-94f7-b3d4-8f06-9cfa69daaf23@gmail.com>
Date: Wed, 25 Apr 2018 17:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b813ac8f-a1e3-3e27-2e44-0a576e05d01c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 04/24/18 13:58, Frank Rowand wrote:
> On 04/24/18 10:50, Jan Kiszka wrote:
>> On 2018-04-24 19:44, Frank Rowand wrote:
>>> On 04/24/18 09:19, Jan Kiszka wrote:
>>>> Only the overlay notifier callbacks have a chance to potentially get
>>>> hold of references to those two resources, but they do not store them.
>>>> So it is safe to stop the intentional leaking.
>>>>
>>>> See also https://lkml.org/lkml/2018/4/23/1063 and following.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> Ideally, we sort out any remaining worries during the 4.17-rc cycle.
>>>>
>>>>  drivers/of/overlay.c | 13 ++-----------
>>>>  1 file changed, 2 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>>> index b35fe88f1851..3553f1f57a62 100644
>>>> --- a/drivers/of/overlay.c
>>>> +++ b/drivers/of/overlay.c
>>>> @@ -671,17 +671,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>>>  		of_node_put(ovcs->fragments[i].overlay);
>>>>  	}
>>>>  	kfree(ovcs->fragments);
>>>> -
>>>> -	/*
>>>> -	 * TODO
>>>> -	 *
>>>> -	 * would like to: kfree(ovcs->overlay_tree);
>>>> -	 * but can not since drivers may have pointers into this data
>>>> -	 *
>>>> -	 * would like to: kfree(ovcs->fdt);
>>>> -	 * but can not since drivers may have pointers into this data
>>>> -	 */
>>>> -
>>>> +	kfree(ovcs->overlay_tree);
>>>> +	kfree(ovcs->fdt);
>>>>  	kfree(ovcs);
>>>>  }
>>>>  
>>>>
>>>
>>> Nack.  It is premature to submit this while the conversation is
>>> continuing in the other thread.
>>>
>>> I'll continue the conversation in the other thread.
>>>
>>
>> Well, at least the strongest argument has been resolved now, the
>> notifier topic. Curious to learn what remains. As I noted, we should
>> work hard to sort out the API regression prior to the release.
> 
> Nope, the notifier discussion continues in the other thread.

Thanks for your patience in the other thread.

As I noted there, I am now willing to accept this patch with some
small changes.  Please add a minimal section to
Documentation/devicetree/overlay-notes.txt about overlay notifiers.
The most important thing to note there is that the overlay notifiers
are not allowed to retain any pointers into the overlay devicetree.
Also, instead of removing the "TODO" comment in free_overlay_changeset(),
change it to say something to the effect of "there should be no live pointers
into ovcs->overlay_tree and ovcs->fdt due to the policy that overlay
notifiers are not allowed to retain pointers into the overlay devicetree".

I will also add myself to the OPEN FIRMWARE AND DEVICE TREE OVERLAYS
entry of MAINTAINERS and add a keyword line to catch overlay notifiers.

I am not happy about freeing the overlay devicetree and overlay fdt
while overlay notifiers are able to retain pointers into the overlay
devicetree and overlay fdt, but am willing to accept documentation and
review as a partial protection until the devicetree access APIs can be
modified to prevent the notifiers from accessing the pointers.  The
volume of overlay notifier patches should be small enough to not be
a review burden.

-Frank
