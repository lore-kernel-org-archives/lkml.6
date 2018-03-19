Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755358AbeCSMgK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:36:10 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:58973 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbeCSMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:36:06 -0400
From: Martin Steigerwald <martin@lichtvoll.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime and could not connect to lvmetad at some boot attempts
Date: Mon, 19 Mar 2018 13:35:59 +0100
Message-ID: <1592165.6qU88H7nrm@merkaba>
In-Reply-To: <f6f20cd6-0d52-4501-f8ea-c4da9ec128cf@redhat.com>
References: <27165802.vQ9JbjrmvU@merkaba> <a3af4fed-a728-5be2-2224-6a0573406c5b@leemhuis.info> <f6f20cd6-0d52-4501-f8ea-c4da9ec128cf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten.

Hans de Goede - 19.03.18, 10:50:
> On 19-03-18 10:42, Thorsten Leemhuis wrote:
> > Hi! On 11.03.2018 09:20, Martin Steigerwald wrote:
> >> Since 4.16-rc4 (upgraded from 4.15.2 which worked) I have an issue
> > 
> >> with SMART checks occassionally failing like this:
> > Martin (or someone else): Could you gibe a status update? I have this
> > issue on my list or regressions, but it's hard to follow as two
> > different issues seem to be discussed. Or is it just one issue? Did the

There are at least two issues.

> > patch/discussion that Bart pointed to help? Is the issue still showing
> > up in rc6?
> 
> Your right there are 2 issues here:
> 
> 1) The Crucial M500 SSD (at least the 480GB MU03 firmware version) does
> not like enabling SATA link power-management at a level of min_power
> or at the new(ish) med_power_with_dipm level. This problem exists in
> older kernels too, so this is not really a regression.
> 
> New in 4.16 is a Kconfig option to enable SATA LPM by default, which
> makes this existing problem much more noticeable. Not sure if you want
> to count this as a regression. Either way I'm preparing and sending
> out a patch fixing this (by blacklisting LPM for this model SSD) right
> now.

Yes, and this is fixed by the nolpm quirk patch of Hans.

> 2) There seem to be some latency issues in the MU03 version of the
> firmware, triggered by polling SMART data, which causes lvmetad to
> timeout in some cases. Note I'm not involved in that part of this
> thread, but I believe that issue is currently unresolved.

Additionally I get a failure on boot / resume from hibernation in 
blk_mq_terminate_expire occassionally. But I tend to believe that this is the 
same issue.

This is still unresolved as of 4.16-rc6 + nolpm quick patch from Hans and the 
"Change synchronize_rcu() in scsi_device_quiesce() into synchronize_sched()" 
patch by Bart. Cause I had this occassional boot failure with it already.

The patch by Bart seems to be related to another issue of the blk-mq quiescing 
stuff.

Thanks,
-- 
Martin
