Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9224ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF5620841
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF5620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeGQQaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:30:08 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:60343 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbeGQQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:30:08 -0400
X-IronPort-AV: E=Sophos;i="5.51,366,1526342400"; 
   d="scan'208";a="60430637"
Subject: Re: [RFC 1/1] libiscsi: Fix race between iscsi_xmit_task and
 iscsi_complete_task
From:   Anoob Soman <anoob.soman@citrix.com>
To:     <lduncan@suse.com>, <cleech@redhat.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <open-iscsi@googlegroups.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1530543624-130587-1-git-send-email-anoob.soman@citrix.com>
 <5cc14ea6-2586-ce2b-f8c4-c46222280df7@citrix.com>
Message-ID: <41949f23-794e-60c8-ce0f-fcb170b1db39@citrix.com>
Date:   Tue, 17 Jul 2018 16:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5cc14ea6-2586-ce2b-f8c4-c46222280df7@citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:43, Anoob Soman wrote:
> On 02/07/18 16:00, Anoob Soman wrote:
>> ---
>>   drivers/scsi/libiscsi.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
>> index d609383..aa3be6f 100644
>> --- a/drivers/scsi/libiscsi.c
>> +++ b/drivers/scsi/libiscsi.c
>> @@ -1449,7 +1449,13 @@ static int iscsi_xmit_task(struct iscsi_conn 
>> *conn)
>>       if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx))
>>           return -ENODATA;
>>   +    spin_lock_bh(&conn->session->back_lock);
>> +    if (conn->task == NULL) {
>> +        spin_unlock_bh(&conn->session->back_lock);
>> +        return -ENODATA;
>> +    }
>>       __iscsi_get_task(task);
>> +    spin_unlock_bh(&conn->session->back_lock);
>>       spin_unlock_bh(&conn->session->frwd_lock);
>>       rc = conn->session->tt->xmit_task(task);
>>       spin_lock_bh(&conn->session->frwd_lock);
>
>
> Hi Chris, Lee.
>
> Could one of you look at this change and provide some comments ?
>
> Thanks,
>
> -Anoob.
>

Hi,

Can someone look at this change ?

Thanks,

Anoob.

