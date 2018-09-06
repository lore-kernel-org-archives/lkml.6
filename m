Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CEAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412182075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeUYkJLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412182075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeIGBOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:14:43 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:49117 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbeIGBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:14:43 -0400
Received: by mail-qt0-f202.google.com with SMTP id a15-v6so12151369qtj.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F4chAjNYxSfMSSc0lr53i2hjb0o+Jf+wxUQuT0zFpdI=;
        b=CeUYkJLrs98VkrUJJaAF2mVnPx7yjTsMEiwDjOwKzhC+umm0xoFayxqavXs9s1HhGq
         x4Os69sLsAPNYD9elS8/9wrzl9HVTAPLPnCc/N+heUgTI4PIlTzqFmEVDbNuS2XyXLku
         3Y4IDWX+HExKbwu3dI4jc6h+kt4MjX1cIwvg6047anaYylqSmThqnitC7k8NMpZjgjPT
         mSq8Oo8RZeIWptaJM4nhFVp6mzFNyE/9oEzQlnQ5UxBTZVt4qb+VnfrEj0706hzbGWJB
         m6dxfVzGQY9c+VocHpn7CTBWKqSU2WCUvkm6FaShslfQnDPaYsaS7cmAzj81Db7zUD4S
         cUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F4chAjNYxSfMSSc0lr53i2hjb0o+Jf+wxUQuT0zFpdI=;
        b=NF8tl0YlceCZR0q9mosNL01D4efnzgmnMgA4zBxgdYO0CYVAT6c5YKyJ+SQQ0ax59Q
         YXfDqidY7UWNaOnpCKaDr9mxk+ANYjrBhsWhj8Mr61lGeb/U1Njzc59hTuOD1XsE3VU4
         /Zy+ksqKndoGSKeiSQ9vr5t0VvLMMg6M3OQfBGVTnTDhlYKbiXdueszOS5ijA7OX0HcX
         14LjW/Ezumak2u2oWxTTWOrMPSf4ztoBOpCPHSs/od3pT7lQXSgdGdZFBqar2O/DumdE
         YwJFOwf4z3mhJUN908KeSe7wUkIv0CmnOaN0Ao6+F29HkzB0ZDIGUiI0dYR1QKVy8wqu
         W3vg==
X-Gm-Message-State: APzg51DCsH36hy/qYGF9QHIMW9a4nI20c2e75AGY+0QoKXYsCNX7m5QX
        iiQFbSbuvTku3kBG1L53h4VInXXCo7wt
X-Google-Smtp-Source: ANB0VdbwMnI00Sd2pHSwyf4yBysxT+PyslcII8ttoBU5wZuT2u6Vh1Q01m7npU1Wkj73ZVxAOde4+nloEvZh
X-Received: by 2002:a37:a1d7:: with SMTP id k206-v6mr1500275qke.54.1536266252412;
 Thu, 06 Sep 2018 13:37:32 -0700 (PDT)
Date:   Thu,  6 Sep 2018 13:37:19 -0700
Message-Id: <20180906203719.209399-1-xueweiz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] scsi: sd: Contribute to randomness when running rotational device
From:   Xuewei Zhang <xueweiz@google.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aditya Kali <adityakali@google.com>,
        tytso@mit.edu, Guenter Roeck <groeck@chromium.org>,
        maze@google.com, Xuewei Zhang <xueweiz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a scsi device won't contribute to kernel randomness when it
uses blk-mq. Since we commonly use scsi on rotational device with
blk-mq, it make sense to keep contributing to kernel randomness in these
cases. This is especially important for virtual machines.

commit b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic
irq vector affinity") made all virtio-scsi device to use blk-mq, which
does not contribute to randomness today. So for a virtual machine only
having virtio-scsi disk (which is common), it will simple stop getting
randomness from its disks in today's implementation.

With this patch, if the above VM has rotational virtio-scsi device, then
it can still benefit from the entropy generated from the disk.

Reported-by: Xuewei Zhang <xueweiz@google.com>
Signed-off-by: Xuewei Zhang <xueweiz@google.com>
---
 drivers/scsi/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b79b366a94f7..5e4f10d28065 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2959,6 +2959,9 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	if (rot == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

