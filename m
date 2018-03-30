Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AIpwx4/o4owVi2/lUSPg7GP1IGmpyRKRyyYuT9RqenLIVj748S76DB7bmL1qlpcsJI7rnxp8Nohi
ARC-Seal: i=1; a=rsa-sha256; t=1522423684; cv=none;
        d=google.com; s=arc-20160816;
        b=vCQvRoVuG7FUOt0ZT1tOmUk0om4Znfg6YXSGROXz8K46vhq5BSwvpUXmk0rlQvUq9s
         IhEPMGYJCxzmIio4rjYYkRFR+dgNkjYC0uBcBJtYoPAhFgn8hAdjtIFGuoeGMAErtVo2
         v9QKGpIxhrserqKE7qvTtbE0wAqDwE0iABZu39LE2zv47/jxtJo8JYSrGC7qVVo1HJy/
         ceQYA7XIjwE0TfVVfUixvg3MgmewdIQ0s1TDx09ylnOwOAdfpNxP3Lzgz6a3esg+sUYh
         Lq96JIs5hwoNcqwrPzSSIi5LKgbmOaPxw//OxEjfgUrnk+utvkZfMzi5xfKNiNswAhmm
         984g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=pmoUYSxfyKXl7U8mnGAs8Qw8sv/CRT0j0nfUXbr75N4=;
        b=ximXc8BFF5pfO7jdxsOA/LEpQ0p1mQAC5Lnber+Av48Hg4hPDe8TgUN3ArCAvlY+dG
         QUDbaP6ird+anWCFy02t33PAxZqB2P4wKBcJSz7Bh57pqdM7vFnTO/Kdq7/jrl+wnBhA
         Y3v8ryBTN5r2fJ24PLR0KSGERVqbnVPVM9qmKn5wzfxGaunMIfx3Yh9CRc4jcociZaeo
         grqx45ptQSD3FhuoexKGQP6+W3ke3METBVV2kayC8XR6Fbc0LPSFXbSeOagSBhvuAVp1
         rkvW1M8FNNTth2PodJt59PFEB4/la0QUeeNEfxY8YJO/FyK3eeOnL8a9ZEgfJK8QIg+A
         1bpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154C3217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180329213940.GB29604@tyrael.ni.corp.natinst.com>
References: <20180329153658.11614-1-mdf@kernel.org> <20180329153658.11614-5-mdf@kernel.org>
 <20180329170618.GE8501@kroah.com> <CANk1AXSDDe_PKsx+9CEAN0ZFdb+efqJPWxLfVM2t9xPAQFNctQ@mail.gmail.com>
 <20180329213940.GB29604@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Fri, 30 Mar 2018 10:27:22 -0500
X-Gmail-Original-Message-ID: <CANk1AXTPpJWUCrSEU4w25o-Ef9mqLnzVLhgDhmnyP6b-Hv_wHA@mail.gmail.com>
Message-ID: <CANk1AXTPpJWUCrSEU4w25o-Ef9mqLnzVLhgDhmnyP6b-Hv_wHA@mail.gmail.com>
Subject: Re: [PATCH 4/6] fpga: region: change fpga_region_register to have one param
To: Moritz Fischer <mdf@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287282137577782?=
X-GMAIL-MSGID: =?utf-8?q?1596376937550808973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 4:39 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Thu, Mar 29, 2018 at 03:42:51PM -0500, Alan Tull wrote:
>> On Thu, Mar 29, 2018 at 12:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> Hi Greg,
>>
>> >> -int fpga_region_register(struct device *dev, struct fpga_region *region)
>> >> +int fpga_region_register(struct fpga_region *region)
>> >>  {
>> >> +     struct device *dev = region->parent;
>> >>       int id, ret = 0;
>> >>
>> >> +     if (!dev) {
>> >> +             pr_err("Attempt to register fpga region without parent\n");
>> >> +             return -EINVAL;
>> >> +     }
>> >
>> > Are you sure you don't want a virtual device?  That is what will happen
>> > if you do not have a parent, right?  Or do you always want to have
>> > "real" devices?
>>
>> I don't want to restrict this to "real" devices, so yes, I'll be
>> removing this check.
>>
>> >> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> >> index b6520318ab9c..423c87e3e29a 100644
>> >> --- a/include/linux/fpga/fpga-region.h
>> >> +++ b/include/linux/fpga/fpga-region.h
>> >> @@ -8,6 +8,7 @@
>> >>  /**
>> >>   * struct fpga_region - FPGA Region structure
>> >>   * @dev: FPGA Region device
>> >> + * @parent: parent device
>> >>   * @mutex: enforces exclusive reference to region
>> >>   * @bridge_list: list of FPGA bridges specified in region
>> >>   * @mgr: FPGA manager
>> >> @@ -18,6 +19,7 @@
>> >>   */
>> >>  struct fpga_region {
>> >>       struct device dev;
>> >> +     struct device *parent;
>> >
>> > Why doesn't your dev parent pointer point to this, why do you need to
>> > have a separate pointer?  That feels really wrong.  Pass in the parent
>> > pointer when you create the struct device, otherwise it will be
>> > registered incorrectly anyway.  Then you always have the correct
>> > pointer, no need to keep a "spare" copy.
>>
>> I'll add a fpga_mgr_create function and let it set the parent.  No
>> need to save it.
>
> I think we had discussed this in the first round of the patchset.

Yup! :)

> How about fpga_mgr_alloc(...) and fpga_mgr_register(...) as suggested
> back then?

I'm cool with either name.  The alloc/create function will be doing
more than alloc.  It's going to fill in some struct members, allocate
an id #, and init the dev.  There's precedent for similar functions
named either way, even 'alloc' functions that do plenty of
initialization.

Alan

>
> Thanks for the review,
>
> Moritz
