Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZpY7J94smh4aBae6s7pMMV6D3qlg45JQYA11Qc60i7jsZ0QCTLZg0WcdwLXTE58cE58O4X/
ARC-Seal: i=1; a=rsa-sha256; t=1525730822; cv=none;
        d=google.com; s=arc-20160816;
        b=r30ZLs7USjvkNf9C3wBm5954ZFqpp/NHhof6EadMJw9aCpMGtL5Mp9Anb2jeSvCgNQ
         A8s9YYyf69DjpUWAa1duxivCJFdasfdCaLENeqXKwRTo+SHk/224Fc1iwZ2R9q79Sv8P
         +Oj+TCEYUxcBgljuYfNN2mKAcdGiqiw2wUjAocwpkXoOgqaR6CrDAKEmUbRRiN52c1+O
         jNkuCv1j8TqMGQ2xx00x2A/NhGF4Eg5avfJQUK3Ya1WnMVZ76cTlELqvf6gRsaDNQjjR
         eKUiDwk5DVCs6H04bbf8b1h9U8tFOe12rLIVYkhSllS1KdwwAI+TwUoW642ZlfCaOMXw
         GZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=fmzTOZcetTH7Hmn40E/0JfTIsJ02ad2Fh4Wa3j2aFzk=;
        b=tScX4UR37e1RTAItlQ/HGTnZKW/0qsiidxsZcjOnWMHx8qJWrIctEufoQfgt6J9ykw
         xtPZTph2oZNYpTHUKCSpKOTyL0fnOixEMreHXvb5oR3nTOyLNrNR6z+VQw4KXkyidZA9
         hRmiAFKKckuMLLuCmfYeXOV+Ko6TIIOqDRi4JjPx/aNSZU4MRGimOrqK77DbkzpJoJ0g
         R/sFiM0OXMyiK5H2zFI5JZAd8+gTC1VzPXPTq3/XOVNqzPxFmobhBpRa2KRfv2loWsgG
         IACHdRR+jT44Q2ahjjptsoeI/QYx8csvSKun7c/jS7H9gEgiJ23C71v+iS0Vs6UVq15o
         4jXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=p4DNn4xf;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=p4DNn4xf;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Mon, 7 May 2018 17:06:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, fred@fredlawl.com,
	linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
	austin_bolen@dell.com, keith.busch@intel.com
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
Message-ID: <20180507220659.GB161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
 <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
 <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
 <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
 <8e8a8de1-a90c-ab88-c8ac-bbe8bcc7d49c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8a8de1-a90c-ab88-c8ac-bbe8bcc7d49c@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1599844722843630523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:41:26PM -0500, Alex G. wrote:
> On 04/30/2018 12:15 PM, Bjorn Helgaas wrote:
> > On Sat, Apr 28, 2018 at 12:07:48PM -0500, Alex G. wrote:
> 
> (snip)
> >> I could update the offending line to say:
> >>  +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> > 
> > That's what I would have expected.  So I'd say either do this, or add
> > a comment about why it's not the right thing to do.
> 
> Okay.
> 
> >> Though I still have the concerns with validating CPER data:
> >>
> >>> I can see a way to use even more common printk code, but that requires
> >>> validating the PCI regs we get from firmware. That means we need to make
> >>> a guarantee about CPER that is beyond the scope of this patch.
> > 
> > Sounds like this is material for another patch, but if/when you do
> > that, I'd like to understand your concern about validating the
> > registers we get from firmware.  Are you worried about getting
> > incorrect register contents, then printing the wrong info, making
> > the wrong decision about how to recover, something else?
> 
> I don't trust firmware, and I have daymares about firmware leaving these
> fields uninitialized. In jargon, I'd like to treat it as external
> untrusted serialized data.

That makes good sense to me.

In this particular case, we only test first_error for equality:

  __aer_print_error(...)
  {
    ...

      pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
	info->first_error == i ? " (First)" : "");

so I don't think there's any danger.  If we were using it to index an
array or something, we should certainly validate it first.
