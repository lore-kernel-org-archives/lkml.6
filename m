Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E12C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1825408
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW2+rhEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D1825408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965063AbeGBJQ4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:16:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46460 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965025AbeGBJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so4164891pfl.13;
        Mon, 02 Jul 2018 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oMS3hA9htItMv93br0dVmXeJfI8MRo73xnLRtlsbQA=;
        b=pW2+rhEewdZ9vk7yFNAGnPRDCWhsKM8EqqgG3u36CSqx9ar+N/AtxHkgFiTflDxbT4
         dany3y1uVD+WwH5mwqs1e+4yYi8zfqcPl6XFyIbUb63G9KtNyAY0X+YRYMJRJwd6RWfU
         ZZed2SgZ4QmBC/S1x0PBe2f4bgEw+iLZ7a6R0AKJsy0JJJRzq4gwYbUS3DPlRyPsvglZ
         SFP5QgS6bSEyEUQa+TwzGx7C1kSgCwTfH4lCqHM09v4s739OLqq3JYe7cRuS+PIg2lja
         xPxC1kQUzpkUmMJjKNgIpqCWV3MQqOF/hZq1A0xyWn+YW022RTzjjCHtA1o7CbRvMah4
         k96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oMS3hA9htItMv93br0dVmXeJfI8MRo73xnLRtlsbQA=;
        b=MEyhImbb4sBcXFidMaHzk7CDJPlC08H694yahpJfI7KbZOr5nV3gm8QPjTfTQ5h7Lf
         W0Wf3WYSj1oOjEBAmjXg9OKTWP/Rx2tsLrsLCyB9gZcF4flI2Q02ngiSYFsXRF0ESD3x
         iYp/dCf+IrTCSHmPlwtiTLUnY1RdoEsFwKDCRm+4MQCaVnAW5a/94n3Yz9Tfw210Porl
         GY3acUa1d6FZs3Abiy0PLboKOLz9FpWqZPaVuBHERYoHonQBXzh7kYd7Kp72wagXgCb3
         nr4DrIX6PRND//55Sk4thlM05OUGypapxT1onoJpS7VS/t4Vc1lKRJIvmcU3s56ZZA4o
         bpng==
X-Gm-Message-State: APt69E3Ou/CB3e7fW/GQKEn9dfwjbxk3WThYiz/TH9JGS4IAyp7b166F
        aA5/WX70KY5KaYe31F4AfxY=
X-Google-Smtp-Source: ADUXVKKcGvhPXGyGQNmGm7IfcrnWGxuENT9QTu0wRk0Xl6l1dj88QbrjKMA3VPYCjrwgcoRy32d9Zg==
X-Received: by 2002:a63:416:: with SMTP id 22-v6mr21168962pge.229.1530523010548;
        Mon, 02 Jul 2018 02:16:50 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 67-v6sm24527627pga.9.2018.07.02.02.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 02:16:49 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Teng Qin <qinteng@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 0/4] samples/bpf: simple fixes
Date:   Mon,  2 Jul 2018 18:14:49 +0900
Message-Id: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This patchset fixes trivial things that I found
when testing 'samples/bpf/' sample code.
I'd appreciate it, if you review this.

Thanks,
Taeung

Taeung Song (4):
  samples/bpf: add missing <linux/if_vlan.h>
  samples/bpf: Check the result of system()
  samples/bpf: Check the error of write() and read()
  samples/bpf: add .gitignore file

 samples/bpf/.gitignore           | 49 ++++++++++++++++++++++++++++++++++++++++
 samples/bpf/parse_varlen.c       |  6 +----
 samples/bpf/test_overhead_user.c | 20 ++++++++++++----
 samples/bpf/trace_event_user.c   | 27 +++++++++++++++++++---
 4 files changed, 89 insertions(+), 13 deletions(-)
 create mode 100644 samples/bpf/.gitignore

-- 
2.7.4

