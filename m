Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZrSutIzeIJd1iX7gXgCKiuPEL9qm4WSCNu1nAL2w0+8Dw60dvz8K11OrMHzpW2YTbaN9882
ARC-Seal: i=1; a=rsa-sha256; t=1525807535; cv=none;
        d=google.com; s=arc-20160816;
        b=YfrCPAp/49mVn+nfzB/CkmfVoPY9vWm6J7oHkz4lX9ppRKqpULXgobi+O80EMp/5mW
         uT/hMbzrL5f5NFmAYzyVUvXftjNoG4LUCSdnPqrjhLOEULOO6Tjj9zeaaAtrX5JpFE3S
         r1Vi+AnOzwqKh6hFMyf8eBzRYde+CWwP/7AwtfLHWW2Qkrm7+naGTeUyjLE31tBMBY3+
         XEsbfzbqzAh4fyo8FwgW8i+YOmP3CL/XlbGuJPiYt6kJgZIy5b8oKUllg1LNUBJBFSQf
         hjIgx1vqxX/mdZVAunFUqI/B+TP5HvFdFSwD4R4WL+eU+5P93OL+HAsXIwr6JsceR/Hv
         SRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Z5jTOfD0FfZw/KBahVDyYRy7Th0avOVtmAp5e1QnJz8=;
        b=0RhCboBvNO3wEQLJ0Q7ij6LOS7ikLVD7vGd6/BWRgo0U+XkoHKexCqkSckOZDLDmEK
         QTLjQkvFPhhgyFrOix8wW+G+OOZo3E8ZeG+Haf3sSSaxF1YGz/Bf4aN179sX8LiHrAvg
         IIyeWFZfiwtGETTcbbTp2JKw2F2ErQbKkvDwxvPzt0y3Zdtl8frtZOKkrdFXlYsC6wBy
         wpDpuiM8Z3Q++UkN3kQPhpbwcuEYVVcFUSyAqglHVN90CU2xLXpZ0PnJR6+8J9FV2JIy
         qof4yG0vMprN/fl6jb4gaq72dcgjybVoxiegIFMhsm9QZ48wvA6Nn5qj9qLphwVX9aNu
         0VgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Z+KOEbJE;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Z+KOEbJE;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 14:25:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Oza Pawandeep <poza@codeaurora.org>,
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
Message-ID: <20180508192532.GA79697@bhelgaas-glaptop.roam.corp.google.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
 <20180312232626.GI18494@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312232626.GI18494@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1599925162285092341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 05:26:26PM -0600, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 02:47:30PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 12, 2018 at 08:25:51AM -0600, Keith Busch wrote:

> > > Per spec, DPC is the recommended way for handling surprise removal
> > > events and even recommends DPC capable slots *not* set 'Surprise'
> > > in Slot Capabilities so that removals are always handled by DPC. This
> > > service driver was developed with that use in mind.
> > 
> > Thanks for this tip.  The only thing I've found so far is the mention
> > of Surprise Down triggering DPC in the last paragraph of sec 6.7.5.
> > Are there other references I should look at?  I haven't found the
> > recommendation about not setting 'Surprise' in Slot Capabilities yet.
> 
> No problem, it's in the "IMPLEMENTATION NOTE" at the end of 6.2.10.4,
> "Avoid Disabled Link and Hot-Plug Surprise Use with DPC".
> 
> Outside the spec, Microsemi as one of the PCI-SIG contributors and early
> adopters of the capability published a white paper "Hot and Surprise
> Plug Recommendations for Enterprise PCIe" providing guidance for OS
> drivers using DPC. We originally developed to that guidance. The paper
> unfortunately appears to be pay-walled now. :(

Any chance you have a URL or contact info for this pay-walled white
paper?  Sounds like it might have useful information in it.
