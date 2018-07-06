Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E37C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797324015
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="cd1/84yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3797324015
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeGFHmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:42:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:17418 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeGFHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530862922;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DmAeQ6uCnjY0CWOTWN7BYkqt9LJ15Dlg78ZU5NfG3OA=;
        b=cd1/84yG4mIEam/JiXh6SRIilhFx8MqUBpiZix3j/DKdyXH7PFRTWfoVPvlBblheTa
        y0Ns5LpljGmv7DQsvOKjXW/64qfEvzTwBckgciy1nzAhTmjBK/tCuyWT9aiuLITnNqHW
        ABfkyAPdnFxRlrpCnSaQucukGye6yLnHifr91HxGHfu9Mzu69w1WtBkiaR5alsR2pRwE
        QnZh/ldKSK03HsK2rYX2Nki6BB28EOl3V8lsCSktu6Xi+bmG49Q/pv4KfeuB1XtiQ6vK
        MFgWOF0CBkPatytAgXFrNaI32z0gR16azlF5rXY0rGpAelYqCsQXYqma/p5a7lFMDcBY
        Pulw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGrithBFZUqsJqaA7gBRM3H/SoCRTjrR5clfHiy/"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u667fxFGD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Jul 2018 09:41:59 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
Date:   Fri, 06 Jul 2018 09:41:53 +0200
Message-ID: <2049675.lBcD2vaCCs@tauon.chronox.de>
In-Reply-To: <CACT4Y+YJUVJnFt2bn7rhV+ET6dVhwWrym8DK+LgV3rJGVUuCFA@mail.gmail.com>
References: <000000000000846e9e0570438176@google.com> <1626520.Rx0128ICKU@positron.chronox.de> <CACT4Y+YJUVJnFt2bn7rhV+ET6dVhwWrym8DK+LgV3rJGVUuCFA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Juli 2018, 09:38:41 CEST schrieb Dmitry Vyukov:

Hi Dmitry,

> On Thu, Jul 5, 2018 at 8:45 PM, Stephan M=FCller <smueller@chronox.de> wr=
ote:
> > Am Donnerstag, 5. Juli 2018, 19:02:01 CEST schrieb syzbot:
> >=20
> > Hi Dimitry,
> >=20
> > does the syzkaller somehow uses the "---" separator as part of the URL?
>=20
> It used it as branch. Please see:
>=20
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-pa=
tch
> es
>=20
> for formats. In all formats a git tree is not enough. And it is not
> enough to identify code state in any other context too, it's always
> git repo + branch or commit hash.

And which branch should I use for the kmsan.git repo?

Ciao
Stephan


