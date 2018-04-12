Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx49qXiKOhs56erQGyEHxH//g64wxKulpuXKIZxxkSFfxDse2BtcQDujTDKrgUo1ShYG3XjoU
ARC-Seal: i=1; a=rsa-sha256; t=1523552896; cv=none;
        d=google.com; s=arc-20160816;
        b=S0uo9j7Fjj3SRjG/8jYSr7TscavoyiSxZTzO2uxNy/NUR+gKYKEkoFg+WQVaWSUHTF
         Io24Cp7DZvmZMQg/zzorgT0pUBKksBmYcck1JrGixRlL1b12XNTVzrga22evHso8ualn
         RB9UY4DCeOhYzloVYvhLxx4lqKYORcE8ivaVQpYZrmu39M7Zj0Mmkn+g9GQWSKpgnJtU
         0aLZZOL9B9otwa7rGGfVvjzYoQxb7tzrh6bmIUfnbUlaBAKG/siAjE9cfXj49iloi2uc
         lChTQ+Pa+lbxEE/NgSdvznaNqRnE3L4eFwmknrjxuLO00BbB9MuKY2XYDVkuYMf59RhX
         kVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=t6PPDYvh+qaEIitujjlmqdED/SamEQLM3hBWiIl1kpE=;
        b=CND8vf+eC4LOl9trsock+g2kb47qj9gRrLDXKrvnX3yllzmQjzfY7NUopEKn0a/v3G
         nwzf9ESWFddLmqr4V5z1Alqz7zYzV5I+gcZkg/TfU06xxRphLmK3bGMD/MjTN0oiUntb
         7WpWPSeGx8l1iGJHu96eiTU97hKzo3rPVbup9KqlAPXSQzEdGEZPWazpmY27aMKTAQ0B
         B7ml+RI9uZFxEQdrO0wUCpey/AniNJQ9iI7q0kYzvPlQkVMN6+G/KP3eSLqh7wP0si/L
         JZiuTIPECd0GDxU3wAtxT6gbsg7YhGFjcnb/rLgPzF1Bw1pHdnwi6W3e+1arhQs0cHUU
         3oLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="32911493"
Date: Thu, 12 Apr 2018 11:09:11 -0600
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
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180412170911.GA6424@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597561001634244778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:27:20PM -0400, Sinan Kaya wrote:
> On 4/12/2018 11:02 AM, Keith Busch wrote:
> > 
> > Also, I thought the plan was to keep hotplug and non-hotplug the same,
> > except for the very end: if not a hotplug bridge, initiate the rescan
> > automatically after releasing from containment, otherwise let pciehp
> > handle it when the link reactivates.
> > 
> 
> Hmm...
> 
> AER driver doesn't do stop and rescan approach for fatal errors. AER driver
> makes an error callback followed by secondary bus reset and finally driver
> the resume callback on the endpoint only if link recovery is successful.
> Otherwise, AER driver bails out with recovery unsuccessful message.

I'm not sure if that's necessarily true. People have reported AER
handling triggers PCIe hotplug events, and creates some interesting race
conditions:

https://marc.info/?l=linux-pci&m=152336615707640&w=2

https://www.spinics.net/lists/linux-pci/msg70614.html

> Why do we need an additional rescan in the DPC driver if the link is up
> and driver resumes operation?

I thought the plan was to have DPC always go through the removal path
to ensure all devices are properly configured when containment is
released. In order to reconfigure those, you'll need to initiate the
rescan from somewhere.
