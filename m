Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeDTONo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:13:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755000AbeDTONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:13:43 -0400
Date: Fri, 20 Apr 2018 16:13:35 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: John Garry <john.garry@huawei.com>
Cc: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: s390 perf events JSONs query
References: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
 <c5dde055-de48-52c1-04d7-7ec22623d75f@linux.ibm.com>
 <c5c99152-4823-2f21-1b98-2a271637bed4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c99152-4823-2f21-1b98-2a271637bed4@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042014-0020-0000-0000-000004141E78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042014-0021-0000-0000-000042A8721A
Message-Id: <20180420141335.GA32698@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Apr 20, 2018 at 02:53:27PM +0100, John Garry wrote:
> On 20/04/2018 14:25, Thomas-Mich Richter wrote:
> >On 04/20/2018 12:51 PM, John Garry wrote:
> >>I noticed that in 4.17-rc1 support was included for s390 perf pmu-events. I also notice that the JSONs contain many common (identical actually) events between different chips for this arch.
> >>
> >>Support was added for factoring out common arch events in https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/perf/pmu-events?h=next-20180420&id=e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
> >>
> >>ARM64 chips use this feature. I am not familiar with the s390 arch, but do you think you could also use this feature?
> >>
> >>Thanks,
> >>John
> >>
> >
> >I have just played with this feature. I was caught off by this error message:
> >
> >[root@s35lp76 pmu-events]# ./jevents s390 arch /tmp/xxx 100000
> >d 0    4096 s390                 arch/s390
> >d 1    4096 cf_z14               arch/s390/cf_z14
> >f 2    1338 basic.json           arch/s390/cf_z14/basic.json
> >....
> >jevents: Ignoring file arch/s390/archevent.json  <---- confusing error message
> 
> Let me check if this can be silenced.
> 
> >
> >jevents: Processing mapfile arch/s390/mapfile.csv
> >[root@s35lp76 pmu-events]#
> >
> >I started debugging, until I realized this file is still processed.....
> >(Just a side remark).
> >
> >Anyway the features is nice, but it does not save anything in the resulting
> >pmu-events.c file, correct? The events defined in the common archevent.json
> >files are just copied into the structures of a specific machine.
> >
> 
> Yes, the resulting derived pmu-events.c should be the same. In fact,
> if there was naming inconsistencies in JSONs previously, they should
> now be gone.
> 
> >The feature saves time and space when you create the machine specific json
> >files because it allows you to refer to a common event by name. Cool!
> >
> >On s390 we do not create the json files manually, but have some scripts to
> >create them based on s390 type/model hardware specific input files.
> 
> Right, I would say that this is mostly useful when the JSONs are
> created manually, which was the case in the ARM world, but not x86.

It is really the right way and the coolest feature to go when the JSONs need
to be created manually.

For s390, I started manually with adding descriptions for the libpfm4 library.
Then, the events sysfs came up and that was the point in time when I created
a common database for the counters in the s390-tools package.  Meanwhile,
s390-tools, libpfm4, kernel, and Thomas recently added perf JSONs as possible
outputs formats.

> >@Hendrik,
> >we could rework our internal tool chain to emit the new "ArchStdEvent"
> >keyword for common events, but in the end we do not save anything in the
> >resulting pmu-events.c file. And it requires considerable rework to
> >support it.
> >Given that, I would put it very low priority on your todo list, comments?

I would consider this a low-priority given the fact that have to overwrite
to the counter number (for the model-dependent counters) as well.

Many thanks!
 
Kind regards,
  Hendrik
