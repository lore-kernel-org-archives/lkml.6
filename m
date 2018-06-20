Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43877C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0744820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbeFTJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:12:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:1546 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754295AbeFTJMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:12:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 02:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="50437870"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2018 02:12:20 -0700
Subject: Re: [BUG] usb: xhci: Two possible sleep-in-atomic-context bugs
To:     Peter Chen <peter.chen@nxp.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a2f62eac-b3e1-bd1e-3993-83e2f6adef03@gmail.com>
 <HE1PR04MB14501B0EC65D993623D96A168B770@HE1PR04MB1450.eurprd04.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <8410b5bf-097c-2b53-84ff-221fb4ab03fa@linux.intel.com>
Date:   Wed, 20 Jun 2018 12:15:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <HE1PR04MB14501B0EC65D993623D96A168B770@HE1PR04MB1450.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.2018 06:28, Peter Chen wrote:
>   
>>
>> The driver may sleep with holding a spinlock.
>> The function call paths (from bottom to top) in Linux-4.16.7 are:
>>
>> [FUNC] schedule
>> drivers/base/power/runtime.c, 741: schedule in rpm_resume
>> drivers/base/power/runtime.c, 1322: rpm_resume in pm_runtime_forbid
>> drivers/usb/host/xhci-hub.c, 647: pm_runtime_forbid in xhci_enter_test_mode
>> drivers/usb/host/xhci-hub.c, 632: _raw_spin_lock_irqsave in xhci_enter_test_mode
>>
>> [FUNC] schedule
>> drivers/base/power/runtime.c, 570: schedule in rpm_suspend
>> drivers/base/power/runtime.c, 434: rpm_suspend in rpm_idle
>> drivers/base/power/runtime.c, 1343: rpm_idle in pm_runtime_allow
>> drivers/usb/host/xhci-hub.c, 670: pm_runtime_allow in xhci_exit_test_mode
>> drivers/usb/host/xhci-hub.c, 1387: xhci_exit_test_mode in xhci_hub_control
>> drivers/usb/host/xhci-hub.c, 1038: _raw_spin_lock_irqsave in xhci_hub_control
>>
>> These bugs are found by my static analysis tool (DSAC-2) and checked by my code
>> review.
>>
> 
> I don't think runtime PM API is needed at xhci_hub_control since the controller should
> be always active, Mathias, do you agree I delete pm_runtime_forbid and pm_runtime_allow
> to fix this issue?
> 

The USB2 test mode is a bit special, it will disable all connected devices, and halt the host.
Port should stay in test mode until feature is cleared or host reset.
There is a risk runtime suspend will try to suspend the host as no devices seem preset.

But I think pm_runtime_get_noresume() and pm_runtime_put_noidle() could be used instad,
those should be safe.

-Mathias

