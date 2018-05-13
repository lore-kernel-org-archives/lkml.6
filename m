Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeEMJbY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 05:31:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60385 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeEMJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 05:31:23 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date: Sun, 13 May 2018 11:30:52 +0200
Message-ID: <8775668.fKKdjnIWAU@aspire.rjw.lan>
In-Reply-To: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, May 5, 2018 1:53:22 PM CEST Chen Yu wrote:
> According to current implementation of acpi_pad driver,
> it does not make sense to spawn any power saving threads
> on the cpus which are already idle - it might bring
> unnecessary overhead on these idle cpus and causes power
> waste. So verify the condition that if the number of 'busy'
> cpus exceeds the amount of the 'forced idle' cpus is met.
> This is applicable due to round-robin attribute of the
> power saving threads, otherwise ignore the setting/ACPI
> notification.

OK, but CPUs are busy, because they are running tasks.  If acpi_pad
kthreads run on them, the tasks they are running will migrate to the
currently idle CPUs (unless they have specific CPU affinity) and the
throttling will not really be effective.

I would think that acpi_pad should ensure that the requested number of
CPUs will not run anything other than throttling kthreads.  Isn't that
the case?

Thanks,
Rafael
