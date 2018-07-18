Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4508DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E7C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E7C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeGRITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:19:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbeGRITO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:19:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A9A0311CEFB1;
        Wed, 18 Jul 2018 15:42:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 15:42:19 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>,
        <herbert@gondor.apana.org.au>
CC:     <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>, <arnd@arndb.de>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH 0/5] crypto: add IV generation templates
Date:   Wed, 18 Jul 2018 15:30:50 +0800
Message-ID: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the iv generation algorithms are implemented in dm-crypt.c.
This patchset moves these algorithms from the dm layer to the kernel
crypto layer by implementing them as template ciphers so they
can be implemented in hardware for performance. We modify the dm layer
to send a whole 'bio' rather than a sector at a time, so the dm layer
needs to called into the crypto layer less times. Each bio contains an
in memory representation of physically contiguous disk blocks. The dm
layer sets up a chained scatterlist of these blocks split into physically
contiguous segments in memory so that DMA can be performed.

This patchset is based on the patchset originally started by
Binoy Jayan <binoy.jayan@linaro.org>
( crypto: Add IV generation algorithms
https://patchwork.kernel.org/patch/9803469/ )

I tested the performance of software implemented ciphers before and after
applying this patchset. The performance didn't change much except for 
slight regression when writting. The detail information is as follows.

The command I used:
cryptsetup -y -c aes-xts-plain -s 256 --hash sha256 luksFormat /dev/sdd1
cryptsetup -y -c aes-cbc-essiv:sha256 -s 256 --hash sha256 luksFormat /dev/sdd1
cryptsetup -y -c aes-cbc-benbi -s 256 --hash sha256 luksFormat /dev/sdd1

cryptsetup luksOpen /dev/sdd1 crypt_fun
time dd if=/dev/mapper/crypt_fun of=/dev/null bs=1M count=500 iflag=direct
time dd if=/dev/zero of=/dev/mapper/crypt_fun bs=1M count=500 oflag=direct

Performance comparision:
--------------------------------------------------------
algorithms	| before applying   | 	after applying
--------------------------------------------------------
		|  read  | write    |  read  | write
--------------------------------------------------------
aes-xts-plain 	| 145.34 | 145.09   | 145.89 | 144.2 
--------------------------------------------------------
aes-cbc-essiv 	| 146.87 | 144.62   | 146.74 | 143.41
--------------------------------------------------------
aes-cbc-benbi 	| 146.03 | 144.74   | 146.77 | 144.46
--------------------------------------------------------

Xiongfeng Wang (5):
  crypto: api - introduce API to (un)register a array of templates
  crypto: ccm - use template array registering API to simplify the code
  crypto: gcm - use template array registering API to simplify the code
  crypto: Add IV generation templates
  dm-crypt: modify dm-crypt to rely on IV generation templates

 crypto/Kconfig          |    7 +
 crypto/Makefile         |    1 +
 crypto/algapi.c         |   27 +
 crypto/ccm.c            |   82 +-
 crypto/gcm.c            |   76 +-
 crypto/geniv.c          | 2240 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/Kconfig      |    1 +
 drivers/md/dm-crypt.c   | 1697 ++++++++---------------------------
 include/crypto/algapi.h |    2 +
 include/crypto/geniv.h  |   47 +
 10 files changed, 2722 insertions(+), 1458 deletions(-)
 create mode 100644 crypto/geniv.c
 create mode 100644 include/crypto/geniv.h

-- 
1.7.12.4

