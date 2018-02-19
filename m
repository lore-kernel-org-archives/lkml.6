Return-Path: <prvs=5812f868a=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AH8x224aVed1gjSmQCIC8VzFgrn11sooWkDxeX3RLCwmywf+m/W53wtoQ+DLUF2AqACBwNJdRdXI
ARC-Seal: i=1; a=rsa-sha256; t=1519049537; cv=none;
        d=google.com; s=arc-20160816;
        b=gxXXu1pR4pEQzFlCoyilrPIEjucouL/g0aSICsadH3n9gxfapon/jYnfvsyuNvj135
         aLUxz3eiM0Thb3QP6ZXBdZ77NpUmkptqDgWfrRQM/0Gg202X/+yTkBFIGkFx6QQdaJSP
         QKViMayF4RtguV4esxlRTXNDmUDhyJHHoLFbo2gneTAHXzh6ajnFexB/dTPRYL7U/HWk
         fiN6YdE7HFC3ilSW0hRCFM0XykjLjkNuBxAqOlKVT0HB0d62jNPba5BeRpLun+LH+1AI
         nnxKxgvSHkj8qNGAGI3COQFheCi/GxPPj8jMepuwjBLod7d9AjAttW3L48HSLcpWh1NW
         Yc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=y+cS+poBQlj0zhmvOBp7dJiK8GcTDwGrdhaA5QS7FxE=;
        b=a7irsf1xXJ/4L91uVFI/gfDNX526KRSyvTl23K9P85gWZHoqv3FTjzTOahSy0VSrol
         EwUPaRLhM+ee/LvWsX6eAxTInKDisCM4zl8cesQ34Nj8nBL1WHdudna/pP7EZ6bwIR+O
         tFlUgp4ywKUGqK+XlYPYWJJtn9EP1asE++KyXMoCpZQ3nnDNQC0r8M3AC7m4nCymhpvC
         QLKTpHtsma7VyIKN/Wb4BjuGFwELCVBeFw6OEi51aMmU//9zrS4mP8VDhV6Epolu/hY+
         EPQd/4jTolCihBiUc38IeAnn7tdem88dN/5l2EZYJssRhLLZJSZKRzwcCg1rYzYKAtZH
         0UBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=5812f868a=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=5812f868a=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=5812f868a=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=5812f868a=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.46,535,1511823600";
   d="scan'208";a="1283230"
Subject: Re: [PATCH] usb: core: introduce per-port over-current counters
To: Felipe Balbi <felipe.balbi@linux.intel.com>, Richard Leitner
	<dev@g0hl1n.net>, <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
	<linux@roeck-us.net>, <mathias.nyman@linux.intel.com>, <johan@kernel.org>,
	<ekorenevsky@gmail.com>, <peter.chen@nxp.com>, <drake@endlessm.com>,
	<joe@perches.com>
References: <20180219120107.20434-1-dev@g0hl1n.net>
 <874lmdgk5k.fsf@linux.intel.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <402e4e43-b422-c2c3-391f-4f0454da6e53@skidata.com>
Date: Mon, 19 Feb 2018 15:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <874lmdgk5k.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592830659623275207?=
X-GMAIL-MSGID: =?utf-8?q?1592838887557875648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 02/19/2018 02:53 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Richard Leitner <dev@g0hl1n.net> writes:
> 
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> For some userspace applications information on the number of
>> over-current conditions at specific USB hub ports is relevant. Therefore
>> introduce a oc_counter in the usb port struct which is exported via
>> sysfs.
> 
> relevant how? What can the application do with that knowledge?

In our case we have a series of USB hardware (using the cp210x driver) which
communicates using a proprietary protocol. These devices sometimes trigger an
over-current situation on some hubs. In case of such an over-current situation
the USB devices offer an interface for reducing the max used power.
As these conditions are quite rare and imply performance reductions of the
device we don't want to use reduce the max power always.

With this patch I want to give the user-space application the possibility to
react adequately to such over-current situations.

I hope this explains my motivation for this patch in a comprehensible way.

> 
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>> ---
>> Tested on an i.MX6DL based board.
>> ---
>>  drivers/usb/core/hub.c  |  4 +++-
>>  drivers/usb/core/hub.h  |  1 +
>>  drivers/usb/core/port.c | 10 ++++++++++
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index c5c1f6cf3228..448fba1e1827 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
>>  
>>  	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
>>  		u16 status = 0, unused;
>> +		port_dev->oc_count++;
>>  
>> -		dev_dbg(&port_dev->dev, "over-current change\n");
>> +		dev_dbg(&port_dev->dev, "over-current change #%u\n",
>> +			port_dev->oc_count);
>>  		usb_clear_port_feature(hdev, port1,
>>  				USB_PORT_FEAT_C_OVER_CURRENT);
>>  		msleep(100);	/* Cool down */
>> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
>> index 2a700ccc868c..b5cf567bf9e2 100644
>> --- a/drivers/usb/core/hub.h
>> +++ b/drivers/usb/core/hub.h
>> @@ -100,6 +100,7 @@ struct usb_port {
>>  	unsigned int is_superspeed:1;
>>  	unsigned int usb3_lpm_u1_permit:1;
>>  	unsigned int usb3_lpm_u2_permit:1;
>> +	unsigned int oc_count;
>>  };
>>  
>>  #define to_usb_port(_dev) \
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 1a01e9ad3804..0bfe410eb8a7 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(connect_type);
>>  
>> +static ssize_t oc_count_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	struct usb_port *port_dev = to_usb_port(dev);
>> +
>> +	return sprintf(buf, "%u\n", port_dev->oc_count);
>> +}
>> +static DEVICE_ATTR_RO(oc_count);
> 
> I would actually spell this out human readable: over_current_count
> 

Would be fine for me.

regards;Richard.L
