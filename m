Return-Path: <tomeu.vizoso@collabora.com>
X-Google-Smtp-Source: AIpwx49yt7VpN568UtksY2OqmNXd3jAynoCzMl6lZOvG4F188cT20UlE7Vd2tm/TgQUfGSS78qzt
ARC-Seal: i=1; a=rsa-sha256; t=1522915853; cv=none;
        d=google.com; s=arc-20160816;
        b=ze0LbTVWW9wE7LMeQHMBrFlJwhqYK2wLgVd+Z8edooNiZP6/B+/4xe5C3X+TtW4X5C
         ZAXEixnaivn3UjlOG73zQMgUxXRvgfGgZDI/5vYX+9XGEbsgAWiAYhGP+XOSPp1lSO6z
         USWHMOX0/eNSRgbiXa0mIAhZMwVx5EvEQIdk/qumj6B+g7fktQ1tZNZ6hGVKL8Fo12Pp
         vM8PWJ9zQV/6WUQYpvB7ylFR2xRNJ6L8Qc+6uCe7+gNlkbVFouzvBRJ0o0WG//oi64Tl
         1hxaoRn9QB9a4uCBUpRzNnagPtcZ/kgHxkaBaOMWn9QW6xSfvbAJnrpf3HFjSujesr6N
         hHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=AWDp1w2ikwEZks39KtclSwgW520WDW7+xajEgRos4xE=;
        b=L7haMJcqrcKedlpYI0GWCApAoPRIi0dVsavGCxGgrsd9dUYcm9RS3tbuitFgEZxdFr
         k4MkoqvYIpqc5as/cSMsfHGFtLPPRASavzS4wDaXXZjAPa/5w+a8k6tvMR+kx8tBOSBD
         Okam65MGiKfoqRvEErMPKIUF/c2ZpckORO96RS0pmC2oXcqgqTx/VYAzp1d2KMFNZpxK
         523BlK7htVM+MIoF0sQEJdGrDjbFVaUG4s26AQzFDyvQfsQDyRhGC8MN6yX+x/5GHbfB
         AHksTMM99Sz4of5ihfd23uA+d/WJM7dmOSF2qBxAEy0eAIN/UOEeDXF78Km4+4X6/Ku6
         3qvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomeu.vizoso@collabora.com designates 46.235.227.227 as permitted sender) smtp.mailfrom=tomeu.vizoso@collabora.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomeu.vizoso@collabora.com designates 46.235.227.227 as permitted sender) smtp.mailfrom=tomeu.vizoso@collabora.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
 Heiko Stuebner <heiko@sntech.de>, Amelie Delaunay <amelie.delaunay@st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180326090001.57627-1-tomeu.vizoso@collabora.com>
 <410670D7E743164D87FA6160E7907A560113AE527D@am04wembxb.internal.synopsys.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <fe9292c5-e90b-96fd-aa73-ea82e7497281@collabora.com>
Date: Thu, 5 Apr 2018 10:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <410670D7E743164D87FA6160E7907A560113AE527D@am04wembxb.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630296773142922?=
X-GMAIL-MSGID: =?utf-8?q?1596893013650491406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Minas,

On 04/05/2018 09:54 AM, Minas Harutyunyan wrote:
> Hi Tomeu,
> 
> On 3/26/2018 1:01 PM, Tomeu Vizoso wrote:
>> devm_regulator_get_optional returns -ENODEV if the regulator isn't
>> there, so if that's the case we have to make sure not to leave -ENODEV
>> in the regulator pointer.
>>
>> Also, make sure we return 0 in that case, but correctly propagate any
>> other errors. Also propagate the error from _dwc2_hcd_start.
>>
>> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
>> Cc: Amelie Delaunay <amelie.delaunay@st.com>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> ---
>>
>> v2: Only overwrite the error in the pointer after checking it (Heiko
>>       Stübner <heiko@sntech.de>)
>> v3: Remove hunks that shouldn't be in this patch
>> v4: Don't overwrite the error code before returning it (kbuild test
>>       robot <lkp@intel.com>)
>> ---
>>    drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>> index 190f95964000..c51b73b3e048 100644
>> --- a/drivers/usb/dwc2/hcd.c
>> +++ b/drivers/usb/dwc2/hcd.c
>> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
>>    
>>    static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>>    {
>> +	int ret;
>> +
>>    	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
>> -	if (IS_ERR(hsotg->vbus_supply))
>> -		return 0;
>> +	if (IS_ERR(hsotg->vbus_supply)) {
>> +		ret = PTR_ERR(hsotg->vbus_supply);
>> +		hsotg->vbus_supply = NULL;
>> +		return ret == -ENODEV ? 0 : ret;
>> +	}
>>    
>>    	return regulator_enable(hsotg->vbus_supply);
>>    }
>> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
>>    
>>    	spin_unlock_irqrestore(&hsotg->lock, flags);
>>    
>> -	dwc2_vbus_supply_init(hsotg);
>> -
>> -	return 0;
>> +	return dwc2_vbus_supply_init(hsotg);
>>    }
>>    
>>    /*
>>
> 
> Not able to apply patch. Please rebase to balbi/next

Are you sure? Just rebased and the resulting patch is identical to what 
was sent.

Thanks,

Tomeu
