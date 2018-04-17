Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeDQPAw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:00:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750741AbeDQPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:00:49 -0400
Subject: Re: [PATCH 1/2] perf tools powerpc: Fix callchain ip filtering
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        maynard@us.ibm.com
References: <20180412171129.4422-1-sandipan@linux.vnet.ibm.com>
 <20180412171129.4422-2-sandipan@linux.vnet.ibm.com>
 <3471e3e0-80ad-7a7f-96b8-60d24a4931a2@linux.ibm.com>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 20:30:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <3471e3e0-80ad-7a7f-96b8-60d24a4931a2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041715-0020-0000-0000-00000412EEB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041715-0021-0000-0000-000042A72F6E
Message-Id: <8b57ea28-f620-2f9c-e494-3877606696a6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/17/2018 12:29 PM, Ravi Bangoria wrote:
> 
> This change looks good to me but seems it fixed the issue
> partially.Ex,
> 
>     # readelf --debug-dump=frames-interp /lib64/libc-2.26.so | less
>     ...
>     00005778 0000000000000024 0000577c FDE cie=00000000 pc=0000000000048b30..0000000000048c64
>        LOC           CFA      r31   ra   
>     0000000000048b30 r1+0     u     u    
>     0000000000048b40 r1+0     c-8   r0   
>     0000000000048b58 r1+64    c-8   c+16 
>     0000000000048bd8 r1+0     c-8   c+16 
>     0000000000048be4 r1+0     u    
>     0000000000048bf0 r1+64    c-8   c+16 
> 
> 0000000000048b30..0000000000048c64 is arandom() function from libc:
> 
>     0000000000048b30 <random>:
>        48b30:       1c 00 4c 3c     addis   r2,r12,28
>        48b34:       d0 e5 42 38     addi    r2,r2,-6704
>        48b38:       a6 02 08 7c     mflr    r0
>        48b3c:       f8 ff e1 fb     std     r31,-8(r1)
>        48b40:       00 00 00 60     nop
>        48b44:       00 00 20 39     li      r9,0
>        48b48:       80 b5 e2 3b     addi    r31,r2,-19072
>        48b4c:       01 00 00 39     li      r8,1
>        48b50:       10 00 01 f8     std     r0,16(r1)
>        48b54:       c1 ff 21 f8     stdu    r1,-64(r1)
>        48b58:       f0 8f 4d e9     ld      r10,-28688(r13)
>        ...
> 
> Your change fixed the issue for 48b30..48b40. But not for
> 48b40..48b58.
> 
> I probed at 0x48b40.
> 
>     # ./perf record -g -e probe_libc:abs_48b40 ~/rand
> 
> perf report without Suka's and your change:
> 
>     # Children      Self  Trace output 
>     # ........  ........  ..............
>     #
>        100.00%   100.00%  (7fffb7d28b40)
>                 |
>                 ---0
>                    __libc_start_main
>                    generic_start_main.isra.0
>                    main
>                    rand
>                    __random
> 
> perf report with only Suka's change:
> 
>     # Children      Self  Trace output 
>     # ........  ........  ..............
>     #
>        100.00%   100.00%  (7fffb7d28b40)
>                 |
>                 ---0
>                    __libc_start_main
>                    generic_start_main.isra.0
>                    main
>                    __random
> 
> perf report with Suka's and your change:
> 
>     # Children      Self  Trace output 
>     # ........  ........  ..............
>     #
>        100.00%   100.00%  (7fffb7d28b40)
>                 |
>                 ---0
>                    __libc_start_main
>                    generic_start_main.isra.0
>                    main
>                    __random
> 
> I think rand() is a valid entry which is missing in last two cases.
> 
> 

Ah, good catch and thanks for the review. Will address these problems in v2.

- Sandipan
