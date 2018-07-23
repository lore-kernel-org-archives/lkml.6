Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD1AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1969320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1969320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbeGWW7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:59:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:55307 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388052AbeGWW7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:59:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 14:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="242673569"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2018 14:55:41 -0700
Message-ID: <fbac7919db6874c76ef3ac628c8356968bb55d7a.camel@linux.intel.com>
Subject: Re: HID: intel_ish-hid: tx_buf memory leak on probe/remove
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Date:   Mon, 23 Jul 2018 14:55:41 -0700
In-Reply-To: <a0faf8a7-17ea-0ed3-5bb5-f1e8fb5debf6@ispras.ru>
References: <a0faf8a7-17ea-0ed3-5bb5-f1e8fb5debf6@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 20:56 +0300, Anton Vasilyev wrote:
> ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores
> it at
> &dev->wr_free_list_head.link list on ish_probe().
> But there is no deallocation of this memory in ish_remove() and in 
> ish_probe()
> error path.
> So current intel-ish-ipc provides 88 KB memory leak for each
> probe/release.
> 
> I have two ideas 1) to replace kzalloc allocation by devm_kzalloc,
Thanks for finding this. We can replace both alloc in this function
with devm_ calls. Once you have a patch I can test.

Thanks,
Srinivas 

> or 2) release memory stored at &dev->wr_free_list_head.link list
> (and 
> may be at
> &dev->wr_processing_list_head.link) in all driver exits.
> 
> But I do not know which way is preferable for this case.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> --
> Anton Vasilyev
> Linux Verification Center, ISPRAS
> web: http://linuxtesting.org
> e-mail: vasilyev@ispras.ru
