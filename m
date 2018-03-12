Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELtimufYPUK+HZ3ebmUUoFYT+QnIORNKKK6H0oecw73IWQzmTiclypwnpCoTHR+7RQuo5wKg
ARC-Seal: i=1; a=rsa-sha256; t=1520864637; cv=none;
        d=google.com; s=arc-20160816;
        b=IOVgogM78uruZEXVMwspuPAyWoetqNDMVGchyhfEqpsPlkbesyTk8zJw060NWA+tZk
         lJl1M9B7QD17VB4KzUv1vWjUeQsW6N1c7tfMiVm4z7pkmXz+Lt4ACGzknShX2PV+vxG0
         2ahmsduHm6xbgXmRAlj7iJ1RMxzUL864t3aDXZNpyPE3QTGk4oyHFccqm+B9d3xLNIfs
         jUG038ZqQQr/VVgKGFCCmywVvTWtKi/13kM8hasgavupr4YTX1S8nW2M0+VobCGfYS0j
         hNduL3/wXU0MnEGK/L97CefdNsWo2mTMaTwdRSOvk05yBjSCe++QRoKoX0Dq/ekAa7tW
         i8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uLWKxM9fdc1s78BbhkPVaVquZYATVBZ1bnxFF0Osy9Y=;
        b=HzGAH8OvHtxz20R4Ti5HJfI4m9DIQFcOclS0fe/l9C+FieJju4GuipoX6cwIpZcwD7
         qmC2unG8RVs2kBbJbSfiB3KtRQJArDlF5fH6x6gP21w25N1+pDsZXeNb7IURtZc0562h
         0YuoRaGGXGbekXGXiMySSS8bJa8j5IWSMJksCDBI9Owtw6010cXsg0E9D1ZoWGKszgSi
         yUuQc6gCA70zBrY/oKqm3dQumHokCrp8i0NR5GYkmTuXbIcMkPLFDXOnoDyfL4G17hYw
         mwcrNWV73XvUth/CPuwgkdRW75JwkStoUFleBmaz7lyp+7M3Vgrefz9LUq0wGUBMwM5Z
         elJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="41253301"
Date: Mon, 12 Mar 2018 08:25:51 -0600
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
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312142551.GB18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594742158102785497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
> On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
> > On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
> 
> > That difference has been there since the beginning of DPC, so it has
> > nothing to do with *this* series EXCEPT for the fact that it really
> > complicates the logic you're adding to reset_link() and
> > broadcast_error_message().
> > 
> > We ought to be able to simplify that somehow because the only real
> > difference between AER and DPC should be that DPC automatically
> > disables the link and AER does it in software.
> 
> I agree this should be possible. Code execution path should be almost
> identical to fatal error case.
> 
> Is there any reason why you went to stop driver path, Keith?

The fact is the link is truly down during a DPC event. When the link
is enabled again, you don't know at that point if the device(s) on the
other side have changed. Calling a driver's error handler for the wrong
device in an unknown state may have undefined results. Enumerating the
slot from scratch should be safe, and will assign resources, tune bus
settings, and bind to the matching driver.

Per spec, DPC is the recommended way for handling surprise removal
events and even recommends DPC capable slots *not* set 'Surprise'
in Slot Capabilities so that removals are always handled by DPC. This
service driver was developed with that use in mind.
