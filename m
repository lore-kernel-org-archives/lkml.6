Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBC2208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5x41Bpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBC2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeK2I3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2I3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:29:15 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A322521473;
        Wed, 28 Nov 2018 21:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543440375;
        bh=S3aSizor1tYetDGI46llMZE2aURa2KBznnluKYwPoms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N5x41BpiBRLwgtqu+ESJsP2N8kTUV9EyJPLY10ktgsKfJKfkWq0PlSBLUH5zYcyCZ
         IqIQmlzxfxeBnBIlLTjB4zjnaCehnbnUY9a1qKb4Hua9kx+y/bcUAKBT4oFDGu3O2V
         L5CzxXxSjb3ed4aB3B/KBEjLxrPRXflQW76z010k=
Received: by mail-qt1-f178.google.com with SMTP id d19so27593913qtq.9;
        Wed, 28 Nov 2018 13:26:15 -0800 (PST)
X-Gm-Message-State: AGRZ1gKaLynhZt3yxuaDBiew30RYqsBR8SV7IWr1/wzpj/m55Hb8P+mL
        PDT+UFbhiSWZbURTuh0UfSTA+j8uuQ6CGvvKgw==
X-Google-Smtp-Source: AJdET5eT1bCzJlTYb9NKHsPIb2FyaSpZ43u+D6A4SSwK5oWQ+ta0ejvwaswh9l17Z2HDf374MgYbsqkRuNAhzKT60Uo=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr37178170qtf.26.1543440374751;
 Wed, 28 Nov 2018 13:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com> <20181128193636.254378-7-brendanhiggins@google.com>
In-Reply-To: <20181128193636.254378-7-brendanhiggins@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Nov 2018 15:26:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
Message-ID: <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode Linux
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Make minimum number of changes outside of the KUnit directories for
> KUnit to build and run using UML.

There's nothing in this patch limiting this to UML. Only patch 1 does
that and I would remove that depends. I'd guess most folks will want
to run under something other than UML. DRM for instance (though the
virtual KMS stuff may work in UML?).

Plus you want to make sure this all builds with allmodconfig for x86
(or ARM) because those get the most (and quickest) compile coverage.

Rob
