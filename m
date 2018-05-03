Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeECB7l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 21:59:41 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:40074 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeECB7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 21:59:40 -0400
X-Google-Smtp-Source: AB8JxZo2e8N0xolX6kSponkIdiwFAbFWh9ZAKEQRnvvoNT+eK+bIQIzERCvLVNPeyXxQ3IvL/WReZA==
Message-ID: <1525312776.14025.29.camel@arista.com>
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in
 irq handler
From: Dmitry Safonov <dima@arista.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
        joro@8bytes.org, "Raj, Ashok" <ashok.raj@intel.com>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        iommu@lists.linux-foundation.org
Date: Thu, 03 May 2018 02:59:36 +0100
In-Reply-To: <5AEA66BC.5050202@linux.intel.com>
References: <20180331003312.6390-1-dima@arista.com>
         <20180331003312.6390-2-dima@arista.com> <5AE95BFF.5040306@linux.intel.com>
         <1525264687.14025.20.camel@arista.com> <5AEA4E84.6050609@linux.intel.com>
         <1525308755.14025.25.camel@arista.com> <5AEA66BC.5050202@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 09:32 +0800, Lu Baolu wrote:
> Hi,
> 
> On 05/03/2018 08:52 AM, Dmitry Safonov wrote:
> > AFAICS, we're doing fault-clearing in a loop inside irq handler.
> > That means that while we're clearing if a fault raises, it'll make
> > an irq level triggered (or on edge) on lapic. So, whenever we
> > return
> > from the irq handler, irq will raise again.
> > 
> 
> Uhm, double checked with the spec. Interrupts should be generated
> since we always clear the fault overflow bit.
> 
> Anyway, we can't clear faults in a limited loop, as the spec says in
> 7.3.1:

Mind to elaborate?
ITOW, I do not see a contradiction. We're still clearing faults in FIFO
fashion. There is no limitation to do some spare work in between
clearings (return from interrupt, then fault again and continue).

> Software is expected to process the non-recoverable faults reported
> through the Fault Recording
> Registers in a circular FIFO fashion starting from the Fault
> Recording Register referenced by the Fault
> Recording Index (FRI) field, until it finds a Fault Recording
> Register with no faults (F field Clear).
> 
> Best regards,
> Lu Baolu

-- 
Thanks,
             Dmitry
