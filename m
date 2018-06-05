Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeFEWh0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:37:26 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42571 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeFEWhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:37:23 -0400
X-Google-Smtp-Source: ADUXVKLTqNU8tTtdRSmC7oD/Lz+g5mw6aQNzn/ae6nRFCKSfPp4TQgB9o9tWj9JjEVZ9N8CvQ1Og6Iyy63x4zefZ2tk=
MIME-Version: 1.0
In-Reply-To: <20180601192545.GR4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601191545.GP4511@wotan.suse.de> <20180601192545.GR4511@wotan.suse.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 15:37:22 -0700
X-Google-Sender-Auth: MJ7Pxo14ZmNoANrzpRrBdg93Vcw
Message-ID: <CAGXu5jKkg_=iHGgrED4qB4TCFJaWgLkLp61RHgJ6UEhAj89GwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware
 (pre-allocated buffer)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, Stephen Boyd <sboyd@kernel.org>,
        Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 12:25 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Fri, Jun 01, 2018 at 09:15:45PM +0200, Luis R. Rodriguez wrote:
>> On Tue, May 29, 2018 at 02:01:59PM -0400, Mimi Zohar wrote:
>> > Some systems are memory constrained but they need to load very large
>> > firmwares.  The firmware subsystem allows drivers to request this
>> > firmware be loaded from the filesystem, but this requires that the
>> > entire firmware be loaded into kernel memory first before it's provided
>> > to the driver.  This can lead to a situation where we map the firmware
>> > twice, once to load the firmware into kernel memory and once to copy the
>> > firmware into the final resting place.
>> >
>> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
>> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
>> > that allows drivers to request firmware be loaded directly into a
>> > pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
>> > allocate this buffer.  According to Documentation/DMA-API.txt,
>> >
>> >      Consistent memory is memory for which a write by either the
>> >      device or the processor can immediately be read by the processor
>> >      or device without having to worry about caching effects.  (You
>> >      may however need to make sure to flush the processor's write
>> >      buffers before telling devices to read that memory.)
>> >
>> > Devices using pre-allocated DMA memory run the risk of the firmware
>> > being accessible by the device prior to the kernel's firmware signature
>> > verification has completed.
>>
>> Indeed. And since its DMA memory we have *no idea* what can happen in
>> terms of consumption of this firmware from hardware, when it would start
>> consuming it in particular.
>>
>> If the device has its own hardware firmware verification mechanism this is
>> completely obscure to us, but it may however suffice certain security policies.
>>
>> The problem here lies in the conflicting security policies of the kernel wanting
>> to not give away firmware until its complete and the current inability to enable
>> us to have platforms suggest they trust hardware won't do something stupid.
>> This becomes an issue since the semantics of the firmware API preallocated
>> buffer do not require currently allow the kernel to inform LSMs of the fact
>> that a buffer is DMA memory or not, and a way for certain platforms then
>> to say that such use is fine for specific devices.
>>
>> Given a pointer can we determine if a piece of memory is DMA or not?
>
> FWIW
>
> Vlastimil suggests page_zone() or virt_to_page() may be able to.

I don't see a PAGEFLAG for DMA, but I do see ZONE_DMA for
page_zone()... So maybe something like

struct page *page;

page = virt_to_page(address);
if (!page)
   fail closed...
if (page_zone(page) == ZONE_DMA)
    handle dma case...
else
    non-dma

But I've CCed Laura and Rik, who I always lean on when I have these
kinds of page questions...

-Kees

-- 
Kees Cook
Pixel Security
