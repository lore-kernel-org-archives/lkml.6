Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EC02087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5H132ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EC02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJEBsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:48:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44685 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeJEBsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:48:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so11025600wra.11;
        Thu, 04 Oct 2018 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2w39VPGeACVECakpqzPDeuelU4Bi3JR8Jg1vqW985jw=;
        b=h5H132ta9H3AEe9O7xOn4T2LgabzDhkvHYLfrbEMJvF732hPvyP5rMlGmvk2XDfKqI
         UHeuZwoW4pwATKetDm+grZ+P9sykyzf/NeRVFiAsIrIEA/Vx1sRPg2TU8gFO6xwjPHeY
         S669eDS8/KIHOBPsdszWzL+laa5IFP1p+eVPErnweuYhLHry2En3T7Wy1zaPQ+Rd3K5/
         xQFzvT9ZeUdyiBoVsruV19VKTK3SHJtmHp/cVbIt10qNygCszclZOspLAMyTBehMk7h9
         CiGgZIn4OKGAyAecRLt0wKd+hJpaAFYlqFp6KeoBOYs5IpRpQRdU8GoMKJl/Ea3SuqQt
         LFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2w39VPGeACVECakpqzPDeuelU4Bi3JR8Jg1vqW985jw=;
        b=TXdHupYB2fgCgdlB7y+J0ouNWfSbalhbLc74voGvXjY/xJuN0xo7iv3vLBtjw2z1Da
         wea4bZiIK3Usw5UwmN/C6c96OcElEdLCbL5UqDvbFr7uZMsJTMLInBaQw3vbhvaCB1Ev
         mw+50ZaebO2QHNLbBgDkt1YTzg+GetrhVHksAvtDCfOkkLnmTXw3UelA/jlw9lYOX9uW
         QMMJzwcL49uMejdWOli0lVc5ij2mAl0wR1ZU1tO/QSiXokE3mJ9MiyRlCQpKvIBJcLjT
         3xGJo4yHTbm8ju4bgP3gdScIrHCLIgFR5Wy6xTNbIlcoMseIUMpY2fq5haj3zT1lL2KB
         mYFQ==
X-Gm-Message-State: ABuFfoj1iee9qUuIDfCLQvzAY4XxSv+bWgCb2HKdjCSKRjL3uIBFjTgq
        8QvPEoOZCSYvfNlmNGFcItv/vnrY
X-Google-Smtp-Source: ACcGV63ebzZkrTsC4M0E+KgXK27pNI0wzHfpKu4Zrz5WcYih89XLdysX1qz1NNeTY8qHXZuX3NVvYA==
X-Received: by 2002:a5d:53c3:: with SMTP id a3-v6mr5840384wrw.191.1538679251970;
        Thu, 04 Oct 2018 11:54:11 -0700 (PDT)
Received: from mappy.world.mentorg.com (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id h78-v6sm8706877wmd.4.2018.10.04.11.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:54:11 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/11] media: videodev2.h: Add more field helper macros
Date:   Thu,  4 Oct 2018 11:53:51 -0700
Message-Id: <20181004185401.15751-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004185401.15751-1-slongerbeam@gmail.com>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds two helper macros:

V4L2_FIELD_IS_SEQUENTIAL: returns true if the given field type is
'sequential', that is a full frame is transmitted, or exists in
memory, as all top field lines followed by all bottom field lines,
or vice-versa.

V4L2_FIELD_IS_INTERLACED: returns true if the given field type is
'interlaced', that is a full frame is transmitted, or exists in
memory, as top field lines interlaced with bottom field lines.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v3:
- none
Changes since v2:
- none
Changes since v1:
- add the complement macro V4L2_FIELD_IS_INTERLACED
- remove V4L2_FIELD_ALTERNATE from V4L2_FIELD_IS_SEQUENTIAL macro.
- moved new macros past end of existing V4L2_FIELD_HAS_* macros.
---
 include/uapi/linux/videodev2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 29729d580452..f7f031736d91 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -130,6 +130,13 @@ enum v4l2_field {
 	((field) == V4L2_FIELD_BOTTOM ||\
 	 (field) == V4L2_FIELD_TOP ||\
 	 (field) == V4L2_FIELD_ALTERNATE)
+#define V4L2_FIELD_IS_INTERLACED(field) \
+	((field) == V4L2_FIELD_INTERLACED ||\
+	 (field) == V4L2_FIELD_INTERLACED_TB ||\
+	 (field) == V4L2_FIELD_INTERLACED_BT)
+#define V4L2_FIELD_IS_SEQUENTIAL(field) \
+	((field) == V4L2_FIELD_SEQ_TB ||\
+	 (field) == V4L2_FIELD_SEQ_BT)
 
 enum v4l2_buf_type {
 	V4L2_BUF_TYPE_VIDEO_CAPTURE        = 1,
-- 
2.17.1

