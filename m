Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7AC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749E52087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfAHFZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:25:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:52280 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfAHFZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:25:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 21:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="308444429"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2019 21:25:03 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc:     borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        wei.w.wang@intel.com, pasic@linux.ibm.com
Subject: [PATCH v4 0/3] virtio-balloon: tweak config_changed
Date:   Tue,  8 Jan 2019 12:50:02 +0800
Message-Id: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since virtio-ccw doesn't work with accessing to the config space
inside an interrupt context, this patch series avoids that issue by
moving the config register accesses to the related workqueue contexts.

v3->v4 ChangeLog:
    - change virtio32_to_cpu to cpu_to_virtio_32 in send_cmd_id_start;
v2->v3 ChangeLog:
    - rename cmd_id_received to cmd_id_received_cache, and have call sites
      read the latest value via virtio_balloon_cmd_id_received. (Still
      kept Cornelia and Halil's reviewed-by as it's a minor change)
    - remove zeroing vb->num_free_page_blocks in probe since vb is
      allocated via kzalloc.
v1->v2 ChangeLog:
    - add config_read_bitmap to indicate to the workqueue callbacks about
      the necessity of reading the related config fields.

Wei Wang (3):
  virtio-balloon: tweak config_changed implementation
  virtio-balloon: improve update_balloon_size_func
  virtio_balloon: remove the unnecessary 0-initialization

 drivers/virtio/virtio_balloon.c | 104 ++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 35 deletions(-)

-- 
2.7.4

