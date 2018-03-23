Return-Path: <zhengjun.xing@linux.intel.com>
X-Google-Smtp-Source: AG47ELu1WLODIGrbcTzefAEsDYc1uJYCSZepUvnL9XHb85KlKkGxxxJn+sA0ZzHFvRF+fCMKznQp
ARC-Seal: i=1; a=rsa-sha256; t=1521766186; cv=none;
        d=google.com; s=arc-20160816;
        b=LM1W4eugtL9Q4IJkskUTnYdhMFxEVLjVeBgKJj1fUxl49KpQKM5E49AXO8MXY7X4T6
         aZeyV0RzPYWynWmpuxvaCZdPnwvH/XxdaIMtxieCUAlQBFYrBhmlRgY5GwtVPdLT76te
         WQ35asbqSyJcJKeBy6Hw6Lmef2Fav2+QGL2kY507Px7f62c/5exut0StrPqZoanlr1lq
         funHJYhbwvN9d08Jg0lbnK9j/HGW8MS22eaIW7UNNYrGzZPzBol+9EfktvaQ9+Az9hZR
         yjoCmn76Y8hd5Axoknb8T2l4iiygstlKXQ5IBqlxmZBTJIrooECWnw6ZMKDRrQsHeM5m
         f6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=aNm4BMGODbyIBE4VgNuq3HHNRxsWhS9z3cLwuCpvEUY=;
        b=Rqq51cpPHpGu11l9Kmj7+ef6CqDbbIwCrfjaDHlf/1N6qXm0ug9U1MGVrys5pxVF3S
         Kw7fTyBrZIGABZ2PAWOPwS5SPuzBzUNVBxi3VC7An8qnjwdU67Lf3/liX2gS48bf8J9M
         /iPB+Rzk9qW8S4eZSRoDsBdVynfvV21CKrxD3eZQA3ulLTc8WZmr4bAREmvSdolbY9Ga
         D/UnvamgZRKTQq1I4XGQlOSytjZtZnP2RiRMa2nlvB8CMYpdr82UrCix8lrbGHM0n5M5
         awAzUt+EkUKOkl7SsP0bp1FU4gsZgCbPVtaVHDbdqbXIztkhRbH/doosqtkN4ozM8kO/
         TSAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of zhengjun.xing@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=zhengjun.xing@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of zhengjun.xing@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=zhengjun.xing@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="scan'208";a="214081274"
Subject: Re: [PATCH] USB:fix USB3 devices behind USB3 hubs not resuming at
 hibernate thaw
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180321052942.2853-1-zhengjun.xing@linux.intel.com>
 <20180322120323.GB3304@kroah.com>
From: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <1ec607c8-9f55-ab57-9ae7-0d3420ae56d4@linux.intel.com>
Date: Fri, 23 Mar 2018 08:49:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322120323.GB3304@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595523829497410329?=
X-GMAIL-MSGID: =?utf-8?q?1595687500844128556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/22/2018 8:03 PM, Greg KH wrote:
> On Wed, Mar 21, 2018 at 01:29:42PM +0800, Zhengjun Xing wrote:
>> USB3 hubs don't support global suspend.
>>
>> USB3 specification 10.10, Enhanced SuperSpeed hubs only support selective
>> suspend and resume, they do not support global suspend/resume where the
>> hub downstream facing ports states are not affected.
>>
>> When system enters hibernation it first enters freeze process where only
>> the root hub enters suspend, usb_port_suspend() is not called for other
>> devices, and suspend status flags are not set for them. Other devices are
>> expected to suspend globally. Some external USB3 hubs will suspend the
>> downstream facing port at global suspend. These devices won't be resumed
>> at thaw as the suspend status flag is not set.
>>
>> A USB3 removable hard disk connected through a USB3 hub that won't resume
>> at thaw will fail to synchronize SCSI cache, return “cmd cmplt err -71”
>> error, and needs a 60 seconds timeout which causing system hang for 60s
>> before the USB host reset the port for the USB3 removable hard disk to
>> recover.
>>
>> Fix this by always calling usb_port_suspend() during freeze for USB3
>> devices.
> This should go to the stable trees as well, right?
>
> greg k-h
   Yes. It should go to the stable trees.
