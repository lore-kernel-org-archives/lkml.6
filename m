Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563FFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104AD20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104AD20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeJ3ESE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:18:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42232 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3ESE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:18:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so4380109pgq.9;
        Mon, 29 Oct 2018 12:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S56dcmp2R3uC4z6hAXVQSGvvuMg9ob0iJhiAj26p10o=;
        b=KYbcEWnbNbkLsWUalyT4gOzFY+NwRLMYJdkQ8LG1WnRYmv4xAkJcX99hLUN2z/PbUb
         xVC1MjUmX37aacs0SqZM74VK462E4foYq49Wv9qGv6G+j1m3K4/UH5hiKwXfEvpYR+fU
         EXBgIyRnv9M5olSoK+YuoGWEu2/5di4keqWQS/K9RH1LotYBgLP6o3MQ5lLe+GiVws+I
         VeChAH8O3JDYwu/eDyUIt0MpJ+yiDwJ8Xd0plB3q4QZsk2/Ugu2keePzMAf3IsoJE3Hg
         aYftZKM6YMXP1JU/NAB78rCl5sjVnMeIU9VzC/XAbtRkjddc0/GERewOZnDgkCvK3Mos
         EWvQ==
X-Gm-Message-State: AGRZ1gKwvw/tK2WiZrBgS2Sup8A1kfLxm3M0l+KlDjizOIfNc9xeH2/G
        FWwD4rQsbzGhooDfJRv0n+O/sKxF
X-Google-Smtp-Source: AJdET5cE7HbiriwfQ69aRBeR/KVAIYBW3vYvitHuiP4bCrFZMTyajkNJf87LayD5s2TvgGwxCYgARQ==
X-Received: by 2002:a62:888c:: with SMTP id l134-v6mr6345704pfd.198.1540841280191;
        Mon, 29 Oct 2018 12:28:00 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 189-v6sm27146543pfe.121.2018.10.29.12.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 12:27:59 -0700 (PDT)
Message-ID: <1540841278.196084.84.camel@acm.org>
Subject: Re: [PATCH 09/14] blk-mq: ensure that plug lists don't straddle
 hardware queues
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 12:27:58 -0700
In-Reply-To: <20181029163738.10172-10-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-10-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4  void blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(struct blk+AF8-plug +ACo-plug, bool from+AF8-schedule)
+AD4  +AHs
+AD4  	struct blk+AF8-mq+AF8-ctx +ACo-this+AF8-ctx+ADs
+AD4 +AEAAQA -1628,7 +-1649,7 +AEAAQA void blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(struct blk+AF8-plug +ACo-plug, bool from+AF8-schedule)
+AD4  	struct request +ACo-rq+ADs
+AD4  	LIST+AF8-HEAD(list)+ADs
+AD4  	LIST+AF8-HEAD(ctx+AF8-list)+ADs
+AD4 -	unsigned int depth+ADs
+AD4 +-	unsigned int depth, this+AF8-flags+ADs
+AD4  
+AD4  	list+AF8-splice+AF8-init(+ACY-plug-+AD4-mq+AF8-list, +ACY-list)+ADs
+AD4  
+AD4 +AEAAQA -1636,13 +-1657,14 +AEAAQA void blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(struct blk+AF8-plug +ACo-plug, bool from+AF8-schedule)
+AD4  
+AD4  	this+AF8-q +AD0 NULL+ADs
+AD4  	this+AF8-ctx +AD0 NULL+ADs
+AD4 +-	this+AF8-flags +AD0 0+ADs
+AD4  	depth +AD0 0+ADs
+AD4  
+AD4  	while (+ACE-list+AF8-empty(+ACY-list)) +AHs
+AD4  		rq +AD0 list+AF8-entry+AF8-rq(list.next)+ADs
+AD4  		list+AF8-del+AF8-init(+ACY-rq-+AD4-queuelist)+ADs
+AD4  		BUG+AF8-ON(+ACE-rq-+AD4-q)+ADs
+AD4 -		if (rq-+AD4-mq+AF8-ctx +ACEAPQ this+AF8-ctx) +AHs
+AD4 +-		if (+ACE-ctx+AF8-match(rq, this+AF8-ctx, this+AF8-flags)) +AHs
+AD4  			if (this+AF8-ctx) +AHs
+AD4  				trace+AF8-block+AF8-unplug(this+AF8-q, depth, +ACE-from+AF8-schedule)+ADs
+AD4  				blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(this+AF8-q, this+AF8-ctx,
+AD4 +AEAAQA -1650,6 +-1672,7 +AEAAQA void blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(struct blk+AF8-plug +ACo-plug, bool from+AF8-schedule)
+AD4  								from+AF8-schedule)+ADs
+AD4  			+AH0
+AD4  
+AD4 +-			this+AF8-flags +AD0 rq-+AD4-cmd+AF8-flags+ADs
+AD4  			this+AF8-ctx +AD0 rq-+AD4-mq+AF8-ctx+ADs
+AD4  			this+AF8-q +AD0 rq-+AD4-q+ADs
+AD4  			depth +AD0 0+ADs

This patch will cause the function stored in the flags+AF8-to+AF8-type pointer to be
called 2 +ACo (n - 1) times where n is the number of elements in 'list' when
blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests() is called. Have you considered to rearrange
the code such that that number of calls is reduced to n?

Thanks,

Bart.
