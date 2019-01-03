Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CEEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BEB2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546510116;
	bh=p4BMsPmNVulD2wJr7uIl6oF25NRo2H9JNsEVVTR9rSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B+Epbi9/CALpE561gMsgGUDIzZgMYn2qaGWEP/x37Sm8/xdkpUeRjysZNRUXQN5HR
	 CEKKSJ+P3rIHPiROEUdlt4jOUo103wx0Paa72PfAvpfsK8qmlvQDqiFm2QlFReRjJL
	 61MzQUll/Z7P5SLaI99QsTaAtjIYmIND/f17JO/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfACKIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:08:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34033 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfACKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:08:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id r62so27342745oie.1;
        Thu, 03 Jan 2019 02:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4BMsPmNVulD2wJr7uIl6oF25NRo2H9JNsEVVTR9rSw=;
        b=lhgsPu54PZBzzzs0igBQQO19we5yjz+WtPQ0vYbXsxzQf+oc3DnAc+dCZeJ1bnnkA0
         Ak1aTitQbv5ovnIodAWfG9wf7Dut88p/iOVNg7OGrKQMQAL9+Yncglti1eERLYAbt8bk
         cErDRc01sEd+CAwZlz0lm0Hj+U/JFeC0URLRHIN54mBku0DgBI7d8D4hTjeDoSa7bZ6z
         qrvKaTnzNphHDsmC8cH9XIw/cfA1S8QUlDUuCpE9ZVQAdMV52v4FxkHh55vc0O7hg+LL
         +Wfndux+0uvgGGGPlNvUCfUTC1gB7MCrCUjj7grHqpPp+pTCKdzLgUifUubTa/pz1ZT/
         qp7w==
X-Gm-Message-State: AA+aEWbC7Fh74TrlOEp3GCW7B3fg6DEjxtjz4uDII+znei/wgQgdV9DQ
        xJrsjeCTwEibgJ1d8OneXIO+gTNMlF9ZX+X+sSU=
X-Google-Smtp-Source: ALg8bN7YahUbk4q0shL2kXkYHr+/V8GVJveWujGxaRriHrdh0dSE4bsshFomaZyBgQ5XJTb59+cHu9w0foHxT5LHLxM=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr32426394oia.95.1546510113851;
 Thu, 03 Jan 2019 02:08:33 -0800 (PST)
MIME-Version: 1.0
References: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@epcms1p7>
 <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7> <eda2b1f2-ed6f-b75f-f582-761c2a48c0cd@partner.samsung.com>
In-Reply-To: <eda2b1f2-ed6f-b75f-f582-761c2a48c0cd@partner.samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 11:08:22 +0100
Message-ID: <CAJZ5v0jAkCP62Vj_G_Eq3wG=ZfdO_NtM1vdAO-HQNovnLSMTMQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drivers: power: suspend: call devfreq suspend/resume
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 4:08 PM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rafael,
>
> Gentle ping...
> Please take this patch, it got ACK.
> The other patches have been taken through MyungJoo's
> tree, but this one is actually enabling the feature.

Applied now and sorry for missing it.

Thanks!
