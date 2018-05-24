Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033264AbeEXO0J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030656AbeEXO0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:26:05 -0400
X-Google-Smtp-Source: ADUXVKIfAFWja9wPVQAxCJSvhW3ib/6/iywpVjcDJA83l+VePGtt9lTSUwOAnZG/nvidX212uneeC2OppGXxn5dd3Ro=
MIME-Version: 1.0
In-Reply-To: <20180521101425.GC9887@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org> <0aba6388-8a73-d371-7b92-3594639eb27e@arm.com>
 <20180518153552.GA23468@rob-hp-laptop> <20180521101425.GC9887@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 May 2018 09:25:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLGgDTfhz6XqgMzDM_KL_W9HRtVOwjeP6rfk3+Tn-Stgg@mail.gmail.com>
Message-ID: <CAL_JsqLGgDTfhz6XqgMzDM_KL_W9HRtVOwjeP6rfk3+Tn-Stgg@mail.gmail.com>
Subject: Re: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh@kernel.org>, James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 5:14 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Hi Rob,
>
> On Fri, May 18, 2018 at 10:35:52AM -0500, Rob Herring wrote:
>> On Tue, May 15, 2018 at 06:12:59PM +0100, James Morse wrote:
>> > Hi guys,
>> >
>> > (CC: +RobH, devicetree list)
>>
>> Thanks.
>>
>> > On 25/04/18 07:26, AKASHI Takahiro wrote:
>> > > Enabling crash dump (kdump) includes
>> > > * prepare contents of ELF header of a core dump file, /proc/vmcore,
>> > >   using crash_prepare_elf64_headers(), and
>> > > * add two device tree properties, "linux,usable-memory-range" and
>> > >   "linux,elfcorehdr", which represent repsectively a memory range
>> > >   to be used by crash dump kernel and the header's location
>>
>> BTW, I intend to move existing parsing these out of the arch code.
>> Please don't add more DT handling to arch/ unless it is *really* arch
>> specific. I'd assume that the next arch to add kexec support will use
>> these bindings instead of the powerpc way.
>
> So do you expect all the fdt-related stuff in my current implementation
> for arm64 to be put into libfdt, or at least drivers/of, from the beginning?

Yes.

> I'm not sure how arch-specific the properties here are. For instance,
> it is only arm64 that uses "linux,usable-memory-range" right now but
> if some other arch follows, it is no more arch-specific.
> # I remember that you didn't like this property :)

The question I guess is what will the next arch use. I don't think any
other DT based arch supports crashdump or kexec yet.

>> > > +{
>> > > + void *buf, *prop;
>> > > + size_t buf_size;
>> > > + int result;
>> > > +
>> > > + buf_size = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
>> > > + prop = buf = vmalloc(buf_size);
>>
>> This can go on the stack instead (and would be required to to work in
>> libfdt).
>
> Well, I can't agree with you here since we are now in effort, as far as
> I correctly understand, of purging all the variable-sized arrays on a local
> stack out of the kernel code.

You don't need a variable sized array. The array size just needs to
the the maximum size (16 bytes).

Rob
