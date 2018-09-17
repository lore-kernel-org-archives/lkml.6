Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50270ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019E52146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019E52146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeIREge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbeIREgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:33 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 603ABC49;
        Mon, 17 Sep 2018 23:07:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 011/158] nbd: dont allow invalid blocksize settings
Date:   Tue, 18 Sep 2018 00:40:41 +0200
Message-Id: <20180917211711.173459203@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit bc811f05d77f47059c197a98b6ad242eb03999cb upstream.

syzbot reports a divide-by-zero off the NBD_SET_BLKSIZE ioctl.
We need proper validation of the input here. Not just if it's
zero, but also if the value is a power-of-2 and in a valid
range. Add that.

Cc: stable@vger.kernel.org
Reported-by: syzbot <syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/nbd.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1239,6 +1239,9 @@ static int __nbd_ioctl(struct block_devi
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
+		if (!arg || !is_power_of_2(arg) || arg < 512 ||
+		    arg > PAGE_SIZE)
+			return -EINVAL;
 		nbd_size_set(nbd, arg,
 			     div_s64(config->bytesize, arg));
 		return 0;


