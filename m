Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E794920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E794920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405679AbeHATIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405664AbeHATId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BBAE810B3;
        Wed,  1 Aug 2018 17:03:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gioh Kim <gi-oh.kim@profitbricks.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 164/336] md/raid1: add error handling of read error from FailFast device
Date:   Wed,  1 Aug 2018 18:48:19 +0200
Message-Id: <20180801165035.392250368@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gioh Kim <gi-oh.kim@profitbricks.com>

[ Upstream commit b33d10624fdc15cdf1495f3f00481afccec76783 ]

Current handle_read_error() function calls fix_read_error()
only if md device is RW and rdev does not include FailFast flag.
It does not handle a read error from a RW device including
FailFast flag.

I am not sure it is intended. But I found that write IO error
sets rdev faulty. The md module should handle the read IO error and
write IO error equally. So I think read IO error should set rdev faulty.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
Reviewed-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid1.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2474,6 +2474,8 @@ static void handle_read_error(struct r1c
 		fix_read_error(conf, r1_bio->read_disk,
 			       r1_bio->sector, r1_bio->sectors);
 		unfreeze_array(conf);
+	} else if (mddev->ro == 0 && test_bit(FailFast, &rdev->flags)) {
+		md_error(mddev, rdev);
 	} else {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	}


