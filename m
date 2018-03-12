Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeCLOKu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:10:50 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:52244 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbeCLOKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:10:49 -0400
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
 <20180312095336.GB9431@pd.tnic>
 <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
 <20180312130653.GC9431@pd.tnic>
 <df1e721c-f030-68b4-f197-2592bce97bbf@maciej.szmigiero.name>
 <20180312134853.GD9431@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <2d60978a-522c-ff00-f245-a7e681283371@maciej.szmigiero.name>
Date: Mon, 12 Mar 2018 15:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312134853.GD9431@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 14:48, Borislav Petkov wrote:
> On Mon, Mar 12, 2018 at 02:32:30PM +0100, Maciej S. Szmigiero wrote:
>> "microcode_amd.bin" in linux-firmware.
> 
> That is the microcode container for all families < 0x15. And it
> *happens* to have 18 entries.
> 
> So purely arbitrary:
> 
> Equivalence table (magic: AMD, type: 0, length: 288 (0x120))
(the long table was cut)
> 
>> There is no problem raising this value in that (future) case.
>> As I wrote previously, currently the maximum used count is 18.
> 
> There is a problem because not everyone can upgrade their kernels
> like you. Distros and big deployments can't just up and update their
> kernels at a whim just because you imposed an arbitrary limit which you
> determined would be ok.

First, this limit is more than 14 times higher than the current maximum
count.

And this current maximum was reached by CPU types added in
families < 15h during last 10+ years (the oldest supported CPU family in
this container is 10h, which - according to Wikipedia - was released
September 10, 2007).

At that rate exceeding this limit will take 130+ additional years (and
this assumes that AMD will introduce new CPU types in these families
at the same rate as in the last 10 years - I sincerely doubt it).

If somebody does not update their kernel for 130 years (even to -stable
versions) then he or she has a much bigger problem than incompatibility
with the current microcode update file.

> 
>> Not really, since even in the existing code CONTAINER_HDR_SZ (12) gets
>> added to this size, then the sum is cast to a (signed) int.
>> If this value is negative then the file get rejected.
> 
> That is a bug in install_equiv_cpu_table() - it should return unsigned int.
> 
>> It can be changed to the current maximum across sizes for particular
> 
> What is the "current maximum across sizes"?
> 

This is the current maximum patch size across families:
#define F15H_MPB_MAX_SIZE 4096

Maciej
