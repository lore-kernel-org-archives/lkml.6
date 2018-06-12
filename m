Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41B54C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA21920891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="bHIt/Jwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA21920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934888AbeFLWSq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:18:46 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:48546 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeFLWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KdcxnL/V87t3c8oEU7atZCCB7zx8+qjs4i7aG7vUVog=; b=bHIt/JwuqoNryVNZ+Qg5s5AM/9
        6viJ9tMaC9ZEYbS0/R5qeKqatp4mzk2/xVg+3XlzZPjlXNTAlJQyuqpBIu27TY52giASP6L87lvKe
        fdbIif7DD2BwC2zE6FgGFWn43aUa/NFODs2cwG5yxoXawSOLT2u5yexTwFbLJLcPP+X3hdE/KGfJ1
        1QcwdkLPA3ot47gb5RZ3AD3Ex14mxFVRCLoxGGPt/buxeKYpPrxEd1tKf0Dhg2KiAywZIdsfansm3
        oP8WJo3DiVpDLyC/YDcQ+9kr4pIWRnjF8LoUyTW9P72QJDJKx3dgmyrzwNfbrpSjaLThib86cGmGP
        E+/WEXGw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48194 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fSrch-005kpE-50; Tue, 12 Jun 2018 22:18:44 +0000
Date:   Tue, 12 Jun 2018 15:18:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mats Karrman <mats.dev.list@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/8] usb: typec: helper for checking cable plug
 orientation
Message-ID: <20180612221842.GA16275@roeck-us.net>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-3-heikki.krogerus@linux.intel.com>
 <595c8953-040a-5697-0f79-ea6622d88bcb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595c8953-040a-5697-0f79-ea6622d88bcb@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:56:31PM +0200, Mats Karrman wrote:
> Hi Heikki,
> 
> On 2018-06-08 13:29, Heikki Krogerus wrote:
> 
> >This adds function typec_get_orientation() that can be used
> >for checking the current cable plug orientation.
> >
> >Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >---
> >  drivers/usb/typec/class.c | 11 +++++++++++
> >  include/linux/usb/typec.h |  1 +
> >  2 files changed, 12 insertions(+)
> >
> >diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> >index 53df10df2f9d..02db9bcbac0c 100644
> >--- a/drivers/usb/typec/class.c
> >+++ b/drivers/usb/typec/class.c
> >@@ -1279,6 +1279,17 @@ int typec_set_orientation(struct typec_port *port,
> >  }
> >  EXPORT_SYMBOL_GPL(typec_set_orientation);
> >+/**
> >+ * typec_get_orientation - Get USB Type-C cable plug orientation
> >+ * @port: USB Type-C Port
> >+ *
> >+ * Get current cable plug orientation for @port.
> >+ */
> >+enum typec_orientation typec_get_orientation(struct typec_port *port)
> >+{
> >+	return port->orientation;
> >+}
> 
> +EXPORT_SYMBOL_GPL(typec_get_orientation);
> 
> Isn't this a candidate for an inline?
> 

Currently struct typec_port is class private. To make this function inline,
struct typec_port would have to be moved from drivers/usb/typec/class.c to
include/linux/usb/typec.h. That doesn't sound like a good idea to me.

Guenter

> BR // Mats
> 
> >+
> >  /**
> >   * typec_set_mode - Set mode of operation for USB Type-C connector
> >   * @port: USB Type-C port for the connector
> >diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> >index 672b39bb0adc..a5f6433e218b 100644
> >--- a/include/linux/usb/typec.h
> >+++ b/include/linux/usb/typec.h
> >@@ -265,6 +265,7 @@ void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
> >  int typec_set_orientation(struct typec_port *port,
> >  			  enum typec_orientation orientation);
> >+enum typec_orientation typec_get_orientation(struct typec_port *port);
> >  int typec_set_mode(struct typec_port *port, int mode);
> >  #endif /* __LINUX_USB_TYPEC_H */
> >
