Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966074AbeEJBLj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:11:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39389 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965830AbeEJBLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:11:38 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39750699"
Subject: Re: [PATCH v2] perf test shell: Add -D to check dynamic symbols for
 ubuntu/debian
To: Kim Phillips <kim.phillips@arm.com>
CC: <linux-kernel@vger.kernel.org>, <acme@kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <philip.li@intel.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <1525851929-20233-1-git-send-email-lizhijian@cn.fujitsu.com>
 <20180509164108.3fd8f5c71c2fa11d0c474067@arm.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <81202e37-a9c2-1385-a32d-0f78d233e22a@cn.fujitsu.com>
Date: Thu, 10 May 2018 09:11:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509164108.3fd8f5c71c2fa11d0c474067@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 64F324B34D43.AC14F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input file is from
lizhijian@haswell-OptiPlex-9020:~/lkp/linux/tools/perf/tests/shell$ grep libc= -A1  record+probe_libc_inet_pton.sh
libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
nm -gD $libc 2>/dev/null | fgrep -q inet_pton || exit 254

It mostly points to a striped libc.so(the runtime library)
lizhijian@haswell-OptiPlex-9020:~/lkp/linux/tools/perf/tests/shell$ grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g'
/lib/x86_64-linux-gnu/libc-2.23.so

Although we can get the expected symbol from the debug library, it still doesn't work for this case.

Thanks
Zhijian


On 05/10/2018 05:41 AM, Kim Phillips wrote:
> On Wed, 9 May 2018 15:45:29 +0800
> Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
>> On Ubuntu and Debian, we can't find any symbol including "inet_pton" from 'nm -g'
>> root@vm-lkp-nex04-8G-5 ~# nm -g /lib/x86_64-linux-gnu/libc-2.25.so | grep inet_pton
>> nm: /lib/x86_64-linux-gnu/libc-2.25.so: no symbols
>>
>> it looks libc.so has different symbol compositions at different distros
> I'm wondering if that is because libc6-dbg isn't installed?:
>
> ubuntu$ nm -g /usr/lib/debug/lib/x86_64-linux-gnu/libc-2.26.so | grep inet_pton
> 0000000000136340 W inet_pton
> 0000000000136010 T __inet_pton_length
>
> Kim
>
>
> .
>
