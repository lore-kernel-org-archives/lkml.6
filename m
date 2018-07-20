Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52946ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1414020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1414020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeGTJ2G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:28:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41651 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeGTJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:28:06 -0400
Received: from rettich.hi.pengutronix.de ([2001:67c:670:100:1d::c3] helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1fgQxx-0002Kb-MD; Fri, 20 Jul 2018 10:40:45 +0200
Received: from jlu by rettich with local (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1fgQxu-0007xm-2x; Fri, 20 Jul 2018 10:40:42 +0200
Message-ID: <1532076042.3511.203.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Udit Agarwal <udit.agarwal@nxp.com>, dhowells@redhat.com,
        zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sahil.malhotra@nxp.com
Date:   Fri, 20 Jul 2018 10:40:42 +0200
In-Reply-To: <20180720054656.29143-1-udit.agarwal@nxp.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c3
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 11:16 +0530, Udit Agarwal wrote:
> +==========
> +Secure Key
> +==========
> +
> +Secure key is the new type added to kernel key ring service.
> +Secure key is a symmetric type key of minimum length 32 bytes
> +and with maximum possible length to be 128 bytes. It is produced
> +in kernel using the CAAM crypto engine. Userspace can only see
> +the blob for the corresponding key. All the blobs are displayed
> +or loaded in hex ascii.
> +
> +Secure key can only be created on platforms which supports CAAM
> +hardware block. Secure key can also be used as a master key to
> +create the encrypted keys along with the existing key types in
> +kernel.
> +
> +Secure key uses CAAM hardware to generate the key and blobify its
> +content for userspace. Generated blobs are tied up with the hardware
> +secret key stored in CAAM, hence the same blob will not be able to
> +de-blobify with the different secret key on another machine.

Thanks for working on this, so far we've been using this functionality
via a custom sysfs interface. Proper integration into the keyring
framework would be very nice!

Some questions which might influence the userspace api design:

- If I remember correctly, CAAM key blobs contain flags which specify
if the key can be exported from the CAAM after unwrapping or not (then
it stays in one of the internal key registers). Which mode do you use?

- If that's not already supported by this series, do you intend to make
secure keys (in the non-exportable-mode) usable for encryption/
decryption, so they could be used for dm-crypt? If so, you'd probably
need some resource management in the CAAM driver, as the number of key
registers is limited.

- Secure keys could also be implemented using OP-TEE for example, so
the documentation shouldn't be CAAM-specific and only use it as an
example.

Are there corresponding changes to the CAAM driver needed to test this?

Best regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
