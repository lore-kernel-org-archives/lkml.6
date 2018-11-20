Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D47EC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4C52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4C52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeKUBv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:51:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:44006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbeKUBv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:51:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CA53B0FE;
        Tue, 20 Nov 2018 15:22:18 +0000 (UTC)
Message-ID: <1542726774.28362.13.camel@suse.com>
Subject: Re: [PATCH v3] usb: hub: add retry routine after intr URB submit
 error
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 20 Nov 2018 16:12:54 +0100
In-Reply-To: <07a6b541f53a68b994f8ee6b1c864e096e1ff8cf.camel@suse.de>
References: <20181120143438.18296-1-nsaenzjulienne@suse.de>
         <1542725830.28362.12.camel@suse.com>
         <07a6b541f53a68b994f8ee6b1c864e096e1ff8cf.camel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Anytime "in_reset" is set "quiescing" is also set:
> 
> static int hub_pre_reset(struct usb_interface *intf)
> {
> 	struct usb_hub *hub = usb_get_intfdata(intf);
> 
> 	hub_quiesce(hub, HUB_PRE_RESET); //sets quiesce
> 	hub->in_reset = 1;
> 	hub_pm_barrier_for_all_ports(hub);
> 	return 0;
> }
> 
> static int hub_post_reset(struct usb_interface *intf)
> {
> 	struct usb_hub *hub = usb_get_intfdata(intf);
> 
> 	hub->in_reset = 0;
> 	hub_pm_barrier_for_all_ports(hub);
> 	hub_activate(hub, HUB_POST_RESET); //clears quiesce
> 	return 0;
> }
> 
> I should be OK isn't it?

Sorry, yes, I overlooked that there are two flags.

	Regards
		Oliver

