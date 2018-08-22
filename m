Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9F820B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="OwHtNapY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9F820B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeHVWT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:19:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:13784 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeHVWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1534964034;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Cc:Message-Id:Date:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=jaXBiPmqcf0rov5BnYGPGwjFWc1Ql3mbCZXWGyA/8rs=;
        b=OwHtNapYJzIVpyBsz9Z79g5qHR9j12KYjnxLbOqBpMsuKqhHSaM26sxc/9mRyrxYgW
        rYcBIEjenc9UbYuPLdhb28dGXsAhvkh/EiBuZD/AJKGUaatkRVvJXvcVSju9/5Qduu0q
        3i+9/lY9F2vsQZd2D/s+FExCT5NpzhDhZzmWHeqLENOhVvNNqH5rhD7g3l1OrLq7xz7e
        m9wDjA7S9DAABPafcOVX4NbA2Z+Wlpnb2LFGDxC3z5IfqM99kIqORnP56SSOtN9WhNE8
        djZM3VLLs4KWmB+CCOqmrr1zTSrXRwXpAk3dVdgijQD9i3mNlbujh+OH5HdyYtmN8H+Z
        b5hA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBs7wpz98S0pHe2e4Sh"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.18 DYNA|AUTH)
        with ESMTPSA id x038eeu7MIrlRlf
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 22 Aug 2018 20:53:47 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is installed" introduced in v4.18.4.
Date:   Wed, 22 Aug 2018 20:53:46 +0200
Message-Id: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
Cc:     Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch requires that /sbin/depmod is installed and installable on
the build host.

But not all build hosts for cross compiling Linux are Linux systems
and are able to provide a working port of depmod, especially at the
file patch /sbin/depmod.

I use, for example, a Darwin system to cross compile Linux and I run
depmod -a on the embedded system once, after installing a new Linux
kernel there.

I have no problem with seeing a warning, but aborting the build process
is IMHO a bad idea since the previous behaviour didn't harm many people
as far as I see. Probably 99% of people compiling Linux kernels do that
on Linux and 99% of those have depmod installed for optimal operation of
their build host. So IMHO printing the warning is good enough.

BR and thanks,
Nikolaus Schaller
