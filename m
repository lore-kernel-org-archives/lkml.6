Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeCWDTe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:19:34 -0400
Received: from cmta19.telus.net ([209.171.16.92]:53547 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbeCWDTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:19:32 -0400
X-Authority-Analysis: v=2.2 cv=TI+qcxta c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=iQQjKHJntgW4jRJZ_nkA:9
 a=QEXdDO2ut3YA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rik van Riel'" <riel@surriel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan>  <20180314120450.GT4043@hirez.programming.kicks-ass.net> z38ge3YFh1Konz38iel45g z5HFe4V4W1Konz5chemDYc
In-Reply-To: z5HFe4V4W1Konz5chemDYc
Subject: RE: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Date: Thu, 22 Mar 2018 20:19:24 -0700
Message-ID: <004c01d3c255$c1f146a0$45d3d3e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPB+2Knq1MUfUhjTr6ehdQ6RKf0qwAFSacQABDbwHA=
X-CMAE-Envelope: MS4wfDJzHJyax60fwZKoDIqT/r49hCoqOgxAY7DEEWozSSdfEM7Ss/HsuEChEumhXPOuZzt1HSnyoADU+DxO9TnZN0YkSX01cmu2SXc1n/eu7P26/Q0nUudS
 oBM2fVRlAqAyUdpTBz0uSO57uEP5xKbM4kWMhcA9d5sct1n1NP7c/5S1giFmqYcfSiAT/FwPWSOqJ1xjpvjS+Seok+zVzy8DJ+SATvbOsHNuzTi/CTdJfgBR
 +5nE7+SgXRD4DzShMYheixHPIQW1DjmooJjF06MdhyBFCiFr1l66Sfy/GE8MAmxRa5umtcKlNU3m/z1LKOVGULW8niuGvbCFNXgiFsUX6HDcKudQzolkWgJV
 aa73yFKaILQ/1egCxAlol+OjdX2ecobCULaP+PxrEdwHhvUETJVXS2zjxEzCh3opp7NzoJvF9qNkAy+YJDgdRRimISDXAj6wN9mBQqxIXlxEbiU3OuDEvhej
 K24AoGzbZ4gwkWCrwx4+UrYkn5G6G65FUSXM4LaLKkXABgOd/kX4qbLXYlU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.22 12:12 Doug Smythies wrote: 
>On 2018.03.22 09:32 Rik van Riel wrote:
>> On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
>>
>>> On x86 we don't have to use that time_check_counter thing,
>>> sched_clock()
>>> is really cheap, not sure if it makes sense on other platforms.
>>
>> Are you sure? I saw a 5-10% increase in CPU use,
>> for a constant query rate to a memcache style
>> workload, with v3 of this patch.
>
> I would very much like to be able to repeat your test results.
> However, I am not sure what you mean by "memcache style workload".
> Is there a test you can point me to? Say a Phoronix type test, for example.
>
> All of my tests with the V3 of this patch have been fine.

What is the difference between sched_clock() talked about herein,
and local_clock() used in the patch?

I'm not sure how good it is but I made a test. I didn't believe
the results, so I did it 3 times.

V7.3 is as from the git branch.
V7.3p is plus the patch adding the counter loop to poll_state.c

The test is a tight loop (about 19600 loops per second) running
on all 8 CPUs. I can not seem to get my system to use Idle State
0, so I disabled Idle States 1 and 2 to force use of Idle State 0.

V7.3 uses a processor package power of 62.5 Watts
V7.3p uses a processor package power of 53.4 Watts, or 14.6% less power.

The loop times do not change.
The Idle state 0 residency per unit time does not change.

... Doug
