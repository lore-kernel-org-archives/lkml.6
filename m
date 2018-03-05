Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeCEOlu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:41:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:42835 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbeCEOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:41:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="22161652"
Message-ID: <1520260903.2637.34.camel@gmail.com>
Subject: Re: regression: SCSI/SATA failure
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date: Mon, 05 Mar 2018 16:41:43 +0200
In-Reply-To: <1519311270.2535.53.camel@intel.com>
References: <1519311270.2535.53.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-Regression-ID: lr#15a115

On Thu, 2018-02-22 at 16:54 +0200, Artem Bityutskiy wrote:
> Hi Christoph,
> 
> one of our test box Skylake servers does not boot with v4.16-rcX.
> Bisection lead us to this commit:
> 
> 84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs
> 
> Reverting this single commit fixes the problem.
> 
> The server is a Dell R640 machine with the latest Dell BIOS. It has a
> single SATA SSD and we do not use raid, even though the system does
> have a megaraid controller.

Correction: we have Raid0 with this single disk.

> Are you aware of this issue? Below is the failure message and the
> full
> dmesg with some debugging boot parameters is here:
> 
> https://pastebin.com/raw/tTYrTAEQ

FYI, the regression still exists and reverting this single patch fixes
it. But today Dell server

I did not have time to really debug this, but I think people who are
working with this should quickly see what is going on.

I think the platform reports way too large possible CPU count. Indeed,
in dmesg I see this:

[    0.000000] smpboot: Allowing 328 CPUs, 224 hotplug CPUs

224 is way too large for this system. It only has 2 sockets, it but the
number looks like if the system had 4 sockets.

The commit changes IRQ affinity logic from being per-present CPU to
being per-possible CPU:

-       for_each_present_cpu(cpu)
+       for_each_possible_cpu(cpu)

And it looks like this has an unexpected side-effect on this Dell
platform.

Artem.
