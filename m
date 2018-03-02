Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428088AbeCBNYC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:24:02 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58974 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428057AbeCBNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:23:48 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        ganeshgr@chelsio.com, nirranjan@chelsio.com, indranil@chelsio.com
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
Date: Fri, 02 Mar 2018 07:22:45 -0600
In-Reply-To: <cover.1519911559.git.rahul.lakkireddy@chelsio.com> (Rahul
        Lakkireddy's message of "Fri, 2 Mar 2018 17:49:56 +0530")
Message-ID: <87lgfad32y.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1erkef-0000OO-8Z;;;mid=<87lgfad32y.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18skhvtD4f98ipG+Eq1FsLbRIakRvXQW0Q=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.0 XM_Doc_Oz_Body BODY: Dr. Oz body dropper
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0001]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.3 (0.0%), b_tie_ro: 2.6 (0.0%), parse: 0.72 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 1.59 (0.0%),
        tests_pri_-1000: 2.7 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        2.2 (0.0%), b_finish: 0.54 (0.0%), tests_pri_0: 194 (1.3%),
        check_dkim_signature: 0.47 (0.0%), check_dkim_adsp: 3.3 (0.0%),
        tests_pri_500: 14785 (98.4%), poll_dns_idle: 14778 (98.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC 0/2] kernel: add support to collect hardware logs in panic
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On production servers running variety of workloads over time, kernel
> panic can happen sporadically after days or even months. It is
> important to collect as much debug logs as possible to root cause
> and fix the problem, that may not be easy to reproduce. Snapshot of
> underlying hardware/firmware state (like register dump, firmware
> logs, adapter memory, etc.), at the time of kernel panic will be very
> helpful while debugging the culprit device driver.
>
> This series of patches add new generic framework that enable device
> drivers to collect device specific snapshot of the hardware/firmware
> state of the underlying device at the time of kernel panic. The
> collected logs are appended to vmcore along with details, such as
> start address and length of the logs, which are required for
> extraction during post-analysis.
>
> Device drivers can use crash_driver_dump_register() to register their
> callback that collects underlying device specific hardware/firmware
> logs during kernel panic (i.e. before booting into the second kernel).
> Drivers can unregister with crash_driver_dump_unregister().
>
> To extract the device specific hardware/firmware logs using crash:
>
> crash> help -D | grep DRIVERDUMP
> DRIVERDUMP=(cxgb4_0000:02:00.4, ffffb131090bd000, 37782968)
>
> crash> rd ffffb131090bd000 37782968 -r hardware.log
> 37782968 bytes copied from 0xffffb131090bd000 to hardware.log
>
> Patch 1 adds API to allow drivers to register callback to
> collect the device specific hardware/firmware logs.
>
> Patch 2 shows a cxgb4 driver example using the API to collect
> hardware/firmware logs during kernel panic.
>
> Suggestions and feedback will be much appreciated.

I strongly suggest you figure out how to run this code in the
crash recovery kernel before your hardware is initialized.
That will give you a known good kernel to perform your collection from.

Every line of code we add to the kexec on panic code path tends to add
to it's fragility and increase the chance you won't get any information
at all.

When the assumption is it is something wrong with your driver/hardware
that caused the crash, calling into your driver is a very bad idea.
Especially running code that does callbacks and all kinds of other cute
things.

Doing this as the crash recover kernel boots up before much if any
hardware is initialized seems like a fine thing to do, and just
needs a little coordination with userspace to ensure the information
gets saved when a vmcore is computed.

Eric
