Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeDEThJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:37:09 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:46115 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeDEThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:37:06 -0400
X-Google-Smtp-Source: AIpwx4+9Q+CrrUJ1c4Ejo3xaxkjMGezLL4ISfczD9TjYJkDr6tlsDoBf50VqkECEJSKFNOnnAGTEkA==
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Rob Herring <robh+dt@kernel.org>
Cc: Jan Kiszka <jan.kiszka@web.de>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <CAL_Jsq+Gu=gwcxJnOF2xybXCh9N2Fp1NV05kuvQ2rif1fdHYrA@mail.gmail.com>
 <935d6135-c5db-e5f8-b850-8ef26ce0c0a0@web.de>
 <69c06530-94df-b67b-4e56-6519275afb45@gmail.com>
 <CAL_JsqKbn_UKdiqo-uOzxzXc3bVT83kx9NqgxAggOb+OPQBsdA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <07f25928-6ecf-ac34-e724-cad2e94f6ba7@gmail.com>
Date: Thu, 5 Apr 2018 12:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKbn_UKdiqo-uOzxzXc3bVT83kx9NqgxAggOb+OPQBsdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 12:26, Rob Herring wrote:
> On Thu, Apr 5, 2018 at 2:16 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 04/05/18 00:22, Jan Kiszka wrote:
>>> On 2018-04-05 02:55, Rob Herring wrote:
>>>> On Wed, Apr 4, 2018 at 5:35 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>>>> Hi Frank,
>>>>>
>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>
>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>
>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>> original FDT.
>>>>>>
>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>
>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>> errors.
>>>>>>
>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>> overlay loader.
>>>>>
>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>> created from a a template but modified prior to application to account
>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>
>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>
>>>> No. I don't think that will work.
>>>>
>>>> The of_overlay_apply() function is still there, but static. We can
>>>> export it again if the need arises.
>>>
>>> That would be the simplest solution from our perspective, but I'm not
>>> sure if that is in the original spirit of this change.
>>
>> For short term out of tree usage, exporting of_overlay_apply() is ok.
> 
> Meaning the out of tree users can go export it themselves.
> 
>> Yes, for in-tree, exporting it again defeats the attempted process to
>> solve the overlay issues to make them acceptable in main line.
> 
> The purpose of providing a function to apply an overlay in one step is
> to handle the common case and avoid open coding the sequence
> everywhere. That doesn't mean everyone will fall into the common case.

That was one of the intents behind the change.

The other intent is that with lifetime of the overlay FDT and overlay
expanded tree visible outside the devicetree core, we can not free the
overlay FDT or the overlay expanded tree because we need to protect
against use after free errors.  The open coded examples of applying
overlays commonly have issues with freeing the overlay FDT and/or the
overlay expanded tree, which leads to the potential for use after free
errors.


> Of course, it also doesn't mean we have to revert back to the previous
> way to handle users that need to tweak the unflattened tree before
> applying.
> 
> Rob
> 
