Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB582C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F451208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsCmT/OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F451208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeHBJWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:22:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43416 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeHBJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:22:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so610993plv.10;
        Thu, 02 Aug 2018 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=myIY5EyyTU2LJbam4xfbYKQJHsikJ6yWByE2GiJowEE=;
        b=FsCmT/OAH412TN7UIsuI/uz/b46OkX9y+PJ3b/0Hol4Yq6BrScPUIH1OfxJJ1u0JGu
         sFhWFH8GwVzGXPnQ3r5gdaJZ+tk71lrIdFPpSiWYA35LLq5zZt9vdWbFmmcPKHQXgRZG
         gL+kAa7Z7WPAzdIbjq7S/11Z5DAQpu2h0ujUgG3jHFlS2SoIv0tUbDAL7p9Z0xQmMWfL
         BMxc3idZRxaQDOl7XWm77c6jDDGnwkB6Aeuc0jML6drLXrZ3ZTVboCJJAgeyG0qM9T9+
         flUzcS0pWEydIGee28knlEOo1bQbs3Ur3asiuyCpnQILmuYl1bl+xXFSkqaoOWb0l4O1
         2vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=myIY5EyyTU2LJbam4xfbYKQJHsikJ6yWByE2GiJowEE=;
        b=Jw5vMCmiRIcQuhZ01CXKhsy7Ry6hkAs8cDUJPMDg/0S5KVnzQytrytbjJ9uq5kUD7+
         bc/dMAKSZU+Vl78UW17vlmFztmxc+uCSDhw21+oBH8uJ7BY4g1FzTkvjWM8lkWqyJSXO
         TpIL3ZPw3gepB5ox/TVJE7+rhs7H14loJo2HymVVZPH6/2qLkhw/22yXMNapYOyUCETL
         YJas4FAh07xNerzdVqjGaEtPjV6lyjgdCJJK1ZfcX4/PfXcd+gwCMmVIiiceBQLsVYBt
         r+rpZp49V9EMYwToBmkdvC9/477t9umCQgljFgVRxC6OZRkZkFMf72sePlxmlKPbNgsk
         AESA==
X-Gm-Message-State: AOUpUlG0BEz/k2+0v0wMJFqdTs5xPijs/MmWpoiOt3z3+n6j/4prJiHC
        ThylmF/lrMEQOAlsdhN0r34=
X-Google-Smtp-Source: AAOMgpe447SP7ywM7ruhyUFCPzS2SOnudKbwNCIhEn7vfIkb9TFtCSsIpEQS0SoOBPadBllOvR6A/Q==
X-Received: by 2002:a17:902:b693:: with SMTP id c19-v6mr1396937pls.114.1533195174154;
        Thu, 02 Aug 2018 00:32:54 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.sparkbb.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id y18-v6sm1455899pfl.90.2018.08.02.00.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 00:32:53 -0700 (PDT)
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
To:     zhong jiang <zhongjiang@huawei.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com>
 <c99a75a2905c1eef50f94ccc0871c36af431e21a.camel@wdc.com>
 <5B627E71.5020600@huawei.com>
Cc:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <928ae07a-8c4a-05fc-16af-48fb6e9c341d@gmail.com>
Date:   Thu, 2 Aug 2018 19:32:37 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <5B627E71.5020600@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 02.08.2018 um 15:45 schrieb zhong jiang:
> On 2018/8/2 11:26, Bart Van Assche wrote:
>> On Thu, 2018-08-02 at 11:10 +0800, zhong jiang wrote:
>>> The same check condition is redundant, so remove one of them.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/scsi/NCR5380.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
>>> index 90ea0f5..2ecaf3f 100644
>>> --- a/drivers/scsi/NCR5380.c
>>> +++ b/drivers/scsi/NCR5380.c
>>> @@ -999,8 +999,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
>>>
>>>  	/* Check for lost arbitration */
>>>  	if ((NCR5380_read(INITIATOR_COMMAND_REG) & ICR_ARBITRATION_LOST) ||
>>> -	    (NCR5380_read(CURRENT_SCSI_DATA_REG) & hostdata->id_higher_mask) ||
>>> -	    (NCR5380_read(INITIATOR_COMMAND_REG) & ICR_ARBITRATION_LOST)) {
>>> +	    (NCR5380_read(CURRENT_SCSI_DATA_REG) & hostdata->id_higher_mask)) {
>>>  		NCR5380_write(MODE_REG, MR_BASE);
>>>  		dsprintk(NDEBUG_ARBITRATION, instance, "lost arbitration, deasserting MR_ARBITRATE\n");
>>>  		spin_lock_irq(&hostdata->lock);
>> Has this patch been tested?
>  I check the issue by doubletest.cocci. Just review the code by myself. Maybe I miss something else.
>  please tell let me know if you any objection.

This redundant load of the ICR has been in the driver code for a long 
time. There's a small chance it is intentional, so at least minimal 
testing might be in order.

Finn - does the ICR_ARBITRATION_LOST bit have to be cleared by a write 
to the mode register? In that case, the first load would have been 
redundant and can be omitted without changing driver behaviour?

Cheers,

	Michael


>
>  Thanks
>  zhong jiang
>> Thanks,
>>
>> Bart.
>>
>>
>>
>
>
