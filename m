Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89774ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503F1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503F1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeJSBzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:55:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43389 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:55:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id d8-v6so3313318pgv.10;
        Thu, 18 Oct 2018 10:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLnWq5PZ49KLY9JiTaNR4OlFx96vg9mA6pqi1thD+H4=;
        b=lcRm6I5Y/A4cU/gvicjAp1jR+jc/gPEaQxdRhpvVzyGyrvqWVkPoSQQapp9lDqsu7h
         m/sewJVMJwPaphwIugnXeJytEjLNMo++4RH+HCFwcPKMLOWJd/lCLZ7w5VBqxZKoqqS3
         TomzKD4s9yFFKCbeqAvfgGWLRi+Tt5d/7FfpstsVWF1Ea/racwWRXY6DFEg5Z1CIORit
         L+Eb9UJcrunAL8mGZRqKQhjfHsiqfTYyVZdnjz8QH2nLUkpJFgz/KN9Gm0w4OuFxivtS
         hzJS6cBRVwPfA4eaBrYI35Dwsbb6abR1KxgD+C2ZRECvUc2oR1WmcI7zTV+5o1JOnVZK
         Brcg==
X-Gm-Message-State: ABuFfognzHS5KwlYF1BRaRWgS/EqxH5XN9TjonExcg1V8t+JvX4F/Uyh
        w7vGoVSG3yeqA0OlDT/O/8U=
X-Google-Smtp-Source: ACcGV62PCzsftFOCdaGIifIBSJzSPxZZLiNjgBo6OidbQfyOxu8lZGRG0uA6Vg/vEpOmfQ9jqMZoqg==
X-Received: by 2002:a63:9a42:: with SMTP id e2-v6mr29693110pgo.340.1539885217577;
        Thu, 18 Oct 2018 10:53:37 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t22-v6sm30287095pfk.141.2018.10.18.10.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 10:53:36 -0700 (PDT)
Message-ID: <1539885215.81977.8.camel@acm.org>
Subject: Re: [driver-core PATCH v4 3/6] device core: Consolidate locking and
 unlocking of parent and device
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Date:   Thu, 18 Oct 2018 10:53:35 -0700
In-Reply-To: <20181015150920.29520.32815.stgit@localhost.localdomain>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150920.29520.32815.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 08:09 -0700, Alexander Duyck wrote:
+AD4 This patch is meant to try and consolidate all of the locking and unlocking
+AD4 of both the parent and device when attaching or removing a driver from a
+AD4 given device.
+AD4 
+AD4 To do that I first consolidated the lock pattern into two functions
+AD4 +AF8AXw-device+AF8-driver+AF8-lock and +AF8AXw-device+AF8-driver+AF8-unlock. After doing that I then
+AD4 created functions specific to attaching and detaching the driver while
+AD4 acquiring this locks. By doing this I was able to reduce the number of
            +AF4AXgBeAF4
Should +ACI-this+ACI perhaps be changed into +ACI-these+ACI?
 
+AD4 +-/+ACo
+AD4 +- +ACo +AF8AXw-device+AF8-driver+AF8-lock - acquire locks needed to manipulate dev-+AD4-drv
+AD4 +- +ACo +AEA-dev: Device we will update driver info for
+AD4 +- +ACo +AEA-parent: Parent device needed if the bus requires parent lock

Please consider splitting that description into two sentences to enhance
clarity, e.g. +ACI-Parent device. Needed if the bus requires parent lock.+ACI

+AD4 +- +ACo +AEA-parent: Parent device needed if the bus requires parent lock

Same comment here.

+AD4  /+ACoAKg
+AD4 +- +ACo device+AF8-driver+AF8-detach - detach driver from a specific device
+AD4 +- +ACo +AEA-dev: device to detach driver from
+AD4 +- +ACo
+AD4 +- +ACo Manually detach driver from device. Will acquire both +AEA-dev lock and
+AD4 +- +ACo +AEA-dev-+AD4-parent lock if needed.
+AD4 +- +ACo-/
+AD4 +-void device+AF8-driver+AF8-detach(struct device +ACo-dev)
+AD4 +-+AHs
+AD4 +-	device+AF8-release+AF8-driver+AF8-internal(dev, NULL, dev-+AD4-parent)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-/+ACoAKg
+AD4   +ACo driver+AF8-detach - detach driver from all devices it controls.
+AD4   +ACo +AEA-drv: driver.
+AD4   +ACo-/

Elsewhere in the driver core the word +ACI-manually+ACI only appears in comments
above exported functions and functions that implement sysfs store methods.
Since device+AF8-driver+AF8-detach() is neither, I think the word +ACI-manually+ACI should
not be used in the comment block above that function. But since the rest of
this patch looks fine to me, feel free to add:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
