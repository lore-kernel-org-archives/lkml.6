Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E0C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBEB213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBEB213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJCWRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:17:37 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40213 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:17:36 -0400
Received: by mail-pl1-f181.google.com with SMTP id 1-v6so3655297plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QK1mDocJ+4HYgAj5hZ6WlG3fGHigsb079/soliErxlo=;
        b=b/g9WG80TLzEt8YQDaOyFrLz1mnMoNF9uVTqe3ZyZJ6rKSCU9NeZp861wxyNNc0htv
         r9n3Zd3qlRSXZb8g/QCZWokRhXSXuRO0PygxKFMGp8TIFjfX+Bx7+MqicaOeWoDn2Jwf
         b5D9XIWiOm03xDSZKIiDqs3eHbr0qJPqeb+B0STEZbolHwrB2rJ/zLNsuogaBPjh2o5K
         yaW1eGKjTFGguW6vgpzoaw4FeZMk1thJBI2rIPMzhVOXtMw8tYO6K52v6kOW9+UtReck
         z/rNlRpSMzcGfJsLtg2XPkeHcCm/eBRDiB4/ErhBY6h+98G3xgthyT4Y2X/qG/zJkXiL
         IMOw==
X-Gm-Message-State: ABuFfohX3+QtQS6/e8k998DXYnDjAYUSsPiKe7Cp/Lo0kJ4fXIt6h0x6
        uDR1W5WJl5gZ7/U3s041yUs=
X-Google-Smtp-Source: ACcGV60AhpyeF0QqUDkEbjtPulPtAIyU+MVfsG1y9efJl0Y3pODPvDT1tdlCEb6jn+qJkcQ2Okmifw==
X-Received: by 2002:a17:902:aa42:: with SMTP id c2-v6mr2106063plr.119.1538580524338;
        Wed, 03 Oct 2018 08:28:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 84-v6sm7110567pfs.108.2018.10.03.08.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:28:43 -0700 (PDT)
Message-ID: <1538580522.205649.7.camel@acm.org>
Subject: Re: [PATCH 3/6] lib/scatterlist: Skip requesting zeroed allocations
 in sgl_alloc_order
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Date:   Wed, 03 Oct 2018 08:28:42 -0700
In-Reply-To: <20180926141625.17727-4-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
         <20180926141625.17727-4-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 15:16 +-0100, Tvrtko Ursulin wrote:
+AD4 From: Tvrtko Ursulin +ADw-tvrtko.ursulin+AEA-intel.com+AD4
+AD4 
+AD4 sg+AF8-init+AF8-table will clear the allocated block so requesting zeroed memory
+AD4 from the allocator is redundant.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

