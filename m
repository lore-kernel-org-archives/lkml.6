Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AG47ELuz+44I8PNTTt11OXwACaTfVyT2XDM4JRv9h3JcdItIuz8ADPqp8z/bSxBtuJsVoI9jMIcR
ARC-Seal: i=1; a=rsa-sha256; t=1521757124; cv=none;
        d=google.com; s=arc-20160816;
        b=qKhyVRg1V5DAAHpo0XBRgyQ5tXuVQ92eoPA6exNg1S1o1nrzja7P8+r8cvUw+lnONG
         MNy9wqHsyaSfBzpwZTtEGYZCeWGcQ924BbMrdecU4/1LvziNBwUWrL+e78vYwp5SZA3i
         Hyyqp2N4+7XzngiNCkqa1WNOxNNJ8BTupygp4otG2Z9jQh7HLJKFZlHWAaH7WTCZSdgy
         HrIBbtOtOyR8g52rMekKSijDnAEnsVpVedpyk8EXx8u1324MM/+S8oh3GJ2H4484cdkp
         ZPlazkMBvAayr1Ng3CaD8YWCyylikumZp7ZEtstuBwYo+LE+nsH/wUbP5IkOMUZLB2AI
         5JwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=l76EkREojMLyGYHe+J7p9DqukO47NKrTkQ08zruRBtM=;
        b=ZofCJ+YOQfTh8UVb2oRAJQxx39TNOohtoeItVjrdXhcLLRMHBrNfBnxt2ZyfMYgH63
         0060ClZSOBqQs6Y0RwTWzZG7gfkGURJSBBf8vUA+KpOlOYAmqoyrJhd5/Jp6oKBJghOQ
         rd2dOABO03tzT2dbTnpdFeWgIDFSMz6I2A8sqIeCKAvNsHJGiFmtNwn6zXq0hAqOoRsR
         AbyMYuwTl3Hu9z2HfA0eFU9K3QRzdY35XL5KXF0SgH4CMXpm8MBkXJrfk4/OLCifZg7T
         WOYmLeZYXGiWQQCcvVrQofri3fHOP7+sYgAlan8bwhIgMpNLnV2yaloQYs8FYsySQMKV
         4aiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=BXTZyQu+;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=BXTZyQu+;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Thu, 22 Mar 2018 15:18:40 -0700
From: Darren Hart <dvhart@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vadim Pasternak <vadimp@mellanox.com>, andy.shevchenko@gmail.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 2/4] platform/x86: mlx-platform: Add differed bus
 functionality
Message-ID: <20180322221840.GC24138@fury>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
 <1518559776-188942-3-git-send-email-vadimp@mellanox.com>
 <20180321225818.GA23931@fury>
 <20180322090451.GA22313@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322090451.GA22313@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318017732489878?=
X-GMAIL-MSGID: =?utf-8?q?1595677997660365514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 10:04:51AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 21, 2018 at 03:58:18PM -0700, Darren Hart wrote:
> > On Tue, Feb 13, 2018 at 10:09:34PM +0000, Vadim Pasternak wrote:
> > > Add deferred bus functionality in order to enforce probing flow execution
> > > order. Driver mlx-platform activates platform driver i2c-mux-reg, which
> > > creates busses infrastructure, after that it activates mlxreg-hotplug
> > > driver, which uses these busses, for connecting devices. The possible
> > > miss-ordering can happened, for example in case the probing routine of
> > > mlxreg-hotplug is already started execution, while i2c-mux-reg probing
> > > routine is not completed yet. In such situation the first one could
> > > attempt to connect device to adapter number, which is not created yet.
> > > And as a result this connection will fail. In order to ensure the order of
> > > probing execution on mlxreg-hotplug probe routine will be deferred until
> > > all the busses is not created by  probe routine of i2c-mux-reg.
> > > In order to ensure the flow order, mlx-platform driver passes the highest
> > > bus number to the mlxreg-hotplug platform data, which in their turn could
> > > wait in the deferred state, until all the necessary buses topology is not
> > > exist.
> > 
> > Vadim,
> > 
> > I've got part way through a review of this series several times, and keep
> > running out of time trying to determine if the solution is appropriate
> > for the problem.
> > 
> > The deferred probing waiting for the i2c bus to be available seems like
> > something we might be able to handle more elegantly with:
> > 
> > 1) request_module() in the platform driver
> > 2) careful use of init levels (subsys, device, late)
> > 
> > This isn't something I'm well versed in - so I'll reach out here for
> > some advice from Greg and the i2c maintainer, Wolfram, and list (added
> > to Cc).
> 
> deferred device probe?
> 

This patch series adds the following, which I believe is what you're referring
to Greg? :

+       /* Defer probing if the necessary adapter is not configured yet. */
+       deferred_adap = i2c_get_adapter(pdata->deferred_nr);
+       if (!deferred_adap)
+               return -EPROBE_DEFER;

This is the preferred approach? Have the platform driver define the expected
adapter number, and then defer until that becomes available?

-- 
Darren Hart
VMware Open Source Technology Center
