Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A69C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8A521773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1vmBKsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBIMZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:25:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35788 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:25:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so5571870qtk.2;
        Sat, 09 Feb 2019 04:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5u2/GAeioG7owoyFoQbxP+8qPTyM3dGvgZ7aD2b1OEo=;
        b=N1vmBKsav68a9OaBk5itoPsPF1pxc9/O/jDljvkDeIZn955qdQiW+3uq3X76bIlQHU
         LMvYsUy0CU5JC4sHJH1UO5LdDXmsm9lX6kxz+6jNisDeoU7R5PtF+dcW+zXnD6BMzBdb
         IRBgId8OfVjCikucn4r3BrcCheuOLomBYcxzWFQpW+cu8sshaq+nN1Xz1X90V0hh1TVy
         kGncy2QAdZrIorz9uaklZRWnG9AClP3DK0dk+Fj9J3zma0WKLELilYrNBu7IGKwWFafI
         DE0ZupcOUqtMeMtZ46sfy9tkO2FlfX5bPRGSTtBycrdEQkp/mU3OiolVQCgxx4BTlL9u
         9DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5u2/GAeioG7owoyFoQbxP+8qPTyM3dGvgZ7aD2b1OEo=;
        b=BUqsAWs1gwRENxVvEzfHbDSOx/2FJBFuulrYQb0w149HNw/V8M6ojPppW0usB4S7tt
         GW6aAGiCUCFoAyY3c69UX2w7dedTsEIuunKZgi3UuROWFvMrdwmko5Tq4J/Pm5HRDDQS
         Qf4l0Vbe6OM8HdvutbJO+oP5peqKe9859MZ5hVKvzfzRyO9bxyPaqTZpDdMcRDuFawNV
         N+LZs6ahYXgTOoPpyb+ESldbS2QxDMeq1dUcC1lkApTbtjSXAgJ3tcOFxZh7Oh1Q3EnW
         9PbnCw9qskjl8ECUwHj6IPFFrC/qDvbRmn7dWvQFJGOQVtIlhUezygnBeVTSwiX319Q8
         8PiA==
X-Gm-Message-State: AHQUAuYyGZG5Fu9roTCIZ6FYoDGjnL4q0/0JUahnJSWs1NKA2pldy+Km
        9fTkO8fKuIaoiWVQmRQXdzk=
X-Google-Smtp-Source: AHgI3IYIgwktQVxnunn090pxbyqxRjL/LRLJ7NmkzFNlY5VMasTgn6IK3YxrhgdWYjSHSOs6/pQm8w==
X-Received: by 2002:a0c:d6ca:: with SMTP id l10mr206861qvi.247.1549715158472;
        Sat, 09 Feb 2019 04:25:58 -0800 (PST)
Received: from localhost.localdomain ([191.255.193.149])
        by smtp.gmail.com with ESMTPSA id g3sm4313286qkc.54.2019.02.09.04.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 04:25:57 -0800 (PST)
From:   Luciana da Costa Marques <lucianadacostamarques@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Luciana da Costa Marques <lucianadacostamarques@gmail.com>
Subject: [PATCH v2] iio:accel:adxl345: Change alignment to match paranthesis
Date:   Sat,  9 Feb 2019 10:25:42 -0200
Message-Id: <20190209122542.4872-1-lucianadacostamarques@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align broken line to match upper line parenthesis. Solves the
checkpatch.pl's message:

CHECK: Alignment should match open parenthesis

Signed-off-by: Luciana da Costa Marques <lucianadacostamarques@gmail.com>
---
 changes in v2:
 - add full name to commit author

 drivers/iio/accel/adxl345_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 780f87f72338..f03ed00685ea 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -150,8 +150,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 }
 
 static int adxl345_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
 	s64 n;
-- 
2.17.1

