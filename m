Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755107AbeCVNT3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:19:29 -0400
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:58815 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752282AbeCVNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:19:28 -0400
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from
 cpuidle_select()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        "Aubrey Li" <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
 <1635957.yuHkCe9oyz@aspire.rjw.lan>
 <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com>
 <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de>
 <CAJZ5v0iThFDEjnwTbpAhwHY_vF_KDdAUyhDL1CdB4GJsG5eNRQ@mail.gmail.com>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Message-ID: <642c6901-ad0d-b6b3-9ee9-3e0bd10aa610@tu-dresden.de>
Date: Thu, 22 Mar 2018 14:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iThFDEjnwTbpAhwHY_vF_KDdAUyhDL1CdB4GJsG5eNRQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MSX-L106.msx.ad.zih.tu-dresden.de (172.26.34.106) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 23:15, Rafael J. Wysocki wrote:
> On Wed, Mar 21, 2018 at 6:59 PM, Thomas Ilsche
> <thomas.ilsche@tu-dresden.de> wrote:
>> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
>>>
>>>
>>> So please disregard this one entirely and take the v7.2 replacement
>>> instead of it:https://patchwork.kernel.org/patch/10299429/
>>>
>>> The current versions (including the above) is in the git branch at
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>>    idle-loop-v7.2
>>
>>
>> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
>> as with v5: several cores which just keep the sched tick enabled.
>> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
>> full sched tick.
>> The resulting power consumption is ~105 W instead of ~ 70 W.
>>
>> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
>>
>> I have briefly ran v7 and I believe it was also affected.
> 
> Then it looks like menu_select() stubbornly thinks that the idle
> duration will be within the tick boundary on those cores.
> 
> That may be because the bumping up of the correction factor in
> menu_reflect() is too conservative or it may be necessary to do
> something radical to measured_us in menu_update() in case of a tick
> wakeup combined with a large next_timer_us value.
> 
> For starters, please see if the attached patch (on top of the
> idle-loop-v7.2 git branch) changes this behavior in any way.
> 

The patch on top of idle-loop-v7.2 doesn't improve idle behavior on
SKL-SP. Overall it is pretty erratic, I have not seen any regular
patterns. Sometimes only few cpus are affected, here's a screenshot of
almost all cpus being affected after a short burst workload.

https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_reflect_skl_sp_idle.png
