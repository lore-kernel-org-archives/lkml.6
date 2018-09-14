Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8FFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F8520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F8520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeINOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:24:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47183 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeINOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:24:13 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 9a4eb3d7e7d93233; Fri, 14 Sep 2018 11:10:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers/base: move device_shutdown() to base/power
Date:   Fri, 14 Sep 2018 11:07:57 +0200
Message-ID: <76851595.dP8mLy4DGX@aspire.rjw.lan>
In-Reply-To: <1534756717-25553-2-git-send-email-kernelfans@gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com> <1534756717-25553-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 20, 2018 11:18:35 AM CEST Pingfan Liu wrote:
> Consider the shutdown as a system state transition, i.e. something like
> suspend, hibernate, hence move it under the base/power. (This is a first
> step to unify the duplicate code logic on devices_kset and dpm_list.)

I don't really think that device_shutodwn() belongs in base/power/.

Moving it to a separate file sounds like a good idea, but let that file
reside in base/ proper.

Then, I would separate the dpm_list definition, locking etc out of
base/power/, move it to the new file containing device_shutdown() and
make the code in base/power/ refer to it (you may want to move the list
entry list head from dev_pm_info to struct device directly while at that
too).

Then, it should be straightforward enough to switch device_shutdown() over to
using it.

Thanks,
Rafael

