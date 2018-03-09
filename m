Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AG47ELsq9J9h7HyyFU8JxF56VS32EmuptAQru9083txq1yZIvBoGi2Sde+6IRtHCeXJFzMyiVHvX
ARC-Seal: i=1; a=rsa-sha256; t=1520602794; cv=none;
        d=google.com; s=arc-20160816;
        b=n+FoUzlowiJUKjWehW86o+4T0cDsVG9mh9pbh4/ZhDuhFGgmN/51NKDHs5fFKv+ED0
         GycovODftElvOg30mNZMYdqhSZUAC6eZlEld6/zVMNAzBe9zhSiKcDWCR4CtT6duIGIJ
         As7afwLvw/4E/aMhCRfK+XuIu2rH1tQlYLR/qDGXDS0SgTFDHOhr9tQ1MXHacjzA4PtO
         OzgDHfM0Q7pBCsRYE3xdh8NrNOLPO3VcZ6NGSB5Ss7tvjMexlYehAy5daMedZtJsPqLR
         nh8CBoc3LNHsxiHMgNDIsMdb15EDg3sS5CHUjbteFk1yHOJ6EIPK2hK7UEk9WdlU+7BG
         gKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Nx5RHRChIkmo7atIEE28jvFI4DRm/ub+barvdkYABdw=;
        b=zWa7eMerTouv+NHCeiNOW5+55sXfnH6QfGuvkbqBt3m482bbJCvIjmt4PT3WB1lURs
         a0y3ItB5eLRzKYxVMHISJVhSv8J39X01nQDHLMfiicjoA8+tXXLKqCJgzRT/UfPAv4Gi
         Rv3tJTt7GsK+Cma5daFHlNX6x1BQlcB2PV6ARKB0fJamOYlvCekygNONTatsOjG1hnCb
         Nji0hjKXOvwWrbeDhzI6CA7zIg9EMPmzQ2C9SmvqteyvEgfkxyC0uBQE5X/4wfRTyeSp
         HdogzNu2kKfAorQQObhHSxJwartV9zmc9MfoofEIgE8ul3IOc9b4FII4VWihO2SZDSbI
         QLTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Q2f0TunO;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Q2f0TunO;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Fri, 9 Mar 2018 07:39:53 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
Message-ID: <20180309133953.GL14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
	Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
	linux-omap@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308204049.29474-1-merlijn@wizzup.org>
 <20180308211525.GJ14921@uda0271908>
 <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d01c0eca-f14b-d888-e940-3c23bbfd701e@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594403514660824083?=
X-GMAIL-MSGID: =?utf-8?q?1594467596343456487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 11:17:48PM +0100, Merlijn Wajer wrote:
> Hi,
> 
> On 08/03/18 22:15, Bin Liu wrote:
> 
> > please add patch version numbers in the subject when necessary. This
> > helps cross-referencing.
> 
> Will do. I naively assumed that the first patch would implicitly be
> number 1. Will send out v2 now.

Sorry, my bad, I forgot the first patch was a RFC. You are doing it
right.

> 
> >>  
> >> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> > 
> > Does it solve the issue if not moving this line? I'd like to have
> > minimum change if possible.
> 
> Yes, it does. The only reason I moved musb_writeb is because I
> understood you wanted me to move both (per previous message: "This can
> be move down to out side of holding the spinlock").

Typically the comments would only applies to the modified code.
Otherwise the comments have to be explicit to avoid confusion.
No worries here anyway, confusion does happen sometimes ;)

Regards,
-Bin.
