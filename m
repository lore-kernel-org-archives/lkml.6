Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB71C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBAF2152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdQ7dBcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBAF2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeHXTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:20:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44896 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:20:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so7216626ljq.11;
        Fri, 24 Aug 2018 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax/oXp4vJyDj6LbekR00oxOMvpoWuKn6ddcYUF/a/E0=;
        b=bdQ7dBcf7o9RBWthKGE7PIlem+pN0jAUiZ5kOeSR14RTHyIF+HNRXBDgTRzhYsJqc+
         DcyLHWJMogyT0REz+JbeYVpwQA9MkVAVtrX+bI0XvDIGKNZMYf86lSh187Ynzp/5wbZF
         zSOrWBIRLKC3fbcV/scsa2PpWGF+WWAA3jBtDqAYqGYVUDOP6pAwJ5DZp/8admTuHb6Z
         ogvDlG9Pt+v3p9XTjoABZ4umPUFy/qzOkcvC1PxMU4suvxPORe6ZYGrD/42mgLWTu2Ic
         b2mxnI0VZO9lgcIjZ+PLel+lIBX+y9MTietKrSur0E/tV+kRpeUT4COStexpu3Z6x26/
         1/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax/oXp4vJyDj6LbekR00oxOMvpoWuKn6ddcYUF/a/E0=;
        b=rcJrjwQHVwda94XzUQ9Sn6COqc3Yr9FZQHF9CaIFlSmFHeTS2CT4TKtUpnipwtB7Gt
         gZAAY4CXn/auRE7IX/XpB6uJsuZKHqI2b5odOiCF6esj+JHM91trQvkt1lbuvSPuaE+D
         afzkRGqSpPzGy7CtVo4ZFp5eon3BnHqZc5ULhIOf/kjERr+dQF5wirtJGnER1LLBCDLz
         2sYM+zYGorn8u6Jb7l/WKe0yQwWPK+IrCHKRE16nq6MyRaRituCNZl5mBYKfsVKbO2TK
         DLDKVS0jGKwewjOF5iTVbYRSPC/G0jXDpnCqQb9ouFRGgwAAtSIOijH/xrsWxJgVol+K
         4cow==
X-Gm-Message-State: APzg51CCnVu0Xf/FFEA42wKGu8qhojXuIO2Msazq7ribMww2V4IcD152
        Ab5nbOetmX9y29iNAbNCxeCVuTmVRPA4m40MOS0=
X-Google-Smtp-Source: ANB0VdY0I1A6XxFT8DxzynXrJ/9kGa+VXgfJ15cCwZjnNSe+uADuiDhzm38UfI7NZesU1Kbh6an7Ejh0vb0Tscfal2k=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr1843220ljh.18.1535125502243;
 Fri, 24 Aug 2018 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com> <20180424080437.21367-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180424080437.21367-3-benjamin.tissoires@redhat.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 24 Aug 2018 08:44:51 -0700
Message-ID: <CAKdAkRRsca1Q2Ltqr=yyZ-rr7vxkty1cGVYjFB5bcC87UtWDSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] HID: generic: create one input report per
 application type
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin, Jiri,

On Tue, Apr 24, 2018 at 1:04 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> It is not a good idea to try to fit all types of applications in the
> same input report. There are a lot of devices that are needing
> the quirk HID_MULTI_INPUT but this quirk doesn't match the actual HID
> description as it is based on the report ID.
>
> Given that most devices with MULTI_INPUT I can think of split nicely
> the devices inputs into application, it is a good thing to split the
> devices by default based on this assumption.
>
> Also make hid-multitouch following this rule, to not have to deal
> with too many input created.
>
> While we are at it, fix some checkpatch complaints about converting
> 'unsigned' to 'unsigned int'.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

I see a spike of user reports on Bugzilla with HID devices being
broken on 4.18 that seem to point to this commit. For example:
https://bugzilla.kernel.org/show_bug.cgi?id=200849

Thanks.

-- 
Dmitry
