Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELtz72zSlWQAap2iBAAy1CW9Pub8iOAnHeIU295zHUMVq8UC2YGzaanvPD90tU9XOjl41bq5
ARC-Seal: i=1; a=rsa-sha256; t=1521225744; cv=none;
        d=google.com; s=arc-20160816;
        b=ik5LxsonZxo9G0h0uNPRnrTpWDZdyUt5aXi73oqWJYd5ByMx0k47yubuHpk0nWm2Ks
         ICVbLtXXy8OcIqwg7/T1+xG/ROnnn8BFj7R1L7aXGZ+bw/R7AtbaK0mkW9sKQBw0an3p
         5ptfnYWByFUU/ovU0jqywn0qWdsE6ifFWBZxJMOTrrWjIa4lpq0sqHNuk83FPRLenjKQ
         58Q0IA5xoR8HpQ2zEMveeJyGlUCbj8RawIrY2wx8rrU6Nji3LUhV3shhagxkPhDX//BG
         jap1a+/4e/vENhvBLkDy2gxn3qHu4DHjKmLbIEeUocfClwCUCqdOkGdQD/zYea0waaYV
         JVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=SUYn6cm8wvmf/4Y/87XOMWgzLB1p228flVNOCLCjOy0=;
        b=i0zWHgArOTEDuwtvLNTt8/MPfqhYeufnZhGI+esfbbF3I4XH8DHERBI+jGrvC42WrP
         adi5mTCYX4ihJV2zkQeY/HK/u+e3/RNXmC0wqBeDjfv2G0zsElwlVL2ePfH9dEMIiHuX
         tmV4Mc1vi+IE63d1BC9Nx4vtGFZJCGHXSQaq80fG/BoGPsNXeNjCGmwaR+sDaxy8C8D5
         e9Iq5yd9mSpHivIlD1XZJI3Cb6ZHUoy00YRDFqt0g49ifMhoa5351Yv6uFEEuhinpVkZ
         NuUT0lSztosgnCyCMm3MEJ7iaOFc1k4Mpw+ej9IQYVkciHHSrKQ8SNsc0Hd+Uv4fQwK9
         KoTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=eaxBSlnX;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=eaxBSlnX;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
Date: Fri, 16 Mar 2018 13:42:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595120806661345497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 12:34 PM, Florian Fainelli wrote:
> 
> 
> On 03/16/2018 10:22 AM, Andrew Lunn wrote:
>> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
>>> one netdevice, as result such drivers will produce warning during system
>>> boot and fail to connect second phy to netdevice when PHYLIB framework
>>> will try to create sysfs link netdev->phydev for second PHY
>>> in phy_attach_direct(), because sysfs link with the same name has been
>>> created already for the first PHY.
>>> As result, second CPSW external port will became unusable.
>>> This issue was introduced by commits:
>>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
>>> a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"
>>
>> I wonder if it would be better to add a flag to the phydev that
>> indicates it is the second PHY connected to a MAC? Add a bit to
>> phydrv->mdiodrv.flags. If that bit is set, don't create the sysfs
>> file.
> 
> We could indeed do that, I am fine with Grygorii's approach though in
> making the creation more silent and non fatal.

The link phydev->netdev still can be created. And failure to create links
is non fatal error in my opinion. 

> 
>>
>> For 99% of MAC drivers, having two PHYs is an error, so we want to aid
>> debug by reporting the sysfs error.
> That is true, either way is fine with me, really.
> 

Error still will be reported, just not warning and it will be non-fatal.
So, with this patch set it will be possible now to continue boot (NFS for example),
connect to the system and gather logs.


-- 
regards,
-grygorii
