Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FA3ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED00320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt1tDyrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED00320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJYX7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeJYX7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:59:03 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6566D20834;
        Thu, 25 Oct 2018 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540481147;
        bh=FCrF2YHz2MfojPFyTuAvP5QlpHDzWF57g5PQi4J27xI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zt1tDyrGZjKA56LreYLZKs8xrCtDqTYqJMQlyv2l1UvwWLXOiy+ukFiCBdR6dATXh
         lr1NO4ZV5w6cux6N0BbNpUXtpur3onI5Y0vs19ULOlBrv3bb6ZrsRns4k1ijW+KvQP
         9iaBFiB8kOBCwu/sheD1Jpgq3GKh8B9+7/qI6E+k=
Received: by mail-ed1-f53.google.com with SMTP id r1-v6so8878002edd.7;
        Thu, 25 Oct 2018 08:25:47 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI/phNeg0eqSxj68sb7uaESohW/PAhN4qAvgxFeQu2W0CmUs8Iv
        1+nVUp6+Suo0zsOjBTgT+8I8isDOVoyGZdm0miQ=
X-Google-Smtp-Source: AJdET5cibd5l0pUpniCzpA9LucOOY+NTfspwxkKVa2Y7KnvB2fc28JppIApgOnWBR8SZ5Gpn+iXzvdSpTrG9iIFC3ZE=
X-Received: by 2002:a17:906:3cea:: with SMTP id d10-v6mr1406576ejh.168.1540481145897;
 Thu, 25 Oct 2018 08:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
 <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com> <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 25 Oct 2018 10:25:08 -0500
X-Gmail-Original-Message-ID: <CANk1AXTm3G-xLz6nEeBh+JGLxF91Cn1-w=J+vKKM2qz1sqLXbA@mail.gmail.com>
Message-ID: <CANk1AXTm3G-xLz6nEeBh+JGLxF91Cn1-w=J+vKKM2qz1sqLXbA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:57 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Oct 22, 2018 at 4:25 PM Alan Tull <atull@kernel.org> wrote:
> >
> > On Thu, Oct 18, 2018 at 5:48 PM <frowand.list@gmail.com> wrote:
> > >
> > > From: Frank Rowand <frank.rowand@sony.com>
> > >
> > > Add checks to (1) overlay apply process and (2) memory freeing
> > > triggered by overlay release.  The checks are intended to detect
> > > possible memory leaks and invalid overlays.
> >
> > I've tested v5, nothing new to report.
>
> Does that mean everything broken or everything works great? In the
> latter case, care to give a Tested-by.
>
> Rob

Tested-by: Alan Tull <atull@kernel.org>

Alan
