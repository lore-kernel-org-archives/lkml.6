Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7380C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A16420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A16420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeIYS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:59:03 -0400
Received: from foss.arm.com ([217.140.101.70]:50390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbeIYS7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:59:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB5337A9;
        Tue, 25 Sep 2018 05:51:37 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D9063F5BD;
        Tue, 25 Sep 2018 05:51:33 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20180925124629.20710-1-brgl@bgdev.pl>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c25df148-718a-d29d-9c1d-20701a0e4534@arm.com>
Date:   Tue, 25 Sep 2018 13:51:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/18 13:46, Bartosz Golaszewski wrote:
> This series implements devm_kstrdup_const() together with some
> prerequisite changes and uses it in pmc-atom driver.

Is anyone expecting me to review this series, or am I just here because 
I once made a couple of entirely unrelated changes to device.h?

Robin.

> v1 -> v2:
> - fixed the changelog in the patch implementing devm_kstrdup_const()
> - fixed the kernel doc
> - moved is_kernel_rodata() to asm-generic/sections.h
> - fixed constness
> 
> v2 -> v3:
> - rebased on top of 4.19-rc5 as there were some conflicts in the
>    pmc-atom driver
> - collected Reviewed-by tags
> 
> v3 -> v4:
> - Andy NAK'ed patch 4/4 so I added a different example
> - collected more tags
> 
> Bartosz Golaszewski (4):
>    devres: constify p in devm_kfree()
>    mm: move is_kernel_rodata() to asm-generic/sections.h
>    devres: provide devm_kstrdup_const()
>    mailbox: tegra-hsp: use devm_kstrdup_const()
> 
>   drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
>   drivers/mailbox/tegra-hsp.c    | 41 +++++++-------------------------
>   include/asm-generic/sections.h | 14 +++++++++++
>   include/linux/device.h         |  5 +++-
>   mm/util.c                      |  7 ------
>   5 files changed, 68 insertions(+), 42 deletions(-)
> 
