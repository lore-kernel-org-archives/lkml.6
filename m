Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CEC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858592084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="IJHMiJMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfAaCbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:31:33 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25369 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAaCbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:31:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548901870; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=X+ml8GMBbecCc3TqJto8+8DMraRD8xLGYKg5Xzzco0pN6xiYjFRdMLHcHy2fS5O2Ef1xlV36vZMx6j1X2FEftv+sXrCrEl+f5PK0g6v6jT3P9VM5llXCUdntyH61ofRWF7K87dm5NtFVk0lQDACsfpkByCRUztQYmA2U8gkcxW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548901870; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Hprshl33TxrC7I6MgIhdNaFls+1mjN5XVsCBfTa4/Vk=; 
        b=hdBFMP4a0NT7dcmBvRS+EY45WcIS3niSsXOq5cAUBG1Fv4eesllME8AQYXYtaP7YR/eH4uT4oR/pymcXngupvmQ7t8+HvU/T23U6RJvWrSQpojSPMWtNitA2CXa1RuIbDCGuA4ZQ8RnN8hfUaQoHQmVz0gWXno1rmzjUYLsLeLc=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=HTuEgdcbZQmmTutO0542+OhLG4dc+iGM1cZRdGCjuy0KypODgxvXNDtlnY1PZcmXxnRVyjQ0zUak
    tMe1r5gE/ydSHoV/reMp81MAUvbhCXdlemoJ6NctGHGU3UqWD4al  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548901870;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=1196;
        bh=Hprshl33TxrC7I6MgIhdNaFls+1mjN5XVsCBfTa4/Vk=;
        b=IJHMiJMGXd0ppiRLfxbuB3ZMfyLZnrk69054SKhnCKd5D8JTrtLf2FaqVu7sut4+
        ZmBWTzywgAPZbjNQpaoW6sAUe3dFuE7SOdrAcstdaiuNccYx4H7Rq47G6/l8L3UIWn5
        sqjqG7/78VadDGVLqdNbKuzgRZtwqgVf/kkwiNdU=
Received: from YEHS1XR956R00D1.lenovo.com (106.38.1.115 [106.38.1.115]) by mx.zohomail.com
        with SMTPS id 1548901867914504.01422197228715; Wed, 30 Jan 2019 18:31:07 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dan.j.williams@intel.com, hch@lst.de, jack@suse.cz, corbet@lwn.net,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v3 0/5] Optimize writecache when using pmem as cache
Date:   Thu, 31 Jan 2019 10:29:50 +0800
Message-Id: <20190131022955.9920-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

This patch set could be used for dm-writecache when use persistent
memory as cache data device.

Patch 1 and 2 go towards removing unused parameter and codes which
actually doesn't really work.

Patch 3 and 4 are targeted at solving problem fn ctr failed to work
due to invalid magic or version, which is caused by the super block
of pmem has messy data stored.

Patch 5 is used for getting the status of seq_count.

Changes Since v2: 
        - seq_count is important for flush operations, output it within status
          for debugging and analyzing code behavior.
	[1]: https://lkml.org/lkml/2019/1/3/43
        [2]: https://lkml.org/lkml/2019/1/9/6

Huaisheng Ye (5):
  dm-writecache: remove unused size to writecache_flush_region
  dm-writecache: get rid of memory_data flush to writecache_flush_entry
  dm-writecache: expand pmem_reinit for struct dm_writecache
  Documentation/device-mapper: add optional parameter reinit
  dm-writecache: output seq_count within status

 Documentation/device-mapper/writecache.txt |  4 ++++
 drivers/md/dm-writecache.c                 | 23 +++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.8.3.1


