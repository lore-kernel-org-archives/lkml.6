Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx4/9vcLvywROb2E+vZrfStEYoX0TQ+uY+c0tOyNPC5HpghNLQfUguC2252DhURkKH0WCQamn
ARC-Seal: i=1; a=rsa-sha256; t=1523543939; cv=none;
        d=google.com; s=arc-20160816;
        b=hCosIaF5QALM7UkkqHVUOehFyXGjMR9YKYW0qhj8IcL9UZh6LFL3RZYWTyRT3U9yj9
         YeFMK1OuStxI5w0saQWNq69LbZZ9G1fJhT3MPN2/92wVlAiW2w+utnDFCKtQYKlNAw2S
         o7l9Gn6MteA04Kaw8skT59aWltp4VEd6DrmBEq6Sk3JVIfXx9YzXHDUV3nedEOeRIRKH
         1nLY7bMusurNKeNMObRgSeQixK3BRNrhNGPk5T0QAJpw70/wC21HgBprZRKhau8V5qJt
         RliaMD6nBgJ/qucpIjUS2gE3IlLv7Mw9r/cEhSrTpqw/jkyoqlfPNfs7u8s5z+ZZTuE2
         b0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=r47sDPPGGjob9gxJJFlmqbBfhbA9dUcgRJooI1S4sGA=;
        b=KxpyF/EDDX/kxApTqE/7dBh1SnvBKjRY+j4gdoeKi9ON0TDdCZTzexVDSU64+Rp3ht
         aAB4YJB4xB26/KyVo/8g8INVQK+uNJE9KJXzDZZKVvllbgT5eEzzOAxm3JmUnuWUptjd
         ZIJqVF4dXyqQIOw07FaGkbEg4o3XQET9W3aUII3dwhQsPFHdakNcDv95sfRpMer3RZ2i
         qWvMJWOp7TSFn6SoxzQS2BEdqt3gQlSYdgNG4sGCPnTngK6pGAXAZ+gWc4U673YtxzVP
         LDlUVJLHxHrVJVwMtFyepXHogcKYjQXIjbaT6XnsaKdDuhQXE9xfaW5LGIaCaBrZauMV
         O4Ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="32868832"
Date: Thu, 12 Apr 2018 08:39:54 -0600
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
Message-ID: <20180412143954.GB4810@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597551609701564310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 10:34:37AM -0400, Sinan Kaya wrote:
> On 4/12/2018 10:06 AM, Bjorn Helgaas wrote:
> > 
> > I think the scenario you are describing is two systems that are
> > identical except that in the first, the endpoint is below a hotplug
> > bridge, while in the second, it's below a non-hotplug bridge.  There's
> > no physical hotplug (no drive removed or inserted), and DPC is
> > triggered in both systems.
> > 
> > I suggest that DPC should be handled identically in both systems:
> > 
> >   - The PCI core should have the same view of the endpoint: it should
> >     be removed and re-added in both cases (or in neither case).
> > 
> >   - The endpoint itself should not be able to tell the difference: it
> >     should see a link down event, followed by a link retrain, followed
> >     by the same sequence of config accesses, etc.
> > 
> >   - The endpoint driver should not be able to tell the difference,
> >     i.e., we should be calling the same pci_error_handlers callbacks
> >     in both cases.
> > 
> > It's true that in the non-hotplug system, pciehp probably won't start
> > re-enumeration, so we might need an alternate path to trigger that.
> > 
> > But that's not what we're doing in this patch.  In this patch we're
> > adding a much bigger difference: for hotplug bridges, we stop and
> > remove the hierarchy below the bridge; for non-hotplug bridges, we do
> > the AER-style flow of calling pci_error_handlers callbacks.
> 
> Our approach on V12 was to go to AER style recovery for all DPC events
> regardless of hotplug support or not. 
> 
> Keith was not comfortable with this approach. That's why, we special cased
> hotplug.
> 
> If we drop 6/6 on this patch on v13, we achieve this. We still have to
> take care of Keith's inputs on individual patches.
> 
> we have been struggling with the direction for a while.
> 
> Keith, what do you think?

My only concern was for existing production environments that use DPC
for handling surprise removal, and I don't wish to break the existing
uses.
