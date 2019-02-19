Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CFC21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfBSIJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:09:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:54323 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfBSIJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:09:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 00:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="300810105"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2019 00:09:30 -0800
Subject: Re: [PATCH 4.4 026/143] usb: hub: delay hub autosuspend if USB3 port
 is still link training
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
References: <Pine.LNX.4.44L0.1902181036520.24068-100000@netrider.rowland.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <b12c7b8c-8c2f-3dc8-a7c6-5f68bf4edbbd@linux.intel.com>
Date:   Tue, 19 Feb 2019 10:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1902181036520.24068-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.2.2019 17.39, Alan Stern wrote:
> On Mon, 18 Feb 2019, Greg Kroah-Hartman wrote:
> 
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> [ Upstream commit e86108940e541febf35813402ff29fa6f4a9ac0b ]
>>
>> When initializing a hub we want to give a USB3 port in link training
>> the same debounce delay time before autosuspening the hub as already
>> trained, connected enabled ports.
>>
>> USB3 ports won't reach the enabled state with "current connect status" and
>> "connect status change" bits set until the USB3 link training finishes.
>>
>> Catching the port in link training (polling) and adding the debounce delay
>> prevents unnecessary failed attempts to autosuspend the hub.
>>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> We should be careful with this commit; it has caused problems for some
> people.  Mathias has been working to fix them, but this commit
> shouldn't go into -stable until the fixes are also ready to go.
> 

This commit should be fine, it gives ports in link training a bit more time
to finish. The commit causing issues is related, preventing runtime suspend
if ports are link training:

commit 2f31a67f01a8beb22cae754c53522cb61a005750
Author: Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Thu Nov 15 11:38:41 2018 +0200

     usb: xhci: Prevent bus suspend if a port connect change or polling state is detected

Turns out it causes suspend issues on some MacBooks

-Mathias
