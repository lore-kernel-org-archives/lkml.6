Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817DE2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbeLQPyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:54:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeLQPyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:54:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2651C00C10B;
        Mon, 17 Dec 2018 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 990D6608F2;
        Mon, 17 Dec 2018 15:54:34 +0000 (UTC)
Message-ID: <f3cb396d0e2c6361866384eeacc7f81622b16366.camel@redhat.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Dec 2018 16:54:33 +0100
In-Reply-To: <20181217123645.42a20fe5@canb.auug.org.au>
References: <20181217123645.42a20fe5@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Dec 2018 15:54:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2018-12-17 at 12:36 +1100, Stephen Rothwell wrote:
> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from net/core/dev.c:148:
> net/core/dev.c: In function 'napi_gro_complete':
> net/core/dev.c:5364:26: error: 'inet_gro_complete' undeclared (first use in this function); did you mean 'eth_gro_complete'?
>        ipv6_gro_complete, inet_gro_complete,
>                           ^~~~~~~~~~~~~~~~~
> include/linux/indirect_call_wrapper.h:32:41: note: in definition of macro 'INDIRECT_CALL_2'
>  #define INDIRECT_CALL_2(f, name, ...) f(__VA_ARGS__)
>                                          ^~~~~~~~~~~
> 
> and on ....
> 
> Caused by commit
> 
>   aaa5d90b395a ("net: use indirect call wrappers at GRO network layer")
> 
> inet_gro_complete() is declared in include/net/inet_comon.h which is
> not directly included in net/core/dev.c.
> 
> I have used the net-next tree from next-20181214 for today.

My fault, I should have tested more kernel configs. This fails with
CONFIG_RETPOLINE=n

A fix has been posted here:

https://marc.info/?l=linux-netdev&m=154504685327698&w=2

Thanks,

Paolo

