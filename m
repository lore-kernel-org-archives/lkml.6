Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D982070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544807753;
	bh=gDpPysTvFPjH+Q3xE4MMncwVDJ4s/xk7nl6RXCUksk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wpkA2U2ymLs8RHH9NtR1/Pi2NLWP5mVLtXuc+XvPxxJ3gsgI3W7ZksrUAKVD281ns
	 EBUNE+sRG+nqlFbpdE4unx3dta2BEYTZUSvoBpl/hFsQZ+XAEsWUdi9JIjgdY5r6hP
	 QoG4IwWdzrzyGqQSZ4rzK8heC7Twuiqn4HsnmdQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeLNRPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeLNRPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:15:51 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497BE2070D;
        Fri, 14 Dec 2018 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544807751;
        bh=gDpPysTvFPjH+Q3xE4MMncwVDJ4s/xk7nl6RXCUksk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i3Gg1yA8M/HoL2SG9Nil3QYvLJSiYnoK2CieOSe8HDWxAyKD8dzCvrenmaxucgNCZ
         Ce257l/R/M5ervAGp5S+rANazqGgM9e+ir2e+3FdRXs611ucdbyKd3qaX1+y0y+6Yk
         9/8uEIbBIuHub74yQ5FJZ2IEaFp84qViRr7uB7qY=
Received: by mail-qt1-f178.google.com with SMTP id d19so6951312qtq.9;
        Fri, 14 Dec 2018 09:15:50 -0800 (PST)
X-Gm-Message-State: AA+aEWYjtBcNnWvHNDIGL0no1jw/K0JcrYItQVzHeWoDe9PpYUqd4JL8
        Bopasc9GZ3Bmu4ECvmX5ZsAgrnJpwBr6rUpwoA==
X-Google-Smtp-Source: AFSGD/WYhUHUP53KWHx9190PGZy4WJhKePrWgXj1D0nJN97TknAB5/8G51IgTPytgGfwZz/DVDrx/2lddjbG0d3SM0M=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr3589069qtd.257.1544807749457;
 Fri, 14 Dec 2018 09:15:49 -0800 (PST)
MIME-Version: 1.0
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com> <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Dec 2018 11:15:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
Message-ID: <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle cache
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> The phandle cache contains struct device_node pointers.  The refcount
> of the pointers was not incremented while in the cache, allowing use
> after free error after kfree() of the node.  Add the proper increment
> and decrement of the use count.

Since we pre-populate the cache at boot, all the nodes will have a ref
count and will never be freed unless we happen to repopulate the whole
cache. That doesn't seem ideal. The node pointer is not "in use" just
because it is in the cache.

Rob
