Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDC8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412FC205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1dJwHcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412FC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJIF01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:26:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53041 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeJIF01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:26:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so9513283wmw.2;
        Mon, 08 Oct 2018 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Y6AQzKkmrMguYZHrSjIJpdgCcDaZrOtGAnckA5TXr4=;
        b=A1dJwHcJvSbl7bbZpESQKOks3MrHjD98La0qd9MxQCvPw+vmcWaN3NLucDeeYgRB0L
         81zVVTVUIwsp2Xil9KL+lkQ//FuoosIUtJfOM/SsKNnXV6mUpDNlC6PJpIgia9Y7jcVt
         1Mb3tUF319zK5oyhgDxD6SzHW2oGMIxRlsyUFhSnWdiZ3zIlX6CW6Ok18eV988TrS/Gb
         dB72bp52DPgkFgvkfKQyt8gjTv2AoCD0mcOcsi26b9+aqdUrOdKDfn6J6W35WrabNg2U
         R2DhNfiflepB5p0N7Ak30fUEDoWr6Af0TT1syV1EDgCUv8Hio+vEIYZyTHCThSprhrsC
         dyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Y6AQzKkmrMguYZHrSjIJpdgCcDaZrOtGAnckA5TXr4=;
        b=RGoj0r1Fc02sRe8R/MjC0nwKL/c/btN7a+FKo8VjKqS9g5pZUiCD7dGe+9BOXUwkHn
         /+vgyuyM3ELsq06X01LkCybFQTzFOVcwao9QP9YXfl+cyDLFFAvE8P+4HCVctpI6zSs1
         k0GV9jAjKuXkJKJ/v66q1J+hwNgS4comp660OdRzPyDDkRD3BJuVHSgTDJYV5tQHSYtm
         j+6KJ6DPqrBmPQoDxFckP3I9Oj4t+zbKVL3InRKlC7br32wSGi4S6pWxKTSA8O8cntH4
         k65KQ3iisa8Ni3BarsK56y0o7T148m3x/pt1SArcw/8Nf4Jepde71JYwqq3Fr/mohy/u
         YICw==
X-Gm-Message-State: ABuFfoghvC2MFwz3vAzanhmBaHT7n1qDKMPyoF14PtdW9lH7ab232WOe
        OeQIhz/RxZxXRFWK0Mm3e6g=
X-Google-Smtp-Source: ACcGV61tMuKz3jNzK9tEIB/nKUYJO4z8WBX7nAaJuD7f+H6qaF8yhyMyhxiNW6QDVK4HE0qmY38qWw==
X-Received: by 2002:a1c:5801:: with SMTP id m1-v6mr16118134wmb.118.1539036753214;
        Mon, 08 Oct 2018 15:12:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 18-v6sm22336775wmw.26.2018.10.08.15.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 15:12:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mats Randgaard <matrandg@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: tc358743: Remove unnecessary self assignment
Date:   Mon,  8 Oct 2018 15:11:28 -0700
Message-Id: <20181008221128.22510-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/media/i2c/tc358743.c:1921:7: warning: explicitly assigning value
of variable of type 'int' to itself [-Wself-assign]
                ret = ret;
                ~~~ ^ ~~~
1 warning generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/i2c/tc358743.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index ca5d92942820..41d470d9ca94 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -1918,7 +1918,6 @@ static int tc358743_probe_of(struct tc358743_state *state)
 	ret = v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep), &endpoint);
 	if (ret) {
 		dev_err(dev, "failed to parse endpoint\n");
-		ret = ret;
 		goto put_node;
 	}
 
-- 
2.19.0

