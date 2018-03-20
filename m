Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCTRPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:15:12 -0400
Received: from cmta17.telus.net ([209.171.16.90]:33460 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeCTRPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:15:09 -0400
X-Authority-Analysis: v=2.2 cv=StJ/0LG0 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
 a=gu6fZOg2AAAA:8 a=FGbulvE0AAAA:8 a=fGE89Ioile8RqVmjMi4A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <2148754.TY7qXgFyZy@aspire.rjw.lan> xuDHe5JrTQdbpxuDMeg0da xyzzeKNZFlebYxzQ2eVyR7
In-Reply-To: xyzzeKNZFlebYxzQ2eVyR7
Subject: RE: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Tue, 20 Mar 2018 10:15:02 -0700
Message-ID: <002401d3c06e$fed035b0$fc70a110$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO/gJrvyo9eKq4lRGmNVPItTw3wKgAFzGIQADG0igA=
X-CMAE-Envelope: MS4wfM6C7lXCIdZGFJFLmC+XiTv4aWHwN9nAua6fiyRpRrSWJwgGTlulxN6RIAIQ3Bbp2jP45bJKeYHIz5Bhnog+5oEJBgoVeVfRnVTbMMmXZN/ayLiE5pbA
 4u/Hh8GIJ04cisPMfe4TN/3LdvQtNSGrgqHwcmnkUoi28ryc2SB/T42bBy1wNADZBc+gdg8Q1vxg3FvcoHBWLp8hhRB4yXHLQe7D2PQxW8Qr52czeSc1HUY5
 WxBtJGsJOfHJ7qaQYiSEvxVB0i6F+WVi+ts1dMqSO+fsOv7tZniOOe207reDPd6xVWj2tx2QLJPiHKuoYWZtV+aagpZqarKantA4jXg/lY4kpgL8LiUMRJmO
 JrFklXMQZ2ZmvJ1skaMwqDspxGFzKRwl3LGOJYMxoHo6p8i6YpW9ATmuMDiBJD/UiNsLm2XybSK7ZgygP/UR/vNIcY5usJbPEwuRSaHyxLnP56rZ6FZBu27N
 e7cpst2Yq0URdUWWviWUYu46QIFE8eWpfr0EZmypZ8U12aCqB9AQkCMlz6Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.20 11:22 Doug Smythies wrote:
> On 2018.03.19 05:47 Thomas Ilsche wrote:
>> On 2018-03-15 23:19, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> 
>>> If the scheduler tick has been stopped already and the governor
>>> selects a shallow idle state, the CPU can spend a long time in that
>>> state if the selection is based on an inaccurate prediction of idle
>>> time.  That effect turns out to be noticeable, so it needs to be
>>> mitigated.
>>
>> What are some common causes for that situation?
>> How could I trigger this for testing?
>
> It appeared quite readily with my simple 100% load
> on one CPU test. Back then (V3) there only 6 patches in the set,
> and before the re-spin there ended up being a patch 7 of 6, which
> made a significant difference in both package power and the
> histograms of times in each idle state.
>
> Reference:
> https://marc.info/?l=linux-pm&m=152075419526696&w=2

I made a kernel (4.16-rc5) with only patches 1 to 6 of 7 (V6)
and also with the poll fix.

I took an old graph:
http://fast.smythies.com/rjwv3pp_100.png

and removed an obsolete line and added a line from this
kernel:

http://fast.smythies.com/rjwv6m_100.png

I also acquired a trace during the test and observe:

Report: Summary:

Idle State 0: Total Entries: 699 : PowerNightmares: 0 : Not PN time (seconds): 0.031169 : PN time: 0.000000 : Ratio: 0.000000
Idle State 1: Total Entries: 3855 : PowerNightmares: 106 : Not PN time (seconds): 0.123759 : PN time: 43.511914 : Ratio: 351.585856
Idle State 2: Total Entries: 3688 : PowerNightmares: 181 : Not PN time (seconds): 1.303237 : PN time: 63.241424 : Ratio: 48.526418
Idle State 3: Total Entries: 528 : PowerNightmares: 115 : Not PN time (seconds): 0.276290 : PN time: 44.764111 : Ratio: 162.018571

Where "PowerNightmare" is defined as spending excessive time in an idle state,
and arbitrarily defined for my processor as:

#define THRESHOLD_0 100       /* Idle state 0 PowerNightmare threshold in microseconds */
#define THRESHOLD_1 1000      /* Idle state 1 PowerNightmare threshold in microseconds */
#define THRESHOLD_2 2000      /* Idle state 2 PowerNightmare threshold in microseconds */
#define THRESHOLD_3 4000      /* Idle state 3 PowerNightmare threshold in microseconds */

While this trace file was only about 15 megabytes, I have several 10s of gigabytes of trace data for
V4 + poll fix and never see any excessive time spent in any idle state.

... Doug
 
