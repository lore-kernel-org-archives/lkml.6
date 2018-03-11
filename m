Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AG47ELvbG3AourA9GXntZs+2TqxE0Bxttjtvl5tDhI4qC3E7FHhMzGvUawdZqmCHHIPx8RibtlNv
ARC-Seal: i=1; a=rsa-sha256; t=1520805865; cv=none;
        d=google.com; s=arc-20160816;
        b=qMOUrTMyN3JTwAUtJOgixAxwpReODdZa9OLpnxSGbJdbupjVOz7Vtv2AeYF9Yleqgg
         s7EL4ILFi/7NkZRzOQqUlrnGaIz77WwB9QnBIyfF9vKWK9/mwMSUCjCBi4Kb6sWLXrR1
         e510WNYhjIF85HtfQVQOlTyXob5UqP8Ly3pZleDAWFqsoLZw0VqFehQYyrOiC2BocJm/
         arAvRcI1cCPyv2VNolGKRRbHrFSNzUxrXqi/IWbVW2Kgvj5Mbm+y78iFGjYBBUi93BIp
         VjRXU3U1RkaTSlyfcx1u3kaZH8KC+cvM0bPKK4UKBpB/zJhF39Qq0QVyynMYE0ZA8+PP
         fn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=B7duFtoNEM7MhCckbQwKNsfMVQhNrhnYdweJTV85Zx4=;
        b=Gq7gTSTUzA++nH1pX3YaHQeAs4SKR5RLqpC89JvQnC0i6/DjJKM33rC8Rhde5AvPJx
         mGtrZGd2ae/YMZ9ZNR8GOTlVg5ok/XC5Icgo44Mco7B0bI+belcg3v6cbHrBATPNT20/
         fr1TPOqP0z/6/BlYd9eKC5KL612FM00efuq5fIJGUhrpvkZw/ZlCgmFBZ0niylHmP32t
         vzpD4fv7OCflCMVVfrayL0U3fuKmOktr0PDmGO/edRozw+csvFYNcQTaihYSag28xWWD
         Gd6F5goYJ10nYRYxThInOlV4MxkBGcBbZHhgT3yx3JQ1w2BwjK687Yv02m7G3P48uAFK
         +1Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE51208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Sun, 11 Mar 2018 17:03:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594680531668685472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> DPC should enumerate the devices after recovering the link, which is
> achieved by implementing error_resume callback.

The main point of this series is to call the driver error handling
callbacks (error_detected(), mmio_enabled(), slot_reset(), etc.) when
DPC events occur.  We've always called them for AER events, but prior
to this series, we didn't call them for DPC events.

That's a good thing -- we should treat DPC events as much like AER
events as possible.

This series does make it more obvious that there's still a big
difference between AER and DPC handling -- for DPC, we remove and
re-enumerate all the devices, but we don't for AER.  

That difference has been there since the beginning of DPC, so it has
nothing to do with *this* series EXCEPT for the fact that it really
complicates the logic you're adding to reset_link() and
broadcast_error_message().

We ought to be able to simplify that somehow because the only real
difference between AER and DPC should be that DPC automatically
disables the link and AER does it in software.

Bjorn
