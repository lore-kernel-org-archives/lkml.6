Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E9DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33F820700
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIcPu7As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33F820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeLEXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:54:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43525 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbeLEXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:54:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so20369135otr.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UVwzh6sr4ACaI1A0FxZsGSIrRettlWSwdFkbLEetD8=;
        b=JIcPu7AsunttTaEi20pi43i6RTMLMhTT249wGURdJgU/L8PdKZaEz3o+ropZJyPZwB
         6UNOJSyFWEIpu2WhZqkoVr8JK3akXkfdHOUtruZ/MsldT58DKhtz0ojOZC4ibyZ8CkHB
         1OJlf0orXUY+IAibcK+rWVpbVqKt4WD8+mego7OC9eLR3QlLSTTTpvo0AAYuBGa2Hu1X
         rwM2o1xYNz3JLQ/PilKhr/AmMrofrVXCU6lX2L+sE0YVwFXHSI1f78oqljpY3fM906LV
         Yza2stjbOotvTxPyRqkaU1fcWWgI3WFlmEgcEH8LijcWfogWhWByQPEXKlZxVVqjD6R+
         qQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UVwzh6sr4ACaI1A0FxZsGSIrRettlWSwdFkbLEetD8=;
        b=XP7AR5GtkGC2/PvlLvh43cVRfYrFAZ+Dg2MT8caBC5JXLDftN0NVBUUg90qdPH5MDS
         lHONQnRXnKP8CPsaygS5YMkA00lDeodxYl735dlSL6EKabuUuLqC93O+73xNFy8/2VZU
         WoEpx/Av1fiDCl/NwTvEKN3hcFJcl/tdVrpY0KuihY0V2Wc7XYkdo86fHZwv5XmhAgBr
         XA1rCIhPkTM7Il2qvIl2cbgkg98X9LSZDfKuTGxCqSIBTn2zGEjbdos8SnZOrz6tPGSV
         6mM48g2JTFiQah7bqVEzjp/FV6Ada5aSjEGvHnLA6eS5rlByPLxQKSd4S7a0KK8BbTTZ
         Df+A==
X-Gm-Message-State: AA+aEWbIc3A5Mb+cqdGMGWTTZtwqUNc21IuiZLmPfHW3i3WekFpJ3JiO
        0/tzI5mhs+K/YZBY8if7y0kuSUrRWXQb9o9iK5JRPQ==
X-Google-Smtp-Source: AFSGD/UIg8nykrU0T38pL2P1RQMxtLX7+ZeZqOGiNKiI7zJR+2BzJ4/qIyTrF4+M/PMakwUf4uNIrPZFTHwB5uhywK8=
X-Received: by 2002:a05:6830:1005:: with SMTP id a5mr15796921otp.113.1544054085851;
 Wed, 05 Dec 2018 15:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com> <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
In-Reply-To: <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Dec 2018 15:54:34 -0800
Message-ID: <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Brendan,
>
> On 11/28/18 11:36 AM, Brendan Higgins wrote:
> > Split out a couple of test cases that these features in base.c from the
> > unittest.c monolith. The intention is that we will eventually split out
> > all test cases and group them together based on what portion of device
> > tree they test.
>
> Why does splitting this file apart improve the implementation?

This is in preparation for patch 19/19 and other hypothetical future
patches where test cases are split up and grouped together by what
portion of DT they test (for example the parsing tests and the
platform/device tests would probably go separate files as well). This
patch by itself does not do anything useful, but I figured it made
patch 19/19 (and, if you like what I am doing, subsequent patches)
easier to review.
