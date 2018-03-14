Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELvxhWQovCAjzl5lhTvFb14xG7W5OmkL+xvP+9jafyI8fPZvTbxI1qm3DnOS8lTet0UMt59J
ARC-Seal: i=1; a=rsa-sha256; t=1521060532; cv=none;
        d=google.com; s=arc-20160816;
        b=PATHkDwBk+qfCJ0WWPdj6hmw4vPQI1dw3PdDgyPax01QgYoKvmgV4JZhPMLQiXR9pA
         CwmytaoVIolmQpj5yJon4Sw46ssmvO+G3Lh67l1cQOh0+2IP/TPD7wBoK8PbkcXa1s2l
         0nSFDDbgEpOyY06ZUakveG9keYp5gnVtgeYOa4l88DXKazRSCzYrC+kvTKjcbSvprWz3
         vXRD4z4SC4B2rgasLFZeDoyIyEv21KO7Vq0LptJEvBDygUae3WqMWcN1gA279tyHKQGc
         Pn2XOWXfqjyffaj1BCQ93qii9zrfeheOcBPjz8t9DBeN31Wgye0qAxuMVRFZmROxiU2D
         a+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=u57EOfjGbql1nGc9HBsGwlIiZG/+nsnS50fmAuKbYVg=;
        b=ffXLPAMO0r70K7cZriq3u6wjb7Az5sjz4ve36mb9xmpHo0nS7aO+mWgWrh1uYb8hGO
         Mw/PVy6LE2su4N+u5VOtea5frmwvz/Kugvvk1jRKvXKkm+dbnFWMxfgdtQczybj4+eag
         HOS6yC15MVkWmQJajwc7HheoDXAgPrN07DTdGd9VJ/0YIw+GNB8Hh9fqVAaT6vbe3dTI
         Vc2LCKi1ydkPFc2Q85xyS8onZ7Sdf3LQTxe5jSAI0qARn+GDl5V06PQzqjCRtzeHpp+P
         wX7voz3YiG5s9AUUh0IMD5IOA460B7eiKmMhsBrE7hHn3AZvFkRjcuW/FPnVdTTD6Y2r
         sncA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,307,1517904000";
   d="scan'208";a="24714782"
Date: Wed, 14 Mar 2018 14:50:50 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180314205049.GE29867@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
 <20180312232626.GI18494@localhost.localdomain>
 <a52d2e0b-d319-bb34-8610-455d8c7ddad9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52d2e0b-d319-bb34-8610-455d8c7ddad9@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594947569368162859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 11:47:12PM -0400, Sinan Kaya wrote:
> 
> The spec is recommending code to use "Hotplug Surprise" to differentiate
> these two cases we are looking for. 
> 
> The use case Keith is looking for is for hotplug support. 
> The case I and Oza are more interested is for error handling on platforms
> with no hotplug support.
> 
> According to the spec, if "Hotplug Surprise" is set in slot capabilities,
> then hotplug driver handles link up and DPC driver doesn't interfere with
> its operation. Hotplug driver observes link up interrupt like it is doing today.
> When link up event is observed, hotplug driver will do the enumeration.
> 
> If "Hotplug Surprise" bit is not set, it is the job of the DPC driver to
> bring up the link. I believe this path should follow the AER driver path
> as there is a very well defined error reporting and recovery framework
> in the code.
> 
> The link comes back up automatically when DPC driver handles its interrupt
> very similar to what secondary bus reset does for AER. I don't believe
> there is a hotplug possibility under this condition since it is not supported
> to begin with.
> 
> Should we plumb the "Hotplug Surprise" condition into the code to satisfy
> both cases and leave the error handling path according to this code series?

I'm on board with this, but I think you mean "Hotplug Capable" rather
than "Hotplug Surprise". The former may co-exist with DPC and handles
the link-ups, leaving DPC responsible for handling the link-down.

The "Hotplug Surprise" capability is recommended to not co-exist with DPC
since that capability may suppress the "surprise link down" notification
that DPC needs to see in order to trigger.

If the "Hotplug Capable" bit is not set, detecting the link-up after a
DPC event would have to fall under a different component's responsibility,
so I think I'm finally seeing your point.
