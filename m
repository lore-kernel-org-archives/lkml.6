Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeFDJNh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:13:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38667 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFDJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:13:35 -0400
X-Google-Smtp-Source: ADUXVKLRB9hY0doEa9+KjG+tCNg+sFjAipz+kB3V9Rv/9O8B3Ra8kFZEIh/0qxQcTFhBwbTi/hpTkw==
Date: Mon, 4 Jun 2018 17:13:27 +0800
From: Jun Yao <yaojun8558363@gmail.com>
To: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, greg@kroah.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 0/4] arm64/mm: migrate swapper_pg_dir
Message-ID: <20180604091327.GA4863@toy>
Mail-Followup-To: robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org, greg@kroah.com,
        kernel-hardening@lists.openwall.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jun 2018 at 10:42:10, Robin Murphy <robin.murphy@arm.com> wrote:
>> Currently, The offset between swapper_pg_dir and _text is
>> fixed. When attackers know the address of _text(no KASLR or
>> breaking KASLR), they can caculate the address of
>> swapper_pg_dir. Then KSMA(Kernel Space Mirroring Attack) can
>> be applied.
>>
>> The principle of KSMA is to insert a carefully constructed PGD
>> entry into the translation table. The type of this entry is
>
>Out of interest, how does that part work? AFAICS, modifying a PGD entry
>involves writing to kernel memory, which would mean the implication of KSMA is
>"userspace can gain write permission to kernel memory by writing to kernel
>memory" - that doesn't sound like an attack in itself, more just a convenience
>for ease of exploiting whatever successful attack got you in there in the
>first place.
>
>That's not to say that it isn't still worth mitigating, I'm just questioning
>the given rationale here.

Yes, you are right. KSMA is just a convenience for ease of exploiting. I think
that the biggest role of KSMA is to covert an arbitrary write to multiple
arbitrary writes. In the past, to accomplish this, a function
pointer(e.g. ptmx_fops) is modified to point to gadget, which can r/w kernel
memory. However, PAN makes this more difficult. And KSMA becomes a new way to
do that.

For details on KSMA, you can refer to:

https://www.blackhat.com/docs/asia-18/asia-18-WANG-KSMA-Breaking-Android-kernel-isolation-and-Rooting-with-ARM-MMU-features.pdf

thanks,

Jun
