Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078908;
	bh=yZDHvxs3zmc9KneHZ82SPkAF5Cjz6fW8RxFnmqZguic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cGoM+X8hOVkZsDS2WTA1xsNjavrs/FQnkYwavnFAWN/bE2dZuVfl6E8capO9hsAYL
	 g8CemA5a/Dv2eLpBOPrPmTW37KvEge0VTb4kt2OROzyB4R9wEkymxmGpaBJC5/zdgB
	 5SgpxzYSoZdsGZAkFBp6zj4O0fp7WVN4IrQnxV38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfAUNzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731661AbfAUNzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE5C2084C;
        Mon, 21 Jan 2019 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078904;
        bh=yZDHvxs3zmc9KneHZ82SPkAF5Cjz6fW8RxFnmqZguic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDQ8rcTKU7JCRR06wSMhW3FVJy2RaTzp7Gozn/NAfKyhU8Xj/cz6rxlRWyYb5eWA+
         kHqcYUVx7ib+GOasbAWUvv0OvOIDU6wySPZ54odz6WIpNKxMbvT84WDWhw2VpbN29j
         0cHpDx94JyWPIUnHMo6AZeCCZB+9Q2IDG6KnHb8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Mironov <mironov.ivan@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 24/51] scsi: sd: Fix cache_type_store()
Date:   Mon, 21 Jan 2019 14:44:20 +0100
Message-Id: <20190121122455.777256066@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mironov <mironov.ivan@gmail.com>

commit 44759979a49bfd2d20d789add7fa81a21eb1a4ab upstream.

Changing of caching mode via /sys/devices/.../scsi_disk/.../cache_type may
fail if device responds to MODE SENSE command with DPOFUA flag set, and
then checks this flag to be not set on MODE SELECT command.

In this scenario, when trying to change cache_type, write always fails:

	# echo "none" >cache_type
	bash: echo: write error: Invalid argument

And following appears in dmesg:

	[13007.865745] sd 1:0:1:0: [sda] Sense Key : Illegal Request [current]
	[13007.865753] sd 1:0:1:0: [sda] Add. Sense: Invalid field in parameter list

>From SBC-4 r15, 6.5.1 "Mode pages overview", description of DEVICE-SPECIFIC
PARAMETER field in the mode parameter header:
	...
	The write protect (WP) bit for mode data sent with a MODE SELECT
	command shall be ignored by the device server.
	...
	The DPOFUA bit is reserved for mode data sent with a MODE SELECT
	command.
	...

The remaining bits in the DEVICE-SPECIFIC PARAMETER byte are also reserved
and shall be set to zero.

[mkp: shuffled commentary to commit description]

Cc: stable@vger.kernel.org
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -208,6 +208,12 @@ cache_type_store(struct device *dev, str
 	sp = buffer_data[0] & 0x80 ? 1 : 0;
 	buffer_data[0] &= ~0x80;
 
+	/*
+	 * Ensure WP, DPOFUA, and RESERVED fields are cleared in
+	 * received mode parameter buffer before doing MODE SELECT.
+	 */
+	data.device_specific = 0;
+
 	if (scsi_mode_select(sdp, 1, sp, 8, buffer_data, len, SD_TIMEOUT,
 			     SD_MAX_RETRIES, &data, &sshdr)) {
 		if (scsi_sense_valid(&sshdr))


