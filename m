Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeCJM0E (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 07:26:04 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:58702 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeCJM0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 07:26:03 -0500
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
 <20180310091838.GA8261@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <2cfade76-7d3d-38be-8da6-5927a043a91b@maciej.szmigiero.name>
Date: Sat, 10 Mar 2018 13:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310091838.GA8261@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2018 10:18, Borislav Petkov wrote:
> On Sat, Mar 10, 2018 at 01:34:45AM +0100, Maciej S. Szmigiero wrote:
>> Currently, it is very easy to make the AMD microcode update driver crash
>> or spin on a malformed microcode file since it does very little
>> consistency checking on data loaded from such file.
> 
> Sorry but if one has enough permissions to install malformed microcode,
> crashing the loader is the least of your problems. IOW, I don't see the
> justification for the unnecessary complication with all those checks.

While I agree this is not a security problem, I cannot agree that these
checks are unnecessary driver complication.

First, these checks are really just very basic checks like "check
whether the loaded file is long enough to actually contain some
structure before accessing it" or "don't iterate an array in file
without checking if it actually has a terminating element" or "check
whether microcode patch length isn't something like 2GB before allocating
memory for it".

Without them, it is easy to crash the driver when just playing with
microcode files (and it turns out that AMD-released microcode files in
linux-firmware actually don't contain the newest microcode versions,
even for older CPUs).

Second, since these checks happen only on a microcode file load
(something that 99.9% of systems probably will do just once at boot
time) it is hardly a performance-critical path.

Third, we still do check consistency of data provided to various
root-only syscalls (and these might be much more performance-critical
than this code).
 
> Thx.
> 

Thanks,
Maciej
