Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFEC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 23:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D2A2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 23:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D2A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeJNH3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 03:29:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeJNH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 03:29:54 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D440313E9EAC9;
        Sat, 13 Oct 2018 16:50:58 -0700 (PDT)
Date:   Sat, 13 Oct 2018 16:50:56 -0700 (PDT)
Message-Id: <20181013.165056.111476046287532695.davem@davemloft.net>
To:     mwb@linux.vnet.ibm.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@intel.com, tyhicks@canonical.com,
        jeffrey.t.kirsher@intel.com, amritha.nambiar@intel.com,
        joe@perches.com, dmitry.torokhov@gmail.com, decot@googlers.com,
        roopa@cumulusnetworks.com, xiyou.wangcong@gmail.com,
        nfont@linux.vnet.ibm.com, minkim@us.ibm.com,
        tyreld@linux.vnet.ibm.com, tlfalcon@linux.vnet.ibm.com
Subject: Re: [PATCH] net/sysfs: Remove devices without receive buffers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181013220451.6905.65084.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181013220451.6905.65084.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 13 Oct 2018 16:50:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Sat, 13 Oct 2018 17:05:28 -0500

> Testing ran into a case where a network device was created and
> initialized, but then removed from the system before accepting
> traffic through it.  In this case, no receive buffers were added
> to the device prior to attempting to release the driver.  This
> resulted in generation of a WARNING notice/stack trace in the
> console log like,

That's not legal.

The device must setup all of this kind of state before calling
register_netdevice().  And this must happen for reasons other than the
crash situation mentioned here.

Please fix the ibmvnic driver to not register partially setup netdev
objects.

Thank you.
