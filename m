Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7904C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED0214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ED0214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeKOMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:35:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44030 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:35:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so13077988otr.10;
        Wed, 14 Nov 2018 18:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT2fm8eth4Bimx392fIX6ciCFE4Cd+HxmvFo1mNOf8g=;
        b=XukuzEXurO7n3XrjRUVVGeCesZ2xC8tEgsjyhfzWeI3JnHiL1wFdNaOEoVU+vltYFz
         RmisWObQ5sf4RjRUvmfdd7B/45hhQVvynMTSy4VAIjnJDfaxL+qYL/YDBgn0fE3ndAu+
         tJ/W8OmZaAAujB7mANYlNWi7UyOR3O/scuefNjRbGjYbfMpt5xp6qNV90WvSYQ/Mt8D3
         IYGjt0Z9hC1m3F73nHNHE1FN5r5bZV15QG7Fk1589ZhoZTh5lTz+h899PStbQUptfuEN
         xkxiCGvhbRAsyLQMNHN7HQLej3X5xrXKCp129EIaNC3cHT0BhVGmFJ4jc0i7NPpwrF4w
         kiMA==
X-Gm-Message-State: AGRZ1gKUQZjUVIF7g7MI/qkLmxu9dXIC98WPhQYzS22P3VO+RGzgJ5SW
        YXb/+l7MV50v9HypOpiDF6GHkx2qEtmYE87czzw=
X-Google-Smtp-Source: AJdET5cpszxDWpMqIKyp/srWVUB/220Hb/8rEWWW8OkUdOsRn+sCk8WKbZB16tmAm6SZ6FqI49CvFtBEy3yUTRAnDtk=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr2702629otg.139.1542249000311;
 Wed, 14 Nov 2018 18:30:00 -0800 (PST)
MIME-Version: 1.0
References: <000001d476bb$ec964520$c5c2cf60$@net> <004901d47be2$fa1d0c20$ee572460$@net>
In-Reply-To: <004901d47be2$fa1d0c20$ee572460$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Nov 2018 03:29:58 +0100
Message-ID: <CAJZ5v0h_+VnTEUDsc+7ToG7cPeUvLoRy5sdZbrUnd5A3XZ3h7w@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 7:26 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.11.08 00:00 Rafael J. Wysocki wrote:
> > On Wednesday, November 7, 2018 6:04:12 PM CET Doug Smythies wrote:
> >> On 2018.11.04 08:31 Rafael J. Wysocki wrote:
>
> ...[snip]...
> >> The results are:
> >> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
> >> http://fast.smythies.com/linux-pm/k420/histo_compare.htm
>
> ...[snip]...
>
> >> There are some odd long idle durations with TEOv3 for idle
> >> states 1, 2, and 3 that I'll watch for with v4 testing.
> >
> > That unfortunately is a result of bugs in the v4 (and v2 - v3 too).
> >
> > Namely, it doesn't take the cases when the tick has been stopped already
> > into account correctly.  IOW, all of the data points beyond the tick boundary
> > should go into the "final" peak.
> >
> > I'll send a v5.
>
> With v5 there were no long idle durations for idle states 1, 2, and 3 for
> this same Phoronix dbench test.

That's good news, thank you!
