Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeCLM5I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:57:08 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47432 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLM5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:57:04 -0400
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
 <20180312095336.GB9431@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
Date: Mon, 12 Mar 2018 13:56:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312095336.GB9431@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 10:53, Borislav Petkov wrote:
> On Sun, Mar 11, 2018 at 04:27:03PM +0100, Maciej S. Szmigiero wrote:
>> +/* 4k */
>> +#define UCODE_EQUIV_CPU_TABLE_MAX_SIZE (256 * sizeof(struct equiv_cpu_entry))
> 
> And you came up with that max size how exactly?
The equivalent CPU table is allocated using vmalloc() so it is nice
when the maximum size is an integer multiple of the page size.

Since the maximum entry count in current microcode files is 18 the
maximum size of 256 entries (or one page) gives us plenty of headroom.

Also, looking in the past, there probably won't be more than 256 AMD CPU
types in one CPU family.

> 
>> +/* If a patch is larger than this the microcode file is surely corrupted */
>> +#define PATCH_MAX_SIZE_ABSOLUTE (16 * 1024 * 1024)
> 
> Same question here.
> 

This limit is an absolute upper cap of a patch size.
This number is high so it won't have to be changed in the future, it
only serves as a plausibility check before we consider other data
contained in the particular patch.

Current patches are 4k max size, but since the size field is
32 bit-wide one can theoretically specify sizes up to 4GB.


Since these two maximum sizes are somewhat arbitrary if anybody wants
to propose other values the patch can be updated, naturally.

Maciej
