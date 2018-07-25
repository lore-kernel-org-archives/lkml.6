Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0D6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9200A20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9200A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbeGYTMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:12:43 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37464 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729367AbeGYTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:12:43 -0400
Received: (qmail 4939 invoked by uid 2102); 25 Jul 2018 13:59:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jul 2018 13:59:58 -0400
Date:   Wed, 25 Jul 2018 13:59:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     arnd@arndb.de, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>, <bauer.chen@realtek.com>,
        <ricky_wu@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power management
In-Reply-To: <20180725152515.1833-5-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1807251357000.1467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Kai-Heng Feng wrote:

> In order to let host's parent device, rtsx_usb, to use USB remote wake
> up signaling to do card detection, it needs to be suspended. Hence it's
> necessary to add runtime PM support for the memstick host.
> 
> To keep memstick host stays suspended when it's not in use, convert the
> card detection function from kthread to delayed_work, which can be
> scheduled when the host is resumed and can be canceled when the host is
> suspended.
> 
> Use an idle function check if there's no card and the power mode is
> MEMSTICK_POWER_OFF. If both criteria are met, put the device to suspend.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I'm not familiar enough with this driver to comment on specific
instances, but you should carefully go through the code and make sure
that you use pm_runtime_get_noresume() and pm_runtime_put_noidle()
correctly.

The basic idea is to use these when you know beforehand that the device
is already at full power (for _get_noresume) and the usage count will
not go to 0 (for _put_noidle).  If you aren't certain of these
requirements then you should call pm_runtime_get_sync() and
pm_runtime_put().

Alan Stern

