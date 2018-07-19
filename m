Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F80C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTSO+uac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F80C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbeGSRm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeGSRm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:42:27 -0400
Received: from [10.82.11.247] (unknown [131.107.174.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35902084E;
        Thu, 19 Jul 2018 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532019505;
        bh=KrADOXqxJuvb0BRFYf5bSN69WybUJNJG0NBJdMFDXIE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UTSO+uacnvnHkwvfgghVqaEX8WhaNLOeGb5YURCuHE1j84OvK4fTSIT6hZ0Z6qfgZ
         JC0GnrjZOCt3iMpxDvxvaTcplzzN/AhYHXgJ3jti+14ycD7hxFXbio8CGkRdyR3pZD
         ESsYwus1YviIBqB898hmDnYnjvmXxItk3Fz+dwds=
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To:     "Alex G." <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
 <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <da6335db-1e6b-c19b-4bbd-0f5523484e0e@kernel.org>
Date:   Thu, 19 Jul 2018 09:58:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2018 8:55 AM, Alex G. wrote:
> I find the intent clearer if we check it here rather than having to do 
> the mental parsing of the state of aer_cap.

I don't feel too strong about my comment to be honest. This was a
style/maintenance comment.

It feels like we are putting pcie_aer_get_firmware_first() into core
functions unnecessarily after your change. I understand the need for
your change. I'm asking if it is the right place or not.

pcie_aer_get_firmware_first() should be called from either the init or
probe function so that the rest of the AER functions do not get called
from any other context.

If someone adds another AER function, we might need to add another
pcie_aer_get_firmware_first() check there. So, we have unnecessary code
duplication.
