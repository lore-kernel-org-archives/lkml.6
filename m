Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeECX07 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:26:59 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:38310 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeECX0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:26:55 -0400
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
 <e10212ef-c876-4965-6279-967005f53950@maciej.szmigiero.name>
 <20180501200308.GC13171@pd.tnic>
 <9cf234e8-4d96-46f0-70e0-7d60d49671d8@maciej.szmigiero.name>
 <20180503100133.GB20023@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <756e5bd8-6cd8-5f28-6cab-c60396dc5de4@maciej.szmigiero.name>
Date: Fri, 4 May 2018 01:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180503100133.GB20023@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.2018 12:01, Borislav Petkov wrote:
> On Wed, May 02, 2018 at 02:47:39AM +0200, Maciej S. Szmigiero wrote:
>> On 01.05.2018 22:03, Borislav Petkov wrote:
>>> On Tue, May 01, 2018 at 06:19:56PM +0200, Maciej S. Szmigiero wrote:
>>>> -EINVAL cast to unsigned int is 4294967274 and this value is also
>>>> a valid count of bytes to skip that this function can return.
>>>
>>> And where exactly in the *old* code do we do that?
>>
>> The old code returned this value as a signed int, but then any
>> "patch_size" value (which is u32) above INT_MAX read from a section header
>> wrapped around to a negative pseudo-error code (which likely didn't match
>> any actual error number).
> 
> Lemme repeat my question: *where* *exactly* in the old code do we do that?
> 
> Feel free to paste snippets to show what you mean.
> 

>From verify_and_add_patch():
> static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
> {
> 	struct microcode_header_amd *mc_hdr;
> 	struct ucode_patch *patch;
> 	unsigned int patch_size, crnt_size, ret;
> 	u32 proc_fam;
> 	u16 proc_id;
> 
> 	patch_size  = *(u32 *)(fw + 4);

Here we read a u32 (= unsigned int) value from a section header
and store it into an unsigned int variable.

> 	crnt_size   = patch_size + SECTION_HDR_SIZE;

Here we add 8 (SECTION_HDR_SIZE) to this value and once again store it
into an unsigned int variable.

> 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
> 	proc_id	    = mc_hdr->processor_rev_id;
> 
> 	proc_fam = find_cpu_family_by_equiv_cpu(proc_id);
> 	if (!proc_fam) {
> 		pr_err("No patch family for equiv ID: 0x%04x\n", proc_id);
> 		return crnt_size;

Here we return this variable, implicitly converting it into a
(signed) int.
Any value above INT_MAX will wrap around to a negative pseudo-error
code (which might not match any actual error number).

Maciej
