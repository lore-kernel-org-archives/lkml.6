Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbeD3W1i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 18:27:38 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44444 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755102AbeD3W1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 18:27:37 -0400
Subject: Re: [PATCH v5 3/6] x86/microcode/AMD: Check microcode container data
 in the early loader
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <60157b92eef72a73778d9e483b5376db737b5a97.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090506.GB6509@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <587188f6-fe91-f2e4-4e41-cb9bc808ecf0@maciej.szmigiero.name>
Date: Tue, 1 May 2018 00:27:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180430090506.GB6509@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2018 11:05, Borislav Petkov wrote:
> On Mon, Apr 23, 2018 at 11:34:08PM +0200, Maciej S. Szmigiero wrote:
>> --- a/arch/x86/kernel/cpu/microcode/amd.c
>> +++ b/arch/x86/kernel/cpu/microcode/amd.c
>> @@ -216,29 +216,33 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
>>   * Returns the amount of bytes consumed while scanning. @desc contains all the
>>   * data we're going to use in later stages of the application.
>>   */
>> -static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
>> +static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
>>  {
>>  	struct equiv_cpu_entry *eq;
>> -	ssize_t orig_size = size;
>> +	size_t orig_size = size;
>>  	u32 *hdr = (u32 *)ucode;
>> +	u32 equiv_tbl_len;
>>  	u16 eq_id;
>>  	u8 *buf;
>>  
>> -	/* Am I looking at an equivalence table header? */
>> -	if (hdr[0] != UCODE_MAGIC ||
>> -	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
>> -	    hdr[2] == 0)
>> +	if (!verify_container(ucode, size, true))
>> +		return 0;
> 
>  		return CONTAINER_HDR_SZ;
> 
> We want to make some forward progress after all.

Even if the container file main magic number is wrong? In this case
parsing is terminated by returning a zero from the above function.

If we want to make the parser more resistant to garbage or
forward-compatible to containers with a different main magic number in
their headers we probably should return a length of a single byte here
instead of 12 (CONTAINER_HDR_SZ) so the parser would correctly skip
unknown data of size which isn't an integer multiple of this number.

Thanks,
Maciej
