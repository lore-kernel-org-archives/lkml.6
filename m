Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92647C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDDE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDDE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeIJXOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:14:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJXOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:14:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37C66C93;
        Mon, 10 Sep 2018 18:18:59 +0000 (UTC)
Date:   Mon, 10 Sep 2018 20:18:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com,
        adouglas@cadence.com
Subject: Re: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Message-ID: <20180910181856.GB6019@kroah.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <1532023084-28083-3-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532023084-28083-3-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 06:57:35PM +0100, Pawel Laszczak wrote:
> This patch add additional functions that converts some fields to string.
> 
> For example function usbssp_trb_comp_code_string take completion
> code value and return string describing completion code.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/usbssp/gadget.h | 580 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 580 insertions(+)
> 
> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
> index 49e7271187cc..b5c17603af78 100644
> --- a/drivers/usb/usbssp/gadget.h
> +++ b/drivers/usb/usbssp/gadget.h
> @@ -930,6 +930,73 @@ struct usbssp_transfer_event {
>  #define COMP_UNDEFINED_ERROR			33
>  #define COMP_INVALID_STREAM_ID_ERROR		34
>  
> +static inline const char *usbssp_trb_comp_code_string(u8 status)

<snip>


You have _giant_ inline functions here, why?

Please just put this all in a .c file and let the linker properly handle
things.  You do not want to duplicate all of these crazy strings all
over the place where ever you call these functions.

And I am guessing this is only for some sort of "debugging" mode?  If
so, shouldn't there be a way to not even build this in?  Some systems
are very space constrained...

thanks,

greg k-h
