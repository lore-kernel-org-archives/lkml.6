Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936532AbeE2P2K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:28:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61799 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935620AbeE2P2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:28:00 -0400
Subject: Re: [PATCH] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180424041559.32410-1-mpe@ellerman.id.au>
 <20180528131914.32231-1-msuchanek@suse.de>
 <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
 <20180529164640.02faedcd@kitsune.suse.cz>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <59492aa2-a12d-4f74-0a5a-14f89de64908@c-s.fr>
Date: Tue, 29 May 2018 15:24:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529164640.02faedcd@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 02:46 PM, Michal Suchánek wrote:
> On Tue, 29 May 2018 16:13:49 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 28/05/2018 à 15:19, Michal Suchanek a écrit :
>>> We now have barrier_nospec as mitigation so print it in
>>> cpu_show_spectre_v1 when enabled.
>>>
>>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>>> ---
>>>    arch/powerpc/kernel/security.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/security.c
>>> b/arch/powerpc/kernel/security.c index 0239383c7e4d..a0c32d53980b
>>> 100644 --- a/arch/powerpc/kernel/security.c
>>> +++ b/arch/powerpc/kernel/security.c
>>> @@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device
>>> *dev, struct device_attribute *attr, c if
>>> (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) return
>>> sprintf(buf, "Not affected\n");
>>> -	return sprintf(buf, "Vulnerable\n");
>>> +	if (barrier_nospec_enabled)
>>
>>> +		return sprintf(buf, "Mitigation: __user pointer
>>> sanitization\n");
>>> +	else
>>> +		return sprintf(buf, "Vulnerable\n");
>>
>> Checkpatch would tell you that an else is unneeded after a return. So
>> just leave it as it was before.
> 
> Where did you get your copy of checkpatch? The one in Linux tree does
> not do that.

Strange, it should, as checkpatch.pl includes the following code:

# check indentation of any line with a bare else
# (but not if it is a multiple line "if (foo) return bar; else return baz;")
# if the previous line is a break or return and is indented 1 tab more...
		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
			my $tabs = length($1) + 1;
			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
			     defined $lines[$linenr] &&
			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
				WARN("UNNECESSARY_ELSE",
				     "else is not generally useful after a break or return\n" . 
$hereprev);
			}
		}


Anyway, you should remove that 'else' in your patch.
And the other sprintf line is over 80 characters.

Christophe

> 
> Thanks
> 
> Michal
> 
