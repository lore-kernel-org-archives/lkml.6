Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522359935; cv=none;
        d=google.com; s=arc-20160816;
        b=QsUiIor6QXw2mkScq7nB9KZWpy5bfh77IcqpnrOYtjyL70HbBKO4Uc1Qj8hlumjPN8
         J4yk1EtnG3+1V+krJTlKWbU/bwgi0RKot10BVU9YUWZ+g4GQdd0wzCi2pNlTg0NaqFAB
         RZxjd4BrTTya6P3VDWlASD8J7Iy+NEYekSOZAVyPyUZ/uIzpUhWSz1lHsyLEG08GVPik
         wMN4ZIWz1h2XVtKelTUVxOeCEeZaWo7N63hmaRuOI7ht62iBjw3pMykaBiRov78pcHsk
         j7xAD19yQ0sB0Xb3F+WF5mz/CIZMn6xBOnVM4UC101J0n70aZFusvFWjlpyK7+xqz/u2
         Xoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=pL0xE09fVAXXJkaltFh5GZKsAkbrmOAPw59cnoVLa80=;
        b=Uq/fZNRi0lwnqHmq6/+DH6fgcpr64RzpbgJH209+3HHQmPDyx7ufAH480G7wfd3aVz
         2IorlQeRHfx/xBeE8WFeGFiwAKynUGPPG5HUuZdRkPpYRpB0T4jexug48fKOXSxHXOBP
         PULYtTE8B3D2qDrp+fi6wYVO8eCMBEGEaUd4mudT0BozWXfx3O5Cx6/mpCbw6UHPxBuI
         2AeohPUVloSfEoA+Co9rp3opWn7tbkBuWogx88zynW0O5F0KkHd8tMaZEKBckO9N5srz
         CCQ9YQ3BXlkFtwsO0BFFrp69+6GAZzkD6Y/AmQP1iEFccLeC/S8oXpIAWoW+RYjl9oaq
         LFIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx49H36cc5bAeJPMJGV0xmB9Lgj4EUvPS0HZPgKyh2WEz4lKWVzSut5yWDIR04IUrOCRy4rSciA==
Date: Thu, 29 Mar 2018 14:39:40 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH 4/6] fpga: region: change fpga_region_register to have
 one param
Message-ID: <20180329213940.GB29604@tyrael.ni.corp.natinst.com>
References: <20180329153658.11614-1-mdf@kernel.org>
 <20180329153658.11614-5-mdf@kernel.org>
 <20180329170618.GE8501@kroah.com>
 <CANk1AXSDDe_PKsx+9CEAN0ZFdb+efqJPWxLfVM2t9xPAQFNctQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSDDe_PKsx+9CEAN0ZFdb+efqJPWxLfVM2t9xPAQFNctQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287282137577782?=
X-GMAIL-MSGID: =?utf-8?q?1596310091960254185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:42:51PM -0500, Alan Tull wrote:
> On Thu, Mar 29, 2018 at 12:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> Hi Greg,
> 
> >> -int fpga_region_register(struct device *dev, struct fpga_region *region)
> >> +int fpga_region_register(struct fpga_region *region)
> >>  {
> >> +     struct device *dev = region->parent;
> >>       int id, ret = 0;
> >>
> >> +     if (!dev) {
> >> +             pr_err("Attempt to register fpga region without parent\n");
> >> +             return -EINVAL;
> >> +     }
> >
> > Are you sure you don't want a virtual device?  That is what will happen
> > if you do not have a parent, right?  Or do you always want to have
> > "real" devices?
> 
> I don't want to restrict this to "real" devices, so yes, I'll be
> removing this check.
> 
> >> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> >> index b6520318ab9c..423c87e3e29a 100644
> >> --- a/include/linux/fpga/fpga-region.h
> >> +++ b/include/linux/fpga/fpga-region.h
> >> @@ -8,6 +8,7 @@
> >>  /**
> >>   * struct fpga_region - FPGA Region structure
> >>   * @dev: FPGA Region device
> >> + * @parent: parent device
> >>   * @mutex: enforces exclusive reference to region
> >>   * @bridge_list: list of FPGA bridges specified in region
> >>   * @mgr: FPGA manager
> >> @@ -18,6 +19,7 @@
> >>   */
> >>  struct fpga_region {
> >>       struct device dev;
> >> +     struct device *parent;
> >
> > Why doesn't your dev parent pointer point to this, why do you need to
> > have a separate pointer?  That feels really wrong.  Pass in the parent
> > pointer when you create the struct device, otherwise it will be
> > registered incorrectly anyway.  Then you always have the correct
> > pointer, no need to keep a "spare" copy.
> 
> I'll add a fpga_mgr_create function and let it set the parent.  No
> need to save it.

I think we had discussed this in the first round of the patchset.
How about fpga_mgr_alloc(...) and fpga_mgr_register(...) as suggested
back then?

Thanks for the review,

Moritz
