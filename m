Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521221680; cv=none;
        d=google.com; s=arc-20160816;
        b=JY5R4iBmqZPosYOmwilVsxGs/Ecbxg68JOqeXI7xzPMdzjuQ8ZN7N3JSpoIdtYqddG
         3C5rMeacl/occNORpql2+L0WObE5XknF0km3JtQYZsiP2WnDTSahyg56ftL25hRWp3qk
         FVKZV2CLU7pzekghoY8ddon6xb7F0oIHMXko9H/UuqAl8ePzl/ZgH5Ch4ex37EymD0GZ
         bZpJaiLGz8ydfnmTrT5EgdNqZ5SvreDq6jiPNaxcRAZR9G9/Ucl0xrOukCn2q6A3z+8N
         rydpw6dVGgdesxEFEAa5JZnQxksSgFGt9wdFI8Ujfh1H3X+uI79Vewd2hpH3o3DES6aP
         A9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=QvHuGAIkwzyOsCc3LebCdbv5q4PYKhu9ZPTGelha32U=;
        b=G00Fva65wWlKgKtY/HjsWZDNs1BW75qblKaQ+RYmmRBiRJUGN75utIU0+HyQJx3iVu
         ISTo4ISI93+dKmd2M9fXoRuRbBRWL1FmPWQCeRkyRn/SvPBpRv99F3OCsR7pxBGJNu5x
         zvANwMdAvTYqhXkle8ki3C+aVfz6OY5uBgrin9GARQ3zi5nFzmcx0KMbDJ7zJWzA+I48
         x4c2AIPWgQkuJnGB8Y8cvRbZDOkoDj0SZDwyJB9r60D8qOYqQgsn9/W7TlOXimHfXdrD
         y4R5H5qIaN7f6Uh3nCLXr0egW5kaXGnMcUHSy56OnFqj2DgXeveLUahga8FJKoWBONAt
         WBnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n9w4gKfF;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n9w4gKfF;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuHqQYBFJV6h7eH9ek9M+70DKJuN908/yK/CU/DssqsBR5Du1U/r10QRsdEVvIir40EUd3LRQ==
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori
 <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
Date: Fri, 16 Mar 2018 10:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316172234.GA4212@lunn.ch>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595116544282235399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 10:22 AM, Andrew Lunn wrote:
> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
>> one netdevice, as result such drivers will produce warning during system
>> boot and fail to connect second phy to netdevice when PHYLIB framework
>> will try to create sysfs link netdev->phydev for second PHY
>> in phy_attach_direct(), because sysfs link with the same name has been
>> created already for the first PHY.
>> As result, second CPSW external port will became unusable.
>> This issue was introduced by commits:
>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
>> a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"
> 
> I wonder if it would be better to add a flag to the phydev that
> indicates it is the second PHY connected to a MAC? Add a bit to
> phydrv->mdiodrv.flags. If that bit is set, don't create the sysfs
> file.

We could indeed do that, I am fine with Grygorii's approach though in
making the creation more silent and non fatal.

> 
> For 99% of MAC drivers, having two PHYs is an error, so we want to aid
> debug by reporting the sysfs error.
That is true, either way is fine with me, really.
-- 
Florian
