Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDETNs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:13:48 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40429 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDETNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:13:46 -0400
X-Google-Smtp-Source: AIpwx49iAmj09hRCtAKqoaQyqyHqRivYx5Uz8vr82mV30wAXpcAWopj+gLH6eLmr2s2U6cknMJu5lA==
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Rob Herring <robh+dt@kernel.org>, Jan Kiszka <jan.kiszka@web.de>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
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
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <de44758c-6c40-b951-e235-b2307ae6257e@gmail.com>
Date: Thu, 5 Apr 2018 12:13:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+Gu=gwcxJnOF2xybXCh9N2Fp1NV05kuvQ2rif1fdHYrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/18 17:55, Rob Herring wrote:
> On Wed, Apr 4, 2018 at 5:35 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>> Hi Frank,
>>
>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Move duplicating and unflattening of an overlay flattened devicetree
>>> (FDT) into the overlay application code.  To accomplish this,
>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>
>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>> original FDT.
>>>
>>> The unflattened devicetree now belongs to devicetree code, which is
>>> thus responsible for freeing the unflattened devicetree.
>>>
>>> These ownership changes prevent early freeing of the duplicated FDT
>>> or the unflattened devicetree, which could result in use after free
>>> errors.
>>>
>>> of_overlay_fdt_apply() is a private function for the anticipated
>>> overlay loader.
>>
>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>> device during hypervisor activation with Linux. The DT overlay is
>> created from a a template but modified prior to application to account
>> for runtime-specific parameters. See [1] for the current implementation.
>>
>> I'm now wondering how to model that scenario best with the new API.
>> Given that the loader lost ownership of the unflattened tree but the
>> modification API exist only for the that DT state, I'm not yet seeing a
>> clear solution. Should we apply the template in disabled form (status =
>> "disabled"), modify it, and then activate it while it is already applied?
> 
> No. I don't think that will work.

I don't think it will work either.  The drivers won't be probed if the
nodes are disabled.


> The of_overlay_apply() function is still there, but static. We can
> export it again if the need arises.

I really don't want to export it again.  sigh.


> Another option is there is a notifier callback OF_OVERLAY_PRE_APPLY,
> but I'm not sure we want to make that be the normal interface to make
> modifications.

This callback is on my list of yet more ways that pointers into the
(overlay) FDT are exposed.  Which means another solution to the
underlying problem (which was an FPGA problem) needs to be created.
I'd prefer that use of this mechanism not be expanded in the mean time.

Even if that were not the case, using the OF_OVERLAY_PRE_APPLY notifier
to modify the tree is problematic because the notifier(s) is called
after the overlay FDT is in final form

-Frank

> 
> Rob
> .
> 
