Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbeD3W1z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 18:27:55 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44908 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755123AbeD3W1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 18:27:53 -0400
Subject: Re: [PATCH v5 4/6] x86/microcode/AMD: Check microcode container data
 in the late loader
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090527.GC6509@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <bce73502-0d18-e50c-b78b-8159dc9f8f66@maciej.szmigiero.name>
Date: Tue, 1 May 2018 00:27:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180430090527.GC6509@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2018 11:05, Borislav Petkov wrote:
> On Mon, Apr 23, 2018 at 11:34:09PM +0200, Maciej S. Szmigiero wrote:
>> --- a/arch/x86/kernel/cpu/microcode/amd.c
>> +++ b/arch/x86/kernel/cpu/microcode/amd.c
>> @@ -750,28 +752,20 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
>>  		return crnt_size;
>>  	}
>>  
>> -	/*
>> -	 * The section header length is not included in this indicated size
>> -	 * but is present in the leftover file length so we need to subtract
>> -	 * it before passing this value to the function below.
>> -	 */
>> -	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
>> -	if (!ret) {
>> -		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
>> +	if (!verify_patch(family, fw, leftover, false))
>>  		return crnt_size;
>> -	}
>>  
>>  	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
>>  	if (!patch) {
>>  		pr_err("Patch allocation failure.\n");
>> -		return -EINVAL;
>> +		return 0;
> 
> So by convention returning 0 is success and negative value means error.
> I don't see the reason for changing that in the whole code.

1) -EINVAL maps to a valid return value of 4294967274 bytes.
We have a different behavior for invalid data in the container file
(including too large lengths) than for grave errors like a failed memory
allocation.

2) This function single caller (__load_microcode_amd()) normalized any
error that verify_and_add_patch() returned to UCODE_ERROR anyway,

3) The existing code uses a convention that zero return value means
'terminate processing' for the parse_container() function in the early
loader which normally returns a 'bytes consumed' value, as this function
does.

Thanks,
Maciej
