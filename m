Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECDBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB45218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545163307;
	bh=zCAO2BbTkh/sFdthPUz5p/F48j8PylSJki+FT1GeNBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AnSOyflFJPfgjjDt77FlGaZjYR8np5saoE+W9i4XnDPEJUl1w178mlv/7RUJ0SFco
	 N4O4wIIRZ6s1WSjjDREpvX+3mBg+5Y63TGc9PiNDrUCYbWKRiLfLwEAsFaUm911TA/
	 zGuGXAhunZu0ZQvMfoEyh24g77RnDvG/XGiepF5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeLRUBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeLRUBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:01:46 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE15218AD;
        Tue, 18 Dec 2018 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545163305;
        bh=zCAO2BbTkh/sFdthPUz5p/F48j8PylSJki+FT1GeNBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aIWSV/M+A2x00EJre0yBqvCAiMfzRebXQ9HppmIi/dbxAQmQlc19xnThZIWBW+Lrc
         FgjZKnZyI3yIU94x6uUD6jYWM5sBTDq6qhvipUyhDenWsiY5Xrza0Ryai02RQCjTL2
         oYjmBJRSQcFe1SB7SpxVUPmMhiPH6WtcIEzpe15Q=
Received: by mail-qt1-f170.google.com with SMTP id v11so19685230qtc.2;
        Tue, 18 Dec 2018 12:01:45 -0800 (PST)
X-Gm-Message-State: AA+aEWauak1n4u4jeJiX18dhPF2wiEyOLAjU/ntEqgaf/HvZeOVmQHAJ
        Tq42q7OwgUL2ui8IpdTFWcPzObE+4wmWSThgGw==
X-Google-Smtp-Source: AFSGD/VLtRpCxETOi7/sDAgrhrMINBjkV30Qxy1JP5KyQy21s/XbziBnJNS5pgk3sHWFNTf+9jjwZ5qUv/i6suQejiQ=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr18734258qvb.218.1545163304244;
 Tue, 18 Dec 2018 12:01:44 -0800 (PST)
MIME-Version: 1.0
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au> <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
In-Reply-To: <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Dec 2018 14:01:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
Message-ID: <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle cache
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/17/18 2:52 AM, Michael Ellerman wrote:
> > Hi Frank,
> >
> > frowand.list@gmail.com writes:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Non-overlay dynamic devicetree node removal may leave the node in
> >> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> >> will incorrectly find the stale entry.  Remove the node from the
> >> cache.
> >>
> >> Add paranoia checks in of_find_node_by_phandle() as a second level
> >> of defense (do not return cached node if detached, do not add node
> >> to cache if detached).
> >>
> >> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >
> > Similarly here can we add:
> >
> > Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
>
> Yes, thanks.
>
>
> > Cc: stable@vger.kernel.org # v4.17+
>
> Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
> fix).  So the bug will not be in stable.

0b3ce78e90fc landed in v4.17, so Michael's line above is correct.
Annotating it with 4.17 only saves Greg from trying and then emailing
us to backport this patch as it wouldn't apply.

Rob
