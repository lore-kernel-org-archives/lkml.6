Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbeCSPWd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:22:33 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45658 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933402AbeCSPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:22:21 -0400
X-Google-Smtp-Source: AG47ELt6caROMx+ciF9wHnrIX1pplDdZfJHKwL5YwFqE6WoiqD6K+QTYZdl9M/ht1CKFzD2mdPGEfw==
Date: Mon, 19 Mar 2018 08:22:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [RFC v2 0/2] kernel: add support to collect hardware logs in
 crash recovery kernel
Message-ID: <20180319082211.6651b45a@xeon-e3>
In-Reply-To: <20180319075555.GA22955@chelsio.com>
References: <1521198725-13463-1-git-send-email-rahul.lakkireddy@chelsio.com>
        <20180319075555.GA22955@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018 13:25:56 +0530
Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> wrote:

> On Friday, March 03/16/18, 2018 at 16:42:03 +0530, Rahul Lakkireddy wrote:
> > On production servers running variety of workloads over time, kernel
> > panic can happen sporadically after days or even months. It is
> > important to collect as much debug logs as possible to root cause
> > and fix the problem, that may not be easy to reproduce. Snapshot of
> > underlying hardware/firmware state (like register dump, firmware
> > logs, adapter memory, etc.), at the time of kernel panic will be very
> > helpful while debugging the culprit device driver.
> > 
> > This series of patches add new generic framework that enable device
> > drivers to collect device specific snapshot of the hardware/firmware
> > state of the underlying device in the crash recovery kernel. In crash
> > recovery kernel, the collected logs are exposed via /proc/crashdd/
> > directory, which is copied by user space scripts for post-analysis.
> > 
> > A kernel module crashdd is newly added. In crash recovery kernel,
> > crashdd exposes /proc/crashdd/ directory containing device specific
> > hardware/firmware logs.
> > 
> > The sequence of actions done by device drivers to append their device
> > specific hardware/firmware logs to /proc/crashdd/ directory are as
> > follows:
> > 
> > 1. During probe (before hardware is initialized), device drivers
> > register to the crashdd module (via crashdd_add_dump()), with
> > callback function, along with buffer size and log name needed for
> > firmware/hardware log collection.
> > 
> > 2. Crashdd creates a driver's directory under /proc/crashdd/<driver>.
> > Then, it allocates the buffer with requested size and invokes the
> > device driver's registered callback function.
> > 
> > 3. Device driver collects all hardware/firmware logs into the buffer
> > and returns control back to crashdd.
> > 
> > 4. Crashdd exposes the buffer as a file via
> > /proc/crashdd/<driver>/<dump_file>.
> > 
> > 5. User space script (/usr/lib/kdump/kdump-lib-initramfs.sh) copies
> > the entire /proc/crashdd/ directory to /var/crash/ directory.
> > 
> > Patch 1 adds crashdd module to allow drivers to register callback to
> > collect the device specific hardware/firmware logs.  The module also
> > exports /proc/crashdd/ directory containing the hardware/firmware logs.
> > 
> > Patch 2 shows a cxgb4 driver example using the API to collect
> > hardware/firmware logs in crash recovery kernel, before hardware is
> > initialized.  The logs for the devices are made available under
> > /proc/crashdd/cxgb4/ directory.
> > 
> > Suggestions and feedback will be much appreciated.
> > 
> > Thanks,
> > Rahul
> > 
> > RFC v1: https://www.spinics.net/lists/netdev/msg486562.html
> > 
> > ---
> > v2:
> > - Added new crashdd module that exports /proc/crashdd/ containing
> >   driver's registered hardware/firmware logs in patch 1.
> > - Replaced the API to allow drivers to register their hardware/firmware
> >   log collect routine in crash recovery kernel in patch 1.
> > - Updated patch 2 to use the new API in patch 1.
> > 
> > Rahul Lakkireddy (2):
> >   proc/crashdd: add API to collect hardware dump in second kernel
> >   cxgb4: collect hardware dump in second kernel
> > 
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |   4 +
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c |  25 +++
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |   3 +
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |  12 ++
> >  fs/proc/Kconfig                                  |  11 +
> >  fs/proc/Makefile                                 |   1 +
> >  fs/proc/crashdd.c                                | 263 +++++++++++++++++++++++
> >  include/linux/crashdd.h                          |  43 ++++
> >  8 files changed, 362 insertions(+)
> >  create mode 100644 fs/proc/crashdd.c
> >  create mode 100644 include/linux/crashdd.h
> > 
> > -- 
> > 2.14.1
> >   
> 
> Does anyone have any comments with this approach?  If there are no
> comments, then I'll re-spin this RFC to Patch series.
> 
> Thanks,
> Rahul

This does look like it gives useful data, but it is not clear that this can
not already be done with existing API's or small extensions.

Introducing a new /proc interface and one that is mostly device specific is
unlikely to be greeted with a warm reception by the current Linux kernel community.

For example, getting firmware logs seems like something more related to
ethtool or sysfs.
