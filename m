Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756016AbeEAQUA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:20:00 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:56138 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755402AbeEAQT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:19:58 -0400
Subject: Re: [PATCH v5 4/6] x86/microcode/AMD: Check microcode container data
 in the late loader
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090527.GC6509@pd.tnic>
 <bce73502-0d18-e50c-b78b-8159dc9f8f66@maciej.szmigiero.name>
 <20180501084317.GC31863@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <e10212ef-c876-4965-6279-967005f53950@maciej.szmigiero.name>
Date: Tue, 1 May 2018 18:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180501084317.GC31863@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.05.2018 10:43, Borislav Petkov wrote:
> On Tue, May 01, 2018 at 12:27:51AM +0200, Maciej S. Szmigiero wrote:
>> 1) -EINVAL maps to a valid return value of 4294967274 bytes.
>> We have a different behavior for invalid data in the container file
>> (including too large lengths) than for grave errors like a failed memory
>> allocation.
> 
> WTF?

Could you please elaborate this comment?

-EINVAL cast to unsigned int is 4294967274 and this value is also
a valid count of bytes to skip that this function can return.

The "grave errors" behavior comes from the existing code, a comment
in code above verify_and_add_patch() says:
"a grave error like a memory allocation has failed and the driver cannot
continue functioning normally. In such cases, we tear down everything
we've used up so far and exit."

>> 2) This function single caller (__load_microcode_amd()) normalized any
>> error that verify_and_add_patch() returned to UCODE_ERROR anyway,
> 
> So?

This means that there is no loss of information here.

The function these three points are about (verify_and_add_patch()) is
declared as "static", so it cannot be called from any other kernel code.

>> 3) The existing code uses a convention that zero return value means
>> 'terminate processing' for the parse_container() function in the early
>> loader which normally returns a 'bytes consumed' value, as this function
>> does.
> 
> parse_container() could very well change its convention to return
> negative on error and positive value if the loop is supposed to skip
> bytes.
> 

Yes, but then the problem from the point 1) above will be introduced
also to parse_container().

Maciej
