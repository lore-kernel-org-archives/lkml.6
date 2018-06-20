Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D0C1B0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C3620883
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C3620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeFTQGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:06:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754184AbeFTQGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D69B940201A2;
        Wed, 20 Jun 2018 16:06:12 +0000 (UTC)
Received: from [10.10.124.140] (ovpn-124-140.rdu2.redhat.com [10.10.124.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 221AE2026A41;
        Wed, 20 Jun 2018 16:06:12 +0000 (UTC)
To:     hamish.martin@alliedtelesis.co.nz,
        chris.packham@alliedtelesis.co.nz,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
From:   Mike Christie <mchristi@redhat.com>
Subject: uio regression in 4.18-rc1 due to "uio: Prevent device destruction
 while fds are open"
Message-ID: <5B2A7B73.5090000@redhat.com>
Date:   Wed, 20 Jun 2018 11:06:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 20 Jun 2018 16:06:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 20 Jun 2018 16:06:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hamish,

I am hitting a regression with your patch:

commit a93e7b331568227500186a465fee3c2cb5dffd1f
Author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Date:   Mon May 14 13:32:23 2018 +1200

    uio: Prevent device destruction while fds are open

The problem is the addition of spin_lock_irqsave in uio_write. This
leads to hitting  uio_write -> copy_from_user -> _copy_from_user ->
might_fault and the logs filling up with sleeping warnings.

I also noticed some uio drivers allocate memory, sleep, grab mutexes
from callouts like open() and release and uio is now doing
spin_lock_irqsave while calling them.

Note target_core_user's irqcontrol looks buggy and was just doing more
work than it should in that callout. I can fix that driver.
