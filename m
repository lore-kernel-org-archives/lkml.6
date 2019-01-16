Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9363C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A38120675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QHtJECbo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QHtJECbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfAPEeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:34:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfAPEeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:34:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E4C3460312; Wed, 16 Jan 2019 04:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547613252;
        bh=3xER5RN0xXxvu0aj80tXiuMRblczkIizlA9M+NSem4M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QHtJECbogmoAuKCkQOixBGyYdGnpl9rGxsE/SsOf9giX/dFcraq8dbxb/GJD174Uw
         m0r664Gef1KbOiN6b0LZp2k5OVLZ6PeS5Aiz8j/TF6jPd0Vyx4OwUewQ+I1WI16GMw
         Q2Msi3CWHyBpkLjTR7+nD570l3G0Ds2rvM+o22Sw=
Received: from [10.206.24.188] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A69806071A;
        Wed, 16 Jan 2019 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547613252;
        bh=3xER5RN0xXxvu0aj80tXiuMRblczkIizlA9M+NSem4M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QHtJECbogmoAuKCkQOixBGyYdGnpl9rGxsE/SsOf9giX/dFcraq8dbxb/GJD174Uw
         m0r664Gef1KbOiN6b0LZp2k5OVLZ6PeS5Aiz8j/TF6jPd0Vyx4OwUewQ+I1WI16GMw
         Q2Msi3CWHyBpkLjTR7+nD570l3G0Ds2rvM+o22Sw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A69806071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Fail request submission if it was
 already queued
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190111060212.7390-1-mgautam@codeaurora.org>
 <87pnt3od02.fsf@linux.intel.com>
 <d0f73188-7943-146f-5944-1bfd74bdce77@codeaurora.org>
 <87k1jbo8hm.fsf@linux.intel.com>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <5ede621a-b1da-bf46-2b9e-938897a728e3@codeaurora.org>
Date:   Wed, 16 Jan 2019 10:04:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87k1jbo8hm.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/11/2019 2:51 PM, Felipe Balbi wrote:
> Hi,
>
> Manu Gautam <mgautam@codeaurora.org> writes:
>>> Manu Gautam <mgautam@codeaurora.org> writes:
>>>> If a function driver tries to re-submit an already queued request,
>>>> it can results in corruption of pending/started request lists.
>>>> Catch such conditions and fail the request submission to DCD.
>>>>
>>>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>>>> ---
>>>>  drivers/usb/dwc3/gadget.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 679c12e14522..51716c6b286a 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -1290,6 +1290,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>>>  				&req->request, req->dep->name))
>>>>  		return -EINVAL;
>>>>  
>>>> +	if (req->request.status == -EINPROGRESS) {
>>> this test is really not enough. What if gadget driver set status to
>>> EINPROGRESS before submission? A better check would involve making sure
>>> req isn't part of dep->pending_list or dep->started_list or
>>> dep->cancelled_list. It's clear that this won't work very well as the
>>> amount of requests grow.
>> Thanks for quick review.
>> 'request.status' check can be replaced:
>> +if (!list_empty(&req->list) {
>>
>> And replace list_del with list_del_init from dwc3_gadget_giveback()
> I would rather avoid this. We could start tracking our own internal
> dwc3_request status. Something along the lines of:

Thanks for this quick patch.

[snip]

>  
> With this, we can remove some of the other request flags, such as "started".
>
>>> Anyway, which gadget driver did this? Why is it only affecting dwc3?
>> Function driver is not in upstream (f_mtp.c).
> So this could happen with any UDC, right? Why is f_mtp.c queueing the
> same request twice?


Looks like chipidea UDC already has such a check.
It is not yet clear that why f_mtp queued same request twice.
However, having a safeguard check in UDC should be helpful.


>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

