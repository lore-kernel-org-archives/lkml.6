Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCNXeO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:34:14 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44618 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeCNXeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:34:13 -0400
Subject: Re: [PATCH v3 2/9] x86/microcode/AMD: check whether the equivalence
 table fits in the file
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <e2de27e0-6250-a10f-8d08-99c0c8d417ba@maciej.szmigiero.name>
 <20180314170457.GE16605@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <863eeb13-1c67-da37-6862-610a1204d648@maciej.szmigiero.name>
Date: Thu, 15 Mar 2018 00:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314170457.GE16605@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.2018 18:04, Borislav Petkov wrote:
> On Tue, Mar 13, 2018 at 10:06:23PM +0100, Maciej S. Szmigiero wrote:
(..)
>> --- a/arch/x86/kernel/cpu/microcode/amd.c
>> +++ b/arch/x86/kernel/cpu/microcode/amd.c
>> @@ -80,20 +80,29 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
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
>> +	size_t eq_size;
>>  	u16 eq_id;
>>  	u8 *buf;
>>  
>>  	/* Am I looking at an equivalence table header? */
> 
> That comment becomes wrong when you add this check here.

It was moved there because on the first (monolithic) iteration of this
change there was a review comment that it better belongs here.

No problem to move it back, however.

>> +	if (size < CONTAINER_HDR_SZ)
>> +		return 0;
>> +
>>  	if (hdr[0] != UCODE_MAGIC ||
>>  	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
>>  	    hdr[2] == 0)
>>  		return CONTAINER_HDR_SZ;
>>  
>> +	eq_size = hdr[2];
> 
> If we're going to have special local vars for the container header, then
> do it right:
> 
> 	cont_magic	= hdr[0];
> 	cont_type  	= hdr[1];
> 	equiv_tbl_len	= hdr[2];
> 
> and then use those from now on.

Will do.

>> +	if (eq_size < sizeof(*eq) ||
>> +	    size - CONTAINER_HDR_SZ < eq_size)
>> +		return 0;
> 
> I think you want
> 
> 	if (size < eqiv_tbl_len + CONTAINER_HDR_SZ)
> 		return size;
> 
> here to skip over the next, hopefully not truncated container.

'size' here is the length of the whole CPIO blob containing all
containers combined (well, the remaining part of it).

If we skip over 'size' bytes we'll have nothing left to parse.

>> @@ -159,15 +168,13 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
>>   */
>>  static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
>>  {
>> -	ssize_t rem = size;
>> -
>> -	while (rem >= 0) {
>> -		ssize_t s = parse_container(ucode, rem, desc);
>> +	while (size > 0) {
>> +		size_t s = parse_container(ucode, size, desc);
>>  		if (!s)
>>  			return;
>>  
>>  		ucode += s;
>> -		rem   -= s;
>> +		size  -= s;
>>  	}
>>  }
>>  
> 
> All changes upto here need to be a separate patch.
> install_equiv_cpu_table() changes below are the second patch.

OK, will split this into two patches.

>> @@ -540,15 +547,30 @@ static enum ucode_state apply_microcode_amd(int cpu)
>>  	return UCODE_UPDATED;
>>  }
>>  
>> -static int install_equiv_cpu_table(const u8 *buf)
>> +static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
>>  {
>>  	unsigned int *ibuf = (unsigned int *)buf;
>> -	unsigned int type = ibuf[1];
>> -	unsigned int size = ibuf[2];
>> +	unsigned int type, size;
> 
> unsigned int type, equiv_tbl_len;

Will do.

>> +
>> +	if (buf_size < CONTAINER_HDR_SZ) {
> 
> 		     <= is ok too.

Will do.

>> +		pr_err("no container header\n");
> 
> More descriptive error messages:
> 
> 			"Truncated microcode container header.\n"

Will do.

>> +		return -EINVAL;
>> +	}
>> +
>> +	type = ibuf[1];
>> +	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
>> +		pr_err("invalid type field in container file section header\n");
> 
> 			"Wrong microcode container equivalence table type: %d.\n"

Will do.

>> +		return -EINVAL;
>> +	}
>> +
>> +	size = ibuf[2];
>> +	if (size < sizeof(struct equiv_cpu_entry)) {
>> +		pr_err("equivalent CPU table too short\n");
> 
> 			"Truncated equivalence table.\n"

Will do.

>> +		return -EINVAL;
>> +	}
>>  
>> -	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
>> -		pr_err("empty section/"
>> -		       "invalid type field in container file section header\n");
>> +	if (buf_size - CONTAINER_HDR_SZ < size) {
>> +		pr_err("equivalent CPU table truncated\n");
> 
> Combine that test with the above one and use the same error message.

Will do.
 
> Thx.
> 

Thanks,
Maciej
