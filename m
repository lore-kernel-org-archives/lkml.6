Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeD3W1X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 18:27:23 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44066 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbeD3W1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 18:27:22 -0400
Subject: Re: [PATCH v5 2/6] x86/microcode/AMD: Add microcode container data
 checking functions
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <ea8b42f1d7a0fa75b2a13758f71f6c486862ab47.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090447.GA6509@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <c4a49546-a4bb-c7a5-116a-be537bacb688@maciej.szmigiero.name>
Date: Tue, 1 May 2018 00:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180430090447.GA6509@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2018 11:04, Borislav Petkov wrote:
> On Mon, Apr 23, 2018 at 11:34:07PM +0200, Maciej S. Szmigiero wrote:
>> --- a/arch/x86/kernel/cpu/microcode/amd.c
>> +++ b/arch/x86/kernel/cpu/microcode/amd.c
>> +/*
>> + * Checks whether there is a valid, non-truncated CPU equivalence table
>> + * at the beginning of a passed buffer @buf of size @size.
>> + * If @early is set this function does not print errors which makes it
>> + * usable by the early microcode loader.
>> + */
>> +static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
>> +{
>> +	const u32 *hdr = (const u32 *)buf;
>> +	u32 cont_type, equiv_tbl_len;
>> +
>> +	cont_type = hdr[1];
> 
> You need to check the size of buf so that there's enough buf passed in
> before you index into it like that.

These checking functions are supposed to be called in order:
first verify_container() verifies the basic container, then
verify_equivalence_table() verifies the equivalence table while not
repeating the checks that were already done by the former function.

>> +	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
>> +		if (!early)
>> +			pr_err("Wrong microcode container equivalence table type: %u.\n",
>> +			       cont_type);
>> +
>> +		return false;
>> +	}
>> +
>> +	equiv_tbl_len = hdr[2];
> 
> And that.

Same situation here.

>> +
>> +/*
>> + * Checks whether a microcode patch located at the beginning of a passed
>> + * buffer @buf of size @size is not too large for a particular @family
>> + * and is not truncated.
>> + * If @early is set this function does not print errors which makes it
>> + * usable by the early microcode loader.
>> + */
>> +static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
>> +{
>> +	const u32 *hdr = (const u32 *)buf;
>> +	u32 patch_size = hdr[1];
> 
> Just like in the first comment above.
> 

And a similar situation here - verify_patch() does not verify things
that were already checked by verify_container() or
verify_patch_section().

Thanks,
Maciej
