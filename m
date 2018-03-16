Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AG47ELt0NCxv1gww/UiK6OqmdUVnho2AwuMfeffHQtBNICLnaZG0vXfSuZzj5D/KCWPspWMw7Iau
ARC-Seal: i=1; a=rsa-sha256; t=1521220958; cv=none;
        d=google.com; s=arc-20160816;
        b=LeYbY6AT7QAfIEiA3SjrTaRUm+emjxIvpHiVq3mMRF+/dBvS9xtua1KA9jyfCcXVAn
         yKsFW8MOCC13rPuZKHheeMR8p4DuvQe7KFUkfVwP4tW3UgBod6uh9mYs9Sjx8NnfBROw
         pcM+QCG9sa4MTkUYZfnqnjGAcrmCjID/t1oAgx67Vy6efivLend9Epnw4dDIiyjFfoKB
         YwbJPVAq3eGr3rwOzWsidqM9/n8PB3S62tNjQqubZz4tA9g6xROcDzSsDLe0HlFOUFrk
         uz0Nrcm9RcdFasfRtSInKApR1f18ImLzPBWwAmmMvrJfTN+WtZmXeRCjLYtbvaXOo3y5
         5jpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=K24zyWQRYb4rCKoFH1yPMShl1qAx1i6F2fR1lLPmHe4=;
        b=r5njLOEJHzJjDQvnX/4GZA7i7o+qm/R6nS5pg9GKmxRK71vofkUcGIi+wqCmmqTbK1
         sPVFJMIAptWoI2PImBwVVqakHsAeQqket7IjgNDVOrsHM9HlxeF6urL68iwdzOeLsp6j
         xa1vdO4a8I3ifo+rshuhFTS7oIen5Py7A7FTXv65rrObZWw6J/Xg7isp5JRD/fdnHcob
         Ii/YZUMZvOx1cXi5VSC67MpQvepGF2v5RP4CeqxyW69ORn3SlyQbIITryD5YqUAl6cNh
         YeL0/X44GeKaxjv0JB6fhNVeofRumVV5tLF5uVqzY9bZuUU8qyWy8vRPvP0hk0y4FX5X
         BUNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=uUmG9VQy;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=uUmG9VQy;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Fri, 16 Mar 2018 18:22:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Message-ID: <20180316172234.GA4212@lunn.ch>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314222624.12744-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595115787977317471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
> one netdevice, as result such drivers will produce warning during system
> boot and fail to connect second phy to netdevice when PHYLIB framework
> will try to create sysfs link netdev->phydev for second PHY
> in phy_attach_direct(), because sysfs link with the same name has been
> created already for the first PHY.
> As result, second CPSW external port will became unusable.
> This issue was introduced by commits:
> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
> a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"

I wonder if it would be better to add a flag to the phydev that
indicates it is the second PHY connected to a MAC? Add a bit to
phydrv->mdiodrv.flags. If that bit is set, don't create the sysfs
file.

For 99% of MAC drivers, having two PHYs is an error, so we want to aid
debug by reporting the sysfs error.

      Andrew
