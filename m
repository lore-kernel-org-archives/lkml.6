Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD55C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD24120853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD24120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeJOP0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:26:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:6120 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeJOP0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:26:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 00:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,383,1534834800"; 
   d="scan'208";a="82640236"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2018 00:42:38 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Zhi Jin <zhi.jin@intel.com>
Cc:     linux-kernel@vger.kernel.org, Zhi Jin <zhi.jin@intel.com>
Subject: Re: [PATCH] stm class: increase pos if no free channels found
In-Reply-To: <1536218530-18601-1-git-send-email-zhi.jin@intel.com>
References: <1536218530-18601-1-git-send-email-zhi.jin@intel.com>
Date:   Mon, 15 Oct 2018 10:42:37 +0300
Message-ID: <87h8hn64gi.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhi Jin <zhi.jin@intel.com> writes:

> Considering this case in find_free_channels():
>
> bitmap:
>        +------------------+-+-+-+-+-+-+-+-+-+-+
>        |     ......       |0|0|0|0|0|0|0|1|0|0|
>        +------------------+-+-+-+-+-+-+-+-+-+-+
>
> 1. Channel #2 has been occupied, so bit #2 is 1, and the others
>    are all 0.
> 2. Another thread tries to find 4 free channels from #0.
> 3. In the 1st loop, pos starts from 0, and then it checks if the
>    following 4 bits are all 0, but fails, as bit#2 is 1.
> 4. In the 2st loop, pos is not updated, and still starts from 0,
>    so nothing changes against loop #1.
> 5. Dead loop ...
>
> This patch is to update the pos in step #3 to avoid the issue.

The description is slightly confusing, but the patch looks correct and
the original code is clearly wrong. Thank you for finding this!

Basically, if you request 1 channel 3 times, release the first two and
then request 4 channels, you'll be stuck, right?

Thanks,
--
Alex
