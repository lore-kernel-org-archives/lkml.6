Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZrf19hInIba0/J9dmm2NF2cgNfpln+omtewGViL45TUTx7Mk7opBD1O6/5JlRVWOFmf1emB
ARC-Seal: i=1; a=rsa-sha256; t=1526585364; cv=none;
        d=google.com; s=arc-20160816;
        b=GNidI5ThnEnxf1OcZZELP9Y7S4yB6Hq3AcCfLDQ9Q1voFv2dwSuDkreUoPOFDaP8Ru
         7MM2dPp07x53IvFBmpevhVFt5WIwSB8aVuEoC+xyJsyyZtvq9jcAbtY7vcgOjhtI29Dx
         u8o/a7Aj6kYSn8VZaZEbEYLIA9Z8DArUxDAoZWwW4c/HkJvw0kRfP6HIBV5tTQcjgIow
         9mHvsGLuLFoS0/o4zYLL6GzUx9eC7nLb1XxcEp46AtcyjixVSmlwQ/4fwRBJncCVP02b
         EFKWNLLV7U7yEjb+NUUA8c8kvpIvA/gi+ieytNv32X6kTib9dGfz1rDDKQvM7ibMZigp
         GQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7vgkbaOMNDP+qwHCIfpJdmIf6xvGJAEVmJy0cHZw1OQ=;
        b=R/cXyAKJ0j7FJgyw81GG94VQttAsIvwAiaExhLnQunfUVOuJ7FRyg8XnVVlvLlW4Tn
         NvZT+m/tb7ajeHjxBLPFF1G4PqBIePE/CE6xrb7Hy5SrvwbixNpsWpMODnbGCAEnFuTH
         dGzWOnjNXaeaBtC0ATyhNhx59NsqPZ0/Re9crVR7K1h+t6/06eSzi+ofzy5KOQaPDfE/
         9yvJK2xc1u95Gh3GYic31IqRdHU0sPMpD5nwgPH7WmK/NVGbWInSquXv+rH7BDzySGfh
         dcYxU13vk/wvekBE459RHgwYwbVuR2g0gmVFnflIoLBh2VyrTUv8BospFPlz40WWaMfs
         hHjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.146.97 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.146.97 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Subject: Re: [PATCH] usbip: vhci_sysfs: fix potential Spectre v1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180516222200.GA14733@embeddedor.com>
 <20180517065117.GA12910@kroah.com>
 <ba00b923-3ff0-95db-2939-7da27d34fe6c@embeddedor.com>
 <20180517191535.GB3799@kroah.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <32f8fcd6-ca00-ff7d-bcd0-a307f178f765@embeddedor.com>
Date: Thu, 17 May 2018 14:29:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517191535.GB3799@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.20.167
X-Source-L: No
X-Exim-ID: 1fJOaa-000MgL-36
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink20-167.telefonia.intercable.net ([192.168.1.39]) [201.172.20.167]:53542
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600740775146779907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/17/2018 02:15 PM, Greg Kroah-Hartman wrote:
>>> Shouldn't we just do this in one place, in the valid_port() function?
>>>
>>> That way it keeps the range checking logic in one place (now it is in 3
>>> places in the function), which should make maintenance much simpler.
>>>
>>
>> Yep, I thought about that, the thing is: what happens if the hardware is
>> "trained" to predict that valid_port always evaluates to false, and then
>> malicious values are stored in pdev_nr and nhport?
>>
>> It seems to me that under this scenario we need to serialize instructions in
>> this place.
>>
>> What do you think?
> 
> I don't understand, it should not matter where you put the barrier.  Be
> it a function call back or right after it, it does the same thing, it
> stops speculation from crossing that barrier.
> 

Yeah. It makes sense.

> So it _should_ work either way, if I understand the issue correctly.
> 
> If not, what am I missing?
> 

No. It seems I'm the one who was missing something.

I'll place the barrier into valid_port and send v2 shortly.

Thanks!
--
Gustavo
