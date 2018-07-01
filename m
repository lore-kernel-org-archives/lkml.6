Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB3C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CE8257EA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CE8257EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeGASFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:05:24 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53482
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965704AbeGASEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:04:49 -0400
X-IronPort-AV: E=Sophos;i="5.51,295,1526335200"; 
   d="scan'208";a="271074622"
Received: from palace.rsr.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jul 2018 20:04:44 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-usb@vger.kernel.org, joe@perches.com,
        Chengguang Xu <cgxu519@gmx.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/3] cast sizeof to int for comparison
Date:   Sun,  1 Jul 2018 19:32:02 +0200
Message-Id: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@safe disable not_int2@
int x;
position p;
binary operator op = {<,<=};
expression e;
@@

(
x < 0 || (x@p op e)
|
x <= 0 || (x@p op e)
|
x > 0 && (x@p op e)
|
x >= 0 && (x@p op e)
)

@@
int x;
type t;
expression e,e1;
identifier f != {strlen,resource_size};
position p != safe.p;
binary operator op = {<,<=};
@@

*x = f(...);
... when != x = e1
    when != if (x < 0 || ...) { ... return ...; }
(
*x@p op sizeof(e)
|
*x@p op sizeof(t)
)
// </smpl>

---

 drivers/input/mouse/elan_i2c_smbus.c |    2 +-
 drivers/media/usb/gspca/kinect.c     |    2 +-
 drivers/usb/wusbcore/security.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
