Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22538C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE04520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE04520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967931AbeFRIfi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:35:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967323AbeFRIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:35:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A3067C8A;
        Mon, 18 Jun 2018 08:35:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 109/189] nvme: fix potential memory leak in option parsing
Date:   Mon, 18 Jun 2018 10:13:25 +0200
Message-Id: <20180618081213.654738489@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -587,6 +587,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->transport);
 			opts->transport = p;
 			break;
 		case NVMF_OPT_NQN:
@@ -595,6 +596,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->subsysnqn);
 			opts->subsysnqn = p;
 			nqnlen = strlen(opts->subsysnqn);
 			if (nqnlen >= NVMF_NQN_SIZE) {
@@ -617,6 +619,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->traddr);
 			opts->traddr = p;
 			break;
 		case NVMF_OPT_TRSVCID:
@@ -625,6 +628,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->trsvcid);
 			opts->trsvcid = p;
 			break;
 		case NVMF_OPT_QUEUE_SIZE:
@@ -706,6 +710,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -EINVAL;
 				goto out;
 			}
+			nvmf_host_put(opts->host);
 			opts->host = nvmf_host_add(p);
 			kfree(p);
 			if (!opts->host) {
@@ -731,6 +736,7 @@ static int nvmf_parse_options(struct nvm
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->host_traddr);
 			opts->host_traddr = p;
 			break;
 		case NVMF_OPT_HOST_ID:


