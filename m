Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELswdQJlURzh0t9t+mLqiZUELQHcJisM0HLfGdo5CAjQ8VkwCBNXWGobDcgjePRKuDUHEMNf
ARC-Seal: i=1; a=rsa-sha256; t=1521128835; cv=none;
        d=google.com; s=arc-20160816;
        b=IK8gYZF70bAogPtsynP5QFY8igoGFo00xq9k3OjoZjK2UlHUpldWZhWoGsfgs2I/Yr
         6kNDOL6oeLtga5D2vDRnMZhebWC48oA4OUeqc5BkLTn4vqvHx20UjCaEFUog1pGLCmwq
         pLb+B0VGMs2Wf+ERcEXhPBZix6Pce10tnA56nQ+htem7oCDgxl5nMTKgw2efAZWg+mHD
         +wbwbjXp4Wy0HZFnA8e7hzDGvGCT8rWjJneLNzYL8X6gIVcdYBszxCDrCTlBzcU4FF6G
         Ya0pb6UXXOESgBEI3uJrjY1dNzGSV2UolZ7X2vGp/QEcA1dR8CvWZpH4SSayfEbTZQ5a
         3TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Kw/tXXk/y0GCZVTO0zyj95wlBe7VVfzbxO2LRzYm20M=;
        b=bjqzgJnxT1RM170j4QLlBpcY8J514h8gJT9O9USc0bSed0Nyvar479PEBxF1n0+vc9
         xTwlrEOulsdBtHxq1ypERpzMyWxFGpuHZEsQKdx8VLPfHKRSbVy0cgBnL4ZHaTuv0T5W
         GxwB/nnd/pM0IujkbW2UPhEEk6m/bRcmUEiAWnvX7QD7gsAPxD5pv42EjgXctGZNc4o4
         X31FhVgkFqcPjQ9+6I+feN/rXwjVgOOZQea4G55BAbowzCVkEAK3G0Rfu6/g6bVkI9y+
         u9GlWPIuTbZ49LoXhzBrcfWd7XOiHiynghUSJmeScq6kTdT2YjAw92bZisGnWWxoo9TD
         w2UA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=baUp5hxh;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=baUp5hxh;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 2/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori
	<nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180314222624.12744-3-grygorii.strashko@ti.com>
 <20180315022637.GA20975@kroah.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <add8a8dc-f417-d2ca-764b-07948d5d1c5b@ti.com>
Date: Thu, 15 Mar 2018 10:47:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315022637.GA20975@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595019189853933690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/14/2018 09:26 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 14, 2018 at 05:26:24PM -0500, Grygorii Strashko wrote:
>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
>> one netdevice, as result such drivers will produce warning during system
>> boot and fail to connect second phy to netdevice when PHYLIB framework
>> will try to create sysfs link netdev->phydev for second PHY
>> in phy_attach_direct(), because sysfs link with the same name has been
>> created already for the first PHY. As result, second CPSW external
>> port will became unusable.
>>
>> Fix it by relaxing error checking when PHYLIB framework is creating sysfs
>> link netdev->phydev in phy_attach_direct(), suppressing warning by using
>> sysfs_create_link_nowarn() and adding debug message instead.
>>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/net/phy/phy_device.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 478405e..fe16f58 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -1012,10 +1012,17 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>>   	err = sysfs_create_link(&phydev->mdio.dev.kobj, &dev->dev.kobj,
>>   				"attached_dev");
>>   	if (!err) {
>> -		err = sysfs_create_link(&dev->dev.kobj, &phydev->mdio.dev.kobj,
>> -					"phydev");
>> -		if (err)
>> -			goto error;
>> +		err = sysfs_create_link_nowarn(&dev->dev.kobj,
>> +					       &phydev->mdio.dev.kobj,
>> +					       "phydev");
>> +		if (err) {
>> +			dev_err(&dev->dev, "could not add device link to %s err %d\n",
>> +				kobject_name(&phydev->mdio.dev.kobj),
>> +				err);
> 
> dev_err() is not a "debugging" message :)

Sry for the mess. I've originally did it as dev_dbg() after searching for
other occurrences of sysfs_create_link_nowarn() in kernel.
And honestly, I was unsure what to use dbg or err here.

> 
> What is a user going to do with this new error?  If it's not important
> at all, why care about it?

Now I think that dev_err() is better to use here:
1) It will notify about link creation error in other drivers (which is
still not critical as networking functionality will not be broken and device
will be able to boot (in case of NFS usage for example).
2) in case of TI CPSW driver we can live with this error message and
it will stimulate us (or any other user of this driver) to find time and
do fix/rework TI CPSW driver.

> 
>> +			/* non-fatal - some net drivers can use one netdevice
>> +			 * with more then one phy
>> +			 */
> 
> What about devices that do not have more than one phy and this call
> fails for?  Shouldn't you check for that?

As I mentioned before, this is not critical error. More over, as per code and
commit a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
- the error of creating link phydev->netdev already ignored in PHYLIB due to
"incorrect" initialization sequence of some network drivers.

if no objection i will repost after fixing commit messages. 

-- 
regards,
-grygorii
