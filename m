Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC970C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988F920830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmyQrxqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988F920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbeKGDkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbeKGDkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:40:11 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B14520830;
        Tue,  6 Nov 2018 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541528024;
        bh=b8wFKv1bc0aSGbQZvnKv44sEw8VUAl3vszgxQhDyb8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PmyQrxqINjwvvTrI/llljhUCb1Xue+TBXIQeCDghxwrlBhJDv5stRrd6uHq9e5mwO
         3bxtEHDp/zcG2qngJnXWQvDBH/hhfZta1Zx83K0J5QQSNrMX8NKeuz7XKTqjBYlemG
         A/XstfoI+8nCdtmzC8RgCWHr/MTF7omjdOq1l/Ww=
Received: by mail-qk1-f171.google.com with SMTP id o125so19041220qkf.3;
        Tue, 06 Nov 2018 10:13:44 -0800 (PST)
X-Gm-Message-State: AGRZ1gIOCvr/TGLJSIbBtfUTcjxNwSCbN2oanLmOrOeTRq7fHU0DWD2N
        o1/DFhtFbqnp4Crf9MwlZvNX5VttVXhNdEXanQ==
X-Google-Smtp-Source: AJdET5d+BlY1NNVvxb7VNVg2ZHRpmphwgxuGvd3600BrFoBP1DK7dp1WiJcpCEKOd4Fg8M0edUYKUohTFu72xGxVcb0=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr26117902qkg.147.1541528023371;
 Tue, 06 Nov 2018 10:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com> <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com> <20181106145537.GB10650@smile.fi.intel.com>
 <20181106150503.GE13048@kuha.fi.intel.com> <20181106155347.GC10650@smile.fi.intel.com>
In-Reply-To: <20181106155347.GC10650@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Nov 2018 12:13:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
Message-ID: <CAL_JsqLdEciRtssX+x8TRmPX6QzZtNyMX9MrT9=J0DhhewFMZg@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:53 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 06, 2018 at 05:05:03PM +0200, Heikki Krogerus wrote:
>
> > Maybe it would be best to just read the "name" device property in
> > fwnode_name() and not have of_fwnode_name at all.
>
> If it's a mandatory property or somehow its presence is guaranteed, it would work.

It is currently, but after removing the name ptr, my current plan is
to remove the 'name' property too for FDT. On real OpenFirmware, it is
a real property so it will remain for sure in some cases.

Rob
