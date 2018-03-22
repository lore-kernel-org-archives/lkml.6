Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755557AbeCVOdR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:33:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeCVOdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:33:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AFA560C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
From: Sinan Kaya <okaya@codeaurora.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
Message-ID: <507571ad-b6a5-7020-45fa-609b44e0166b@codeaurora.org>
Date: Thu, 22 Mar 2018 10:33:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more time hopefully without HTML this time.


On 03/22/2018 08:48 AM, okaya@codeaurora.org wrote:
>> Can you remove the writeq change if it is too late for me to fix?
>>
>> This is an infrastructural issue on xtensa arch.
>>
>> Probably, it won't get fixed today.
>
> AFAIS, even writeq won't compile on this arch. I started questioning 
> this build test.

I found out that the solution is this:

#include <linux/io-64-nonatomic-hi-lo.h>

https://patchwork.ozlabs.org/patch/511801/

I did a compile test with this change on xtensa and it passed. I'll 
repost with the added diff.

+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -46,7 +46,7 @@
  #include <linux/timer.h>
  #include <linux/io.h>
  #include <linux/workqueue.h>
-
+#include <linux/io-64-nonatomic-hi-lo.h>
  #include <asm/byteorder.h>

  #include <net/net_namespace.h>
