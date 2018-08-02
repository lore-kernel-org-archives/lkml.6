Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE699C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9803D214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9803D214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeHBPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:52:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:9561 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732141AbeHBPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:52:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 07:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="scan'208";a="61507134"
Received: from mylly.fi.intel.com (HELO [10.237.72.153]) ([10.237.72.153])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2018 07:00:59 -0700
Subject: Re: [PATCH 02/12] i2c: designware-master: use core to detect 'no zero
 length' quirk
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <db46f7ba-0627-eb0b-9a93-40f26a82b0bf@linux.intel.com>
Date:   Thu, 2 Aug 2018 17:00:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 11:26 PM, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested.
> 
>   drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
I tested this with patch 1 and I like it since with these patches the 
test is done before firing up the HW, waiting for an interrupt and then 
see the length is invalid for us.

i2ctransfer -f 8 r0@0x10

Before (with i2c_designware debugging on):
[   15.607283] i2c_designware i2c_designware.1: i2c_dw_xfer: msgs: 1
[   15.711988] i2c_designware i2c_designware.1: enabled=0x1 stat=0x10
[   15.712002] i2c_designware i2c_designware.1: i2c_dw_xfer_msg: invalid 
message length
Error: Sending messages failed: Invalid argument

After:
[   25.838661] i2c i2c-8: adapter quirk: no zero length (addr 0x0010, 
size 0, read)
Error: Sending messages failed: Operation not supported

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
