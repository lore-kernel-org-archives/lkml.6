Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E3C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8772083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8772083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeKFKM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:12:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44457 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:12:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id s5-v6so5283183plq.11;
        Mon, 05 Nov 2018 16:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udvSEhguxOJgi4/AIhSJuMdBPB6vX7uQ8eSOdZebpN8=;
        b=n2OCW0Zy1FNoWy6Lje+mbkyXdKlDnXGlgbp2HWqKIBez+Xr+XyNNasoH8R8uC3/4PB
         EeUQ1/EmH+RWK7148M45zNLggbPaInE0lkIAPmof1FplkhGyegSREffK8VKnMS2tBPf8
         DnDaEgkS8V2nhmrMNAQSKGHJAz5uQ+iNHKy6UHczy6Uq5sC3EEYo0UsQ8Gz6ppd2yRuF
         BeDf17OzhgCJRzmrKzd+DRMcmqHPN/AFaR8IXDDOsIJnpnDOx8Z0R5SFluLJhBz3HjRh
         o9d4J+wgPb53Ww42Zy1Zcw5D56MJIoucRNJSVt8B6L32PSLVGtaSRnrY5rn53/2rnMQr
         LA5Q==
X-Gm-Message-State: AGRZ1gIdtZWroBA2F6ezjFwe79+1ef242HJrigniAudf4lMxGetRb4SB
        9hIOqbpcxyNo4qqIEv8DSGk=
X-Google-Smtp-Source: AJdET5e3YDuSD5B4exGeKGkkVUgGnkRgmy3miOWYX6PPZRKASNN00197Itbp0LiiuuwdQgO33a41hg==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr15489187pld.304.1541465427012;
        Mon, 05 Nov 2018 16:50:27 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t4-v6sm46679184pfh.45.2018.11.05.16.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 16:50:26 -0800 (PST)
Message-ID: <1541465425.196084.170.camel@acm.org>
Subject: Re: [driver-core PATCH v5 0/9] Add NUMA aware async_schedule calls
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Mon, 05 Nov 2018 16:50:25 -0800
In-Reply-To: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
+AD4 This patch set provides functionality that will help to improve the
+AD4 locality of the async+AF8-schedule calls used to provide deferred
+AD4 initialization.

Hi Alexander,

Is this patch series perhaps available in a public git tree? That would make
it easier for me to test my sd changes on top of your patches than applying
this patch series myself on kernel v4.20-rc1.

Thanks,

Bart.
