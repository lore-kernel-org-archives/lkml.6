Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BFA2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYzbwGCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfAKCcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:32:32 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36482 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKCcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:32:32 -0500
Received: by mail-pf1-f174.google.com with SMTP id b85so6219023pfc.3;
        Thu, 10 Jan 2019 18:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZKVPLxsVvmavmhEhg/It9g/craYjRgUjLhGShe9xX3E=;
        b=vYzbwGCA6o2OEf6yCTf0LRiFacVhwZQyn9f+R3+tBpCHbzq9GGTFe7HsHc1PPCKneD
         wtXtrXD5Shyr5gWtgocabZ1df2JeK/Zq2uQ7J/8sICQkbqdjfzhqDBOgVmgJTpWAuCBl
         P8hfxtIReeq6104gXTRhHl6lflvw7QgZbY7+xkT4f/mYzh1PagfbWkLzyfvZkJ8Q9bVM
         ShiVTfIm6+pp0+VfNF5bOlDY4FiKhDFUvo5mifpek7YE/+OeX0HOHdDMfwNXE7k0f6sB
         wdwfaaATtlBhpLrTMcV8x1G9oxTiHWPIkU4o8pTn57kEq660ghDnMeSTC8jxLYzGEhXb
         2Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZKVPLxsVvmavmhEhg/It9g/craYjRgUjLhGShe9xX3E=;
        b=B1B7bgnvJwzm55V1plZtmXyqJtnidcGOmxQxoMDi0VdChkoNKtDmPxI96mEU3rLNY4
         R0gtPtW6I34h3nChv5S5avdQt1ShclaSvSw42lvsQ1CrqnejhRVB8CA78b+Qb0lCj/xW
         J9m43/NJFARqpPxPqVhQTYqneFt5p8VwmwHEe5RZrs5dETc3A3E5mhUi57UNyq3GYvdG
         pdIJD+k4apqwKgPf4VJ2PxZKPpTv5eE/Yu/imYhPgDJw718hoYGsat/qqcoHAAgaZF/7
         iQLenP7jPFpSCZiv5RHsxixKgTEqKGcpa3J0YEmzbxbWa8uyhonq7NCk+RUuqGMFT0/C
         EM8g==
X-Gm-Message-State: AJcUukeIb69smDAmZFD5ITspHCdp0A8HP+iVDqXs218aReijs1NdK4S3
        H81x6w7EuO5muYG+8lpbTDDpCexy
X-Google-Smtp-Source: ALg8bN7RhcabebJ1Ld2x60HEwIHAI3ScNf7pk0Uz53ggQk0rkUZkLgnJvKEV/gLhGFH9t+0C77oWug==
X-Received: by 2002:a62:3adc:: with SMTP id v89mr12506395pfj.109.1547173951513;
        Thu, 10 Jan 2019 18:32:31 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id e86sm117555755pfb.6.2019.01.10.18.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 18:32:30 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     aviad.krawczyk@huawei.com, davem@davemloft.net
Cc:     netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] net: huawei: hinic: a possible sleep-in-atomic-context bug in
 msg_to_mgmt_async
Message-ID: <cafbb5d2-1a35-cd7b-1604-0125e42c403c@gmail.com>
Date:   Fri, 11 Jan 2019 10:32:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in the directory 
"drivers/net/ethernet/huawei/hinic/" in Linux-4.17 is:

[FUNC] down
hinic_hw_mgmt.c, 324: down in msg_to_mgmt_async
hinic_hw_mgmt.c, 408: msg_to_mgmt_async in mgmt_recv_msg_handler
hinic_hw_mgmt.c, 464:mgmt_recv_msg_handler in recv_mgmt_msg_handler
hinic_hw_mgmt.c, 484: recv_mgmt_msg_handler in mgmt_msg_aeqe_handler
hinic_hw_eqs.c, 264: [FUNC_PTR]mgmt_msg_aeqe_handler in aeq_irq_handler
hinic_hw_eqs.c, 355: aeq_irq_handler in eq_irq_handler
hinic_hw_eqs.c, 383: eq_irq_handler in ceq_tasklet

Note that [FUNC_PTR] means a function pointer call.

This bug is found by my static analysis tool (DSAC-2) and checked by my
manual code review.

I do not know how to correctly fix this bug, so I just report it.
A possible way may be to replace up() and down() with spin_lock() and 
spin_unlock().


Best wishes,
Jia-Ju Bai

