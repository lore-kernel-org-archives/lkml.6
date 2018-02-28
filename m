Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965170AbeB1XzR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:55:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:9581 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964824AbeB1XzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:55:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="20977845"
Date: Wed, 28 Feb 2018 16:55:37 -0700
From: Keith Busch <keith.busch@intel.com>
To: wenxiong <wenxiong@linux.vnet.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com,
        linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH V3] nvme-pci: Fixes EEH failure on ppc
Message-ID: <20180228235537.GK16002@localhost.localdomain>
References: <1518725110-25894-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <bf3a386a2b82dac84b681c14d5334632@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3a386a2b82dac84b681c14d5334632@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 04:31:37PM -0600, wenxiong wrote:
> On 2018-02-15 14:05, wenxiong@linux.vnet.ibm.com wrote:
> > From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> > 
> > With b2a0eb1a0ac72869c910a79d935a0b049ec78ad9(nvme-pci: Remove watchdog
> > timer), EEH recovery stops working on ppc.
> > 
> > After removing whatdog timer routine, when trigger EEH on ppc, we hit
> > EEH in nvme_timeout(). We would like to check if pci channel is offline
> > or not at the beginning of nvme_timeout(), if it is already offline,
> > we don't need to do future nvme timeout process.
> > 
> > Add mrmory barrier before calling pci_channel_offline().
> > 
> > With the patch, EEH recovery works successfuly on ppc.
> > 
> > Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> 
> Hi Keith and All,
> 
> We have the newer Linux distro releases came out recently, so I got more
> reports for this issue.
> 
> Test teams have verified the patch in several distro kernel version(v4.14,
> v4.15).
> 
> 
> If you have any question about the V3 patch I submitted two weeks, Let me
> know.

Sorry, I'd nearly forgotten about this one.

We need a better change log. Could you help explain how this really
works? As I understand it, I would write it something like this, but
let me know if there's more to it:

  Triggering PPC EEH detection and handling requires a memory mapped
  read failure. The NVMe driver removed the periodic health check MMIO,
  so there's no early detection mechanism to trigger the recovery.

  Instead, the detection happens when the nvme driver handles an IO
  timeout event. Since this takes the pci channel offline, we do not
  want the driver to proceed with escalating its own recovery efforts
  that may conflict with the EEH handler. This patch ensures the driver
  will observe the channel was set to offline after a failed MMIO read
  and resets the IO timer so the EEH handler has a chance to recover
  the device.
