Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551CCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16662086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16662086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIKNKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:10:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeIKNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:10:39 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B202CCF5;
        Tue, 11 Sep 2018 08:12:29 +0000 (UTC)
Date:   Tue, 11 Sep 2018 10:12:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com,
        adouglas@cadence.com
Subject: Re: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Message-ID: <20180911081227.GB8963@kroah.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <1532023084-28083-3-git-send-email-pawell@cadence.com>
 <20180910181856.GB6019@kroah.com>
 <87in3c1t50.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in3c1t50.fsf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:48:43AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Thu, Jul 19, 2018 at 06:57:35PM +0100, Pawel Laszczak wrote:
> >> This patch add additional functions that converts some fields to string.
> >> 
> >> For example function usbssp_trb_comp_code_string take completion
> >> code value and return string describing completion code.
> >> 
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  drivers/usb/usbssp/gadget.h | 580 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 580 insertions(+)
> >> 
> >> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
> >> index 49e7271187cc..b5c17603af78 100644
> >> --- a/drivers/usb/usbssp/gadget.h
> >> +++ b/drivers/usb/usbssp/gadget.h
> >> @@ -930,6 +930,73 @@ struct usbssp_transfer_event {
> >>  #define COMP_UNDEFINED_ERROR			33
> >>  #define COMP_INVALID_STREAM_ID_ERROR		34
> >>  
> >> +static inline const char *usbssp_trb_comp_code_string(u8 status)
> >
> > <snip>
> >
> >
> > You have _giant_ inline functions here, why?
> >
> > Please just put this all in a .c file and let the linker properly handle
> > things.  You do not want to duplicate all of these crazy strings all
> > over the place where ever you call these functions.
> >
> > And I am guessing this is only for some sort of "debugging" mode?  If
> > so, shouldn't there be a way to not even build this in?  Some systems
> > are very space constrained...
> 
> many of them seem to be a straight copy from xhci.

Which doesn't mean it's a great model to copy :)

Let's learn from our past mistakes, having had to try to slim down a
kernel for a limited memory system is a chore that no one should have to
manually hack up the source tree just to accomplish it.

thanks,

greg k-h
