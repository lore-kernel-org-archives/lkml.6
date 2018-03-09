Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Google-Smtp-Source: AG47ELtc9WBmIPQmG/Yrn4IB7p8WouyqeMKy0Fp1X0bEBOB23dHpZQH3Ry9LI+GeCxlvWl1D65Vj
ARC-Seal: i=1; a=rsa-sha256; t=1520555699; cv=none;
        d=google.com; s=arc-20160816;
        b=KtyNv291LRXFG/Pixr9EjT4YJhcsjGMFDZqo/g0tqDrS3J+1sucC4UwXMQh3D1eWpX
         epcoak51ztGiCLvMeEoz3R+C6Y9qWjs1pz9cAglfd9naCiNr1X/VEgZv3vNNIJoiHccc
         yqjBcZNHqVokbKkgn3AO49m+rgorMBLH4OllMGuTl2lRlv3iblIjNn25qXVuHIvRX/Q+
         4ne1p5HEwh3EnUVqIX8MS9ZdBvN3pAACrUD8BOwjG0/5waqIf089M241gMRSrKqPL3Np
         h1W5/Vxs4LgENEXvuzNoJjmJKydlI/9zLUJqrA4RNJ7Rip+4z0UVt7kngiODFpB89i8U
         G3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:arc-authentication-results;
        bh=23pHynXASDaoQHhWVaXGOyR4vJbMKcYujhbgpRpIlZk=;
        b=zkzqxDRfdGbvmIh3PtjCZtusyxeEEnFgwR2oyFTtVYxAqu1yfGgzPhWhsDl1QxlsI1
         84dphUlzNj+52qFwiEQEaNeegSFgFgERjuYwHsor12FM6b2BLTyhuqIbKH7yG2MkqKds
         AEWf2/aTqFrCHjIH5DWFcnMJiMw53SMYHhGywDHDf3+QUmPqWMeNu5ifmLK1xQrQLCfn
         2ZuadQjqoSfcy/G4M+SykmIM7OlAI3qPwAqmBJzg634DuadBVS861BqO7eCMfbB77Wnt
         OgC6bWWAhg5QYikRvDIESS9mNEx+2Gbz6ng2NOyHUmfznvwdN4qdecp2IFNahQ/FQQLj
         63WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="37187649"
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs array
 access
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>, johan@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20180307205840.GA6242@kroah.com>
 <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
 <1520499297.2983.3.camel@suse.com>
 <df24d0e5-73b1-3300-79a5-3dd7329f8a57@linux.intel.com>
 <20180308234306.GA22931@kroah.com>
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <a3cc4530-984e-cb7c-b3cf-38ad8cd7bb81@linux.intel.com>
Date: Thu, 8 Mar 2018 16:34:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308234306.GA22931@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594311837404941668?=
X-GMAIL-MSGID: =?utf-8?q?1594418212316121088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/08/2018 03:43 PM, Greg KH wrote:
> On Thu, Mar 08, 2018 at 03:29:48PM -0800, sathyanarayanan kuppuswamy wrote:
>>
>> On 03/08/2018 12:54 AM, Oliver Neukum wrote:
>>> Am Mittwoch, den 07.03.2018, 13:41 -0800 schrieb sathyanarayanan
>>> kuppuswamy       :
>>>> On 03/07/2018 12:58 PM, Greg KH wrote:
>>>>> So I don't see why your check is needed, what other code path would ever
>>>>> call this function in a way that the bounds check would be needed?
>>>> void usb_serial_generic_read_bulk_callback(struct urb *urb)
>>>>
>>>> 385         for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
>>>> 386                 if (urb == port->read_urbs[i])
>>>> 387                         break;
>>>> 388         }
>>>>
>>>> In here, after this for loop is done (without any matching urb), i value
>>>> will be equal to ARRAY_SIZE(port->read_urbs). So there is a possibility
>>>> of usb_serial_generic_submit_read_urb() getting called with this invalid
>>>> index.
>>> If this happens the function was called for a stray URB.
>>> Your check comes to late. We have called set_bit with an invalid index
>>> and other shit.
>>> We definitely do not just want to return an error in that case.
>> In that case do you think we should use some WARN_ON() for invalid index in
>> usb_serial_generic_read_bulk_callback()?
> No, again, how could that ever happen?
>
> Don't add pointless error checking for things that are impossible to
> ever hit :)
Thanks Greg.
>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
