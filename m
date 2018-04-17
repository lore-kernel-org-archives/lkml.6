Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDQPqk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:46:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34291 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeDQPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:46:38 -0400
X-Google-Smtp-Source: AIpwx4/J5pQMh/LWdccaJUe9bAHrvJ5J4CqafVPJlWBkPNFyqilF+6moOnzYa/RAazF9Fi+3RwuY8sjVoPUjRedOMQw=
MIME-Version: 1.0
In-Reply-To: <fd4b5238-c995-c374-60c0-e4a32f644ae4@infradead.org>
References: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
 <1523907327-20979-3-git-send-email-mathieu.poirier@linaro.org> <fd4b5238-c995-c374-60c0-e4a32f644ae4@infradead.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 17 Apr 2018 09:46:36 -0600
Message-ID: <CANLsYkzc60no4SnjtRvx+0tt-PNCTdqXU=Jnb+GQKbmUMtiiKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] coresight: Add section for integration with the perf tools
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jon Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ben Gainey <Ben.Gainey@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 April 2018 at 13:48, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/16/2018 12:35 PM, Mathieu Poirier wrote:
>> Adding a section that document how to use the Coresight framework and
>> drivers from the perf tools.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  Documentation/trace/coresight.txt | 50 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
>> index 710c75b6c73f..8caae8050a60 100644
>> --- a/Documentation/trace/coresight.txt
>> +++ b/Documentation/trace/coresight.txt
>> @@ -187,9 +187,18 @@ that can be performed on them (see "struct coresight_ops").  The
>>  specific to that component only.  "Implementation defined" customisations are
>>  expected to be accessed and controlled using those entries.
>>
>> +
>>  How to use the tracer modules
>>  -----------------------------
>>
>> +There is two ways to use the Coresight framework: 1) using the perf cmd line
>
>    There are two ways
>
>> +tools and 2) interacting directly with the Coresight devices using the sysFS
>> +interface.  Preference is given to the former as using the sysFS interface
>> +requires a deep understanding of the Coresight HW.  The following sections
>> +provide details on using both methods.
>> +
>> +1) Using the sysFS interface:
>> +
>>  Before trace collection can start, a coresight sink needs to be identify.
>
>                                                                    identified.
>
>>  There is no limit on the amount of sinks (nor sources) that can be enabled at
>>  any given moment.  As a generic operation, all device pertaining to the sink
>> @@ -295,6 +304,47 @@ Instruction     13570831        0x8026B584      E28DD00C        false   ADD
>>  Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
>>  Timestamp                                       Timestamp: 17107041535
>>
>> +2) Using perf framework:
>> +
>> +Coresight tracers are represented using the Perf framework's Performance
>> +Monitoring Unit (PMU) abstraction.  As such the perf framework takes charge of
>> +controlling when tracing gets enabled based on when the process of interest is
>> +scheduled.  When configured in a system, Coresight PMUs will be listed when
>> +queried by the perf command line tool:
>> +
>> +     linaro@linaro-nano:~$ ./perf list pmu
>> +
>> +             List of pre-defined events (to be used in -e):
>> +
>> +             cs_etm//                                    [Kernel PMU event]
>> +
>> +     linaro@linaro-nano:~$
>> +
>> +Regardless of the number of tracers available in a system (usually equal to the
>> +amount of processor core), the "cs_etm" PMU will be listed only once.
>
> ?                      cores),
>
>> +
>> +A Coresight PMU works the same way as any other PMUs, i.e the name of the PMU is
>
>                                          any other PMU, i.e.
>
>> +listed along with configuration options within forward slashes '/'.  Since a
>> +Coresight system will typically have more than one sink, the name of the sink to
>> +work with needs to be specified as an event option.  Names for sink to choose
>> +from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
>> +
>> +     root@linaro-nano:~# ls /sys/bus/coresight/devices/
>> +             20010000.etf   20040000.funnel  20100000.stm  22040000.etm
>> +             22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
>> +             20070000.etr     20120000.replicator  220c0000.funnel
>> +             23040000.etm  23140000.etm     23340000.etm
>> +
>> +     root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
>> +
>> +The syntax within the forward slashes '/' is important.  The '@' character
>> +tells the parser that a sink is about to be specified and that this is the IP
>
> Can we get away from using "IP" and call it a device or (hardware) module or
> something more descriptive?

Sure thing.

Thanks for taking the time to read the patch and providing comments.

Mathieu

>
>> +to use for the trace session.
>> +
>> +More information on the above and other example on how to use Coresight with
>> +the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
>> +repository [3].
>
>
> --
> ~Randy
