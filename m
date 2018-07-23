Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CCECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4147F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbeGWS6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:58:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57812 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388212AbeGWS6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:58:48 -0400
Received: from [10.10.2.207] (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id A0D89540081;
        Mon, 23 Jul 2018 20:56:24 +0300 (MSK)
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Anton Vasilyev <vasilyev@ispras.ru>
From:   Anton Vasilyev <vasilyev@ispras.ru>
Subject: HID: intel_ish-hid: tx_buf memory leak on probe/remove
Message-ID: <a0faf8a7-17ea-0ed3-5bb5-f1e8fb5debf6@ispras.ru>
Date:   Mon, 23 Jul 2018 20:56:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores it at
&dev->wr_free_list_head.link list on ish_probe().
But there is no deallocation of this memory in ish_remove() and in 
ish_probe()
error path.
So current intel-ish-ipc provides 88 KB memory leak for each probe/release.

I have two ideas 1) to replace kzalloc allocation by devm_kzalloc,
or 2) release memory stored at &dev->wr_free_list_head.link list (and 
may be at
&dev->wr_processing_list_head.link) in all driver exits.

But I do not know which way is preferable for this case.

Found by Linux Driver Verification project (linuxtesting.org).

--
Anton Vasilyev
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: vasilyev@ispras.ru
