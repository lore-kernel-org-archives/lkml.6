Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCJHlu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 02:41:50 -0500
Received: from cmta20.telus.net ([209.171.16.93]:51564 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeCJHls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 02:41:48 -0500
X-Authority-Analysis: v=2.2 cv=Pr98V0E3 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8
 a=vGffbGkmiYaUsvATMv4A:9 a=QEXdDO2ut3YA:10 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rik van Riel'" <riel@surriel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Mike Galbraith'" <mgalbraith@suse.de>
Cc: "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> uJnxe6lrNpApsuJnyelRSD
In-Reply-To: uJnxe6lrNpApsuJnyelRSD
Subject: RE: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Fri, 9 Mar 2018 23:41:39 -0800
Message-ID: <007c01d3b843$3d825e70$b8871b50$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO3ugnLE8NqFahvTPGHjXiTd6r3dQAGVIBQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfLd26KR1jw3mnS8UrntUFqpVuyCz2tgjtCPYPjrLZcY7QptgplgHGdj9kuH7WK6Anni+9nv/e1FBmSI+lcs8G6oMcDgfq+BrE4cUYvhudS9KHyQmQnsC
 ZukM37gwPlYb8twmIdXPHho7eowwVJqs6FcaRKELTk+8b0J0F4+0LtMy0nhzzt7wnKL7eDr/Mrs3Z0aa+WbAZkWa7QkAKR3i0YhE4O0r1LC/jCpy1LONFLbv
 LyZPAjuLKughNzPlnhAPP3SsSX/fHjkX5gD3XssuG1Zd5ZpJxL1On7YYFDGAr9SwzJUO/xaOoaIlnWjWIynDrt7v1MxZzlh16ObgP4hXnHZs3y318myXFQfm
 ok+CVgCQdcKJIffpuR1EXrTGOjS7bYZjxMgYCg9M8pibOPvHZ4H66lut0m0XwCWrUhVN3kk4RIiGznAJPqq8R5CwR72F+Ev90GxhMwv5IPyls4pYuWG+gHc6
 uQCyBTCUPzEwxIH5H2LCPtlfr1BGLX5VilDgcA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2A7fs9g015336

On 2018.03.09 07:19 Rik van Riel wrote:
> On Fri, 2018-03-09 at 10:34 +0100, Rafael J. Wysocki wrote:
>> Hi All,
>> 
>> Thanks a lot for the discussion and testing so far!
>> 
>> This is a total respin of the whole series, so please look at it
>> afresh.
>> Patches 2 and 3 are the most similar to their previous versions, but
>> still they are different enough.
>
> This series gives no RCU errors on startup,
> and no CPUs seem to be getting stuck any more.

Confirmed on my test server. Boot is normal and no other errors, so far.

Part 1: Idle test:

I was able to repeat Mike's higher power issue under very light load,
well no load in my case, with V2.

V3 is much better.

A one hour trace on my very idle server was 22 times smaller with V3
than V2, and mainly due to idle state 4 not exiting and re-entering
every tick time for great periods of time.

Disclaimer: From past experience, 1 hour is not nearly long enough
for this test. Issues tend to come in bunches, sometimes many hours
apart.

V2:
Idle State 4: Entries: 1359560
CPU: 0: Entries: 125305
CPU: 1: Entries: 62489
CPU: 2: Entries: 10203
CPU: 3: Entries: 108107
CPU: 4: Entries: 19915
CPU: 5: Entries: 430253
CPU: 6: Entries: 564650
CPU: 7: Entries: 38638

V3:
Idle State 4: Entries: 64505
CPU: 0: Entries: 13060
CPU: 1: Entries: 5266
CPU: 2: Entries: 15744
CPU: 3: Entries: 5574
CPU: 4: Entries: 8425
CPU: 5: Entries: 6270
CPU: 6: Entries: 5592
CPU: 7: Entries: 4574

Kernel 4.16-rc4:
Idle State 4: Entries: 61390
CPU: 0: Entries: 9529
CPU: 1: Entries: 10556
CPU: 2: Entries: 5478
CPU: 3: Entries: 5991
CPU: 4: Entries: 3686
CPU: 5: Entries: 7610
CPU: 6: Entries: 11074
CPU: 7: Entries: 7466

With apologies to those that do not like the term "PowerNightmares",
it has become very ingrained in my tools:

V2:
1 hour idle Summary:

Idle State 0: Total Entries: 113 : PowerNightmares: 56 : Not PN time (seconds): 0.001224 : PN time: 65.543239 : Ratio: 53548.397792
Idle State 1: Total Entries: 1015 : PowerNightmares: 42 : Not PN time (seconds): 0.053986 : PN time: 21.054470 : Ratio: 389.998703
Idle State 2: Total Entries: 1382 : PowerNightmares: 17 : Not PN time (seconds): 0.728686 : PN time: 6.046906 : Ratio: 8.298370
Idle State 3: Total Entries: 113 : PowerNightmares: 13 : Not PN time (seconds): 0.069055 : PN time: 6.021458 : Ratio: 87.198002

V3:
1 hour idle Summary: Average processor package power 3.78 watts

Idle State 0: Total Entries: 134 : PowerNightmares: 109 : Not PN time (seconds): 0.000477 : PN time: 144.719723 : Ratio: 303395.646541
Idle State 1: Total Entries: 1104 : PowerNightmares: 84 : Not PN time (seconds): 0.052639 : PN time: 74.639142 : Ratio: 1417.943768
Idle State 2: Total Entries: 968 : PowerNightmares: 141 : Not PN time (seconds): 0.325953 : PN time: 128.235137 : Ratio: 393.416035
Idle State 3: Total Entries: 295 : PowerNightmares: 103 : Not PN time (seconds): 0.164884 : PN time: 97.159421 : Ratio: 589.259243

Kernel 4.16-rc4: Average processor package power (excluding a few minutes of abnormal power) 3.70 watts.
1 hour idle Summary:

Idle State 0: Total Entries: 168 : PowerNightmares: 59 : Not PN time (seconds): 0.001323 : PN time: 81.802197 : Ratio: 61830.836545
Idle State 1: Total Entries: 1669 : PowerNightmares: 78 : Not PN time (seconds): 0.022003 : PN time: 37.477413 : Ratio: 1703.286509
Idle State 2: Total Entries: 1447 : PowerNightmares: 30 : Not PN time (seconds): 0.502672 : PN time: 0.789344 : Ratio: 1.570296
Idle State 3: Total Entries: 176 : PowerNightmares: 0 : Not PN time (seconds): 0.259425 : PN time: 0.000000 : Ratio: 0.000000

Part 2: 100% load on one CPU test. Test duration 4 hours

V3: Summary: Average processor package power 26.75 watts

Idle State 0: Total Entries: 10039 : PowerNightmares: 7186 : Not PN time (seconds): 0.067477 : PN time: 6215.220295 : Ratio: 92108.722903
Idle State 1: Total Entries: 17268 : PowerNightmares: 195 : Not PN time (seconds): 0.213049 : PN time: 55.905323 : Ratio: 262.405939
Idle State 2: Total Entries: 5858 : PowerNightmares: 676 : Not PN time (seconds): 2.578006 : PN time: 167.282069 : Ratio: 64.888161
Idle State 3: Total Entries: 1500 : PowerNightmares: 488 : Not PN time (seconds): 0.772463 : PN time: 125.514015 : Ratio: 162.485472

Kernel 4.16-rc4: Summary: Average processor package power 27.41 watts

Idle State 0: Total Entries: 9096 : PowerNightmares: 6540 : Not PN time (seconds): 0.051532 : PN time: 7886.309553 : Ratio: 153037.133492
Idle State 1: Total Entries: 28731 : PowerNightmares: 215 : Not PN time (seconds): 0.211999 : PN time: 77.395467 : Ratio: 365.074679
Idle State 2: Total Entries: 4474 : PowerNightmares: 97 : Not PN time (seconds): 1.959059 : PN time: 0.874112 : Ratio: 0.446190
Idle State 3: Total Entries: 2319 : PowerNightmares: 0 : Not PN time (seconds): 1.663376 : PN time: 0.000000 : Ratio: 0.000000

Graph of package power verses time: http://fast.smythies.com/rjwv3_100.png

... Doug
