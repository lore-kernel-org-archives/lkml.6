Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2F9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05852080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05852080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeKLF7M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:59:12 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21795 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeKLF7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:59:11 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1541966965; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ZMQc1Gp4fycFKPWTuDWaRv5OaGKnY1ylMtHb+hdySvWOUewNorBmULBd6j64coiaQJki8PnIx9rlypGdUqdhG7zoBlfwD5kO4EZOMZEnIhLMO4lGaamh0PMsOjKdQW4c9jr7oFX3K5HwL9oNjMWBlnepsPbtlpXwSQYoDj0vbMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1541966965; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=YR3WVKfpIS6z1Qj4SMgJBZ1aePS5t8lU9Y+Foo7GYNk=; 
        b=fJdQfQ9ZeVh0hu+bJbcXKW1LVTT29nSIGLPRumsxdvWUBpVPqa2uvxyr2cXezV1Qs++IvCneWBi89nvvtZurQTo5Tc5DAV59EbTobdILQ0FUysAU+q+Pdfg3mJSGRQts8lWRJuoMWmg31VM4FJAetmF7E5OmLnRNVZFptJ6MNSU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1541966962917302.1454457460799; Sun, 11 Nov 2018 12:09:22 -0800 (PST)
Message-ID: <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1541962653.3190.7.camel@HansenPartnership.com>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
         <1541962653.3190.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 11 Nov 2018 21:09:19 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2018-11-11 at 10:57 -0800, James Bottomley wrote:
> On Sun, 2018-11-11 at 19:50 +0100, Michael Niewöhner wrote:
> [...]
> > > However, this makes me wonder about yours:
> > > 
> > > > [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO
> > > > TC-
> > > > S06   00001300 AMI  00000000)
> > > 
> > > I thought the Lenovo "upgrade to 2.0" in fact disabled the external
> > > TPM in favour of the Intel PTT (software TPM in the management
> > > engine).  Since you apparently have the tpm_crb driver that should
> > > find the PTT TPM, this might be one of the attachment bugs in the
> > > CRB driver ... from your ACPI output it looks to be not specifying
> > > the Tpm2Tabl.
> > 
> > Well, there are at least two implementations I know of:
> > For my Lenovo X260 I can choose between Infineon TPM 1.2 or Intel PTT
> > TPM 2.0 This here is my ThinkStation P320 which can choose between
> > PTT 1.2, PTT 2.0,
> > Nuvoton 1.2 and 2.0. When switchting between 1.2 and 2.0 the Nuvoton
> > gets
> > reflashed with the appropriate firmware.
> 
> Well, I still think the ACPI setup is incorrect.  What's in
> /sys/class/platform (should be directories of ACPI devices)?  The TPM
> is supposed to show up as MSFT0101.  If it doesn't is there any other
> device string in there that might be a TPM?

Nope. I'm not sure if it should show up in ACPI... isn't TPM 2.0 I2C?

$ find /sys | grep -i tpm
/sys/class/tpmrm
/sys/class/tpm
/sys/bus/platform/drivers/tpm_tis
/sys/bus/platform/drivers/tpm_tis/uevent
/sys/bus/platform/drivers/tpm_tis/bind
/sys/bus/platform/drivers/tpm_tis/unbind
/sys/bus/pnp/drivers/tpm_tis
/sys/bus/pnp/drivers/tpm_tis/uevent
/sys/bus/pnp/drivers/tpm_tis/bind
/sys/bus/pnp/drivers/tpm_tis/unbind
/sys/bus/acpi/drivers/tpm_crb
/sys/bus/acpi/drivers/tpm_crb/uevent
/sys/bus/acpi/drivers/tpm_crb/bind
/sys/bus/acpi/drivers/tpm_crb/unbind
/sys/bus/i2c/drivers/tpm_i2c_nuvoton
/sys/bus/i2c/drivers/tpm_i2c_nuvoton/uevent
/sys/bus/i2c/drivers/tpm_i2c_nuvoton/bind
/sys/bus/i2c/drivers/tpm_i2c_nuvoton/unbind


> 
> James
> 


