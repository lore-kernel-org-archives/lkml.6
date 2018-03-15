Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeCOAFR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:05:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39076 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbeCOAFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:05:16 -0400
Subject: Re: [PATCH v3 4/9] x86/microcode/AMD: automatically compute the
 PATCH_MAX_SIZE macro
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <de9e4416-0afa-ef07-2c0d-77aa7252a6ea@maciej.szmigiero.name>
 <20180314180209.GH16605@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <a4ea015b-1176-2db2-d339-677b1b5893f5@maciej.szmigiero.name>
Date: Thu, 15 Mar 2018 01:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314180209.GH16605@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.2018 19:02, Borislav Petkov wrote:
> On Tue, Mar 13, 2018 at 10:06:48PM +0100, Maciej S. Szmigiero wrote:
>> +/* Maximum of all the above families */
>> +#define PATCH_MAX_SIZE SIMPLE_MAX3(F1XH_MPB_MAX_SIZE, F14H_MPB_MAX_SIZE, \
> 
> Nope, it should be
> 
> #define PATCH_MAX_SIZE (max_t(unsigned int, FXXH...

Unfortunately, this does not work:
> ./include/linux/kernel.h:806:41: error: braced-group within expression allowed only inside a function
>  #define __max(t1, t2, max1, max2, x, y) ({  \

That's because we have a static array containing the chosen microcode
patch for the current CPU (amd_ucode_patch) using this macro value as its
length.

Comments in the code say we can't use vmalloc() during early microcode
load so we can't allocate this array dynamically.

And if we hardcode its length we don't get the benefits of automatically
computing this length as maximum of all family patch sizes (as it should
be).

Maciej
