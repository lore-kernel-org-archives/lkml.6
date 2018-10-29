Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26130C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF482080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF482080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeJ3DVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:21:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40090 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJ3DVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:21:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9-v6so4217110pls.7;
        Mon, 29 Oct 2018 11:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLTVR03Av8/7EIy5uS3yczJLab47CXlH6S6gFsZdnJ8=;
        b=JE1Os70omxp4svTXHlZKdafO3EbSjnQANxCOrQ+QuGulmhi4blVTN/PxkYot1cZi1H
         vtc5lK0ZXQTxc2DO7IoVw6H5TQYypi5a3fcsfJ1HeE0ViWXZuum+duqRiribun2LVkXa
         2Xa6d467qoOqRzT5u8bixK93swj7bz1RjbaqCd100TRVTtnAyfALY4JmXyqe6jspQm8p
         WBWXwA0xyIUm84OYgVS+Iqf36StAdMiINTacPjnaxhEd+SeAc+uszHni3FJ+4Empvx6R
         N6rKLn+5vlfuuPKN/FweWBZbjXXbywMNiVZ9e/M/fZTszJZ3Mtsshxoma1ZTI/7hJf0j
         b3Yw==
X-Gm-Message-State: AGRZ1gI/rfS8kRGlCKY5q6QPpWlVATTMchpvXTlEJZav5HH2yoCdlHmF
        yGXxTl0zjYAMCcZ9NdgxYf8=
X-Google-Smtp-Source: AJdET5eYPGHc6NGWUS/KGtab3LqqbNQNC/D5dB/ZyU+3pVJEmZDFXQpl15ZwsBEPeebIKuk2lEHZSA==
X-Received: by 2002:a17:902:24b:: with SMTP id 69-v6mr15751840plc.280.1540837879311;
        Mon, 29 Oct 2018 11:31:19 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s13-v6sm56156684pgs.76.2018.10.29.11.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 11:31:17 -0700 (PDT)
Message-ID: <1540837876.196084.75.camel@acm.org>
Subject: Re: [PATCH 08/14] blk-mq: separate number of hardware queues from
 nr_cpu_ids
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 11:31:16 -0700
In-Reply-To: <20181029163738.10172-9-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-9-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 With multiple maps, nr+AF8-cpu+AF8-ids is no longer the maximum number of
+AD4 hardware queues we support on a given devices. The initializer of
+AD4 the tag+AF8-set can have set -+AD4-nr+AF8-hw+AF8-queues larger than the available
+AD4 number of CPUs, since we can exceed that with multiple queue maps.
+AD4 
+AD4 Reviewed-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4
+AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 ---
+AD4  block/blk-mq.c +AHw 28 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--------
+AD4  1 file changed, 21 insertions(+-), 7 deletions(-)
+AD4 
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 0fab36372ace..60a951c4934c 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -2663,6 +-2663,19 +AEAAQA static void blk+AF8-mq+AF8-realloc+AF8-hw+AF8-ctxs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set,
+AD4  	mutex+AF8-unlock(+ACY-q-+AD4-sysfs+AF8-lock)+ADs
+AD4  +AH0
+AD4  
+AD4 +-/+ACo
+AD4 +- +ACo Maximum number of queues we support. For single sets, we'll never have
                       +AF4
                   hardware?
+AD4 +- +ACo more than the CPUs (software queues). For multiple sets, the tag+AF8-set
+AD4 +- +ACo user may have set -+AD4-nr+AF8-hw+AF8-queues larger.
+AD4 +- +ACo-/

Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

