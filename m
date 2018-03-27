Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeC0B5X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:57:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeC0B5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:57:20 -0400
Subject: Re: [PATCH 1/2] Move kfree_call_rcu() to slab_common.c
To: Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        brouer@redhat.com, linux-mm@kvack.org
References: <1514923898-2495-1-git-send-email-rao.shoaib@oracle.com>
 <20180102222341.GB20405@bombadil.infradead.org>
 <3be609d4-800e-a89e-f885-7e0f5d288862@oracle.com>
 <20180104013807.GA31392@tardis>
 <be1abd24-56c8-45bc-fecc-3f0c5b978678@oracle.com>
 <64ca3929-4044-9393-a6ca-70c0a2589a35@oracle.com>
 <20180104214658.GA20740@bombadil.infradead.org>
 <3e4ea0b9-686f-7e36-d80c-8577401517e2@oracle.com>
 <20180104231307.GA794@bombadil.infradead.org>
 <20180104234732.GM9671@linux.vnet.ibm.com>
 <20180105000707.GA22237@bombadil.infradead.org>
 <1515134773.21222.13.camel@perches.com>
From: Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <1e8c4382-b97f-659a-59fa-07c71efad970@oracle.com>
Date: Mon, 26 Mar 2018 18:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515134773.21222.13.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Is anyone working on resolving the check patch issue as I am waiting to 
resubmit my patch. Will it be fine if I submitted the patch with the 
original macro as the check is in-correct.

I do not speak perl but I can do the process work. If folks think Joe's 
fix is fine I can submit it and perhaps someone can review it ?

Regards,

Shoaib


On 01/04/2018 10:46 PM, Joe Perches wrote:
> On Thu, 2018-01-04 at 16:07 -0800, Matthew Wilcox wrote:
>> On Thu, Jan 04, 2018 at 03:47:32PM -0800, Paul E. McKenney wrote:
>>> I was under the impression that typeof did not actually evaluate its
>>> argument, but rather only returned its type.  And there are a few macros
>>> with this pattern in mainline.
>>>
>>> Or am I confused about what typeof does?
>> I think checkpatch is confused by the '*' in the typeof argument:
>>
>> $ git diff |./scripts/checkpatch.pl --strict
>> CHECK: Macro argument reuse 'ptr' - possible side-effects?
>> #29: FILE: include/linux/rcupdate.h:896:
>> +#define kfree_rcu(ptr, rcu_head)                                        \
>> +	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
>>
>> If one removes the '*', the warning goes away.
>>
>> I'm no perlista, but Joe, would this regexp modification make sense?
>>
>> +++ b/scripts/checkpatch.pl
>> @@ -4957,7 +4957,7 @@ sub process {
>>                                  next if ($arg =~ /\.\.\./);
>>                                  next if ($arg =~ /^type$/i);
>>                                  my $tmp_stmt = $define_stmt;
>> -                               $tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
>> +                               $tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\**\(*\s*$arg\s*\)*\b//g;
> I supposed ideally it'd be more like
>
> $tmp_stmt =~ s/\b(?:typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*(?:\s*\*\s*)*\s*\(*\s*$arg\s*\)*\b//g;
>
> Adding ?: at the start to not capture and
> (?:\s*\*\s*)* for any number of * with any
> surrounding spacings.
