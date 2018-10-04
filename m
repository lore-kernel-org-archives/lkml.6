Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C375C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54C520684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54C520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJEAaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:30:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49939 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJEAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:30:08 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g86uM-00017k-Od; Thu, 04 Oct 2018 17:55:26 +0100
Message-ID: <1538672124.3024.270.camel@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH 3/4] usbnet: smsc95xx: check for csum
 being in last four bytes
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc:     linux-kernel@lists.codethink.co.uk, linux-usb@vger.kernel.org,
        oneukum@suse.com, linux-kernel@vger.kernel.org, davem@davemloft.net
Date:   Thu, 04 Oct 2018 17:55:24 +0100
In-Reply-To: <20181002092645.1115-4-ben.dooks@codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
         <20181002092645.1115-4-ben.dooks@codethink.co.uk>
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
[...]
> @@ -2031,7 +2045,8 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
> >  	}
>  
>  	if (csum) {
> -		if (skb->len <= 45) {
> +		/* note, csum does not work if csum in last DWORD of packet */
> +		if (skb->len <= 45 || !smsc95xx_can_checksum(skb)) {

It would make more sense to move the length check into
smsc95xx_can_checksum() as well.

Ben.

>  			/* workaround - hardware tx checksum does not work
>  			 * properly with extremely small packets */
>  			long csstart = skb_checksum_start_offset(skb);
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
