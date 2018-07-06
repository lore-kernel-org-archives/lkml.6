Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E694C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BC922BC4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xe8376uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BC922BC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeGFXAo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:00:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbeGFXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M0xU/Nm4tUZsQTf3C+2DBrP+AOjZQ7PvS5B458q2ZW4=; b=Xe8376uMV2mBRwDUjQaltcrgT
        Fztx2CJWnPm918xej6wflZOrUZ7jJ6eNH3REFWD9hyIH7ath4oKnFPRL1bDOWFQh5pLcP486ve2hj
        VH7VqyNaGHRCC8nYAugnfz8zDCOCfiGuRyrnAoNivNk8SevJTG599SvXx6kWZbi5F+gTZWRsISqNC
        uk3YUmztamJ8OdO4KhwMHP5+2g3dez/3nEMlUXpL0xFdBvay41UJ4UK9mBEGAZ3D0xa29m2noUF9o
        DfYl6o2cR520YDAtXRy+aVhh/+wqKHriqS4yhPrC7yMLGB7foOSETZhnzkICjZWRZ4RjRmfPZ4ElT
        iJ/xJWZ2g==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbZiT-0007qk-SF; Fri, 06 Jul 2018 23:00:41 +0000
Date:   Fri, 6 Jul 2018 16:00:40 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: wmi: prefix sysfs files in
 /sys/bus/wmi with the ACPI device
Message-ID: <20180706230040.GA3041@fury>
References: <1512786861-1014-1-git-send-email-mario.limonciello@dell.com>
 <1512786861-1014-2-git-send-email-mario.limonciello@dell.com>
 <DDE9D9EA-D55D-41CC-94ED-EB2A590B7BCF@amacapital.net>
 <1512790860266.96149@Dell.com>
 <CALCETrWm9jY-jo9EN7KW+E4Gc1nDPrQAJ_g+07L-UgZpe5XgMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWm9jY-jo9EN7KW+E4Gc1nDPrQAJ_g+07L-UgZpe5XgMA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2017 at 01:32:29PM -0800, Andy Lutomirski wrote:
> On Fri, Dec 8, 2017 at 7:41 PM,  <Mario.Limonciello@dell.com> wrote:
> >>> On Dec 8, 2017, at 6:34 PM, Mario Limonciello <mario.limonciello@dell.com> wrote:
> >>>
> >>> It's possible for the same GUID to show up on as system twice.
> >>> This means using solely the GUID for identify the file will not
> >>> be sufficient.
> >>
> >>Isn't the file already in a per-bus directory?
> >
> > Yep, but the symlink created in /sys/bus/wmi/devices isn't.
> > That's where the kernel complains about duplicate sysfs
> > attributes.
> >
> > It's not exactly a pretty path I submitted, but it does avoid
> > those collisions.
> >
> > Example (with this in place from /sys/bus/wmi/devices):
> > lrwxrwxrwx 1 root root 0 Dec  8 21:39 PNP0C14:04-70FE8229-D03B-4214-A1C6-1F884B1A892A -> ../../../devices/platform/PNP0C14:04/wmi_bus/wmi_bus-PNP0C14:04/PNP0C14:04-70FE8229-D03B-4214-A1C6-1F884B1A892A
> 
> Right, I saw that in the cover letter right after sending this.
> 
> Greg, is there a cleaner way to deal with this?  There are two
> instances of the same bus type, each of which would like to have a
> device called "70FE8229-D03B-4214-A1C6-1F884B1A892A".  Can we somehow
> rename the symlinks without renaming the device, or are we just
> supposed to prefix the device name like Mario is doing here?
> 

Mario,

This one has been lingering at the bottom of my patch stack for a while now -
sorry for not poking on this earlier. Is this still something you have a need
for?

If so, would you resend and add Greg to Cc - specifically directing Andy's
question above to him?

-- 
Darren Hart
VMware Open Source Technology Center
