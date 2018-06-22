Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9918A246D9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9918A246D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934013AbeFVRnW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:43:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:61693 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbeFVRnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:43:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 10:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="59425774"
Received: from haiyuewa-mobl1.ccr.corp.intel.com (HELO [10.249.173.233]) ([10.249.173.233])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2018 10:43:17 -0700
Subject: Re: [PATCH ] ipmi: kcs_bmc: fix IRQ exception if the channel is not
 open
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     luis.a.silva@dell.com, avi.fishman@nuvoton.com,
        openbmc@lists.ozlabs.org
References: <1529636218-280096-1-git-send-email-haiyue.wang@linux.intel.com>
 <ea0a4cd3-2973-7ac8-c4a1-26379d9066cc@acm.org>
 <980bbe06-afa6-67b0-a3d3-c5fd921dcfbd@linux.intel.com>
From:   "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <3950b9ff-79d6-b0f8-91fb-1a13b34c24d2@linux.intel.com>
Date:   Sat, 23 Jun 2018 01:43:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <980bbe06-afa6-67b0-a3d3-c5fd921dcfbd@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-23 01:23, Wang, Haiyue wrote:
>> Maybe it's best to have the interrupt disabled unless the device is 
>> open.
>> You have to handle the interrupt disable race on a close, but with the
>> sync functions that shouldn't be too hard.
>>
> In fact, in BMC chip design, the LPC controller has many devices, such as
> Port 80 snoop, BT, KCS etc, they shares the same interrupt. :) 
BTW, for AST2500, if the BMC and PCH run under eSPI (like LPC) mode, and 
if we
disable the KCS devices, then reboot the BMC, it will cause the system 
hang, and
the KCS channel can't be used anymore. So we need always enable these 
used KCS
devices (keep the KCS enable register setting) for working well under 
eSPI mode.
