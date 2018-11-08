Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1094CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D331820840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D331820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeKIJOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:14:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41967 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeKIJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:14:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so11062plr.8;
        Thu, 08 Nov 2018 15:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5suQGV9TfmYbNfOKb6sM3mSkbpZZrXk5ZTzghPGIFso=;
        b=EVCMpnxPLReNDnl3W88kRkjH8XkdBK83GUaLefsoYScAWu0S5r4T8LDbeMckTacLU2
         pOJnZhTQED0yQLJxVQvCPR6FpbjE8bLD7sHXinjzR/gP+3Nwcenp/boikatStsynwS+d
         1EZTw2KuAtgVx1uootJDxmL7PPxsifr1AxFodTzwkjDQXthfVqlkqNMOLvU6V4fM/Jhn
         5Da5T/jj56+P3xko7cIGlX5jhD4KVXORGqSGWWLFSpbTRbLPHk7mrGPanPlj0h4uXKX8
         8f3Ucyx7Fd0moLU+mAwpVFR3fTMqVDsQIXq4i9qB+G/gpJ+3THlm1uoTUpNv1t30Yt1l
         j4RQ==
X-Gm-Message-State: AGRZ1gKJSR9SuLcLwBeHQ7Ik96rzpxiZ06RPe2HRCNuGepWUOrHbWxfE
        ZsBTNLlZCaUSh+EQzicYSs4AL3PlJeQ=
X-Google-Smtp-Source: AJdET5elc4wf2ZJOWWlkYP7CtqGjcJpvEOHHgFM1QZVhl+booQes8zQ9leu3E3yXjMEfA3UJQHr9aA==
X-Received: by 2002:a17:902:e089:: with SMTP id cb9-v6mr3356615plb.196.1541720199210;
        Thu, 08 Nov 2018 15:36:39 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 62sm4539168pgc.61.2018.11.08.15.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 15:36:38 -0800 (PST)
Message-ID: <1541720197.196084.231.camel@acm.org>
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Thu, 08 Nov 2018 15:36:37 -0800
In-Reply-To: <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 10:06 -0800, Alexander Duyck wrote:
+AD4 Introduce four new variants of the async+AF8-schedule+AF8 functions that allow
+AD4 scheduling on a specific NUMA node.
+AD4 
+AD4 The first two functions are async+AF8-schedule+AF8-near and
+AD4 async+AF8-schedule+AF8-near+AF8-domain end up mapping to async+AF8-schedule and
+AD4 async+AF8-schedule+AF8-domain, but provide NUMA node specific functionality. They
+AD4 replace the original functions which were moved to inline function
+AD4 definitions that call the new functions while passing NUMA+AF8-NO+AF8-NODE.
+AD4 
+AD4 The second two functions are async+AF8-schedule+AF8-dev and
+AD4 async+AF8-schedule+AF8-dev+AF8-domain which provide NUMA specific functionality when
+AD4 passing a device as the data member and that device has a NUMA node other
+AD4 than NUMA+AF8-NO+AF8-NODE.
+AD4 
+AD4 The main motivation behind this is to address the need to be able to
+AD4 schedule device specific init work on specific NUMA nodes in order to
+AD4 improve performance of memory initialization.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

