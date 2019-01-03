Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C8820675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfACVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:00:25 -0500
Received: from smtp.infotech.no ([82.134.31.41]:50880 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfACVAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:00:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 2133420423B;
        Thu,  3 Jan 2019 22:00:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MKwROC4O7+Tz; Thu,  3 Jan 2019 22:00:15 +0100 (CET)
Received: from [192.168.48.23] (host-184-164-16-103.dyn.295.ca [184.164.16.103])
        by smtp.infotech.no (Postfix) with ESMTPA id 37558204191;
        Thu,  3 Jan 2019 22:00:13 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
To:     Randall Huang <ihhuang@abmail.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     huangrandall@google.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181226041504.66283-1-huangrandall@google.com>
 <20190103075133.GA5141@infradead.org> <20190103094755.GA96532@google.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
Date:   Thu, 3 Jan 2019 16:00:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190103094755.GA96532@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-03 4:47 a.m., Randall Huang wrote:
> On Wed, Jan 02, 2019 at 11:51:33PM -0800, Christoph Hellwig wrote:
>> On Wed, Dec 26, 2018 at 12:15:04PM +0800, Randall Huang wrote:
>>> In SPC-3, WRITE(10)/(16) support grouping function.
>>> Let's associate bio write hint with group number for
>>> enabling StreamID or Turbo Write feature.
>>>
>>> Signed-off-by: Randall Huang <huangrandall@google.com>
>>> ---
>>>   drivers/scsi/sd.c | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>>> index 4b49cb67617e..28bfa9ed2b54 100644
>>> --- a/drivers/scsi/sd.c
>>> +++ b/drivers/scsi/sd.c
>>> @@ -1201,7 +1201,12 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
>>>   		SCpnt->cmnd[11] = (unsigned char) (this_count >> 16) & 0xff;
>>>   		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
>>>   		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
>>> -		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
>>> +		if (rq_data_dir(rq) == WRITE) {
>>> +			SCpnt->cmnd[14] = rq->bio->bi_write_hint & 0x3f;
>>> +		} else {
>>> +			SCpnt->cmnd[14] = 0;
>>> +		}
>>
>> No need for braces here.
> Already send a new version
>>
>> But what I'm more worried about is devices not recognizing the feature
>> throwing up on the field.  Can you check what SBC version first
>> references these or come up with some other decently smart conditional?
> My reference is SCSI Block Commands – 3 (SBC-3) Revision 25.
> Section 5.32 WRITE (10) and 5.34 WRITE (16)
> 
>> Maybe Martin has a good idea, too.
> 

That is the GROUP NUMBER field. Also found in READ(16) at the same
location within its cdb. The proposed code deserves at least an
explanatory comment.

Since it is relatively recent, perhaps the above should only be done iff:
    - the REPORT SUPPORTED OPERATION CODES (RSOC) command is supported, and
    - in the RSOC entry for WRITE(16), the CDB USAGE DATA field (a bit mask)
      indicates the GROUP NUMBER field is supported

That check can be done once, at disk attachment time where there is already
code to fetch RSOC.


Is there a bi_read_hint ? If not then the bi_write_hint should also be applied
to READ(16). Makes that variable naming look pretty silly though.

Doug Gilbert

