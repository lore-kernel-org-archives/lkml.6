Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZqnr3EPEkTGv3JR6Gb62qhGMlGtSbBlL5Fv4xdPCuLyGSnU9NVZ20ucGPzweNdmr81PFovu
ARC-Seal: i=1; a=rsa-sha256; t=1526579878; cv=none;
        d=google.com; s=arc-20160816;
        b=Tg8evYipJNzvSpc4vVSoTYYIYmhfqH1IJGpK+8nfB33MDh6nbIm29Ewi3zJplaFmHr
         NWrEwwhBehayue1gz2cp5+CI3BchJbtIsNC2GyHXYBrca0lsV2E3vDSFDki756LuZtQh
         2Vf4bI9Q1l3Uq2/I7+zP6qBCrApV9Alc0Sbsc4Hh+kZOtL7qiTyyVyGCu75zUK607duq
         mKtL/hTrqncjaVC+mbmFuzrYhc4MaimQqKJdnnJ/KBREtSrqPJ9w3+7VtsxJk7a/W0rq
         Q5kn7AzpFzIEd9SlMeQY2mbYZhuSDcfuU5wa5O5BO1OSiHwe9lGkcm5RlcMVa2C+L5E0
         sATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+bQYIjC57OKRqmecOphBWZBKgeM3FHG6EF9a2JybBSE=;
        b=m719yKa9vHhpoJeCzZqHySfHS+BYBNDjYTCzxCsozbk8d3aINkqa8kowZ7sLSxVuX5
         1so9H9uT3G7D5PN5f5djt+5jnLN5v4eyjOG5iYOL9qZdhsMNGP+4ZcqHDzeSBztylP5w
         WcE4q/ar6wWSO6WJL9EBMyVOTwCdqoLW4c9W30YsRzVqp28j5S8AmEGBzp461N3QF6v+
         NP9nWWwIT6KLucUlv/48cCv2oHtmapDpLTbOMepuA6RcicQARo8BloyxRZzZJBony/Ha
         6eKalWtAc+d7LW/1sLiZIkfGTdNR2wpcqWGAPMFxkX0p1Jax+shArWrBrEKqI5g3dqYN
         Rz8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.143.5 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.143.5 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Subject: Re: [PATCH] usbip: vhci_sysfs: fix potential Spectre v1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180516222200.GA14733@embeddedor.com>
 <20180517065117.GA12910@kroah.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba00b923-3ff0-95db-2939-7da27d34fe6c@embeddedor.com>
Date: Thu, 17 May 2018 12:57:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517065117.GA12910@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fJNA4-003Tyu-Sv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.172.56.86]:42034
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600735022099586444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 05/17/2018 01:51 AM, Greg Kroah-Hartman wrote:
> On Wed, May 16, 2018 at 05:22:00PM -0500, Gustavo A. R. Silva wrote:
>> pdev_nr and rhport can be controlled by user-space, hence leading to
>> a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential
>> spectre issue 'vhcis'
>> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential
>> spectre issue 'vhcis'
>> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential
>> spectre issue 'vhci->vhci_hcd_ss->vdev'
>> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential
>> spectre issue 'vhci->vhci_hcd_hs->vdev'
> 
> Nit, no need to line-wrap long error messages from tools :)
> 

Got it.

>> Fix this by sanitizing pdev_nr and rhport before using them to index
>> vhcis and vhci->vhci_hcd_ss->vdev respectively.
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/usb/usbip/vhci_sysfs.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>> index 4880838..9045888 100644
>> --- a/drivers/usb/usbip/vhci_sysfs.c
>> +++ b/drivers/usb/usbip/vhci_sysfs.c
>> @@ -10,6 +10,8 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   
>> +#include <linux/nospec.h>
>> +
>>   #include "usbip_common.h"
>>   #include "vhci.h"
>>   
>> @@ -235,6 +237,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>>   	if (!valid_port(pdev_nr, rhport))
>>   		return -EINVAL;
>>   
>> +	pdev_nr = array_index_nospec(pdev_nr, vhci_num_controllers);
>> +	rhport = array_index_nospec(rhport, VHCI_HC_PORTS);
> 
> Shouldn't we just do this in one place, in the valid_port() function?
> 
> That way it keeps the range checking logic in one place (now it is in 3
> places in the function), which should make maintenance much simpler.
> 

Yep, I thought about that, the thing is: what happens if the hardware is 
"trained" to predict that valid_port always evaluates to false, and then 
malicious values are stored in pdev_nr and nhport?

It seems to me that under this scenario we need to serialize 
instructions in this place.

What do you think?

Thanks
--
Gustavo
