Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZqCOWvGNJ8+cbijC8O8apJbGBiohNlIUeIWYrDx1XgxP4oaURUfEWY/bvJP6bzRSvJyatX0
ARC-Seal: i=1; a=rsa-sha256; t=1526748836; cv=none;
        d=google.com; s=arc-20160816;
        b=SRg7o1pMYpkpIk0UUdYK9mIFP6thPJESADh/hrPm+Zh0VWnJAG7H9cxfzuUSS99PTN
         vaMhrsI5ZuoOFe4vf7//HUrqKJBqDJiCpsFI2KvYUnUObVlhYrOaQ6gnu2LXSmOeL5wB
         ec4agr3yJYOBCU5riwCAxo5fNDVrjfaGeTp/i5lTVWc0KaCgRtsws49uyN1onHIK4Scv
         +qWt5uNfKnQ5vAxw2JjZPSGnkrcRse+b2xDCjAz5nIJsLRY3MSLGbbUymESFC+4q5XSI
         BvAD97IB2eTgiOIAPy9gW/sd5hvGfqK+Y9065SmGc5U4EG5tFyU1Luicku1ROmzIMjvt
         fZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=cTmWVIrX4df56ECbtS5iFYSYY2rluSog+T2QjauI+Zk=;
        b=jCdrY3WinIpRUjZG0vgklH+V6tMrlj6kkl+o+NwCdLNO85PG7sGS77fCG5agGmSACi
         4Xuu4Js1K4BfgE0H7U46Ny5RH2pFxvaG7bEML9OfVTVubvEaffhZoBXIbnpUlUj/hAcL
         ZOrB+ACrfdEoYoKO37qFPQzGhfceQR83ifg2oSK4nIfbuYo9Q/nlW3Hr6ZR+4MujRx/X
         ZFe8fMDwQhVItVnXO7UuA+MiVZUXqV/UbaPBo3xgXJcJgNXaZ4q4x4dMIDiRPralXvBf
         +G3EqrbD3ANWgNTIuB3eFeqUp5kf3cHfmcjwJpxWxLRlRAxxralVvG/VyQSkVWnqYSmY
         vOZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.49.218 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.49.218 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Subject: Re: [PATCH v2] usbip: vhci_sysfs: fix potential Spectre v1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Valentina Manea <valentina.manea.m@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180517201628.GA6090@embeddedor.com>
 <20180518134701.GA15598@kroah.com>
 <a6e9c635-5749-6fa0-7d1d-c1390d7f61ff@kernel.org>
 <3a169862-d723-88fb-05d6-f1ec80c8f7ab@embeddedor.com>
 <20180519070407.GA2943@kroah.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <fb19e149-b439-8222-73e4-792acdb13d0f@embeddedor.com>
Date: Sat, 19 May 2018 11:53:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180519070407.GA2943@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fK57D-001lH5-9e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.69]) [187.192.46.223]:32774
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600912187766309910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/19/2018 02:04 AM, Greg Kroah-Hartman wrote:
>>
>> Greg,
>>
>> I've been talking with Dan Williams (intel) about this kind of issues [1]
>> and it seems my original assumptions are correct. Hence, this patch is not
>> useful and, in order to actually prevent speculation here we would need to
>> pass the address of pdev_nr and rhport into valid_port, otherwise there may
>> be speculation at drivers/usb/usbip/vhci_sysfs.c:235:
>>
>>          if (!valid_port(pdev_nr, rhport))
>>                  return -EINVAL;
>>
>>          hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
> 
> Ah, yes, sorry, you do need to pass the address through, my mistake
> completely.  But the location for the checking is still the right place
> to do it, so I was half-right :)
> 

Yep. And that totally make sense.

I already sent v3:

https://marc.info/?l=linux-kernel&m=152669243313887&w=2

Thanks!
--
Gustavo
