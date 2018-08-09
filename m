Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F19C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8F8223A6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRqAbqeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8F8223A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeHJCGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:06:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42149 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHJCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:06:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so3576252pff.9;
        Thu, 09 Aug 2018 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJImHBF2EwXLlmdkVXoaXDFCNFb51x1QyyG4T9zW/E4=;
        b=GRqAbqeDjmF5kPs5ObgL6RzQaApkTal5T6hciJuOVqAfMC76ipXhwqmGRzytlmWJgG
         RLLArvBGlBxmpr72jcEHKcvWnzNPb5RxHkBF+846lVPPWwbUPxOVCbAZu2X243KAsAyU
         xoyP8nZsG8U0nC3P/BATj+EgGjCy44uUrQkC+8TyQ0OYTKOUkbpwj/Zembsl3pnrT/qK
         gFEzNaa+/P4kG0WzKPka+dcu3lpczbQyhmacnT7Yg8y4aB4e45M6BQAsCoDlfftuo7Gf
         t+8Te3yMkVPRJU8E0v0TdcKkGmKYy25iPXz/gyEKfhYWG8J97woqfsdJ3T0v1UVnxpND
         c+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJImHBF2EwXLlmdkVXoaXDFCNFb51x1QyyG4T9zW/E4=;
        b=XX063evPENJNfJoYUfzsi+d5FNT6LmM3+/7p1Nl6aE0VPiYk1YRfDLMHKo0Z68KTWW
         QCjTS5saDVzL7XeyOpXhA7B6Odsl15i1uVmNGOScoaEcmIlOATSnPsYXQeaVlb2Ysz83
         4M6tUVXP1Mp0jHwgG4AADEWAAn8cCtp2Duye/Y0sw/bdCXvyvz2UDDC7gOLVdMR2MZVU
         GA9DcKePFd4VipWvbFDGX7PbE5teMB+ZrmRfPEPhe+pammF6g6ls/RejWnuGmA1pZXqQ
         dYiH429MshEs1FjlFlbxn/uhurcj8KDVr3HLBal/a5Bh0YGb5YhS56FhaD2EkeVPZ5Q2
         DA/A==
X-Gm-Message-State: AOUpUlH+1ClMO53zWCTuud+L6N1CPMslyF796SB9ZbXdjnqBSQIN0FJZ
        n74Qp/M6PfQqlupvYVrjag/UjUX6
X-Google-Smtp-Source: AA+uWPxKSnLf6CG+4cY0CSacJljrDe0AhvwA7femYr3209G2oyJrnX7sFkaXtLyxwyflw8HiXr5oUA==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr4484769pfl.8.1533857972203;
        Thu, 09 Aug 2018 16:39:32 -0700 (PDT)
Received: from hobbes.alyptik.lan (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id d191-v6sm14275101pfg.172.2018.08.09.16.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 16:39:31 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH RESEND 2/4] HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
Date:   Thu,  9 Aug 2018 13:39:17 -1000
Message-Id:
 <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180809233917.v1O-swi2wOcHMe3RYECQMK13WORSZsdn8-mRktg8aos@z>

The HID_GROUP_MULTITOUCH_WIN_8 group never needs to check for the serial
protocol, so avoid setting `td->serial_maybe = true;` in order to avoid
an unnecessary mt_post_parse_default_settings() call

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a793076139d7d0db9b..c0654db0b736543ca0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1460,11 +1460,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!td->fields) {
 		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
 		return -ENOMEM;
 	}
 
-	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
+	if (id->vendor == HID_ANY_ID
+			&& id->product == HID_ANY_ID
+			&& id->group != HID_GROUP_MULTITOUCH_WIN_8)
 		td->serial_maybe = true;
 
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
 	 */
-- 
2.18.0

