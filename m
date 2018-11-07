Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B733C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D3D20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D3D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbeKGJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:54:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34320 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbeKGJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:54:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so5822999plo.1;
        Tue, 06 Nov 2018 16:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVNMRkrwBIwuGV55QxZYAYGx8UdMGagqcmUvuT7Huwk=;
        b=bk9qrXVfnVbVHYRy8SOFl7NOJ11UMOspoea0VLPIOcQnYtQbahfVhO+iMXjSbP8yB6
         3wIz0gdV+xEU5SrLo2ug+VyT1txvk757KO29E9YgnIoXm6uuVwe3hnpP01oPdAeExi7u
         eO3vA03nxfARNiroDz7lsPBw2yuR7SKTnHABX4pPRxPX6C3uB6+6mxrboY9II10y+oXH
         0n5yCLzqY3veJJXbrZtEJwgX0/jQh3v85omCUONd2dJJtY3Wsk3KZ3IWpxda+8ta/16O
         a5QlSjQjNUEdMEtaRK3rMrA7kpm79iA8nCYOUBrxg7D9h/lb5R/6CePcvzzhJIZ1xa3I
         nBzQ==
X-Gm-Message-State: AGRZ1gKgLQ1jNB/XsYz1SK5pER6x8s174ty2363WpWpyXoesBGRmkzzP
        2Hzzt2UfAhV1tpLA7HjFpLM=
X-Google-Smtp-Source: AJdET5dfkHqQu90+rDNRsTTUTMk3cpFnZeMijEdsFHi2dNOrmm4eX7iBCr6XV1/WdWQrLZh+r2ap0w==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr4008983pln.340.1541550395458;
        Tue, 06 Nov 2018 16:26:35 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k75-v6sm53476126pfb.119.2018.11.06.16.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:26:34 -0800 (PST)
Message-ID: <1541550393.196084.202.camel@acm.org>
Subject: Re: [driver-core PATCH v5 9/9] libnvdimm: Schedule device
 registration on node local to the device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 16:26:33 -0800
In-Reply-To: <154145234526.29224.2575533246153120029.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145234526.29224.2575533246153120029.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
+AD4 This patch is meant to force the device registration for nvdimm devices to
+AD4 be closer to the actual device. This is achieved by using either the NUMA
+AD4 node ID of the region, or of the parent. By doing this we can have
+AD4 everything above the region based on the region, and everything below the
+AD4 region based on the nvdimm bus.
+AD4 
+AD4 By guaranteeing NUMA locality I see an improvement of as high as 25+ACU for
+AD4 per-node init of a system with 12TB of persistent memory.

Thank you for having included the performance numbers.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

