Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A3FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D5921473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="bcIR/uj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D5921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalray.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHQLUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:20:42 -0400
Received: from zimbra1.kalray.eu ([92.103.151.219]:49350 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:20:41 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 07:20:40 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DA3E427E02EF;
        Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uZn_rMdbLe72; Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6A5F327E02F0;
        Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6A5F327E02F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1534493390;
        bh=jGfxbTGJ/dKQwnGDcvNSMBgkYF5uLMA32G3+ccRAUZw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bcIR/uj8GaScV4fap5sS0/RO4+1JfI+oAjY7WJnQEZHBlPn09zrltVoRG0YI5Mh9z
         xmqwRrU8QCcEoFzSHq/VjV7VDeXHC9YIFJhie0OF8Y0V6wOmJgpD3Rzft2xo0KasdI
         oVROrDVOX5Xj3HA6yamVRZOVnfh+lQecAU3bONao=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zCJgA2p3INuH; Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4C63827E02EF;
        Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
Date:   Fri, 17 Aug 2018 10:09:50 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Message-ID: <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180817044902.31420-6-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org> <20180817044902.31420-6-benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/6] pci: Protect the enable/disable state of
 pci_dev using the state mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.8_GA_3008 (ZimbraWebClient - FF57 (Linux)/8.8.8_GA_1703)
Thread-Topic: Protect the enable/disable state of pci_dev using the state mutex
Thread-Index: QDBJGu64Fqg2Igvbl8Y4Q13tS1Paiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 17 Aug, 2018, at 06:49, Benjamin Herrenschmidt benh@kernel.crashing.org wrote:

> This protects enable/disable operations using the state mutex to
> avoid races with, for example, concurrent enables on a bridge.
> 
> The bus hierarchy is walked first before taking the lock to
> avoid lock nesting (though it would be ok if we ensured that
> we always nest them bottom-up, it is better to just avoid the
> issue alltogether, especially as we might find cases where
> we want to take it top-down later).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


> 
> static void pci_enable_bridge(struct pci_dev *dev)
> {
> 	struct pci_dev *bridge;
> -	int retval;
> +	int retval, enabled;
> 
> 	bridge = pci_upstream_bridge(dev);
> 	if (bridge)
> 		pci_enable_bridge(bridge);
> 
> -	if (pci_is_enabled(dev)) {
> -		if (!dev->is_busmaster)
> -			pci_set_master(dev);
> +	/* Already enabled ? */
> +	pci_dev_state_lock(dev);
> +	enabled = pci_is_enabled(dev);
> +	if (enabled && !dev->is_busmaster)
> +		pci_set_master(dev);
> +	pci_dev_state_unlock(dev);
> +	if (enabled)
> 		return;
> -	}
> 

This looks complicated too me especially with the double locking. What do you
think about a function doing that check that used an unlocked version of
pcie_set_master?

Like:

        dev_state_lock(dev);
        enabled = pci_is_enabled(dev);
        if (enabled &&  !dev->is_busmaster)
                pci_set_master_unlocked();
        pci_dev_state_unlock(dev);

BTW If I remember correctly the code today can set bus mastering multiple
times without checking if already done.

Marta
