Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE3A20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE3A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeILBDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:03:40 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51637 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeILBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:03:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fzos0-0001fA-25; Tue, 11 Sep 2018 21:02:44 +0100
Message-ID: <1536696163.3024.146.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 47/79] ieee802154: at86rf230: switch from BUG_ON()
 to WARN_ON() on problem
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Date:   Tue, 11 Sep 2018 21:02:43 +0100
In-Reply-To: <20180823074922.172707485@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
         <20180823074922.172707485@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 09:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> [ Upstream commit 20f330452ad8814f2289a589baf65e21270879a7 ]
> 
> The check is valid but it does not warrant to crash the kernel. A
> WARN_ON() is good enough here.
> Found by checkpatch.

If the BUG/WARN fires, the very next statement is going to cause an
oops.  So this doesn't fix anything.

Either it's OK for a null pointer to be a fatal error, in which case
the WARN can be removed, or that shouldn't be a fatal error, in which
case the following assignment needs to be conditional.

Ben.

> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ieee802154/at86rf230.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -932,7 +932,7 @@ at86rf230_xmit(struct ieee802154_hw *hw,
>  static int
>  at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	BUG_ON(!level);
> +	WARN_ON(!level);
>  	*level = 0xbe;
>  	return 0;
>  }

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
