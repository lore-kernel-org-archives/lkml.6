Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598EC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746DF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746DF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeKGKSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:18:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeKGKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:18:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id j22-v6so6935775pfh.3;
        Tue, 06 Nov 2018 16:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xx9vvdjGAJqQmalywI9s8U4bqdAaQdgWhdlpT6ay7ow=;
        b=bV5HUyb4ozpa77I3A7zjDjOXxlTL6DpvTFpC1/cDJfXR5JysMylCgekcshQn56OC8D
         uLVwllMCB4gHJNWVvXh8CTMEyn/swM8bAdEeHq0NrwHgZ7H/s5TXUpV1y+WYqkToNYSN
         EcAt0mAtaaEFBRiiFTsLElY+wGUFDIB1xeT8b0kjMPrJxwND7q3pSjDJ9qEVxuQlcJS7
         pLv6TSIVn1qjDWcSKnrk0OBrK8M0Rc1RGgmfmOqMABnAew0T74dXFF+P+FV7lno0xk73
         BpKpu5atD7W12nDJx1cu0mXarNya0UD+So8XxPt5uVS7HFODesmARVUrmdj3iUo81OpT
         zlYA==
X-Gm-Message-State: AGRZ1gIFFtV3/kgO8/NxbKWBvyvbB/FAbedBrRxf9OZYHCEIfZj3+fDc
        axMO/OMkRymOcOGq3xMC7mo=
X-Google-Smtp-Source: AJdET5e8T94qIVdGVt2VYbWnL8o/6VGUP2rf+aOfO7boeZXHU34PkqPUNYsONSKg7rFSeAQrVme9+A==
X-Received: by 2002:a63:f006:: with SMTP id k6mr25865919pgh.259.1541551831349;
        Tue, 06 Nov 2018 16:50:31 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v37sm30112047pgn.5.2018.11.06.16.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:50:30 -0800 (PST)
Message-ID: <1541551829.196084.206.camel@acm.org>
Subject: Re: [driver-core PATCH v5 2/9] async: Add support for queueing on
 specific NUMA node
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 16:50:29 -0800
In-Reply-To: <154145230954.29224.13087735653265580553.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145230954.29224.13087735653265580553.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
+AD4 +-/+ACoAKg
+AD4 +- +ACo async+AF8-schedule+AF8-domain - schedule a function for asynchronous execution within a certain domain
+AD4 +- +ACo +AEA-func: function to execute asynchronously
+AD4 +- +ACo +AEA-data: data pointer to pass to the function
+AD4 +- +ACo +AEA-domain: the domain
+AD4 +- +ACo
+AD4 +- +ACo Returns an async+AF8-cookie+AF8-t that may be used for checkpointing later.
+AD4 +- +ACo +AEA-domain may be used in the async+AF8-synchronize+AF8AKgBf-domain() functions to
+AD4 +- +ACo wait within a certain synchronization domain rather than globally.  A
+AD4 +- +ACo synchronization domain is specified via +AEA-domain.
+AD4 +- +ACo Note: This function may be called from atomic or non-atomic contexts.
+AD4 +- +ACo-/

Please leave out +ACI-A synchronization domain is specified via +AEA-domain.+ACI since
that text is redundant due to +ACIAQA-domain: the domain+ACI.

+AD4 +-/+ACoAKg
+AD4 +- +ACo async+AF8-schedule+AF8-dev+AF8-domain - A device specific version of async+AF8-schedule+AF8-domain
+AD4 +- +ACo +AEA-func: function to execute asynchronously
+AD4 +- +ACo +AEA-dev: device argument to be passed to function
+AD4 +- +ACo +AEA-domain: the domain
+AD4 +- +ACo
+AD4 +- +ACo Returns an async+AF8-cookie+AF8-t that may be used for checkpointing later.
+AD4 +- +ACo +AEA-dev is used as both the argument for the function and to provide NUMA
+AD4 +- +ACo context for where to run the function. By doing this we can try to
+AD4 +- +ACo provide for the best possible outcome by operating on the device on the
+AD4 +- +ACo CPUs closest to the device.
+AD4 +- +ACo +AEA-domain may be used in the async+AF8-synchronize+AF8AKgBf-domain() functions to
+AD4 +- +ACo wait within a certain synchronization domain rather than globally.  A
+AD4 +- +ACo synchronization domain is specified via +AEA-domain.
+AD4 +- +ACo Note: This function may be called from atomic or non-atomic contexts.
+AD4 +- +ACo-/

Same comment here: I think +ACI-A synchronization domain is specified via +AEA-domain.+ACI
is redundant.

+AD4 +-/+ACoAKg
+AD4 +- +ACo async+AF8-schedule+AF8-node+AF8-domain - NUMA specific version of async+AF8-schedule+AF8-domain
+AD4 +- +ACo +AEA-func: function to execute asynchronously
+AD4 +- +ACo +AEA-data: data pointer to pass to the function
+AD4 +- +ACo +AEA-node: NUMA node that we want to schedule this on or close to
+AD4 +- +ACo +AEA-domain: the domain
+AD4 +- +ACo
+AD4 +- +ACo Returns an async+AF8-cookie+AF8-t that may be used for checkpointing later.
+AD4 +- +ACo +AEA-domain may be used in the async+AF8-synchronize+AF8AKgBf-domain() functions to
+AD4 +- +ACo wait within a certain synchronization domain rather than globally.  A
+AD4 +- +ACo synchronization domain is specified via +AEA-domain.  Note: This function
+AD4 +- +ACo may be called from atomic or non-atomic contexts.
+AD4 +- +ACo
+AD4 +- +ACo The node requested will be honored on a best effort basis. If the node
+AD4 +- +ACo has no CPUs associated with it then the work is distributed among all
+AD4 +- +ACo available CPUs.
+AD4 +- +ACo-/

Same comment here: I think that also in the above +ACI-A synchronization domain is
specified via +AEA-domain.+ACI is redundant.

Otherwise this patch looks fine to me.

Bart.

