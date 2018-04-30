Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZr/jPYj/GnAUUR0ES2KHy2g6ZdzrS+R0M54hqInGtYEyyvOTMs6/1pvNt4TvJMkhoXAaFax
ARC-Seal: i=1; a=rsa-sha256; t=1525108533; cv=none;
        d=google.com; s=arc-20160816;
        b=fVIu9/91V3fXFQmyqzH8csy7faMq2G925ajFghlpsyvZ/2Je3S1tTI7qmaJnAkCFSi
         QcKaFM05HY5Id/voupj7rL2CoUsI5E2fTLvEZqDowCnnlWOzghp5ErSAgJxK2SwkkayG
         hFa4ji0bHfl7HQIwDIj2H7s/ifsBIhWRLctRPeqwQsJejW+rbcWWk/9zbD8W/UPD9lLW
         cpWaiHJM1QGb5zVC9LKJjV3C4UTNSlb++mgowkL+qPOp1qIMfTPNUVZEp+t7yeyPgxeL
         Scc/sNZcspFzg1rfzEzbxraXgMeBhRu5QWepcGEFPq1zcVtlbsHpoqTJ5cl9qZ9LENRQ
         66nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dmarc-filter:arc-authentication-results;
        bh=dsSKODxO5Y7B4UwK7iCuFHtA3Fb2DHw0dcvzy7K4mZE=;
        b=NecbnXWzOLwHugs6zVerT7W6ElciZN6iBDWMAZJ6Y54+30YD1mIRsp2HF2Kdvzfgf4
         RRMClxhN8WJkwyt1Hxn/xJKKLaTviYJJlb0VxWxkpkamkMsKHNnVF4nHQ9rVPzS5Z2Jv
         5YeZEM+1moZKAVO9crfFo3f52ykcPQq03UfrU2T+EUp3R+suhrNUwyP5ReiVP2SashPI
         5HpXAKDfjl21s3uLPphp8o2V53kgG84gkY1O8HnUuvO60b5OgbLTK6cNvh6yBELATpyh
         gbgojWGceqyulkC+vEiCSU7KaATUvn0YVRBGPkZ2s8IA0AvJIT+9aZSsPBsloSioWkF6
         GqOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA17B22D48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 30 Apr 2018 12:15:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, fred@fredlawl.com,
	linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
	austin_bolen@dell.com, keith.busch@intel.com
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
Message-ID: <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
 <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
 <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1599192205664594782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 12:07:48PM -0500, Alex G. wrote:
> On 04/28/2018 11:46 AM, Alex G. wrote:
> > On 04/27/2018 05:43 PM, Bjorn Helgaas wrote:
> > > On Tue, Apr 17, 2018 at 12:09:43PM -0500, Alexandru Gagniuc wrote:
> (snip)
> > > > +    memset(&info, 0, sizeof(info));
> > > > +    info.severity = aer_severity;
> > > > +    info.status = status;
> > > > +    info.mask = mask;
> > > > +    info.first_error = 0x1f;
> > > 
> > > I like this patch a lot, but where does this "first_error = 0x1f" come
> > > from?
> > 
> > aer_(un)correctable_error_string don't go to [0x1f], so this guarantees
> > us we don't print "(First)".
> > 
> > > I assume this is supposed to be the "First Error Pointer" in the
> > > Advanced Error Capabilities and Control register (PCIe r4.0, sec
> > > 7.8.4.7).  There is a "cap_control" field in struct
> > > aer_capability_regs; should we be using that here?
> > 
> > There is a way to extract it from the PCI regs, and it's quite simple.
> > IIRC, it should be all f's when the capability is not implemented. I
> > wanted to avoid any further parsing of PCI regs in this patch.
> 
> I could update the offending line to say:
>  +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);

That's what I would have expected.  So I'd say either do this, or add
a comment about why it's not the right thing to do.

> Though I still have the concerns with validating CPER data:
> 
> > I can see a way to use even more common printk code, but that requires
> > validating the PCI regs we get from firmware. That means we need to make
> > a guarantee about CPER that is beyond the scope of this patch.

Sounds like this is material for another patch, but if/when you do
that, I'd like to understand your concern about validating the
registers we get from firmware.  Are you worried about getting
incorrect register contents, then printing the wrong info, making
the wrong decision about how to recover, something else?

Bjorn
