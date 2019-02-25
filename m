Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5496C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfBYVqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:46:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45697 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731869AbfBYVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:46:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so9227199ota.12;
        Mon, 25 Feb 2019 13:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yw/7y3kVbWxx+Impqh/A1MkvvT2GqX10ydWL44s8z3c=;
        b=il2OOKuBxPChSsCleg/tuJek5T+oIF5SLPLY5er++A1TjgWuNnBxj401+BWnI7XKaL
         QMR4IplffbCIN49hWhIKAXOfhWRaBsKK/HZzLrtRhxH4klZWOLhX66s7CKdhqLd94ucF
         fZlIW9o4wRLlkkice4no6Ujf7lOVhqSJIA2dHLFbWspevVgv9FdJ9/RR0alda2HwBzFT
         OCpAMg6DP1I+IByPkTbJcmedyg2ALRVpWZHSrXO/TVYWnLCtkOCHrJko/1XMEruLDZPj
         Tb1YAkNihUaHVosTZJAp4oYBOwYnouLZK13tWN6FADfqK7nhfsamidUqoXDoPjT7eRCF
         cONQ==
X-Gm-Message-State: AHQUAub0wj7N4YvUESstDFPNAU5XKd05BVpOd05BdeyrLA73XTrzoWII
        YvHL0wctdNSxoPZ6J7Atl7RGf7UB
X-Google-Smtp-Source: AHgI3IYJHw1a4/k+kmuGGoWAAy4emvLQ/WOrz8cEP8wcQN2pM4rol+hTnb6EGMPhfEeHKE/SdTwc0Q==
X-Received: by 2002:a9d:6f97:: with SMTP id h23mr13438816otq.26.1551131199388;
        Mon, 25 Feb 2019 13:46:39 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id v8sm4393598otq.4.2019.02.25.13.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 13:46:38 -0800 (PST)
Subject: Re: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190218183302.1242676-1-haakon.bugge@oracle.com>
 <38187795-4082-42C2-AF56-E6C89EE7DE39@oracle.com>
 <66C92ED1-EE5E-4136-A7D7-DBF8A0816800@oracle.com>
 <20190220171441.GH8429@ziepe.ca>
 <A7FA2738-ACD2-42C7-A0AF-4343583CF87E@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <602b7707-37d1-5e36-13e3-0911d5f35021@grimberg.me>
Date:   Mon, 25 Feb 2019 13:46:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A7FA2738-ACD2-42C7-A0AF-4343583CF87E@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I was thinking of the stuff in core/cq.c - but it also doesn't have
>> automatic comp_vector balancing. It is the logical place to put
>> something like that though..
>>
>> An API to manage a bundle of CPU affine CQ's is probably what most
>> ULPs really need.. (it makes little sense to create a unique CQ for
>> every QP)
> 
> ULPs behave way differently. E.g. RDS creates one tx and one rx CQ per QP.
> 
> As I wrote earlier, we do not have any modify_cq() that changes the comp_vector (EQ association). We can balance #CQ associated with the EQs, but we do not know their behaviour.
> 
> So, assume 2 completion EQs, and four CQs. CQa and CQb are associated with the first EQ, the two others with the second EQ. That's the "best" we can do. But, if CQa and CQb are the only ones generating events, we will have all interrupt processing on a single CPU. But if we now could modify CQa.comp_vector to be that of the second EQ, we could achieve balance. But not sure if the drivers are able to do this at all.
> 
>> alloc_bundle()
> 
> You mean alloc a bunch of CQs? How do you know their #cqes and cq_context?
> 
> 
> Håkon
> 
> 
>> get_cqn_for_flow(bundle)
>> alloc_qp()
>> destroy_qp()
>> put_cqn_for_flow(bundle)
>> destroy_bundle();
>>
>> Let the core code balance the cqn's and allocate (shared) CQ
>> resources.
>>
>> Jason
> 

I sent a simple patchset back in the day for it [1], IIRC there was
some resistance of having multiple ULPs implicitly share the same
completion queues:

[1]:
--
RDMA/core: Add implicit per-device completion queue
  pools

Allow a ULP to ask the core to implicitly assign a completion
queue to a queue-pair based on a least-used search on a per-device
cq pools. The device CQ pools grow in a lazy fashion with every
QP creation.

In addition, expose an affinity hint for a queue pair creation.
If passed, the core will attempt to attach a CQ with a completion
vector that is directed to the cpu core as the affinity hint
provided.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
--

That one added implicit QP create flags:
--
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bdb1279a415b..56d42e753eb4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1098,11 +1098,22 @@ enum ib_qp_create_flags {
         IB_QP_CREATE_SCATTER_FCS                = 1 << 8,
         IB_QP_CREATE_CVLAN_STRIPPING            = 1 << 9,
         IB_QP_CREATE_SOURCE_QPN                 = 1 << 10,
+
+       /* only used by the core, not passed to low-level drivers */
+       IB_QP_CREATE_ASSIGN_CQS                 = 1 << 24,
+       IB_QP_CREATE_AFFINITY_HINT              = 1 << 25,
+
--

Then I modified it to add a ib_cq_pool that a ULP can allocate
privately and then get/put CQs from/to.

[2]:
--
IB/core: Add a simple CQ pool API

Using CQ pools is useful especially for target/server modes.
The server/target implementation will usually serve multiple clients
and will usually have an array of completion queues allocated for that.

In addition, usually the server/target implementation will use a least-used
scheme to select a completion vector to each completion queue in order
to acheive better parallelism.

Having the server/target rdma queue-pairs share completion queues as
much as possible is desirable as it allows for better completion 
aggragation.
One downside of this approach is that some entries of the completion queues
might never be used in case the queue-pairs sizes are not fixed.

This simple CQ pool API allows for both optimizations and exposes a simple
API to alloc/free a completion queue pool and get/put from the pool.

The pool starts by allocating a caller-defined batch of CQs, and grows
in batches in a lazy fashion.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
--

That one had the CQ pool API:
--
+struct ib_cq_pool *ib_alloc_cq_pool(struct ib_device *device, int nr_cqe,
+                       int nr_cqs, enum ib_poll_context poll_ctx);
+void ib_free_cq_pool(struct ib_cq_pool *pool);
+void ib_cq_pool_put(struct ib_cq *cq, unsigned int nents);
+struct ib_cq *ib_cq_pool_get(struct ib_cq_pool *pool, unsigned int nents);
--

I can try to revive this if this becomes interesting again to anyone..

Thoughts?
