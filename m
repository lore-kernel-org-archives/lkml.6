Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935662AbeCABhG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:37:06 -0500
Received: from ozlabs.org ([103.22.144.67]:54077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbeCABhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:37:05 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : Restore different PSSCR for idle and hotplug
In-Reply-To: <20180228191903.23jmawvfqzbcwi2r@aksadiga.ibm>
References: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com> <87vaekmk6n.fsf@linux.vnet.ibm.com> <20180228191903.23jmawvfqzbcwi2r@aksadiga.ibm>
Date: Thu, 01 Mar 2018 12:37:02 +1100
Message-ID: <87371ka85d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> On Mon, Feb 26, 2018 at 03:47:12PM +1100, Stewart Smith wrote:
>> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
>> > commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
>> > states via stop API.") uses stop-api provided by the firmware to restore
>> > PSSCR. PSSCR restore is required for handling special wakeup. When special
>> > wakeup is completed, the core enters stop state based on restored PSSCR.
>> >
>> > Currently PSSCR is restored to deepest available stop state, causing
>> > a idle cpu to enter deeper stop state on a special wakeup, which causes
>> > the cpu to hang on wakeup.
>> >
>> > A "sensors" command which reads temperature (through DTS sensors) on idle
>> > cpu can trigger special wakeup.
>> >
>> > Failed Scenario :
>> > Request restore of PSSCR with RL = 11
>> > cpu enters idle state (stop5)
>> >   user triggers "sensors" command
>> >    Assert special wakeup on cpu
>> >      Restores PSSCR with RL = 11  <---- Done by firmware
>> >       Read DTS sensor
>> >    Deassert special wakeup
>> >   cpu enters idle state (stop11) <-- Instead of stop5
>> >
>> > Cpu hang is caused because cpu ended up in a deeper state than it requested
>> >
>> > This patch fixes instability caused by special wakeup when stop11 is
>> > enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
>> > Only when offlining cpu, request restore of PSSCR to deepest stop state.
>> > On onlining cpu, request restore of PSSCR to deepest stop state used by
>> > cpuidle.
>> >
>> > Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
>> > states via stop API.")
>> 
>> This should CC stable ?
>> 
>> We'll need this to enable stop11 in firmware and not break things, right?
>
> Yes I will resend and CC it to stable.

That's not how patches get to stable.

You tag it with "Cc: stable@vger ...", you don't actually email it to
stable@vger.kernel.org.

cheers
