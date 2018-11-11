Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C7C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6351C2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rzWeFnqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6351C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeKLEqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:46:54 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49120 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726848AbeKLEqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:46:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 887B38EE12F;
        Sun, 11 Nov 2018 10:57:35 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rCZ4AIoDVqj8; Sun, 11 Nov 2018 10:57:35 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E37BD8EE0A4;
        Sun, 11 Nov 2018 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1541962655;
        bh=tO7PhfuaNHq4sHvf0qyKforuKUAy9KVwtK/6EC6V9YM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=rzWeFnqmIEeYvri2lvfMSIweZDI3QKntx3y+nsmUuF+AFEhvvfVOJQIhK6VA8qVZs
         7/wQvV7xoGl0koX+1Ouh7lvK6kh/sDCZfwRCdE4UFqCi0RixhHsoLui+yOHunMqgB/
         Up7kvWz5Oohw3zBGml4F+fnjfc3FnvkSBKHA2Sv4=
Message-ID: <1541962653.3190.7.camel@HansenPartnership.com>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Nov 2018 10:57:33 -0800
In-Reply-To: <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-11 at 19:50 +0100, Michael Niewöhner wrote:
[...]
> > However, this makes me wonder about yours:
> > 
> > > [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO
> > > TC-
> > > S06   00001300 AMI  00000000)
> > 
> > I thought the Lenovo "upgrade to 2.0" in fact disabled the external
> > TPM in favour of the Intel PTT (software TPM in the management
> > engine).  Since you apparently have the tpm_crb driver that should
> > find the PTT TPM, this might be one of the attachment bugs in the
> > CRB driver ... from your ACPI output it looks to be not specifying
> > the Tpm2Tabl.
> 
> Well, there are at least two implementations I know of:
> For my Lenovo X260 I can choose between Infineon TPM 1.2 or Intel PTT
> TPM 2.0 This here is my ThinkStation P320 which can choose between
> PTT 1.2, PTT 2.0,
> Nuvoton 1.2 and 2.0. When switchting between 1.2 and 2.0 the Nuvoton
> gets
> reflashed with the appropriate firmware.

Well, I still think the ACPI setup is incorrect.  What's in
/sys/class/platform (should be directories of ACPI devices)?  The TPM
is supposed to show up as MSFT0101.  If it doesn't is there any other
device string in there that might be a TPM?

James

