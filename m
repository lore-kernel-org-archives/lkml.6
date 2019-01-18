Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC9C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF502087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k+RuwAME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfARWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:09:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45434 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729621AbfARWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:09:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 977638EE390;
        Fri, 18 Jan 2019 14:09:19 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yXMzODEDbqr1; Fri, 18 Jan 2019 14:09:19 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2E5248EE10C;
        Fri, 18 Jan 2019 14:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547849359;
        bh=KKbZXUW2kwUrTYp4XwsTF1nUQhcuoNIwcAhN0k7ttN4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k+RuwAMEcyCiHDaUjGmEl7T0MpaXK7KQbfL4y1azEFe12oNdW3u/5mvi2iTA7BFVG
         fhb6BZFi8JTOMNDIOe9xe76rFN1BMsvogVWMhFHsfkPudw+/LJm/qjTVrnmwMKq2ID
         7owa6QrnvDq6IYW8uL3wokQsniteS09yT4h0ztZU=
Message-ID: <1547849358.2794.90.camel@HansenPartnership.com>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 18 Jan 2019 14:09:18 -0800
In-Reply-To: <20190118142559.GA4080@linux.intel.com>
References: <20190118142559.GA4080@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 16:25 +0200, Jarkko Sakkinen wrote:
> I get this on a Geminilake NUC after rebasing my maintainer trees:
> 
> tpm tpm0: A TPM error (-1) occurred attempting the self test
> 
> I checked the latest commit ID from drivers/char/tpm to make sure
> that I did not put anything broken to my last PR [1]. It works
> without issues.
> 
> In addition [2] gives me an empty diff.
> 
> Something outside of the TPM driver must have happened that breaks
> the driver. Any ideas?
> 
> [1] commit 9488585b21bef0df1217e510c7134905d1d376a7
> [2] git diff 9488585b21bef0df1217e510c7134905d1d376a7 master
> drivers/char/tpm/

I'm afraid you're going to have to bisect to find the offending in-
kernel commit, which is going to be painful since it seems to depend on
physical hardware.  My first instinct is that we're getting a zero
length read somewhere, but I still can't see anything in the merge
window that would cause that behaviour.

James

