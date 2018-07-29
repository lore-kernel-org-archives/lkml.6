Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B5C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E1B20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E1B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeG2TbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:31:08 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:53532 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbeG2TbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:31:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A2D50182CF673;
        Sun, 29 Jul 2018 17:59:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pail60_1c0e3eda49e51
X-Filterd-Recvd-Size: 2221
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Jul 2018 17:59:52 +0000 (UTC)
Message-ID: <12e1804800e490aa57b51a0e64c6da573d32a3a4.camel@perches.com>
Subject: Re: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Jul 2018 10:59:51 -0700
In-Reply-To: <90fb5087-22df-0480-548a-7658881181c8@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
         <20180729170851.2581-8-straube.linux@gmail.com>
         <07a456ef0b1163115ef9aeb717120c191263fe28.camel@perches.com>
         <90fb5087-22df-0480-548a-7658881181c8@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-29 at 19:42 +0200, Michael Straube wrote:
> On 07/29/18 19:21, Joe Perches wrote:
> > On Sun, 2018-07-29 at 19:08 +0200, Michael Straube wrote:
> > > Use is_broadcast_ether_addr instead of checking each byte of the
> > > address array for 0xff. Shortens the code and improves readability.
> > 
> > You should show in the commit log that sta_addr is __aligned(2)
> > as required by is_broadcast_ether_addr, otherwise you could be
> > introducing runtime alignment defects.
> > 
> 
> Ok, sta_addr is used from following structs.
> 
> struct ieee_param {
>          u32 cmd;
>          u8 sta_addr[ETH_ALEN];
>          union {
>          ...
>          ...
>          }; u
> };
> 
> struct ieee_param_ex {
> 	u32 cmd;
> 	u8 sta_addr[ETH_ALEN];
> 	u8 data[0];
> };
> 
> Well, looking at it now, I'm not sure about the alignment anymore
> in the struct that contains the union. Is sta_addr in the first
> struct __aligned(2)?
> 
> Should I include the snippets in the commit message, or is just
> writing that sta_addr is __aligned(2) enough? (if it is in the
> first case...)

It's enough to just state that the uses are properly aligned
as long as you looked and understand that it's required.

