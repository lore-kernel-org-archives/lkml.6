Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5869920658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5869920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeHVVDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:03:10 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:44556 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeHVVDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:03:10 -0400
Received: by mail-qk0-f178.google.com with SMTP id d131-v6so1766090qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cXbQMuUc6OWVwxJkkUPmfwxyU+IEjt3DyikGX3T4Jr4=;
        b=jdZHDxWtdxKG575Uwt4TCQDq73ZBJdvK2xDZq50lq7s8aN+zO/H6b+BWuBHHeh5FzE
         DzmW5DYA5MLjW3UxY1AP3lgvfXhNoiLo95LjRtMd/THbzQ3jmoilsn4+x4zLxU2pqDGR
         fQ1Q9aRWweIh0cT9lZzYv4VicMTYV9qf0nv2xVkzcyL8eMbR4O033IgiICW3+4b9VBZK
         gTh8uZzb+2k9OIaEAkaUCwYQI00GfY3P6W/d4Ci9dCshvnJMZDBdMA1jaQCActslb2XA
         mKlLD2WnlMVjrWphiZQGY95+4eivvDrezesXbU6txzu/PueF7y6CqZ0mgSwqcNKxWEy8
         XiMA==
X-Gm-Message-State: APzg51DD5Zn/7YX5p5mNWkDnZvPwue7pqFP4FYS+4C7dwIEsDC+wcgZU
        4kdrIsjqJDaehlOqaO6q1Nsotw==
X-Google-Smtp-Source: ANB0VdYc8iomS56Ei6fwM+zHKtnvfhJ2+vQZuA4mMgxKD2MzcqFgVJ3nqucf2VkEZv/0LxSrHvye4w==
X-Received: by 2002:a37:aa07:: with SMTP id t7-v6mr11087502qke.38.1534959441619;
        Wed, 22 Aug 2018 10:37:21 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::7272])
        by smtp.gmail.com with ESMTPSA id t11-v6sm1441081qtb.17.2018.08.22.10.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 10:37:20 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>
Cc:     Laura Abbott <labbott@redhat.com>, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iscsi-target: Don't use stack buffer for scatterlist
Date:   Wed, 22 Aug 2018 10:37:09 -0700
Message-Id: <20180822173709.5886-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fedora got a bug report of a crash with iSCSI:

kernel BUG at include/linux/scatterlist.h:143!
...
RIP: 0010:iscsit_do_crypto_hash_buf+0x154/0x180 [iscsi_target_mod]
...
 Call Trace:
  ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
  iscsit_get_rx_pdu+0x4cd/0xa90 [iscsi_target_mod]
  ? native_sched_clock+0x3e/0xa0
  ? iscsi_target_tx_thread+0x200/0x200 [iscsi_target_mod]
  iscsi_target_rx_thread+0x81/0xf0 [iscsi_target_mod]
  kthread+0x120/0x140
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x3a/0x50

This is a BUG_ON for using a stack buffer with a scatterlist.
There are two cases that trigger this bug. Switch to using a
dynamically allocated buffer for one case and do not assign
a NULL buffer in another case.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1615258
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/target/iscsi/iscsi_target.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 8e223799347a..8b40f0e99e2c 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1419,7 +1419,8 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
 
 	sg_init_table(sg, ARRAY_SIZE(sg));
 	sg_set_buf(sg, buf, payload_length);
-	sg_set_buf(sg + 1, pad_bytes, padding);
+	if (padding)
+		sg_set_buf(sg + 1, pad_bytes, padding);
 
 	ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
 
@@ -3913,10 +3914,14 @@ static bool iscsi_target_check_conn_state(struct iscsi_conn *conn)
 static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 {
 	int ret;
-	u8 buffer[ISCSI_HDR_LEN], opcode;
+	u8 *buffer, opcode;
 	u32 checksum = 0, digest = 0;
 	struct kvec iov;
 
+	buffer = kmalloc_array(ISCSI_HDR_LEN, sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return;
+
 	while (!kthread_should_stop()) {
 		/*
 		 * Ensure that both TX and RX per connection kthreads
@@ -3985,6 +3990,8 @@ static void iscsit_get_rx_pdu(struct iscsi_conn *conn)
 		if (ret < 0)
 			return;
 	}
+
+	kfree(buffer);
 }
 
 int iscsi_target_rx_thread(void *arg)
-- 
2.17.1

