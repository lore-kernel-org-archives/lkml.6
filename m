Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeCFOwo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:52:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753065AbeCFOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:52:43 -0500
Subject: Re: [PATCH Resent] perf annotate: Fix s390 target function
 disassembly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20180306123955.98802-1-tmricht@linux.vnet.ibm.com>
 <20180306140449.GD10176@kernel.org>
From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Organization: IBM LTC
Date: Tue, 6 Mar 2018 15:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306140449.GD10176@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030614-0012-0000-0000-000005B979D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030614-0013-0000-0000-00001935917F
Message-Id: <f37513cc-1819-6a66-03b5-73b30bbbb966@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 03:04 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 06, 2018 at 01:39:55PM +0100, Thomas Richter escreveu:
>> Perf annotate displays function call assembler instructions
>> with a right arrow. Hitting enter on this line/instruction
>> causes the browser to disassemble this target function and
>> show it on the screen.  On s390 this results in an error
>> message 'The called function was not found.'
>>
>> The function call assembly line parsing does not handle
>> the s390 bras and brasl instructions. Function call__parse
>> expects the target as first operand:
>> 	callq	e9140 <__fxstat>
>> S390 has a register number as first operand:
>> 	brasl	%r14,41d60 <abort>
>> Therefore the target addresses on s390 are always zero
>> which is an invalid address.
>>
>> Fix this by skipping the first operand on s390.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>> ---
>>  tools/perf/util/annotate.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 49ff825f745c..feb6006b676d 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -192,6 +192,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
>>  	};
>>  
>>  	ops->target.addr = strtoull(ops->raw, &endptr, 16);
>> +	if (!strcmp(arch->name, "s390")) {
>> +		/* s390 function call 1st operand is register */
>> +		tok = strchr(ops->raw, ',');
>> +		if (tok)
>> +			ops->target.addr = strtoull(tok + 1, &endptr, 16);
>> +		else
>> +			ops->target.addr = 0;
>> +	} else
>> +		ops->target.addr = strtoull(ops->raw, &endptr, 16);
> 
> Do we have to do this here? Can't we have a s390_call__parse() and set
> that in the s/390 instructions?


Originally I wanted to add an architecture specific weak function to handle s390
This did not work because file util/annotate.c includes the architecture specific versions
around line 100:

#include "arch/arm/annotate/instructions.c"
#include "arch/arm64/annotate/instructions.c"
#include "arch/x86/annotate/instructions.c"
#include "arch/powerpc/annotate/instructions.c"
#include "arch/s390/annotate/instructions.c"

This includes the C file for s390 so we end up having function call__parse defined twice,
one with a weak definition and one without which results in a compiler error.

I will use  a s390 specific call__parse function and sent another patch.

>> -- 
>> 2.14.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
