Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523956756; cv=none;
        d=google.com; s=arc-20160816;
        b=mGWUiE6r8ycDFhBjOlc/k/SvIooGEIX/wKpm1V/2qiHsuUhhSB8BiSmLa2UFA4FTZY
         c40bKCKcG/b5jpvoBtM7VHRPMu4azibQjfWDGTvMem0M9uGbU/BmJHkzF7k0pLmleGNM
         SthuIAZ/QvAn+99Qh24Wegzbcq9ytQUH0NJ0SqYi/6gKQ5VmsgRKF0Bz6Pa01DaHhcwy
         6YAw3PxHD0N7Pzl//fmVIC9E9AZ3cWa0ydeFLL0VGScNZ2ybo4ueZ/zcOLlnHsVRPseh
         iQd7v+/lmoEEvINvBUxeF6MGJhcovRz2SfMQSa3bXXxZKOcD4vjRUgGoDianiGQm93LI
         kgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=39GE6jOGRavIidAe4deZkWR7bcyzHu7nbGlGcw/zDtI=;
        b=KqLMU6aZuxKjDTPzNb6Yi7hcvJdfFF15UHUE8lO3/OO2cV/dwj0FbKsrA8TDSs41sI
         6XBBNc9XfwMo6sMP+YhxBfwwRy87zIUp8uchlk5FPXF+Tq1BPH+rm31PjWpeKZnP+twu
         H1Aiw+SanwU0RuxvtGKCsHThNIwX962uLhgiT0Se66XwgUS1ISscxTYe6WtLxFHC3cUl
         aCFU7HawKDb1Sh06Dnaj/EkO8b3NMDq9iY2PO3LzSpsruYU69yquGNzJLCdFztrcKk7m
         U+KTb1AEO/PoTUf5gaWV1+KMgJ5dAHi6rqL+Y584OUGdjDGdnqGtMdeqWoz5y5wc9J4B
         hbnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4+tmucWWtqdZXOvy3IWpUBb9uUkRMz8Sb3kTuEhgiKC6q4dSo6W/94Tr6z8KcSy2IbCshKzyQ==
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
 Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
 mfuzzey@parkeon.com, keescook@chromium.org, Kalle Valo
 <kvalo@codeaurora.org>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
 bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
 linux-efi@vger.kernel.org
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180417001738.GN30543@wotan.suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <00800dc5-f6de-ab26-4d3e-eb2a47e10709@redhat.com>
Date: Tue, 17 Apr 2018 11:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417001738.GN30543@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1597984479862597863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 17-04-18 02:17, Luis R. Rodriguez wrote:
> On Sun, Apr 08, 2018 at 07:40:11PM +0200, Hans de Goede wrote:
>>   static void firmware_free_data(const struct firmware *fw)
>>   {
>> @@ -576,6 +600,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>>   		goto out;
>>   
>>   	ret = fw_get_filesystem_firmware(device, fw->priv);
>> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
>> +	if (ret && device &&
>> +	    device_property_read_bool(device, "efi-embedded-firmware")) {
>> +		ret = fw_get_efi_embedded_fw(device, fw->priv, ret);
>> +		if (ret == 0)
>> +			ret = assign_fw(fw, device, opt_flags | FW_OPT_NOCACHE);
>> +		goto out;
>> +	}
>> +#endif
> 

So thinking some more about this, I can put the device_property check
inside the fw_get_efi_embedded_fw() call, as well as modify opt_flags
there to or in FW_OPT_NOCACHE on success, then together with the discussed
changed to drop the #ifdef, the code would look like this:

         ret = fw_get_filesystem_firmware(device, fw->priv);
	if (ret)
		fw_get_efi_embedded_fw(device, fw->priv, &opt_flags, ret);
	if (ret)
                 if (!(opt_flags & FW_OPT_NO_WARN))
                         dev_warn(device,
	...

With just these 2 lines being new:

	if (ret)
		fw_get_efi_embedded_fw(device, fw->priv, &opt_flags, ret);

So the main.c changes will be nice and clean then.

Regards,

Hans
