Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5530E2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5530E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJCWXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:23:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33993 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:23:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so1756629pgs.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVPjsqg7h7ECUpnPz4+gQaOCquxaFji9J+6klIEax60=;
        b=GSIK+/qWIlUIkZYeldUMecLWiKXPjRtbLBXsF/+XpEolkfRJrlmxkGn4D2OaQTtjfz
         lIuLKIZuDLsDUuBgkg6tBGYsJ3OorSzc4/gs+jQwBqWCO7EO3iqDKRk7ro0uxJs7MG0G
         7aYS/DxymLhRLJT49DY7PlE75TSXFbJLz5OupIUunM0H+lzaqgeqN+S6IFfBtvXUjVhu
         xyZwx8pXMSEGJlukidSGBojSqiZxTF50PpvkafTEP9A2tK+oiCiBNu9Ur5KkdyqH6prK
         ImDcYKg0DQa8xaFWz1n692lg1NSVIk+Qdwum79yO4+9/fy1FFYUGr1gPaNVt59cdhVGQ
         WuoQ==
X-Gm-Message-State: ABuFfojs6qi0ygbUYERfygLCVV8ZFt3RhXwm3aPmX93EVGzr6rg0fAfg
        OTnXcmIe/76tUD7Eap4aOWE=
X-Google-Smtp-Source: ACcGV62li7RV65MRRH6bVesnPD+F+aIOzaH1JuIUcz2txalcNRoBWY/xZGexTa1NP6ITFejCrbEg7w==
X-Received: by 2002:a63:e943:: with SMTP id q3-v6mr1864103pgj.42.1538580898756;
        Wed, 03 Oct 2018 08:34:58 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n79-v6sm6990654pfk.19.2018.10.03.08.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:34:57 -0700 (PDT)
Message-ID: <1538580896.205649.12.camel@acm.org>
Subject: Re: [PATCH 6/6] lib/scatterlist: Fix overflow check in
 sgl_alloc_order
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Date:   Wed, 03 Oct 2018 08:34:56 -0700
In-Reply-To: <20180926141625.17727-7-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
         <20180926141625.17727-7-tvrtko.ursulin@linux.intel.com>
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
+AD4 It is necessary to ensure types on both sides of the comparison are of the
+AD4 same width. Otherwise the check overflows sooner than expect due left hand
+AD4 side being an unsigned long length, and the right hand side unsigned int
+AD4 number of elements multiplied by element size.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

