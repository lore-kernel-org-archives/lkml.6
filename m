Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F960C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30A72080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30A72080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeJ3EvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:51:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeJ3EvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:51:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so4421383pgc.8;
        Mon, 29 Oct 2018 13:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cx1n4j+Ck+Eekku8O+QHHGo1WH22XlTZ9U1i2DeBsco=;
        b=spHrZbQeLoCEvkn/WxSOHDfk3ag0tQudvnpa29rrRR5KbMl4Sk7EonVEPX36HuApXk
         teqyOvolhpKGlbTmVZZp+XsX+KeQ2rufq7cNuRuYzlJ9XoEwRuZRl0GUaCjl1ZpYSNZm
         7Kai2qbMDVLi4otnw8rfC+nKy4Hhe2qONjRqbGVtLIdu1DgGvIpR912Bssoji/zAEgTh
         FKDGDke/UuejSD0a8xuPBkFF6SiRIjGQRxrA0VGPucWWuUpOESWR7V9VL+eg4UH2+WsN
         IZln6C8lb5M+aCwpCN1ea0O5crZwG17TYcrgZbmiV2rBA5G1pSYbalar078nLDSdE2u+
         DJEQ==
X-Gm-Message-State: AGRZ1gJt4NqXgzsKLpwK8PGT36dBPNW76jTNJdojbcfX2huDlpprIEGH
        SJ3HtMWMDGM8TJZ57itgkTg=
X-Google-Smtp-Source: AJdET5egf3LsgA0fxHDpz4onL727oWx5NMjpe8JZOOeiHofA3b1ZdSBZX1XityVdFV67TT0pIBU6fw==
X-Received: by 2002:a62:1693:: with SMTP id 141-v6mr17091299pfw.183.1540843252578;
        Mon, 29 Oct 2018 13:00:52 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s80-v6sm24506205pfa.114.2018.10.29.13.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 13:00:51 -0700 (PDT)
Message-ID: <1540843250.196084.93.camel@acm.org>
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 13:00:50 -0700
In-Reply-To: <ac755067-1432-54ce-6a4f-c7383f1ecc9d@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-11-axboe@kernel.dk>
         <1540842034.196084.89.camel@acm.org>
         <ac755067-1432-54ce-6a4f-c7383f1ecc9d@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 13:53 -0600, Jens Axboe wrote:
+AD4 On 10/29/18 1:40 PM, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 +AD4 +AD4 -static int cpu+AF8-to+AF8-queue+AF8-index(unsigned int nr+AF8-queues, const int cpu)
+AD4 +AD4 +AD4 +-static int cpu+AF8-to+AF8-queue+AF8-index(struct blk+AF8-mq+AF8-queue+AF8-map +ACo-qmap,
+AD4 +AD4 +AD4 +-			      unsigned int nr+AF8-queues, const int cpu)
+AD4 +AD4 +AD4  +AHs
+AD4 +AD4 +AD4 -	return cpu +ACU nr+AF8-queues+ADs
+AD4 +AD4 +AD4 +-	return qmap-+AD4-queue+AF8-offset +- (cpu +ACU nr+AF8-queues)+ADs
+AD4 +AD4 +AD4  +AH0
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AFs ... +AF0
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 --- a/include/linux/blk-mq.h
+AD4 +AD4 +AD4 +-+-+- b/include/linux/blk-mq.h
+AD4 +AD4 +AD4 +AEAAQA -78,10 +-78,11 +AEAAQA struct blk+AF8-mq+AF8-hw+AF8-ctx +AHs
+AD4 +AD4 +AD4  struct blk+AF8-mq+AF8-queue+AF8-map +AHs
+AD4 +AD4 +AD4  	unsigned int +ACo-mq+AF8-map+ADs
+AD4 +AD4 +AD4  	unsigned int nr+AF8-queues+ADs
+AD4 +AD4 +AD4 +-	unsigned int queue+AF8-offset+ADs
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 
+AD4 +AD4 I think it's unfortunate that the blk-mq core uses the .queue+AF8-offset member but
+AD4 +AD4 that mapping functions in block drivers are responsible for setting that member.
+AD4 +AD4 Since the block driver mapping functions have to set blk+AF8-mq+AF8-queue+AF8-map.nr+AF8-queues,
+AD4 +AD4 how about adding a loop in blk+AF8-mq+AF8-update+AF8-queue+AF8-map() that derives .queue+AF8-offset
+AD4 +AD4 from .nr+AF8-queues from previous array entries?
+AD4 
+AD4 It's not a simple increment, so the driver has to be the one setting it. If
+AD4 we end up sharing queues, for instance, then the driver will need to set
+AD4 it to the start offset of that set. If you go two patches forward you
+AD4 can see that exact construct.
+AD4 
+AD4 IOW, it's the driver that controls the offset, not the core.

If sharing of hardware queues between hardware queue types is supported,
what should hctx-+AD4-type be set to? Additionally, patch 5 adds code that uses
hctx-+AD4-type as an array index. How can that code work if a single hardware
queue can be shared by multiple hardware queue types?

Thanks,

Bart.
