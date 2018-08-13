Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08A1C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2452189B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hrsCOVdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2452189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeHMSW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:22:58 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38116 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728547AbeHMSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:22:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AD5BA8EE171;
        Mon, 13 Aug 2018 08:40:12 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5CMrRuecfq_6; Mon, 13 Aug 2018 08:40:12 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 40D3C8EE0ED;
        Mon, 13 Aug 2018 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534174812;
        bh=bu23gIFLrjeNLdwjA8OvF29QvwVC/5Yn7MakmGzrCB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:From;
        b=hrsCOVdhyh3LhMFrnTL6TYajtrWKM/4yhXvfvOe+OlZjx0YLqc6MmSg+Cgia3Px5R
         M5a46z6DLlPGw2QhbJyWw0g8TmpUDRhPH9xW9sH72khgXQQyGpyCRRs/ypudx0+b3q
         8461Y8DSUwgY1G2+0oa+YLWPWh5SxDf3aQrvq8pU=
Message-ID: <1534174811.7872.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Date:   Mon, 13 Aug 2018 08:40:11 -0700
In-Reply-To: <20180731191102.2434-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ample information, including documentation, installation
> instructions,
> and project details, is available at:
> 
>   * https://www.wireguard.com/
>   * https://www.wireguard.com/papers/wireguard.pdf

In your paper you say this:

> Finally, WireGuard is cryptographically opinionated. It intentionally
> lacks cipher and protocol agility. If
> holes are found in the underlying primitives, all endpoints will be
> required to update.

The only thing that's certain (beyond death and taxes) is that your
crypto choice will one day need updating; either in response to an
urgent CVE because an algorithm is compromised or in response to a less
urgent one because it is deprecated.  Assuming wireguard is reasonably
successful we'll have a large ecosystem dependent on it.  On this day,
we're going to have the choice of either breaking the entire ecosystem
by rolling out a change that can't connect to lower protocol versions
or trying to wedge version agility into wireguard in a hurry.  The
former is too awful to contemplate because of the almost universal
ecosystem breakage it would cause and the latter is going to lead to
additional bugs because people in a hurry aren't as careful as they
should be.

Could we please build planning for this crypto failure day into
wireguard now rather than have to do it later?  It doesn't need to be
full cipher agility, it just needs to be the ability to handle multiple
protocol versions ... two should do it because that gives a template to
follow (and test version to try to find bugs in the implementation). 
It looks like the protocol could simply be updated to put the version
into one (or more) of the three reserved bytes in the handshake
headers, so perhaps doing this before they get used for something else
would be a good first step?

James

