Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54254C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F6523F14
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F6523F14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeF0Ipq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:45:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35721 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeF0Ipm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:45:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id c13-v6so1148040wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 01:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DHTJZ1B5k7KZ37vXVFj/T/s8C3f54StnBN+mpHyt/rw=;
        b=T9QoWRqtyjOF4GZmw4dtrOLG9RQXB2wSKjV/NQQoZQSQ1CkhP/uh+UExL5sy5SHA08
         x160FPXVYkatlu/C3MF73GP7dnEeI7221zkGHvXr1gTnWT87VdSvHO9SNCMpXOybQUeH
         VRrQ2ZXpOugicFXJWtNuYW4dKTKPvOIcAWMgy2MDwSk7ySLKDQrbjnCTAEX1mMvfX1HR
         36ERtFDxVI/QP/Tqi48KkgLVrUhZjfJ8EFeQc6ZXt5RaMbFQhky+/x3TwasW7rnKixLV
         CRr543BTWwquIOboTa0AWUwdXrGHrrNLVw4ryleYs/dkorbGAcLYILvn5DHZPRktgyb8
         Uwmg==
X-Gm-Message-State: APt69E3sBv+BXdD8VOF0I+zOcEuiTWMhb0vF5e8lGs2vMT5IIHwBqoQ8
        btS9qpqYcIr6KWl3Kva4XSE=
X-Google-Smtp-Source: AAOMgpfaRr+kqdNsJ0QaH4XqEOcd88sj5a0D6+LzfHRnO7NeD7TJIZMLmC5jdv+hrNBcUjCtWCajCA==
X-Received: by 2002:adf:c104:: with SMTP id r4-v6mr4414373wre.203.1530089141550;
        Wed, 27 Jun 2018 01:45:41 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m3-v6sm3072135wro.27.2018.06.27.01.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 01:45:40 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@linux.intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-2-jthumshirn@suse.de>
 <20180626145532.GA6628@localhost.localdomain>
 <20180627073511.og4xsmt2o2pqagit@linux-x5ow.site>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7958c766-c99e-ed07-3764-fdb82fd73c94@grimberg.me>
Date:   Wed, 27 Jun 2018 11:45:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627073511.og4xsmt2o2pqagit@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> @@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>>   	}
>>>   
>>>   	cmd->common.command_id = req->tag;
>>> +	nvme_req(req)->ctrl = ctrl;
>>>   	if (ns)
>>>   		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
>>>   	else
>>
>> I don't think we need to do this per-io. The request coming from the
>> controller's tagset, so we can do this just once at .init_request time,
>> right?
> 
> Agreed, but as it's Sagi's patch I'd like to hear his opinion on this
> before changing it.

That's a good idea!

seems to work... Johannes, can you respin with this version?
Please CC james and keith on it too.
--
     nvme: cache struct nvme_ctrl reference to struct nvme_request

     We will need to reference the controller in the setup and
     completion time for tracing and future traffic based keep alive
     support.

     Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 41d45a1b5c62..9cc33752539a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1737,6 +1737,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, 
struct request *rq,
         int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
         struct nvme_fc_queue *queue = &ctrl->queues[queue_idx];

+       nvme_req(rq)->ctrl = &ctrl->ctrl;
         return __nvme_fc_init_request(ctrl, queue, op, rq, queue->rqcnt++);
  }

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..f2249387b60d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,7 @@ struct nvme_request {
         u8                      retries;
         u8                      flags;
         u16                     status;
+       struct nvme_ctrl        *ctrl;
  };

  /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..d2bd60d8315a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -418,6 +418,7 @@ static int nvme_init_request(struct blk_mq_tag_set 
*set, struct request *req,

         BUG_ON(!nvmeq);
         iod->nvmeq = nvmeq;
+       nvme_req(req)->ctrl = &dev->ctrl;
         return 0;
  }

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 20db67d53ffa..e4087caf8754 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -292,6 +292,7 @@ static int nvme_rdma_init_request(struct 
blk_mq_tag_set *set,
                 return ret;

         req->queue = queue;
+       nvme_req(rq)->ctrl = &ctrl->ctrl;

         return 0;
  }
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..af7fbf4132b0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -227,6 +227,7 @@ static int nvme_loop_init_request(struct 
blk_mq_tag_set *set,
  {
         struct nvme_loop_ctrl *ctrl = set->driver_data;

+       nvme_req(req)->ctrl = &ctrl->ctrl;
         return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
                         (set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
  }
--
