Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ACA21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYH93yrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ACA21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeINTiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:38:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:38:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so10769450wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=202+GwpKrSsi+oCMwBSmc5iv2ix8J+LHnuiDke6OVOQ=;
        b=AYH93yrgf12orjRbPXMPjJzjvHxzl+uQb6fyaQDDKOt5+5dGTOE6MIx6Qd16V0bNoA
         oE4nbxF/YakHomYqmywiWdxW4Wu2Dwt8BVN2a7E6+UtxgpHaqEwL0SqQSGI83ciIkiTz
         r/tOcJSmnFrwWUYCyUoRqZdPScc6+OBs7zBis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=202+GwpKrSsi+oCMwBSmc5iv2ix8J+LHnuiDke6OVOQ=;
        b=MY4ZHZ0oT4L6P6XzFVhJhVrxeKX3sOWJa28tCTQIKoL3ffHvhUlGbhQdrd+y+yw/Ln
         kgeAM9ZeoLcxVb3zQdHhq5BeYfZ+WUuo3DAR3CIcHJB5gODzPjjRqQ9PChWByCujZXJ/
         qVrM/HGEXjy/HA3j1Ix03IgaX9c/4oCHP6fREIwSZum/U5/Daw0BVKisUkmfDairCOS4
         Gjwdugz7/JTW1MPoGRgFNX5HX/6ndyO0gU4vGxY4z5fA6oEfbQcRZh8AUK2gRrYqgOtC
         WHg77wxclamX0z8WwE7YVQVmCfwM3LjzouqjxbbpPHZsM+a95K8HfKJXsCbtsVvz/uMD
         eYvQ==
X-Gm-Message-State: APzg51Caz7gkCCSwpnFtktsPODmcJVUqLhVMrOuO5o6fNAoQoZ18qSSE
        dfbmIe7Ep0gnJMxU82kP05DoWg==
X-Google-Smtp-Source: ANB0VdbcK1fz6XAdgzj1pVV/3fM0+Nzg5atOQ0cMgiRuKmadJm3FzENZF1esz7qFaRXq+WymGN9ZaA==
X-Received: by 2002:adf:dfca:: with SMTP id q10-v6mr9184060wrn.113.1536934998238;
        Fri, 14 Sep 2018 07:23:18 -0700 (PDT)
Received: from wifi-122_dhcprange-84.wifi.unimo.it (wifi-122_dhcprange-84.wifi.unimo.it. [155.185.122.84])
        by smtp.gmail.com with ESMTPSA id k35-v6sm17084888wrc.14.2018.09.14.07.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:23:17 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/3] bfq: one fix and two important improvements for throughput
Date:   Fri, 14 Sep 2018 16:23:06 +0200
Message-Id: <20180914142309.6789-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
the second and third patch in this series provide two important
improvements in bfq's ability to boost throughput with random I/O. The
benefits of the second patch concern I/O control, and are described in
detail in this LWN article [1] (and briefly in the commit message
itself). The benefits of the other patch should be
straightforward. Finally, the first patch fixes an I/O-control bug,
found while making the second patch.

These patches modify somehow core operations of bfq, so, before
submitting them, I have tested them a lot, and have had them tested by
other people too. In particular, during these months, they have been
tested in systems ranging from PCs to development platforms.

Thanks,
Paolo

[1] https://lwn.net/Articles/763603/

Paolo Valente (3):
  block, bfq: correctly charge and reset entity service in all cases
  block, bfq: inject other-queue I/O into seeky idle queues on NCQ flash
  blok, bfq: do not plug I/O if all queues are weight-raised

 block/bfq-iosched.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h | 26 ++++++++++++++++++
 block/bfq-wf2q.c    | 13 ++++++---
 3 files changed, 106 insertions(+), 11 deletions(-)

--
2.16.1
