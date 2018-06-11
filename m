Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D78A7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395FE208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gregn.net header.i=@gregn.net header.b="CSG/lqWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395FE208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gregn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbeFLAAK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:00:10 -0400
Received: from vserver.gregn.net ([174.136.110.154]:38962 "EHLO
        vserver.gregn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeFLAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:00:09 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2018 20:00:09 EDT
Received: from vbox.gregn.net (unknown [IPv6:2001:470:d:6c5:e4ca:cb3c:683d:fee3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 991012248;
        Mon, 11 Jun 2018 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1528761114; bh=GkLPpFQx9YRjlkVK39ioBWIZN/rLYxCYiltzxMzl2vM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CSG/lqWCobSPNc8QmsBbZzRlky1woLCRiXgTnHCO/1utzwoz8Si4qc7AmBqi7eJu7
         0cO0opEBzIohUaMaRb8Mvx3D0PcPcMgn3FX+An3mC4P5ThByTLQw9dU5YNE/LlAoMy
         tZNW+1/Q1waEj93r6XkN0eXPiJ+GLvuVDFbsZLKmz90ZqZVgngtcAfXTNJwZfFKHtO
         wEVUvAH+fRQ/wj8w2er6qG4Sk0Ot0enfI/nSHSW0NOtnxk6bs8lCfrzn85mO82h60Z
         FfD68R/lQsi4PbsVO/rnf0nbPmyQgwDaW4pEdLPzwAj0fa6x1WejdH/GNPAuvNbH2A
         +sUs3gykdw7YA==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1fSWao-0007vH-Ut; Mon, 11 Jun 2018 16:51:22 -0700
Date:   Mon, 11 Jun 2018 16:51:22 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180611235122.GA28343@gregn.net>
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
 <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.99.4 at vserver
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 12:57:03AM +0200, Samuel Thibault wrote:
> Anybody up for testing please?
> 
> If people want to see speakup get mainlined instead of staging, please
> help.

If I understand right, this patch changes how synthesizers are loaded
and unloaded through /sys/accessibility/speakup/synth, correct? If
yes, then would for example verifying that

echo bns >/sys/accessibility/speakup/synth
echo soft >/sys/accessibility/speakup/synth

does what it should be good enough of a test? If this would not be
good enough, please describe exactly what needs testing.

I likely won't be able to do a kernel build until this weekend, but
should be able to report back next Monday on the 18th.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
