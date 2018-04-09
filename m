Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeDIMj5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:39:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751786AbeDIMj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:39:56 -0400
Date: Mon, 9 Apr 2018 14:39:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: s390: defective uses of va_arg in __debug_sprintf_event
In-Reply-To: <1523041723.6127.33.camel@perches.com>
References: <1523041723.6127.33.camel@perches.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040912-0008-0000-0000-000004E858E5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040912-0009-0000-0000-00001E7B7D10
Message-Id: <20180409143934.3f27902c@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Apr 2018 12:08:43 -0700
Joe Perches <joe@perches.com> wrote:

> debug_sprintf_event calls __debug_sprintf_event
> with a format and arguments.
> 
> There various types of arguments used in these
> call, but __debug_sprintf_event uses va_arg
> with only long as the type argument so random
> errors could occur because the type and argument
> are supposed to match.
> 
>     debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
>     {
>     	    [...]
>     	    va_start(ap, string);
>     	    curr_event->string = string;
>     	    for (idx = 0; idx < min(numargs, (int)(id->buf_size / sizeof(long)) - 1); idx++)
>     	    	    curr_event->args[idx] = va_arg(ap, long);
>     	    va_end(ap);
>     	    [...]
>     }
> 
> from man va_arg
> 
>     va_arg()
> 
>     if type is not compatible with the type of the actual next argument
>     (as promoted according to the default argument promotions),
>     random errors will occur.
> 
> For instance, uses like:
> 
> arch/s390/kernel/perf_cpum_sf.c:919:    debug_sprintf_event(sfdbg, 6, "pmu_enable: es=%i cs=%i ed=%i cd=%i "
> arch/s390/kernel/perf_cpum_sf.c-920-                        "tear=%p dear=%p\n", cpuhw->lsctl.es, cpuhw->lsctl.cs,
> arch/s390/kernel/perf_cpum_sf.c-921-                        cpuhw->lsctl.ed, cpuhw->lsctl.cd,
> arch/s390/kernel/perf_cpum_sf.c-922-                        (void *) cpuhw->lsctl.tear, (void *) cpuhw->lsctl.dear);
> 
> where the first 3 arguments are int but their type
> as used by va_arg in __debug_sprintf_event is long
> which could produce random errors.

In principle you are right that the va_arg handling is not 100%
correct. It works though because the C ABI for s390x requires
that arguments are sign- or zero-extended to 64 bits by the caller
of a function. This is true for values passed in registers and for
the variable argument list.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
