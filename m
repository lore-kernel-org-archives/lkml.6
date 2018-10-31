Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60615C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2811F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="X6elLZcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2811F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeKABjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:39:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:19314 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeKABjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541004024;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=lTBFLW1MhYVp0DjS8iOUSJiZJSRSzGVgwJuJMp2eGI4=;
        b=X6elLZcJ/VmhWoWrQKMjjVooYsResWrti1pYT7uKT/ks9pyeKXMQiCmCXb2Q/Q7RF8
        pSb9xOaLozHL86tuaryFhYnp/R0VNzEiQZ8Sk+S6Pi2ZWXXVa46UFiFMBiXPK5vEktvV
        Gn30vz6G3ZqPTm0jcWXADAuwlC8+cOMXUSiMgLN1hpthoaodYfczreWwUlkXqoAmN6yv
        bDDObMxAenaOlyYde+uHN7lwT7HfwDTm5zOEa81hDpnbPwHTg+9rGj7StO3Xn+z/Wbjf
        kTQqFdNH3CLoBlZZzBaVF2cHhIewuYPs4eSFOxY9P7FBR4C9JYZirr4Py/RvzdG8D5eT
        cGOA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxiLpiw3NC+Jq8oLnGwZyQOsz0lBmVY88yiFzW"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b003:7756:f462:48c6:2ba2:31c9]
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id Z0624cu9VGeDKGl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 31 Oct 2018 17:40:13 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] of: Fix cpu node iterator to not ignore disabled cpu nodes
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20181031144226.26747-1-robh@kernel.org>
Date:   Wed, 31 Oct 2018 17:40:12 +0100
Cc:     Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60687CA2-AD09-46D8-A317-FB6FA5605996@xenosoft.de>
References: <20181031144226.26747-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. I will test this patch tomorrow.

=E2=80=94 Christian

Sent from my iPhone

> On 31. Oct 2018, at 15:42, Rob Herring <robh@kernel.org> wrote:
>=20
> In most cases, nodes with 'status =3D "disabled";' are treated as if the
> node is not present though it is a common bug to forget to check that.
> However, cpu nodes are different in that "disabled" simply means offline
> and the OS can bring the CPU core online. Commit f1f207e43b8a ("of: Add
> cpu node iterator for_each_of_cpu_node()") followed the common behavior
> of ignoring disabled cpu nodes. This breaks some powerpc systems (at
> least NXP P50XX/e5500). Fix this by dropping the status check.
>=20
> Fixes: 651d44f9679c ("of: use for_each_of_cpu_node iterator")
> Fixes: f1f207e43b8a ("of: Add cpu node iterator for_each_of_cpu_node()")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> drivers/of/base.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index cc62da278663..e47c5ce6cd58 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -776,8 +776,6 @@ struct device_node *of_get_next_cpu_node(struct device=
_node *prev)
>        if (!(of_node_name_eq(next, "cpu") ||
>              (next->type && !of_node_cmp(next->type, "cpu"))))
>            continue;
> -        if (!__of_device_is_available(next))
> -            continue;
>        if (of_node_get(next))
>            break;
>    }
> --=20
> 2.19.1
>=20
