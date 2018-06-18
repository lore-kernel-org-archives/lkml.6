Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D910E20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D910E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965628AbeFRIW5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965596AbeFRIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB3ACC7F;
        Mon, 18 Jun 2018 08:22:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 165/279] nvme: fix potential memory leak in option parsing
Date:   Mon, 18 Jun 2018 10:12:30 +0200
Message-Id: <20180618080615.649253719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit 59a2f3f00fd744dbad22593f47552037d3154ca6 ]

When specifying same string type option several times,
current option parsing may cause memory leak. Hence,
call kfree for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fabrics.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -668,6 +668,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->transport);
 			opts->transport = p;
 			break;
 		case NVMF_OPT_NQN:
@@ -676,6 +677,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->subsysnqn);
 			opts->subsysnqn = p;
 			nqnlen = strlen(opts->subsysnqn);
 			if (nqnlen >= NVMF_NQN_SIZE) {
@@ -698,6 +700,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->traddr);
 			opts->traddr = p;
 			break;
 		case NVMF_OPT_TRSVCID:
@@ -706,6 +709,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->trsvcid);
 			opts->trsvcid = p;
 			break;
 		case NVMF_OPT_QUEUE_SIZE:
@@ -792,6 +796,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -EINVAL;
 				goto out;
 			}
+			nvmf_host_put(opts->host);
 			opts->host = nvmf_host_add(p);
 			kfree(p);
 			if (!opts->host) {
@@ -817,6 +822,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->host_traddr);
 			opts->host_traddr = p;
 			break;
 		case NVMF_OPT_HOST_ID:


