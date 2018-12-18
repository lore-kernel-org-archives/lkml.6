Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCBAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59F721873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545147802;
	bh=m2DB6QqWu8SEUESKErQD/rr7f13p+Lqxt8lAYe2ja6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UESEZv6aQMNUBzJoUJ+REYku6xjJjk2xxh07wJANBcxVFzVTENIbrP53WEGd+/He8
	 BL08UC2Fl+djnPYCSP/427hmzE61K6N9iY5dNhEmzCs5dRh0rULfz1wK1O2yH9w6++
	 eWc0FVJgqiC/loQk6COra6eqijVgC6U+HOlC0gA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeLRPnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbeLRPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:43:20 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0ED218A3;
        Tue, 18 Dec 2018 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545147800;
        bh=m2DB6QqWu8SEUESKErQD/rr7f13p+Lqxt8lAYe2ja6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yuKKblqCgjQX95iSWznF6Mt5m86MeOqoVMzY+QICMc7Y9+4z22J83gW/ormQ7gdlY
         ocGCeHz6YipSoHAnQEHCv7jzBta7tlsEhXbz52KpyOvEmwxUQFzMhmBrh7yLMzwpiR
         BaMcen7mIv+Fn/3q0J4XU+1RgGvnturQl9n8/So4=
Received: by mail-qt1-f173.google.com with SMTP id e5so18606156qtr.12;
        Tue, 18 Dec 2018 07:43:19 -0800 (PST)
X-Gm-Message-State: AA+aEWZPsGO+kCRLjwWdkRKY5xmWmjK/bSxr1ZSEZYxzgImpEz7jE/kh
        KU32wVu39rW2Dlaszxpq6n9nrWrGNewy6K7R5g==
X-Google-Smtp-Source: AFSGD/V2hEjckYCxFUw27PJsHhsjEZMqOsEiophnQQNx600vkpI9LvKFo1eb75w7FOXBIPfsAt2nnwvz+nqiFMumJDA=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr18229770qts.144.1545147799172;
 Tue, 18 Dec 2018 07:43:19 -0800 (PST)
MIME-Version: 1.0
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Dec 2018 09:43:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZ=g16jZ_SZX2qi-ecE-hvQ+-UfUw40=+ztiM-Zpsq9A@mail.gmail.com>
Message-ID: <CAL_JsqKZ=g16jZ_SZX2qi-ecE-hvQ+-UfUw40=+ztiM-Zpsq9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: phandle_cache, fix refcounts, remove stale entry
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

On Mon, Dec 17, 2018 at 1:56 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  This bug exposed the foloowing
> phandle cache refcount bug.
>
> The refcount of phandle_cache entries is not incremented while in
> the cache, allowing use after free error after kfree() of the
> cached entry.
>
> Changes since v1:
>   - make __of_free_phandle_cache() static
>   - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
>
> Frank Rowand (2):
>   of: of_node_get()/of_node_put() nodes held in phandle cache
>   of: __of_detach_node() - remove node from phandle cache

I'll send this to Linus this week if I get a tested by. Otherwise, it
will go in for 4.21.

Rob
