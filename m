Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 25499C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD2B208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD2B208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934482AbeFLQSW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:18:22 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54992 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933638AbeFLQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:18:21 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fSlzq-0000hB-0q; Tue, 12 Jun 2018 10:18:14 -0600
To:     Jon Mason <jdmason@kudzu.us>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-3-logang@deltatee.com>
 <CAPoiz9ykPufmQi=fhhA8k=CXdXwdo0v7+UPQwNwnkokXU-vWjw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ba7e652f-493c-eb92-042b-f60897b79045@deltatee.com>
Date:   Tue, 12 Jun 2018 10:18:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPoiz9ykPufmQi=fhhA8k=CXdXwdo0v7+UPQwNwnkokXU-vWjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, allenbh@gmail.com, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, jdmason@kudzu.us
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/8] NTB: Setup the DMA mask globally for all drivers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/18 09:48 AM, Jon Mason wrote:
> ntb.c is more of a glue layer, and this is more device specific.
> While I like adding it here for more common code, it should probably
> reside in the ntb_hw_*.c files to enforce the hw specific code all
> reside in that layer.  So, this probably needs to be replaced with a
> patch which adds the setting of the mask to the switchtec driver.

I disagree strongly. You can tell it's not device specific seeing we
have 4 devices that need the exact same code. In fact, there is nothing
device specific in those lines of code as the device specific part comes
when a driver sets the PCI parent device's DMA mask. These lines just
initialize the dma_mask for the new NTB device with its parent's mask.
This is just sensible given that nothing now works if it is not done and
trusting driver writers to get it right is not a good idea seeing we
already screwed it up once. Furthermore, it violates DRY (do not repeat
yourself).

If there is something driver specific that must be done (although I
can't actually imagine what this would be) the drivers are free to
change the mask after calling ntb_register but getting the common case
setup in common code is just good design.

Logan
