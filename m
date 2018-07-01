Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF0FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ACF2517A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ACF2517A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeGAFkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:40:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37849 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751730AbeGAFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:40:16 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="41692745"
Received: from localhost (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Jul 2018 13:40:12 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 85D504B41ED0;
        Sun,  1 Jul 2018 13:40:06 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.399.0; Sun, 1 Jul 2018 13:40:08 +0800
Subject: Re: [PATCH] perf test record+probe_libc_inet_pton: expect [unknown]
 for ping as well
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
References: <1530170160-4979-1-git-send-email-lizhijian@cn.fujitsu.com>
 <20180629151736.GA3593@kernel.org>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <40b4c887-1853-3f37-9d2c-4646f0e0adc6@cn.fujitsu.com>
Date:   Sun, 1 Jul 2018 13:40:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629151736.GA3593@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 85D504B41ED0.AA60A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/29/2018 11:17 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 28, 2018 at 03:16:00PM +0800, Li Zhijian escreveu:
>> On system which has not installed debuginfo of iputils(ping) will fail like:
>> ~/lkp/linux/tools/perf$ sudo ./perf test ping -v
> I think that we should try to check if the required debuginfo package is
> installed and if so, expect the symbol resolution that takes place in
> that case. Other wise expect [unknown], this way we don't leave this
> test accepting almost anything in any case.

Looks ping binary in different distros include different symbol.
without this patch, ubuntu 16.04 is good and debian 9 is bad when they both have not installed debuginfo for ping.

and then after i installed debuginfo for ping(iputils-ping-dbgsym), test become passed as well on debian 9

Debian 9
bofore installing debuginfo, it includes [unknown]
root@vm-lkp-nex04-8G-10 /usr/src/linux-perf-x86_64-randconfig-w0-06061439-fb43d6cb91ef57d9e58d5f69b423784ff4a4c374/tools/perf# ./perf test ping -v
62: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 6324
ping 6341 [000] 4470.361330: probe_libc:inet_pton: (7f9f3900eaa0)
105aa0 inet_pton (/lib/x86_64-linux-gnu/libc-2.24.so)
d52f8 getaddrinfo (/lib/x86_64-linux-gnu/libc-2.24.so)
3ebe [unknown] (/bin/ping)
test child finished with 0

------------------------------
after install debuginfo
root@vm-lkp-nex04-8G-10 /usr/src/linux-perf-x86_64-randconfig-w0-06061439-fb43d6cb91ef57d9e58d5f69b423784ff4a4c374/tools/perf# ./perf test ping -v
62: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 6387
ping 6404 [000] 4488.855086: probe_libc:inet_pton: (7fb5bcc7caa0)
105aa0 inet_pton (/lib/x86_64-linux-gnu/libc-2.24.so)
d52f8 getaddrinfo (/lib/x86_64-linux-gnu/libc-2.24.so)
3ebe main (/bin/ping)
test child finished with 0



Thanks


>
> - Arnaldo
>
>> 63: probe libc's inet_pton & backtrace it with ping       :
>> --- start ---
>> test child forked, pid 4207
>> ping 4224 [007] 3034121.295510: probe_libc:inet_pton: (7fedfccb2200)
>> 7fedfccb2200 __GI___inet_pton+0x0 (/lib/x86_64-linux-gnu/libc-2.23.so)
>> 7fedfcc7ad5e getaddrinfo+0xee (/lib/x86_64-linux-gnu/libc-2.23.so)
>> 55e3239a9f4d [unknown] (/bin/ping)
>> FAIL: expected backtrace entry 3
>> ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" got "55e3239a9f4d [unknown] (/bin/ping)"
>> test child finished with -1
>> ---- end ----
>> probe libc's inet_pton & backtrace it with ping: FAILED!
>>
>> To be compatible with this system, expects [unknown] as well
>>
>> Fixes: 7903a7086723 ("perf script: Show symbol offsets by default")
>> CC: Sandipan Das <sandipan@linux.vnet.ibm.com>
>> CC: Thomas Richter <tmricht@linux.ibm.com>
>> Reported-by: kernel test robot <xiaolong.ye@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> index 2630570..ebb6549 100755
>> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> @@ -22,12 +22,12 @@ trace_libc_inet_pton_backtrace() {
>>   		eventattr='call-graph=dwarf,max-stack=4'
>>   		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
>>   		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
>> -		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
>> +		expected[4]=".*(\+0x[[:xdigit:]]|\[unknown\])+[[:space:]]\(.*/bin/ping.*\)$"
>>   		;;
>>   	*)
>>   		eventattr='max-stack=3'
>>   		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
>> -		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
>> +		expected[3]=".*(\+0x[[:xdigit:]]|\[unknown\])+[[:space:]]\(.*/bin/ping.*\)$"
>>   		;;
>>   	esac
>>   
>> -- 
>> 2.7.4
>
> .
>

-- 
Best regards.
Li Zhijian (8528)



