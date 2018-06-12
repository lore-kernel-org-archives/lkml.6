Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F15F0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD11208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD11208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934228AbeFLQOr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:14:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:65444 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933666AbeFLQOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:14:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 09:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="47182351"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 09:14:43 -0700
Date:   Tue, 12 Jun 2018 10:17:39 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [BUG] cc5b114dcf bpf, i40e: add meta data support
Message-ID: <20180612161739.GA3303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My server's i40e no longer obtains an IP address on linux
mainline. Bisected to the following:

commit cc5b114dcf986bfd8e4c37bf65d1b7b1e5290ac6
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Mon May 28 11:07:20 2018 +0200

    bpf, i40e: add meta data support

Reverting on mainline resolves the issue.

Is there something wrong with my i40e adapter, or is the patch possibly
doing something wrong? Or any other information I can get to help
understand why it's stopped working with this feature?

An excert from "journalctl -xe" on on the failing network adapter
is below.

Thanks,
Keith

---
Jun 12 10:04:35 localhost.localdomain dhclient[2632]: DHCPDISCOVER on eno1 to 255.255.255.255 port 67 interval 7 (xid=0x3b301712)
Jun 12 10:04:42 localhost.localdomain dhclient[2632]: DHCPDISCOVER on eno1 to 255.255.255.255 port 67 interval 14 (xid=0x3b301712)
Jun 12 10:04:56 localhost.localdomain dhclient[2632]: DHCPDISCOVER on eno1 to 255.255.255.255 port 67 interval 21 (xid=0x3b301712)
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <warn>  [1528819503.2274] dhcp4 (eno1): request timed out
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2275] dhcp4 (eno1): state changed unknown -> timeout
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2440] dhcp4 (eno1): canceled DHCP transaction, DHCP client pid 2632
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2441] dhcp4 (eno1): state changed timeout -> done
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2445] device (eno1): state change: ip-config -> failed (reason 'ip-config-unavailable', internal state 'managed')
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2448] manager: NetworkManager state is now DISCONNECTED
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <warn>  [1528819503.2452] device (eno1): Activation: failed for connection 'Wired connection 1'
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2460] device (eno1): state change: failed -> disconnected (reason 'none', internal state 'managed')
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2498] policy: auto-activating connection 'Wired connection 1'
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2517] device (eno1): Activation: starting connection 'Wired connection 1' (16a13ab5-c51e-361b-90bc-b6fc6f84cbe9)
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2520] device (eno1): state change: disconnected -> prepare (reason 'none', internal state 'managed')
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2523] manager: NetworkManager state is now CONNECTING
Jun 12 10:05:03 localhost.localdomain NetworkManager[2215]: <info>  [1528819503.2529] device (eno1): state change: prepare -> config (reason 'none', internal state 'managed')
