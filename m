Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA1BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3563420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S9C9sJfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfAKCMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:12:07 -0500
Received: from m12-17.163.com ([220.181.12.17]:49705 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfAKCMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=2gYEx
        ETUN2qZwC6w1JQx2+NWPxWko9KH+Z2H35nmEJE=; b=S9C9sJfei2o362/yGuDNk
        nOuO2b0Ra2wYWQ8gd3jx7oMC6EiKukqVnUxt5mfzPCXUIkDlraeBAAP1suMX/ilZ
        5JO3Q5wSRPZ6cc+zA5WD0jWUodJOKV3aXOteb52Q+7hilqdVUuJHdJaqsdNY5I7I
        XINtyMejKxyRH64uZwNomI=
Received: from [166.111.71.59] (unknown [166.111.71.59])
        by smtp13 (Coremail) with SMTP id EcCowACXt69v+zdc7TORAQ--.31623S2;
        Fri, 11 Jan 2019 10:12:00 +0800 (CST)
Subject: [BUG] net: huawei: hinic: a possible sleep-in-atomic-context bug in
 hinic_get_stats64
From:   Jia-Ju Bai <baijiaju1990@163.com>
To:     aviad.krawczyk@huawei.com
References: <e69f8fe7-6bb9-56b4-7053-9766b3a0f3da@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <b45e662b-b50f-a23b-a123-e1454daf20ed@163.com>
Date:   Fri, 11 Jan 2019 10:11:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e69f8fe7-6bb9-56b4-7053-9766b3a0f3da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: EcCowACXt69v+zdc7TORAQ--.31623S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4rXr47JrykCF43XF4ktFb_yoWxtwcE9r
        4FgF1DJw18uFsxKr4Ykr48WFyUKw1jvF97Ar409rWfCr9rZaykAFyDur17GrWxX3yavF1r
        ur15tw1qgwnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5D-PUUUUUU==
X-Originating-IP: [166.111.71.59]
X-CM-SenderInfo: xedlyx5dmximizq6il2tof0z/1tbiHhA5elSIfIVnWwAAsU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a RCU lock.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] down
drivers/net/.../hinic/hinic_main.c, 775: down in hinic_get_stats64
net/core/dev.c, 8278: [FUNC_PTR]hinic_get_stats64 in dev_get_stats
net/core/net-sysfs.c, 568: dev_get_stats in netstat_show
net/core/net-sysfs.c, 565: _raw_read_lock in netstat_show

Note that [FUNC_PTR] means a function pointer call.

This bug is found by my static analysis tool (DSAC-2) and checked by my
manual code review.

I do not know how to correctly fix this bug, so I just report it.
A possible way may be to replace up() and down()
with spin_lock() and spin_unlock().


Best wishes,
Jia-Ju Bai

