Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D36A2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfABLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:32:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:62856 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbfABLcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:32:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 03:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,430,1539673200"; 
   d="scan'208";a="103341680"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2019 03:32:37 -0800
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     Nathan Royce <nroycea+kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
Date:   Wed, 2 Jan 2019 13:36:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.01.2019 20:57, Nathan Royce wrote:
> Kernel 4.19.13
> 
> 00:14.0 USB controller: Intel Corporation 9 Series Chipset Family USB
> xHCI Controller
> 
> Around 400 "unknown event type 37" messages logged in a 2 second span.
> *****
> Jan 01 02:08:07 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> Jan 01 02:08:00 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> Jan 01 02:07:56 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> unknown event type 37
> ...
> Jan 01 02:07:55 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> unknown event type 37
> Jan 01 02:07:55 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> unknown event type 37
> Jan 01 02:07:52 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> Jan 01 02:07:44 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
> QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
> *****
> 
> I question whether this also caused kemleak to crash as well (will
> post after this).
> 
> Regarding my tv tuner, it isn't supported by the kernel specifically,
> but is close enough that all I have to do is alter a single source
> file to include my device's pid, and it works just fine almost all of
> the time.
> 

The event type 37 is a host controller event, most likely a event ring full error.

So there are probably so many events that we fill the event ring before we can handle them.

Could you take traces of this?
Note that the trace file will be huge.

mount -t debugfs none /sys/kernel/debug
echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable

copy the traces somewhere safe once the error is triggered:
cp /sys/kernel/debug/tracing/trace  /<somewhere>

-Mathias
