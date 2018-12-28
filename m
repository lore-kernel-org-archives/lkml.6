Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB54C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14F820873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeL1Mu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:50:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:51184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729597AbeL1Mu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:50:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E358FAEB9;
        Fri, 28 Dec 2018 12:50:54 +0000 (UTC)
Subject: Re: [PATCH 03/10] SCSI: fcoe: convert to use BUS_ATTR_WO
To:     James Bottomley <jejb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
 <20181221075442.17109-4-gregkh@linuxfoundation.org>
 <1545406185.2765.8.camel@linux.ibm.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5691ac07-ec5d-893f-09e4-ff1acd889abd@suse.de>
Date:   Fri, 28 Dec 2018 13:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545406185.2765.8.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 4:29 PM, James Bottomley wrote:
> [scsi list cc added]
> On Fri, 2018-12-21 at 08:54 +0100, Greg Kroah-Hartman wrote:
>> We are trying to get rid of BUS_ATTR() and the usage of that in the
>> fcoe driver can be trivially converted to use BUS_ATTR_WO(), so use
>> that instead.
>>
>> At the same time remove a unneeded EXPORT_SYMBOL() marking for the
>> sysfs callback function we are renaming, no idea of how that got into
>> the tree...
> 
> The EXPORT_SYMBOL removal is fine, but
> 
> [...]
>> --- a/include/scsi/libfcoe.h
>> +++ b/include/scsi/libfcoe.h
>> @@ -405,10 +405,8 @@ int fcoe_transport_attach(struct fcoe_transport
>> *ft);
>>   int fcoe_transport_detach(struct fcoe_transport *ft);
>>
>>   /* sysfs store handler for ctrl_control interface */
>> -ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
>> -			       const char *buf, size_t count);
>> -ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
>> -				const char *buf, size_t count);
>> +ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
>> size_t count);
>> +ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
>> size_t count);
> 
> You're really damaging our prefix namespace here.  It looks like the
> ctlr_ name is a farly recent addition for sysfs (only myra/b) use it in
> SCSI but it's inviting symbol clashes.
> 
Hmm. I was under the impression that all sysfs functions from myrb/myrs 
are local, hence I would not need to prefix them.
If this isn't the case I definitely will be fixing them.

But in any case, if possible any sysfs function should be local to the 
driver; no-one else should ever attempt to use them.
And we should be making it so if that's not the case.

Cheers,

Hannes
