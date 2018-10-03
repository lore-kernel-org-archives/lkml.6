Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245352089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245352089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJCWPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:15:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45534 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:15:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so1708623pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Mok85nzSbErJqtfR5DMucijQ06b1EKccbA5oFfY7fk=;
        b=Q9YO+KYosGL82MXCvRZx85x6QymUKSzXYN/FjXnSynS/PdLzyvaAARGGv4gP2vLUSQ
         LoKYbLDMoWTOr2ANtR7Clmd99G5bYQrsKC1pBHt3nx8rMrtWxYcp6MJLzCxweq8BeRuq
         n0cUQzjgmHb1+tAMWnyZDo3E7TumEV8okIH/zOKTpI86TpY87+1bKl+on+FxtiJ50WTm
         MSnwZGNIWYNplbIyAXvKpiTSpRDIFjUSgt3oPl6sn1Tl0iOCEneCeq2OBhvdVADTYZqo
         rnNVwTwgXmtW8cdGmnMdat1ldQNBb4wPgjpwtfKdBxO8v8ySPOQePBhpWe+GqPw03OHK
         gEPA==
X-Gm-Message-State: ABuFfog+pZuj1KOr9y6wCILNfBdMlLEHw24PbGiXOrMF7GXLA4E5WysH
        MCvkIHr9LtLCQK2sBa2UBn8cL0FlhPc7jQ==
X-Google-Smtp-Source: ACcGV60abuhZ2xJINtd2xaZTohBKGSktNwNV6qX2AhUQqnprQ6swrB95MCW7LYzeL3EoKN9oF8gyTA==
X-Received: by 2002:a65:614a:: with SMTP id o10-v6mr1832570pgv.387.1538580412193;
        Wed, 03 Oct 2018 08:26:52 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 23-v6sm4599345pfy.156.2018.10.03.08.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:26:51 -0700 (PDT)
Message-ID: <1538580410.205649.4.camel@acm.org>
Subject: Re: [PATCH 1/6] lib/scatterlist: Use natural long for
 sgl_alloc(_order) length parameter
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Date:   Wed, 03 Oct 2018 08:26:50 -0700
In-Reply-To: <20180926141625.17727-2-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
         <20180926141625.17727-2-tvrtko.ursulin@linux.intel.com>
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
+AD4 None of the callers need unsinged long long (they either pass in an int,
                           +AF4AXgBeAF4AXgBeAF4AXg
                           unsigned?
+AD4 u32, or size+AF8-t) so it is not required to burden the 32-bit builds with an
+AD4 overspecified length parameter.

Otherwise,

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

