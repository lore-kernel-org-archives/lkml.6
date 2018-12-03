Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48128C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9122082D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdaIcd+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9122082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLCX5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCX5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:57:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E631B2073D;
        Mon,  3 Dec 2018 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543881474;
        bh=Dlt5n7kvJQcOfWQ1Q8HopxEvGHERwlU3kLyFUN8tddk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=LdaIcd+cZAQUv08HiQtGagJxKzPBscWOpntP0+U/0HzpzuwnwrRaOXLDHzVyQelkZ
         T/5FnU6LDWOOszQwzaqnCcR89q6MWmy3hGr5FcjFN3KWw8H+p08khAVwM1TRTJuc2j
         rNRqq3JhOBAQO+BdgjptshhbPhhwVCpDcBHaWC6w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rob Herring <robh@kernel.org>, Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203230907.GA17086@bogus>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
 <20181203230907.GA17086@bogus>
Message-ID: <154388147333.88331.17115812518434146640@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date:   Mon, 03 Dec 2018 15:57:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-12-03 15:09:07)
> On Sun, Dec 02, 2018 at 09:25:02AM +0530, Taniya Das wrote:
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which=
 are
> > controlled by the hardware engine.
> > =

> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++=
++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-q=
com-hw.txt
> > =

> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.=
txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > new file mode 100644
> > index 0000000..2b82965
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -0,0 +1,172 @@
> > +Qualcomm Technologies, Inc. CPUFREQ Bindings
> > +
> > +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, In=
c. (QTI)
> > +SoCs to manage frequency in hardware. It is capable of controlling fre=
quency
> > +for multiple clusters.
> > +
> > +Properties:
> > +- compatible
> > +     Usage:          required
> > +     Value type:     <string>
> > +     Definition:     must be "qcom,cpufreq-hw".
> > +
> > +- clocks
> > +     Usage:          required
> > +     Value type:     <phandle> From common clock binding.
> > +     Definition:     clock handle for XO clock and GPLL0 clock.
> > +
> > +- clock-names
> > +     Usage:          required
> > +     Value type:     <string> From common clock binding.
> > +     Definition:     must be "xo", "alternate".
> > +
> > +- reg
> > +     Usage:          required
> > +     Value type:     <prop-encoded-array>
> > +     Definition:     Addresses and sizes for the memory of the HW base=
s in
> > +                     each frequency domain.
> > +- reg-names
> > +     Usage:          Optional
> > +     Value type:     <string>
> > +     Definition:     Frequency domain name i.e.
> > +                     "freq-domain0", "freq-domain1".
> > +
> > +- freq-domain-cells:
> =

> #freq-domain-cells
> =

> Otherwise,
> =

> Reviewed-by: Rob Herring <robh@kernel.org>

Or should it be #qcom,freq-domain-cells? That would match the same stem
of the property used in the cpu node.


