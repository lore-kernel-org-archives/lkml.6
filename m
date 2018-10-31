Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276C62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276C62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeJaTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbeJaTd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:33:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0D5E2D7E0;
        Wed, 31 Oct 2018 10:36:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D159718686;
        Wed, 31 Oct 2018 10:36:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181030223249.dhwhxdjipzmjxzsy@gofer.mess.org>
References: <20181030223249.dhwhxdjipzmjxzsy@gofer.mess.org> <153778383104.14867.1567557014782141706.stgit@warthog.procyon.org.uk> <20181030110319.764f33f0@coco.lan>
To:     Sean Young <sean@mess.org>
Cc:     dhowells@redhat.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Brad Love <brad@nextdimension.cc>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb: Allow MAC addresses to be mapped to stable device names with udev
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8473.1540982182.1@warthog.procyon.org.uk>
Date:   Wed, 31 Oct 2018 10:36:22 +0000
Message-ID: <8474.1540982182@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 31 Oct 2018 10:36:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Young <sean@mess.org> wrote:

> > > Devices have a MAC address available, which is printed during boot:
> 
> Not all dvb devices have a mac address.

How do I tell?  If it's all zeros it's not there?

> Devices without a mac address shouldn't have a mac_dvb sysfs attribute,
> I think.

I'm not sure that's possible within the core infrastructure.  It's a class
attribute set when the class is created; I'm not sure it can be overridden on
a per-device basis.

Possibly the file could return "" or "none" in this case?

> The dvb type and dvb adapter no is already present in the device name,
> I'm not sure why this needs duplicating.

They can be used with ATTR{} in udev rules.  I'm not clear that the name can.

> With this patch, with a usb Hauppauge Nova-T Stick I get:
> ...
> ==> /sys/class/dvb/dvb0.demux0/dvb_mac <==
> 00:00:00:00:00:00

I can't say why that happens.  I don't have access to this hardware.  Should
it have a MAC address there?  Is the MAC address getting stored in
dvbdev->adapter->proposed_mac?  Maybe it's not getting read - on the card I
use it's read by the cx23885 driver... I think...  The nova-t-usb2.c file
doesn't mention proposed_mac.

David
