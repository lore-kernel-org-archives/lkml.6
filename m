Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520792659; cv=none;
        d=google.com; s=arc-20160816;
        b=EYos5+y2p7SrNlVV+bDs2rAvPorAT6ubG/lELbPobB6Ckf/HTRHcGBnQF5vU4qsejO
         /HFJXSdrpDH07u0DOzFOqt3qf+m5uRBM5dAy/etLO/Mx++cOTLCpKuKO3OetopYgMzSO
         WeL4T886EVamB12kYw5LcZ+j2p2SNGTapA7fy7WAVx3rK7B0Bu25lNPZgNj35uZ2CxFb
         iZmTriCcl5K0gUnYDQj4yQ+NAmqTXfBGxi60dF3spehHcs91Lc4Jd8OblBbpa9QplXm2
         giAmLunhRBRA/yAqbVA5V+6azYaWaSI/TFTceWzOzoITXCWsDK4J+E764wC9X2dOOY2Z
         di/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QNbgVdIsb7eHpWim6uSOclNqLn2fqiaspfICiuCiYIE=;
        b=K1lf9Gx4FOIYnQWbnVMjw+Ux0j1s23OEQ2XoJZS5WTapbuA4aBzHIAF/L8egPvJHOG
         RXA2CpAgMHvJ10hF2/FrrBpoG3TFIQM6hqWIj7q9uAk4aGQI282vAXLdL26BY+YO82IO
         W/BcM/PPf2oIUG6v7ImHXyXP5LnSn45paVVtAOnRnu/94WMkTU4fXVHhm6BZHMyKPyCQ
         gfBi3iw636j3U1gRM3U6tU4lUdqBHhvP9O2SWjYk/3ZJtwb4pHaPdSnlkIC4euio84tQ
         C19QggNvb+15B+pK3/7KXnmgHycaWcIGaePC2y4qinO203YT/xqYXOt8rAQ9BXKs1sfn
         5Uhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELuQtQ7ZGJPp8RFif6R73OOlD8S3wo87thCRX39evJM2NMIdBkgKvZnJzSq88Q/veIP7/RVCzg==
Subject: Re: [PATCH v6 01/12] drivers: base: Unified device connection lookup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180302102057.8917-1-hdegoede@redhat.com>
 <20180302102057.8917-2-hdegoede@redhat.com>
 <20180309175347.GA12150@kroah.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <bddcf7ea-e58c-637a-e546-9978fd2cb540@redhat.com>
Date: Sun, 11 Mar 2018 19:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309175347.GA12150@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593820906030657716?=
X-GMAIL-MSGID: =?utf-8?q?1594666683984119308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

On 09-03-18 18:53, Greg Kroah-Hartman wrote:
> On Fri, Mar 02, 2018 at 11:20:46AM +0100, Hans de Goede wrote:
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> Several frameworks - clk, gpio, phy, pmw, etc. - maintain
>> lookup tables for describing connections and provide custom
>> API for handling them. This introduces a single generic
>> lookup table and API for the connections.
>>
>> The motivation for this commit is centralizing the
>> connection lookup, but the goal is to ultimately extract the
>> connection descriptions also from firmware by using the
>> fwnode_graph_* functions and other mechanisms that are
>> available.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Sorry for the delay, just now reviewing this patch...
> 
> The content is fine (if not scary for the obvious reason of passing
> around 'struct device' of different bus types, but ok...), but the api
> naming is "rough":


Heikki, I think it is best if you answer Greg's remarks. FWIW I'm
fine with the changes Greg proposes.

I currently have significantly less bandwidth for this due to
personal circumstances, so if a new version of this patch-set
is necessary it would be great if you (Heikki) can do a v7.

Regards,

Hans

> 
>> --- /dev/null
>> +++ b/include/linux/connection.h
> 
> "connection.h" is vague, why not just put this in device.h? >
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#ifndef _LINUX_CONNECTION_H_
>> +#define _LINUX_CONNECTION_H_
>> +
>> +#include <linux/list.h>
>> +
>> +struct device;
>> +
>> +/**
>> + * struct devcon - Device Connection Descriptor
>> + * @endpoint: The names of the two devices connected together
>> + * @id: Unique identifier for the connection
>> + * @list: List head, private for devcon internal use only
>> + */
>> +struct devcon {
> 
> 'struct device_connection'?  Spell it out please, people might think
> this is a "developer conference" :)
> 
>> +	const char		*endpoint[2];
>> +	const char		*id;
>> +	struct list_head	list;
>> +};
>> +
>> +void *__device_find_connection(struct device *dev, const char *con_id,
>> +			       void *data,
>> +			       void *(*match)(struct devcon *con, int ep,
>> +					      void *data));
> 
> Ick, __* functions are usually "no lock needed", but here you are doing
> a lot "more" than the normal device_find_connection() call.  Why not
> make this:
> 	device_connection_find_match()?
> 
>> +
>> +struct device *device_find_connection(struct device *dev, const char *con_id);
> 
> device_connection_find()?
> 
>> +
>> +#define DEVCON(_ep0, _ep1, _id)    (struct devcon) { { _ep0, _ep1 }, _id, }
> 
> Can you use named identifiers here?
> 
>> +
>> +void add_device_connection(struct devcon *con);
>> +void remove_device_connection(struct devcon *con);
> 
> device_connection_add() and device_connection_remove()?
> 
> I can make the api name changes in an add-on patch.
> 
> thanks,
> 
> greg k-h
> 
