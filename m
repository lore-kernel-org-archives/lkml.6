Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595942083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595942083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934638AbeFRNfW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:35:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933557AbeFRNfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:35:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA51BABE4;
        Mon, 18 Jun 2018 13:35:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DF95DAC2E; Mon, 18 Jun 2018 15:32:29 +0200 (CEST)
Date:   Mon, 18 Jun 2018 15:32:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     clm@fb.com, dsterba@suse.com, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, anand.jain@oracle.com
Subject: Re: general protection fault in find_device
Message-ID: <20180618133228.GL24375@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        clm@fb.com, dsterba@suse.com, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, anand.jain@oracle.com
References: <000000000000e5da7e056ee43449@google.com>
 <45200a61-58c3-b7f0-d8e4-5108f8369ac5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45200a61-58c3-b7f0-d8e4-5108f8369ac5@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:03:18AM +0300, Nikolay Borisov wrote:
> So this suggests some inconsistency on fs_devices->devices list. On a
> quick look indeed it doesn't seem clear what the locking rules for this
> list are. In device_list_add in the !device case a device is added with
> fs_devices->device_list_Mutex held and using list_add_rcu. In the same
> function if we want to read the list ie invoke find_devices (because we
> have found an fsid) we are using plain list_for_each_entry (ie not the
> _rcu version and i don't see device_list_mutex being held while
> iterating the list). Additionally in btrfs_free_extra_devids the
> fs_devices->devices list is iterated with uuid_mutex being held and not
> device_list_mutex. In open_fs_devices we don't get any protection
> whatsoever while reading the list.

The uuid_mutex or device_list_mutex is provided by a caller up the
stack.

> Same thing in
> btrfs_find_next_active_device. If the list is supposed to be
> RCU-protected then the rules are:
> 
> 1. There needs to be an out of band (ie not RCU) mutual exclusion of
> modifiers

that's device_list_mutex for fs_devices::devices

> 2. Iterating the list should use _rcu list primitives.
> 
> Currently I don't see those 2 invariants being enforced in every code path.

Where is it not enforced for example?

If the device_list_mutex is held, list traversal does not use
list_for_each_entry_rcu, otherwise it does (eg the DEV_INFO ioctl or
btrfs_show_devname).

The problem that triggers this report is IMO in device_list_add that
uses the device list unprotected. Anand sent patches for that, but they
were titled as 'cleanups' so I skipped them for the merge window.

Candidate fixes are:

https://patchwork.kernel.org/patch/10437705/
https://patchwork.kernel.org/patch/10437713/
