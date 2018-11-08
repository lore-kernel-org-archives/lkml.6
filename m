Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5049C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC920857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCC920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeKIJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:24:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33305 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeKIJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:24:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id q5-v6so36768pgv.0;
        Thu, 08 Nov 2018 15:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lpi2Z2T9Yvneb0BZWxArD1UqtatuZTwK7tcSqH6Ke1k=;
        b=gNiywInsXUi+kVT/CYd/sjyncGS0sxbil03l2edJCrx+iBeyV6T6Fqfr8IJrCtASuU
         Q4XmR83rb+A13k6eVjc0uwtG4FWm+FLQIJeZNBIsS+FNg3+zoK/Rm+YgAC66xoP+hr3t
         EhlUQsRngIwQy2lgWRaeDqA7QZH2julWNvC9Iv1QfENEZ13Y1cq4ukZsoUbz+Q+EWmq2
         yIPkjNDc4qnu8CbqJQniWUdZU12d0HIWZc89umDeJ2zx8u9XtIBbv9PpCKsI6M0K9I5m
         4cPAgZADHc160HRO20makjfSz1LhlKuTT3oSdhC61aKDSsoj6xs5ReLiWc8VtonY7ICW
         DC0Q==
X-Gm-Message-State: AGRZ1gIQ9tpJob+S+g/qgkIdH1j1S0HUlekKcQDtj5WGjsgEg/kusBpE
        0jcHYReEFn8wC1VN/Q0XE3Q23Tn2gRs=
X-Google-Smtp-Source: AJdET5d1O8t81/tIGumdNfjmWi+DQLVORRJ7K3aQnsI7kBPY0+YdqVcluDxRM/PkPIr0En87IPwLLw==
X-Received: by 2002:a63:ae4d:: with SMTP id e13-v6mr5522984pgp.315.1541720822482;
        Thu, 08 Nov 2018 15:47:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d196-v6sm5536713pfd.58.2018.11.08.15.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 15:47:01 -0800 (PST)
Message-ID: <1541720820.196084.238.camel@acm.org>
Subject: Re: [driver-core PATCH v6 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Thu, 08 Nov 2018 15:47:00 -0800
In-Reply-To: <154170042611.12967.14256799141542560553.stgit@ahduyck-desk1.jf.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170042611.12967.14256799141542560553.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 10:07 -0800, Alexander Duyck wrote:
+AD4 One change I made in addition is I replaced the use of +ACI-bool X:1+ACI to define
+AD4 the bitfield to a +ACI-u8 X:1+ACI setup in order to resolve some checkpatch
+AD4 warnings.

If you have to repost this patch series please remove the above from the
patch description since I think this part is no longer relevant. Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

