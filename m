Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965311AbeBMQfq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:35:46 -0500
Received: from 8bytes.org ([81.169.241.247]:41348 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965232AbeBMQfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:35:44 -0500
Date: Tue, 13 Feb 2018 17:35:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv2 4/6] iommu/intel: Handle DMAR faults on workqueue
Message-ID: <20180213163542.tdqhazwfjgqk3zuu@8bytes.org>
References: <20180212164825.22421-1-dima@arista.com>
 <20180212164825.22421-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212164825.22421-5-dima@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:48:23PM +0000, Dmitry Safonov wrote:
> dmar_fault() reports/handles/cleans DMAR faults in a cycle one-by-one.
> The nuisance is that it's set as a irq handler and runs with disabled
> interrupts - which works OK if you have only a couple of DMAR faults,
> but becomes a problem if your intel iommu has a plenty of mappings.

I don't think that a work-queue is the right solution here, it adds a
long delay until the log is processed. During that delay, and with high
fault rates the error log will overflow during that delay.

Here is what I think you should do instead to fix the soft-lockups:

First, unmask the fault reporting irq so that you will get subsequent
irqs. Then:

	* For Primary Fault Reporting just cycle once through all
	  supported fault recording registers.

	* For Advanced Fault Reporting, read start and end pointer of
	  the log and process all entries.

After that return from the fault handler and let the next irq handle
additional faults that might have been recorded while the previous
handler was running.

And of course, ratelimiting the fault printouts is always a good idea.


Regards,

	Joerg
