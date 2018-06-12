Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42591C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E331F20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="txZecGZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E331F20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeFLTF5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:05:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933254AbeFLTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2FRbNYo+3tlvCg5HfuFGR9UiAMukmzhxlbr/Q3ElRbs=; b=txZecGZ8JZN4gs0/OkEvyn0zB
        Y8F2hSaOghZ7a+sWl4bzL3NsJeCb22JAZTf7oqKq4dI8HlX2sBQ8mgTdBkYMQEWkY0vcVLR430LPy
        aFj2ch+mM1HsVjZpt8Jz32mCJe6DRoO3Q6PxL3sWzs/ZCwsXnarW3Qctc5ttCPkgSsN4fCMYNzSnS
        JC7u0Fe8cCKSRW7DbYqmwPDOE/870ifqhPf78EiewK9z6TsOyR2XRWQKSQwHKSKLi46z7zxfjSn/5
        208uH5F8/sX2K5GTsZ8AxciRy0iycMv9RHOnAE0KBwgz56V4eR5lpt38CkqsVQZecPwf6byQ1hLGa
        s/LH0jHgw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSoc2-0002uK-0n; Tue, 12 Jun 2018 19:05:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/3] Use sbitmap instead of percpu_ida
Date:   Tue, 12 Jun 2018 12:05:42 -0700
Message-Id: <20180612190545.10781-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the percpu_ida code nets over 400 lines of removal.  It's not
as spectacular as deleting an entire architecture, but it's still a
worthy reduction in lines of code.

Untested due to lack of hardware and not understanding how to set up a
target platform.

Changes from v1:
 - Fixed bugs pointed out by Jens in iscsit_wait_for_tag()
 - Abstracted out tag freeing as requested by Bart
 - Made iscsit_wait_for_tag static as pointed out by 0day

Matthew Wilcox (3):
  target: Abstract tag freeing
  Convert target drivers to use sbitmap
  Remove percpu_ida

 drivers/scsi/qla2xxx/qla_target.c        |  14 +-
 drivers/target/iscsi/iscsi_target_util.c |  35 ++-
 drivers/target/sbp/sbp_target.c          |   7 +-
 drivers/target/target_core_transport.c   |   5 +-
 drivers/target/tcm_fc/tfc_cmd.c          |  10 +-
 drivers/usb/gadget/function/f_tcm.c      |   7 +-
 drivers/vhost/scsi.c                     |   8 +-
 drivers/xen/xen-scsiback.c               |   9 +-
 include/linux/percpu_ida.h               |  83 -----
 include/target/iscsi/iscsi_target_core.h |   1 +
 include/target/target_core_base.h        |  10 +-
 lib/Makefile                             |   2 +-
 lib/percpu_ida.c                         | 370 -----------------------
 13 files changed, 73 insertions(+), 488 deletions(-)
 delete mode 100644 include/linux/percpu_ida.h
 delete mode 100644 lib/percpu_ida.c

-- 
2.17.1

