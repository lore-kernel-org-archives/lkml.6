Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78F8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A514C2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A514C2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbeIUADH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:03:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38371 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeIUADH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:03:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4754596pfh.5;
        Thu, 20 Sep 2018 11:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCcavlPVPvdBxcaFEW9JLUDAXKXmk3ocVqWd2XRCOzg=;
        b=rwzBAEgs/rqwi5QZVBoL937TAgeItVDTROh47DdEkCfboFTQaA/o/E0RknUu0gmgol
         9lJ3qYbTQAv1EAWdF6XdJEqj1CrMCNzMjsRyyuKoocxnGHG/PtYMnuxEP3B/Xj6gqpjs
         6P6jme0caxykJF8b9cMENw8ewlJPi54P9fXE1f625a2LSD1lQ/jjFyKS2C6tZruJC2K0
         jEugp45AqwEJA0l+uK9jwSIS/HICFl0R1P0xX4zjsEr9Vd4ImkE8JlFOqCZQKzMqNyMZ
         3fAcL3rpQXTeYvZwtw7yUz8vc6PIpBhr7Ud4wGxGOPiJBgRSXM9HDpAT22G+KwNilYdn
         hN8A==
X-Gm-Message-State: APzg51CA/JApXYlb3s6CQIYQTdhcH0THNIacT+gZrrGFEF+t513vLPCy
        GWPgo/pSZzVGd6p9z4wtvq8=
X-Google-Smtp-Source: ANB0VdbOK6R8Y+J0fKjOIq196HBb3piFNkoHWOUMmgYlZECH38fPvBpB1NNC3cMbJiMUUK7AssnU4A==
X-Received: by 2002:aa7:818f:: with SMTP id g15-v6mr42303810pfi.71.1537467502071;
        Thu, 20 Sep 2018 11:18:22 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t14-v6sm26244720pgu.0.2018.09.20.11.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 11:18:21 -0700 (PDT)
Message-ID: <1537467499.224533.21.camel@acm.org>
Subject: Re: [PATCH] scsi: sd: don't crash the host on invalid commands
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Date:   Thu, 20 Sep 2018 11:18:19 -0700
In-Reply-To: <20180920071907.10102-1-jthumshirn@suse.de>
References: <20180920071907.10102-1-jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-20 at 09:19 +-0200, Johannes Thumshirn wrote:
+AD4 When sd+AF8-init+AF8-command() get's a with a unknown req+AF8-op() it crashes the
+AD4 system via BUG().
+AD4 
+AD4 This makes debugging the actual reason for the broken request
+AD4 cmd+AF8-flags pretty hard as the system is down before it's able to write
+AD4 out debugging data on the serial console or the trace buffer.
+AD4 
+AD4 Change the BUG() to a WARN+AF8-ON() and return BLKPREP+AF8-KILL to fail
+AD4 gracefully and return an I/O error to the producer of the request.
+AD4 
+AD4 Signed-off-by: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4
+AD4 Cc: Hannes Reinecke +ADw-hare+AEA-suse.de+AD4
+AD4 Cc: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4
+AD4 ---
+AD4 Fixed Typo in Bart's mail, sorry for this.
+AD4 
+AD4  drivers/scsi/sd.c +AHw 3 +-+--
+AD4  1 file changed, 2 insertions(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
+AD4 index b79b366a94f7..19f28962d65b 100644
+AD4 --- a/drivers/scsi/sd.c
+AD4 +-+-+- b/drivers/scsi/sd.c
+AD4 +AEAAQA -1276,7 +-1276,8 +AEAAQA static int sd+AF8-init+AF8-command(struct scsi+AF8-cmnd +ACo-cmd)
+AD4  	case REQ+AF8-OP+AF8-ZONE+AF8-RESET:
+AD4  		return sd+AF8-zbc+AF8-setup+AF8-reset+AF8-cmnd(cmd)+ADs
+AD4  	default:
+AD4 -		BUG()+ADs
+AD4 +-		WARN+AF8-ON(1)+ADs
+AD4 +-		return BLKPREP+AF8-KILL+ADs
+AD4  	+AH0
+AD4  +AH0

Have you considered to use WARN+AF8-ON+AF8-ONCE() instead of WARN+AF8-ON(1)? Otherwise
this patch looks good to me.

Thanks,

Bart.

