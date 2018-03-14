Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeCNJXs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:23:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752406AbeCNJXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:23:47 -0400
Subject: Re: perf-core build fails on powerpc
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
References: <20180313191742.GA29120@us.ibm.com>
 <152d2ba4-fe57-beab-87d5-554a0fede9ae@huawei.com>
 <20180313201003.GB29120@us.ibm.com>
 <543acf58-520d-e3e2-211e-17068d713a4f@huawei.com>
 <20180313211837.GC29120@us.ibm.com>
 <603efe46-6b79-3066-751e-696502eaef3f@huawei.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        "Jiri Olsa" <jolsa@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6ade080f-e12f-5db3-940e-c7df309311c1@huawei.com>
Date: Wed, 14 Mar 2018 09:23:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <603efe46-6b79-3066-751e-696502eaef3f@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.87]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2018 07:10, John Garry wrote:
> On 13/03/2018 21:18, Sukadev Bhattiprolu wrote:
>> John Garry [john.garry@huawei.com] wrote:
>>> On 13/03/2018 20:10, Sukadev Bhattiprolu wrote:
>>>
>>>> Hi John,
>>>>
>>>> I have an xfs file system which seems to have d_type == DT_UNKNOWN
>>>> for all
>>>> entries in 'tools/perf/pmu-events/arch/power8'! readdir(3) says
>>>> ->d_type
>>>> may not be supported by all file systems.
>>>>
>>>> Not relying on ->d_type seems to fix it:
>>>>
>>>
>>> Hi Sukadev,
>>>
>>> Thanks for debugging this. Jiri Olsa (cc'ed) warned me on this, so I
>>> did add
>>> the check for d_type == DT_UNKNOWN.
>>>
>>> But, if all files have d_type == DT_UNKNOWN, you're code would from
>>> visual
>>> observation look to be same as mine (apart from check for '.' or '..'
>>> filename, which I would say is already covered by stat() and
>>> S_ISDIR()). Or
>>> is d_type value just unreliable?
>>
>> In the current code and with DT_UNKNOWN, is_leaf_dir() returns false when
>> it sees the "." or ".." entries right? In the new code, we skip those and
>> return false only if we find some other directory.
>>
>
> OK, that's the real issue, being the "." and ".." entries.
>
> @Arnaldo, I'll try to send a fix for this today. I just need to make an
> xfs to test. Sorry for the hassle.
>

Hi Sukadev,

Even with the xfs I have created I still don't see DT_UNKNOWN. So can 
you kindly test this change for me:

diff --git a/tools/perf/pmu-events/jevents.c 
b/tools/perf/pmu-events/jevents.c
index 1c018445e757..9f712dafa0b2 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -873,7 +873,10 @@ static int is_leaf_dir(const char *fpath)
                 return 0;

         while ((dir = readdir(d)) != NULL) {
-               if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
+               if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
+                    continue;
+
+               if (dir->d_type == DT_DIR) {
                         res = 0;
                         break;
                 } else if (dir->d_type == DT_UNKNOWN) {


It's quite similar to your change, except keeping the check for DT_DIR.

Much appreciated,
John

> John
>
>> Thanks,
>>
>> Sukadev
>>
>>
>>
>
