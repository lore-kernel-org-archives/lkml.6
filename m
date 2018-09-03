Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F714C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6320843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D6320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeICLPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:15:38 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:56870 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeICLPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:15:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id D4FB5201D1;
        Mon,  3 Sep 2018 10:56:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iIZfhvaKbaaW; Mon,  3 Sep 2018 10:56:33 +0200 (CEST)
Received: from mail-essen-02.secunet.de (mail-essen-02.secunet.de [10.53.40.205])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 86B272008A;
        Mon,  3 Sep 2018 10:56:33 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-02.secunet.de
 (10.53.40.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Sep 2018
 08:56:50 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 8852D31817E3;
 Mon,  3 Sep 2018 08:56:50 +0200 (CEST)
Date:   Mon, 3 Sep 2018 08:56:50 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Yannick Brosseau <scientist@fb.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2] Optimize lookup of /0 xfrm policies
Message-ID: <20180903065650.GL23674@gauss3.secunet.de>
References: <20180831221838.25597-1-scientist@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180831221838.25597-1-scientist@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: cbe3d3f7-b9e3-4256-b890-f24c4306a01c
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 38DEC598-276C-407F-AD67-B0C3F01165CF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:18:38PM -0400, Yannick Brosseau wrote:
> Currently, all the xfrm policies that are not /32 end up in
> the inexact policies linked list which take a long time to lookup.

It is possible to configure which policies are going to the
hashtable and the inexact list.

You can do:

ip x p set hthresh4 0 0

This sets the hash threshold to local /0 and remote /0 netmasks.
With this configuration, all policies should go to the hashtable.

To view the configuration:

ip -s -s x p count

Can you please do your tests with this too?
I'd really like to avoid to add new code to the policy lookup
if we can get similar results with this configuration option.

