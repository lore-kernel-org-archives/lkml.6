Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeDETAG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:00:06 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:42489 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeDETAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:00:02 -0400
X-Google-Smtp-Source: AIpwx4+dIL7MoEHjCdBdOGr1nwSCzx1t+2ffjL2BB20b60fd+i+HaTgDnI5VxkPIgX39mU8q6LXLyQ==
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Jan Kiszka <jan.kiszka@web.de>, Rob Herring <robh+dt@kernel.org>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
Date: Thu, 5 Apr 2018 11:59:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 04/04/18 15:35, Jan Kiszka wrote:
> Hi Frank,
> 
> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Move duplicating and unflattening of an overlay flattened devicetree
>> (FDT) into the overlay application code.  To accomplish this,
>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>
>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>> code, which is thus responsible for freeing the duplicate FDT.  The
>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>> original FDT.
>>
>> The unflattened devicetree now belongs to devicetree code, which is
>> thus responsible for freeing the unflattened devicetree.
>>
>> These ownership changes prevent early freeing of the duplicated FDT
>> or the unflattened devicetree, which could result in use after free
>> errors.
>>
>> of_overlay_fdt_apply() is a private function for the anticipated
>> overlay loader.
> 
> We are using of_fdt_unflatten_tree + of_overlay_apply in the
> (out-of-tree) Jailhouse loader driver in order to register a virtual
> device during hypervisor activation with Linux. The DT overlay is
> created from a a template but modified prior to application to account
> for runtime-specific parameters. See [1] for the current implementation.
> 
> I'm now wondering how to model that scenario best with the new API.
> Given that the loader lost ownership of the unflattened tree but the
> modification API exist only for the that DT state, I'm not yet seeing a
> clear solution. Should we apply the template in disabled form (status =
> "disabled"), modify it, and then activate it while it is already applied?

Thank you for the pointer to the driver - that makes it much easier to
understand the use case and consider solutions.

If you can make the changes directly on the FDT instead of on the
expanded devicetree, then you could move to the new API.

Looking at the driver, I see one potential issue with that approach.
The property "interrupt-map" is added directly to the changeset
instead of being an existing property in the overlay.  Is it possible
to have this property in the overlay when needed?

I'll also reply to other comments in this thread.

-Frank

> 
> Thanks,
> Jan
> 
> [1]
> https://github.com/siemens/jailhouse/blob/11ef401a9064644bf7faf28e35c97f27ececd81d/driver/pci.c#L280
> .
> 
