Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523123644; cv=none;
        d=google.com; s=arc-20160816;
        b=gresVGdPOMFtDEMHaF3jPri79LUCypjjRe36rNOdHxXHRwFgKbc5zKdRyGJ66VhKDp
         cxzfx79AQWZWXs3UYX+U6qbG4sHRMOdalQ2JLEnL8kUa64SjBc9iEPJsmVr1JCMj48bb
         VxV4pZS8Uuwb6221Jr9ptUpmkYRTFVfkN5UZaG6nrF+GKq8DQ3xvCvTvH9tEJ0XOfry7
         l4+pNYHHuhLQeKIyva5oeCyU+FyXKKHFsiDDQQNVI2JFjKbLF6RqB0OH7LNURkf/MCsF
         lB5b7x9msEKaDnTtO8qKEFyU/mTV37pDQ+rlfvJH45FFLN6vYc9dxCj5P8MXDa5PVDKa
         jqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7Npr3hkZ8jRWFYLzcZN54YgQ+ZRXThvheRDnsoDgoUA=;
        b=dZjVKQ18cO35IA4CHLQkb5pR+WcAE5OBFDj32Yo6y4Z5I3TCrZlo0b/k0uieB9DhWZ
         9BdXfYnzMbesscaSSB4b4jb3k6w3jrSON1cQ0YlmKpUSpMJT4CNmTPDMphSKHQHbE5rP
         +9EmKJNZtbrQje5TnMg5etML/ZtHVQVlSOX5AoWH19UH8AlCGOiHAcpfkzuUVRd049Yq
         wECh6rX4EF/UdA0JVNL4zTLStpf0+uDSnyQlnCU4/3UVSbxN2+ExeionfllRRMCwIu84
         oWsDTP7uU2ZVAxy6OkQ4+59GQXTz3AUnppXiyw18WnYqSUQ7wgsb1qDF1XYHs9a47h8X
         oK9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vg5wZyFm;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vg5wZyFm;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+b6PnbL6ppK3U6frPfNPATKVFUeY1nUD4BmsABDv0XjpnMxqUDc/I+oJN1n+0CN4KwxsNX1g==
Date: Sat, 7 Apr 2018 18:54:01 +0100
From: Craig Tatlor <ctatlor97@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Message-ID: <20180407175401.GA28199@arch.home>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <d33902cb-65d8-9790-7950-e30134f68578@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d33902cb-65d8-9790-7950-e30134f68578@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1597110898630919996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 09:37:21AM -0700, Randy Dunlap wrote:
> On 04/07/2018 06:59 AM, Craig Tatlor wrote:
> > This patch adds a driver for the BMS (Battery Monitoring System)
> > block of the PM8941 PMIC, it uses a lookup table defined in the
> > device tree to generate a capacity from the BMS supplied OCV, it
> > then ammends the coulomb counter to that to increase the accuracy
> > of the estimated capacity.
> > 
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > ---
> >  drivers/power/supply/Kconfig    |   9 +
> >  drivers/power/supply/Makefile   |   1 +
> >  drivers/power/supply/qcom_bms.c | 500 ++++++++++++++++++++++++++++++++
> >  3 files changed, 510 insertions(+)
> >  create mode 100644 drivers/power/supply/qcom_bms.c
> 
> > diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_bms.c
> > new file mode 100644
> > index 000000000000..5aa6e906d1b9
> > --- /dev/null
> > +++ b/drivers/power/supply/qcom_bms.c
> > @@ -0,0 +1,500 @@
> 
> Hi,
Hey
> 
> > +static unsigned int between(int left, int right, int val)
> > +{
> > +	if (left <= val && val >= right)
> 
> maybe double-check those if() conditions?
> [or I need my morning coffee]
Yeah, they are wrong, will fix.
> 
> > +		return 1;
> > +
> > +	return 0;
> > +}
> 
> thanks,
> -- 
> ~Randy
