Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9223EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 12:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE682098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 12:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="gCEj86hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE682098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHZQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 12:14:19 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.237]:33630 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeHZQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 12:14:19 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Aug 2018 12:14:19 EDT
X-Interia-R: Interia
X-Interia-R-IP: 103.217.167.198
X-Interia-R-Helo: <[192.168.1.197]>
Received: from [192.168.1.197] (unknown [103.217.167.198])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by int.pl (INTERIA.PL) with ESMTPSA;
        Sun, 26 Aug 2018 14:24:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/microcode: allow non-root reading of microcode version and processor flags
From:   Jacek Tomaka <jacek.tomaka@poczta.fm>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <8DACDEF8-ED0A-42BF-8426-3AAA4BA16317@alien8.de>
Date:   Sun, 26 Aug 2018 20:23:48 +0800
Cc:     Jacek Tomaka <jacekt@dugeo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD5DA006-0D28-4CB9-95FA-231F0E20BF44@poczta.fm>
References: <20180825035039.14409-1-jacekt@dugeo.com> <8DACDEF8-ED0A-42BF-8426-3AAA4BA16317@alien8.de>
To:     Boris Petkov <bp@alien8.de>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1535286247;
        bh=UcEu8HY/zeR+ujSLnMvWhe/LaFAf7Oe0oxLhhPo0Kso=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Content-Type:
         Mime-Version:Subject:From:X-Mailer:In-Reply-To:Date:Cc:
         Content-Transfer-Encoding:Message-Id:References:To:
         X-Interia-Antivirus;
        b=gCEj86hvu9Fqhy1t64nV9OuDhuH2akp0xMkV2pQOktWjLBp0O3rXx/fBwky19RGeC
         RxN819HtS+aj2/uunKe1Rq53t57zyf1j3cG8Wv6LqoFmmJ3MMQKzw/+cndh2PinN10
         yi08VBICuC0jE/DdHBUnRwVu/hN2RZ18nyI6T7AY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 26 Aug 2018, at 7:52 pm, Boris Petkov <bp@alien8.de> wrote:
>=20
>> On August 25, 2018 6:50:39 AM GMT+03:00, Jacek Tomaka <jacekt@dugeo.com> w=
rote:
>> /sys/devices/system/cpu/cpuX/microcode
>>=20
>> Before:
>> -r-------- processor_flags
>> -r-------- version
>>=20
>> After:
>> -r--r--r-- processor_flags
>> -r--r--r-- version
>>=20
>> Microcode version has been already readable for non root users via
>> /proc/cpuinfo. However it is easier to access it from
>> /sys/devices/system/cpu/cpuX/microcode/version
>=20
> Easier than /proc/cpuinfo?! Sorry, not really.=20

Why not?

> You'd need to elaborate in greater detail what exactly you're trying to ac=
hieve.

I am trying to get microcode version from user space. Reading it from /proc/=
cpuinfo requires greping/awking to extract the bits of information that are r=
eadily available in microcode/version.

Any reason why the same piece of information has different access permission=
s, depending on the way it is accessed?

Regards.
Jacek Tomaka=

