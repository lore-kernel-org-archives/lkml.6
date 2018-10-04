Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0504C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B792320684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B792320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeJEAaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:30:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49939 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeJEAaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:30:10 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g86sG-00014P-Mi; Thu, 04 Oct 2018 17:53:16 +0100
Message-ID: <1538671996.3024.269.camel@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH 2/4] usbnet: smsc95xx: align tx-buffer to
 word
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc:     linux-kernel@lists.codethink.co.uk, linux-usb@vger.kernel.org,
        oneukum@suse.com, linux-kernel@vger.kernel.org, davem@davemloft.net
Date:   Thu, 04 Oct 2018 17:53:16 +0100
In-Reply-To: <20181002092645.1115-3-ben.dooks@codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
         <20181002092645.1115-3-ben.dooks@codethink.co.uk>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 10:26 +0100, Ben Dooks wrote:
> The tegra driver requires alignment of the buffer, so try and
> make this better by pushing the buffer start back to an word
> aligned address. At the worst this makes memcpy() easier as
> it is word aligned, at best it makes sure the usb can directly
> map the buffer.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [todo - make this configurable]
[...]

I don't think you need a separate kconfig symbol for this.  Aligning RX
buffers to words (or better, cache lines) is almost always a win, so
long as the CPU can handle misaligned fields in the network/transport
headers.  You can use #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to
check that.

It seems like NET_IP_ALIGN should be defined to 0 or 2 depending on
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, but NET_IP_ALIGN predates the
latter.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
