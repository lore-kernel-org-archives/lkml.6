Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969760AbeEXMKd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:10:33 -0400
Received: from foss.arm.com ([217.140.101.70]:42794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966524AbeEXMK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:10:28 -0400
Subject: Re: [PATCH 02/14] arm64: Call ARCH_WORKAROUND_2 on transitions
 between EL0 and EL1
To: Mark Rutland <mark.rutland@arm.com>,
        Julien Grall <julien.grall@arm.com>
Cc: Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-3-marc.zyngier@arm.com>
 <0b03ce12-510e-464b-63de-cd481d7cb1c5@arm.com>
 <20180524105205.rq25srimaceo3ov4@lakrids.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4613ce1d-f9e8-5ef4-e3c2-6c2c4d89c929@arm.com>
Date: Thu, 24 May 2018 13:10:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524105205.rq25srimaceo3ov4@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 11:52, Mark Rutland wrote:
> On Wed, May 23, 2018 at 10:23:20AM +0100, Julien Grall wrote:
>> Hi Marc,
>>
>> On 05/22/2018 04:06 PM, Marc Zyngier wrote:
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index ec2ee720e33e..f33e6aed3037 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -18,6 +18,7 @@
>>>     * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>     */
>>> +#include <linux/arm-smccc.h>
>>>    #include <linux/init.h>
>>>    #include <linux/linkage.h>
>>> @@ -137,6 +138,18 @@ alternative_else_nop_endif
>>>    	add	\dst, \dst, #(\sym - .entry.tramp.text)
>>>    	.endm
>>> +	// This macro corrupts x0-x3. It is the caller's duty
>>> +	// to save/restore them if required.
>>
>> NIT: Shouldn't you use /* ... */ for multi-line comments?
> 
> There's no requirement to do so, and IIRC even Torvalds prefers '//'
> comments for multi-line things these days.

Also, this is an assembly code, not C; '//' is the actual A64 assembler 
comment syntax so is arguably more appropriate here in spite of being 
moot thanks to preprocessing.

Robin.
