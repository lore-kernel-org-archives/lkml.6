Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434C21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A434C21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeI0AYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:24:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:51930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbeI0AYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:24:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 11:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="93496241"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2018 11:10:35 -0700
Date:   Wed, 26 Sep 2018 11:10:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926181035.GA1132@agluck-desk>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
 <20180925175023.GA16725@agluck-desk>
 <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
 <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
 <20180926161749.GI5584@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926161749.GI5584@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:17:49PM +0200, Borislav Petkov wrote:
> On Wed, Sep 26, 2018 at 01:03:40PM -0300, Mauro Carvalho Chehab wrote:
> > I guess this is/was needed to create things like this:
> > 
> > 	lrwxrwxrwx 1 root root 0 set 26 05:24 /sys/bus/edac/devices/mc -> ../../../devices/system/edac/mc
> 
> They're still there:
> 
> $ ls -l /sys/bus/edac/devices/
> total 0
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 csrow0 -> ../../../devices/system/edac/mc/mc0/csrow0
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm0 -> ../../../devices/system/edac/mc/mc0/dimm0
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm3 -> ../../../devices/system/edac/mc/mc0/dimm3
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm6 -> ../../../devices/system/edac/mc/mc0/dimm6
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm9 -> ../../../devices/system/edac/mc/mc0/dimm9
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc -> ../../../devices/system/edac/mc
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc0 -> ../../../devices/system/edac/mc/mc0

I ran into trouble on my 4 socket broadwell server (so 8 memory controllers,
a whole pile of DIMMs, running from sb_edac.c)

Things start going wrong with:

[   45.216657] sysfs: cannot create duplicate filename '/bus/edac/devices/dimm0'
[   45.216663] CPU: 37 PID: 2034 Comm: systemd-udevd Not tainted 4.19.0-rc5 #1
[   45.216665] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
[   45.216667] Call Trace:
[   45.216688]  dump_stack+0x5c/0x7b
[   45.216697]  sysfs_warn_dup+0x56/0x70
[   45.216702]  sysfs_do_create_link_sd.isra.2+0x98/0xb0
[   45.216714]  bus_add_device+0x77/0x160
[   45.216720]  device_add+0x424/0x660
[   45.216731]  edac_create_sysfs_mci_device+0xb9/0x2f0
[   45.216738]  edac_mc_add_mc_with_groups+0x111/0x2b0
[   45.216747]  sbridge_init+0x13c9/0x2000 [sb_edac]
[   45.216757]  ? _raw_spin_lock+0x1d/0x20
[   45.216765]  ? free_pcppages_bulk+0x2ca/0x630
[   45.216769]  ? 0xffffffffc050f000
[   45.216779]  do_one_initcall+0x46/0x1c8
[   45.216784]  ? free_unref_page_commit+0x95/0x120
[   45.216791]  ? _cond_resched+0x15/0x40
[   45.216798]  ? kmem_cache_alloc_trace+0x153/0x1c0
[   45.216805]  do_init_module+0x5b/0x208
[   45.216826]  load_module+0x1a2d/0x1fb0
[   45.216835]  ? __do_sys_finit_module+0xe9/0x110
[   45.216840]  __do_sys_finit_module+0xe9/0x110
[   45.216847]  do_syscall_64+0x5b/0x180
[   45.216852]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   45.216856] RIP: 0033:0x7fcdec618bd9

and fell off a cliff after that.

Going back to the old code I have a "dimm0" on each of the eight controllers:

# find /sys -name dimm0
/sys/devices/system/edac/mc/mc6/dimm0
/sys/devices/system/edac/mc/mc4/dimm0
/sys/devices/system/edac/mc/mc2/dimm0
/sys/devices/system/edac/mc/mc0/dimm0
/sys/devices/system/edac/mc/mc7/dimm0
/sys/devices/system/edac/mc/mc5/dimm0
/sys/devices/system/edac/mc/mc3/dimm0
/sys/devices/system/edac/mc/mc1/dimm0
/sys/bus/mc6/devices/dimm0
/sys/bus/mc4/devices/dimm0
/sys/bus/mc2/devices/dimm0
/sys/bus/mc0/devices/dimm0
/sys/bus/mc7/devices/dimm0
/sys/bus/mc5/devices/dimm0
/sys/bus/mc3/devices/dimm0
/sys/bus/mc1/devices/dimm0
# ls -l /sys/bus/mc0/devices
total 0
lrwxrwxrwx. 1 root root 0 Sep 26 11:08 csrow0 -> ../../../devices/system/edac/mc/mc0/csrow0
lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm0 -> ../../../devices/system/edac/mc/mc0/dimm0
lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm3 -> ../../../devices/system/edac/mc/mc0/dimm3
lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm6 -> ../../../devices/system/edac/mc/mc0/dimm6
lrwxrwxrwx. 1 root root 0 Sep 26 11:08 dimm9 -> ../../../devices/system/edac/mc/mc0/dimm9
lrwxrwxrwx. 1 root root 0 Sep 26 11:08 mc0 -> ../../../devices/system/edac/mc/mc0

It looks like the new code isn't trying to place the dimm symlinks
in the proper subdirectories.

-Tony
