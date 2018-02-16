Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162091AbeBPRfH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:35:07 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:43324 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161197AbeBPRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:35:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name A829B2F90A1
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Holger =?ISO-8859-1?Q?Hoffst=E4tte?=
        <holger@applied-asynchrony.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson <vanj@google.com>,
        Jerry Chu <hkchu@google.com>
Subject: Re: TCP and BBR: reproducibly low cwnd and bandwidth
Date: Fri, 16 Feb 2018 18:35:03 +0100
Message-ID: <2938690.9Cepv1nWrF@natalenko.name>
In-Reply-To: <061740d0-9876-c905-7466-ef225ec3cdc5@applied-asynchrony.com>
References: <1697118.nv5eASg0nx@natalenko.name> <2189487.nPhU5NAnbi@natalenko.name> <061740d0-9876-c905-7466-ef225ec3cdc5@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1518802503;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=Wbvz+gb0Oj9m6JnBK1J1Tppkz2AtsxrdiW5uW2Sp3kk=;
        b=A33eoSZcR2ctcyQOCUsa2i9wLffuvpiX5ifzYzKWRN9lpMBBQeoctFjklyhgXreMT09Wp9
        yFRRxsLfjAOuE3Z6j95Ipc4AslXbkoqYbJaEbbSAXgZ1BMEcOeXpPKuxRCeZ9lfZGqd+Q6
        gnamAcPy3whPIB67beEK8+tfZUcrzMM=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1518802503; a=rsa-sha256;
        cv=none;
        b=pKqD2gcWjBCpmsB6SvAkDSzAsjubfOkBnO4CoTDL5CJqRTWrNsZd9ERBQ5X6WzZmeKxgQOyXYVhg0FVyk0PrcNQisenW0hZIjuCRM5wArhEphTkFNhjuLX2Ss7zNMKd20y/jtK5Od68wOsTRjNunOLximqRKC4N6RfN3R+urFOk=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GHZXRu026398

Hi.

On pátek 16. února 2018 17:26:11 CET Holger Hoffstätte wrote:
> These are very odd configurations. :)
> Non-preempt/100 might well be too slow, whereas PREEMPT/1000 might simply
> have too much overhead.

Since the pacing is based on hrtimers, should HZ matter at all? Even if so, 
poor 1 Gbps link shouldn't drop to below 100 Mbps, for sure.

> BBR in general will run with lower cwnd than e.g. Cubic or others.
> That's a feature and necessary for WAN transfers.

Okay, got it.

> Something seems really wrong with your setup. I get completely
> expected throughput on wired 1Gb between two hosts:
> /* snip */

Yes, and that's strange :/. And that's why I'm wondering what I am missing 
since things cannot be *that* bad.

> /* snip */
> Please note that BBR was developed to address the case of WAN transfers
> (or more precisely high BDP paths) which often suffer from TCP throughput
> collapse due to single packet loss events. While it might "work" in other
> scenarios as well, strictly speaking delay-based anything is increasingly
> less likely to work when there is no meaningful notion of delay - such
> as on a LAN. (yes, this is very simplified..)
> 
> The BBR mailing list has several nice reports why the current BBR
> implementation (dubbed v1) has a few - sometimes severe - problems.
> These are being addressed as we speak.
> 
> (let me know if you want some of those tech reports by email. :)

Well, yes, please, why not :).

> /* snip */
> I'm not sure testing the old version without builtin pacing is going to help
> matters in finding the actual problem. :)
> Several people have reported severe performance regressions with 4.15.x,
> maybe that's related. Can you test latest 4.14.x?

Observed this on v4.14 too but didn't pay much attention until realised that 
things look definitely wrong.

> Out of curiosity, what is the expected use case for BBR here?

Nothing special, just assumed it could be set as a default for both WAN and 
LAN usage.

Regards,
  Oleksandr
