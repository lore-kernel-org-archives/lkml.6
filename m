Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AIpwx48ja34XiXlF/byTUVW5O+gDPGKBdStde8oJyYQL75k14xQPbw5scwQmya31WEH3UYaqh+71
ARC-Seal: i=1; a=rsa-sha256; t=1522356214; cv=none;
        d=google.com; s=arc-20160816;
        b=zPo9rYRKI9Y/Lsev/QCxYvphKm1YGoRgmmaZTnzFGaFcWzGpI1bjATF531XWon/dY7
         5g6BrXN/U4GJnxGOHRnwa9Ku33Zqv8kxJI0pglqM2BqYez6yb704swAupAoXL9txg21M
         9CrimZCaHg4zVGZB38+wb7TATWIcG6/FCOFjYVozhFgNai55AxN/cTXfrX2LGptUJE6/
         MZbhHZKd9+S/a5D4lNFaWFAFgtCFUJoy0FY4MQtx87kRGwcmhFydeMMeiJjnN+pdjvdk
         ZZQyfpvRaTEk1nP9RQcm3IGkvMbVDOKgFm924pBCVj3gopn0piyC+Gq6IqDiy49slbrA
         MZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=xQtefIq1uzwXwvU2lFHw4Uy9L3k9wDavZYUqmYe7fKM=;
        b=iH/BSqvovI8ROZjTSZWJ9cgy6UaRZeNl/vxm64i5GrEZJ4gYWS6PnUyICJkB5KAxj9
         oxvffeGvJ5iYDqq3xSAsDopNsHT/uS6qB3Vtm3ch6M+y9psutNY4vNDi/XcwZLaFGP7o
         msA13myg+XQKbuGwcjbj7Rs7MVcFhAvgCu2m8udRnXKL5CfETcSyKy3spCv4MP15lCyY
         Y1xEvQLjbs5yz/Z3n51QupeszACkGrNsYxH5CRqDJyw9ccrUU1dgPewdNrhia/k0Imo2
         OmqI2eSDkCJt0JbeY9bnTEccHbZbbptLWmovoTwmDq0BSFS1Js/x6S/vF+9UNPXPLl7o
         CgDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95938217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180329170618.GE8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org> <20180329153658.11614-5-mdf@kernel.org>
 <20180329170618.GE8501@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 29 Mar 2018 15:42:51 -0500
X-Gmail-Original-Message-ID: <CANk1AXSDDe_PKsx+9CEAN0ZFdb+efqJPWxLfVM2t9xPAQFNctQ@mail.gmail.com>
Message-ID: <CANk1AXSDDe_PKsx+9CEAN0ZFdb+efqJPWxLfVM2t9xPAQFNctQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] fpga: region: change fpga_region_register to have one param
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287282137577782?=
X-GMAIL-MSGID: =?utf-8?q?1596306189735714717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 12:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

Hi Greg,

>> -int fpga_region_register(struct device *dev, struct fpga_region *region)
>> +int fpga_region_register(struct fpga_region *region)
>>  {
>> +     struct device *dev = region->parent;
>>       int id, ret = 0;
>>
>> +     if (!dev) {
>> +             pr_err("Attempt to register fpga region without parent\n");
>> +             return -EINVAL;
>> +     }
>
> Are you sure you don't want a virtual device?  That is what will happen
> if you do not have a parent, right?  Or do you always want to have
> "real" devices?

I don't want to restrict this to "real" devices, so yes, I'll be
removing this check.

>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> index b6520318ab9c..423c87e3e29a 100644
>> --- a/include/linux/fpga/fpga-region.h
>> +++ b/include/linux/fpga/fpga-region.h
>> @@ -8,6 +8,7 @@
>>  /**
>>   * struct fpga_region - FPGA Region structure
>>   * @dev: FPGA Region device
>> + * @parent: parent device
>>   * @mutex: enforces exclusive reference to region
>>   * @bridge_list: list of FPGA bridges specified in region
>>   * @mgr: FPGA manager
>> @@ -18,6 +19,7 @@
>>   */
>>  struct fpga_region {
>>       struct device dev;
>> +     struct device *parent;
>
> Why doesn't your dev parent pointer point to this, why do you need to
> have a separate pointer?  That feels really wrong.  Pass in the parent
> pointer when you create the struct device, otherwise it will be
> registered incorrectly anyway.  Then you always have the correct
> pointer, no need to keep a "spare" copy.

I'll add a fpga_mgr_create function and let it set the parent.  No
need to save it.

Thanks again for the review,
Alan

>
> thanks,
>
> greg k-h
