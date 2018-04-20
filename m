Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754888AbeDTN0H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:26:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754762AbeDTN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:26:05 -0400
Subject: Re: s390 perf events JSONs query
To: John Garry <john.garry@huawei.com>, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
References: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 20 Apr 2018 15:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042013-0008-0000-0000-000004ED7B05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042013-0009-0000-0000-00001E819318
Message-Id: <c5dde055-de48-52c1-04d7-7ec22623d75f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 12:51 PM, John Garry wrote:
> Hi Hendrik, Thomas,
> 
> I noticed that in 4.17-rc1 support was included for s390 perf pmu-events. I also notice that the JSONs contain many common (identical actually) events between different chips for this arch.
> 
> Support was added for factoring out common arch events in https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/perf/pmu-events?h=next-20180420&id=e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
> 
> ARM64 chips use this feature. I am not familiar with the s390 arch, but do you think you could also use this feature?
> 
> Thanks,
> John
> 

I have just played with this feature. I was caught off by this error message:

[root@s35lp76 pmu-events]# ./jevents s390 arch /tmp/xxx 100000
d 0    4096 s390                 arch/s390
d 1    4096 cf_z14               arch/s390/cf_z14
f 2    1338 basic.json           arch/s390/cf_z14/basic.json
....
jevents: Ignoring file arch/s390/archevent.json  <---- confusing error message

jevents: Processing mapfile arch/s390/mapfile.csv
[root@s35lp76 pmu-events]# 

I started debugging, until I realized this file is still processed.....
(Just a side remark).

Anyway the features is nice, but it does not save anything in the resulting
pmu-events.c file, correct? The events defined in the common archevent.json
files are just copied into the structures of a specific machine.

The feature saves time and space when you create the machine specific json
files because it allows you to refer to a common event by name. Cool!

On s390 we do not create the json files manually, but have some scripts to
create them based on s390 type/model hardware specific input files.

@Hendirk,
we could rework our internal tool chain to emit the new "ArchStdEvent"
keyword for common events, but in the end we do not save anything in the
resulting pmu-events.c file. And it requires considerable rework to 
support it.
Given that, I would put it very low priority on your todo list, comments?

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
