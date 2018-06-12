Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2ABF9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D487F20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G1/50mk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D487F20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934044AbeFLU4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:56:36 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6029 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933637AbeFLU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836994; x=1560372994;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FInAt5ibGXfg881hGlOMYQvmDIsnPK+1a117RSZwwLo=;
  b=G1/50mk94lmyeHpYZguGAbAbpjwwdMK5nMF+CPM0mTiphI8aII8O1U5D
   d589x2A58obdEAFnx0iLobkId5il6vp8f5AdavyefjewV14ViNN/wy7ep
   yKpd4wbJXe8MQNDLIq6nm0Klt8xQ6ttauOfl+xYSu4PlWefcqvEpxtejI
   4=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="736713934"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuQ5p090870
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:26 GMT
Received: from EX13D10UWB001.ant.amazon.com (10.43.161.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D10UWB001.ant.amazon.com (10.43.161.111) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:26 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Jun
 2018 20:56:24 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 00/12] Enable PM hibernation on guest VMs
Date:   Tue, 12 Jun 2018 20:56:07 +0000
Message-ID: <20180612205619.28156-1-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am sending out a series of patches that implements guest
PM hibernation. These guests are running on xen hypervisor.
The patches had been tested against mainstream kernel and latest
xen version-4.11. EC2 instance hibernation feature is provided to
the AWS EC2 customers. PM hibernation uses swap space where
hibernation image is stored and restored from. I would like
the community to review and provide some feedback on the patch 
series and if they look good, merge them into 4.17 kernel.

Aleksei Besogonov (1):
  PM / hibernate: update the resume offset on SNAPSHOT_SET_SWAP_AREA

Anchal Agarwal (1):
  x86/xen: Introduce new function to map HYPERVISOR_shared_info on
    Resume

Munehisa Kamata (10):
  xen/manage: keep track of the on-going suspend mode
  xen/manage: introduce helper function to know the on-going suspend
    mode
  xenbus: add freeze/thaw/restore callbacks support
  x86/xen: add system core suspend and resume callbacks
  xen-blkfront: add callbacks for PM suspend and hibernation
  xen-netfront: add callbacks for PM suspend and hibernation support
  xen-time-introduce-xen_-save-restore-_steal_clock
  x86/xen: save and restore steal clock
  xen/events: add xen_shutdown_pirqs helper function
  x86/xen: close event channels for PIRQs in system core suspend
    callback

 arch/x86/xen/enlighten_hvm.c      |   8 ++
 arch/x86/xen/suspend.c            |  66 ++++++++++++++++
 arch/x86/xen/time.c               |   3 +
 arch/x86/xen/xen-ops.h            |   1 +
 drivers/block/xen-blkfront.c      | 158 ++++++++++++++++++++++++++++++++++++--
 drivers/net/xen-netfront.c        |  97 ++++++++++++++++++++++-
 drivers/xen/events/events_base.c  |  12 +++
 drivers/xen/manage.c              |  73 ++++++++++++++++++
 drivers/xen/time.c                |  28 ++++++-
 drivers/xen/xenbus/xenbus_probe.c | 102 ++++++++++++++++++++----
 include/xen/events.h              |   1 +
 include/xen/xen-ops.h             |   8 ++
 include/xen/xenbus.h              |   3 +
 kernel/power/user.c               |   6 +-
 14 files changed, 540 insertions(+), 26 deletions(-)

-- 
2.13.6

