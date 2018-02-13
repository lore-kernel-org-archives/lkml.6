Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965355AbeBMRi6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:38:58 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52515 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965099AbeBMRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:38:56 -0500
X-Google-Smtp-Source: AH8x2258ckOmxyvbHPVB+npdHlFbJeTZMOW8wK44S8RNDJj9ob4n1/0216V8wqO9bLz77PGen0m4xA==
Message-ID: <1518543533.2849.25.camel@arista.com>
Subject: Re: [PATCHv2 4/6] iommu/intel: Handle DMAR faults on workqueue
From: Dmitry Safonov <dima@arista.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Date: Tue, 13 Feb 2018 17:38:53 +0000
In-Reply-To: <20180213163542.tdqhazwfjgqk3zuu@8bytes.org>
References: <20180212164825.22421-1-dima@arista.com>
         <20180212164825.22421-5-dima@arista.com>
         <20180213163542.tdqhazwfjgqk3zuu@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 17:35 +0100, Joerg Roedel wrote:
> On Mon, Feb 12, 2018 at 04:48:23PM +0000, Dmitry Safonov wrote:
> > dmar_fault() reports/handles/cleans DMAR faults in a cycle one-by-
> > one.
> > The nuisance is that it's set as a irq handler and runs with
> > disabled
> > interrupts - which works OK if you have only a couple of DMAR
> > faults,
> > but becomes a problem if your intel iommu has a plenty of mappings.
> 
> I don't think that a work-queue is the right solution here, it adds a
> long delay until the log is processed. During that delay, and with
> high
> fault rates the error log will overflow during that delay.
> 
> Here is what I think you should do instead to fix the soft-lockups:
> 
> First, unmask the fault reporting irq so that you will get subsequent
> irqs. Then:
> 
> 	* For Primary Fault Reporting just cycle once through all
> 	  supported fault recording registers.
> 
> 	* For Advanced Fault Reporting, read start and end pointer of
> 	  the log and process all entries.
> 
> After that return from the fault handler and let the next irq handle
> additional faults that might have been recorded while the previous
> handler was running.

Ok, will re-do this way, thanks.

> And of course, ratelimiting the fault printouts is always a good
> idea.

-- 
            Dima
