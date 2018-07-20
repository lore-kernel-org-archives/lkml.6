Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8861AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDBA20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="skMAwdSI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gp3bM27I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDBA20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbeGTSoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:44:19 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41327 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGTSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:44:18 -0400
Received: by mail-vk0-f65.google.com with SMTP id o82-v6so4623516vko.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XPwfsJElYimK93ikweJh9DjsCPNn7T/d8/fH7TlOPPs=;
        b=skMAwdSIEeu+dtbOmviu5qif3eBr+LgdgA40aSHy2nhuiU7yJQbIQIj7myE3HcP99N
         RNs9UcKlg77jlMY1t2hH8ucyI8h2eTEB/T8Wzze+QRkX5Ja4ZL63rfEFElp8A6So+Iu1
         1rIteI4+9XHvwCJeBH9kMZcZZi0peym34+PN/PrGBhaGqQOqm3z3TJ4AkUnpv9PvLASS
         B8HCM1ZxRNvq65DXRwX7nRmDNGCSImUaC3wt+vyeydO9fhPiocsQX8qcqtNwVBla5Ro0
         m9v4tRh2+2T7EWI5tlyv3Ba8azlRNGyxMX9Rkp+QyyCZMKolSrgI2UyS6Z6lFCXpycyT
         Xw6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XPwfsJElYimK93ikweJh9DjsCPNn7T/d8/fH7TlOPPs=;
        b=gp3bM27IPxgLG1qKlKA1qqe1tn+bqXiWQH6QyYKVi2vt3O3+QZ9Ry2SBXPVvC4APvQ
         5iZ5fEYgo0INhmM9uY5JT6A0s2Iqob9B21m4FbhrwrqPPouPZS5UKhZ/XMNFRP2tG9Xj
         Y7jVmFtHEa3kCqxey/uEUOhj6kgVufE+plXKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XPwfsJElYimK93ikweJh9DjsCPNn7T/d8/fH7TlOPPs=;
        b=lC98EItWOzZPwAi8KJeCQf0qRd+Z8q3YYnuYWT3y1d+ttwVygNZVdKgRTms9c5HMhi
         GvzwimYavcEz8JyzJ0VDb+hWBJObU20+1ZtWkfEQVme/JalXcYm+tKmJo/ujyBtW7Lvd
         T51wGuiKxpd5iB//Zn9wcUPMcSYpjq+k3qhx4Wzr9vdTQkwJMf7P8bGG3L1bRTkdqynn
         eyBLpf118krV7gj8/Nnu1dBAHruJ4H/Lt/Ow8GIwHyKb/Bl3VQJhnHwwYWOqOdx8nEH3
         h4GKbeLG9hRNiMuC2/3KoR1v18LvPIirZNum10r0sH72xcAWOcyeR+NYm3RfTAHNBY/h
         vUew==
X-Gm-Message-State: AOUpUlGqYCihqHkMp/gWzsB/BoH40dTOJQfTz01AA8Lh+B8g7g32ACUQ
        0pqbqscOZGSkFhXQQrR3fngSEgpMejEbptYhbNiiFg==
X-Google-Smtp-Source: AAOMgpfK2373qjsIpvMznCPRluSRiAKeyb3/+R2fR6zNPMxs6yUHrn8AE98FoTT+63ziNk5YChaZVfYjaTL2PyYBrZs=
X-Received: by 2002:a1f:acc4:: with SMTP id v187-v6mr1810488vke.32.1532109295779;
 Fri, 20 Jul 2018 10:54:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:54:55 -0700 (PDT)
In-Reply-To: <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com>
References: <20180706233142.166296-1-dianders@chromium.org>
 <20180720141059.GA3064@rob-hp-laptop> <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
 <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 10:54:55 -0700
X-Google-Sender-Auth: 71Q0bmhZfWDMi5B8wCUOcQrhoh0
Message-ID: <CAD=FV=XBCeKUrfMCppfhetWNWLJWzsbiBkQnTugoXDff-0SD5w@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 20, 2018 at 10:26 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 20, 2018 at 9:13 AM Doug Anderson <dianders@chromium.org> wrote:
>>
>> Rob,
>>
>> On Fri, Jul 20, 2018 at 7:10 AM, Rob Herring <robh@kernel.org> wrote:
>> > On Fri, Jul 06, 2018 at 04:31:42PM -0700, Douglas Anderson wrote:
>> >> A few patches have landed for the qcom-qmp PHY that affect how you
>> >> would write a device tree node.  ...yet the bindings weren't updated.
>> >> Let's remedy the situation and make the bindings refelect reality.
>> >
>> > "dt-bindings: phy: ..." for the subject.
>>
>> Sorry.  Every subsystem has different conventions for this so I
>> usually just do a "git log" on the file and make my best guess.  I'll
>> try to remember this for next time though.
>
> NP. I'd like to add this info to MAINTAINERS or maybe a git commit
> hook could figure this out automagically.
>
>> In this case, though, it looks like this already landed.  I see this
>> patch in Kishon's next branch.
>>
>>
>> >> Fixes: efb05a50c956 ("phy: qcom-qmp: Add support for QMP V3 USB3 PHY")
>> >> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
>> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> >> ---
>> >>
>> >>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 14 ++++++++++++--
>> >>  1 file changed, 12 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> >> index 266a1bb8bb6e..0c7629e88bf3 100644
>> >> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> >> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> >> @@ -12,7 +12,14 @@ Required properties:
>> >>              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>> >>              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
>> >>
>> >> - - reg: offset and length of register set for PHY's common serdes block.
>> >> + - reg:
>> >> +   - For "qcom,sdm845-qmp-usb3-phy":
>> >> +     - index 0: address and length of register set for PHY's common serdes
>> >> +       block.
>> >> +     - named register "dp_com" (using reg-names): address and length of the
>> >> +       DP_COM control block.
>> >
>> > You need to list reg-names and what are the names for the other 2
>> > regions?
>>
>> Here's the code works.  You can tell me how you want this expressed in
>> the bindings:
>>
>> * In all cases the driver maps its main memory range (for the common
>> serdes block) without specifying any name.  This is equivalent to
>> asking for index 0.
>>
>> * For "qcom,sdm845-qmp-usb3-phy" the driver requests a second memory
>> range by name using the name "dp_com".
>>
>> ...basically the driver is inconsistent between using names and
>> indices and I was trying to document that fact.
>
> That's fine as long as the indices are fixed.
>
>>
>> I guess options:
>>
>> 1. I could reword this so it's clearer (open to suggestions)
>>
>> 2. I could add something to the bindings saying that the first reg
>> name should be "reg-base" or something.  Then the question is whether
>> we should go to the code and start enforcing that.  If we do choose to
>> enforce it then it's technically breaking compatibility (though I
>> doubt there is any real dts in the wild).  If we don't choose to
>> enforce it then why did we bother saying what it should be named?
>
> I think you need to state index 1 is dp_com (and only for
> "qcom,sdm845-qmp-usb3-phy") and a name for index 0. 'reg-base' doesn't
> seem great, but I don't have another suggestion.

...but why do we bother giving "dp_com" a name if we're saying it has
to be index 1?  It feels like the author of the driver was trying to
transition from specifying to specifying registers by index to
specifying them by name, but left the first register specified by
index for compatibility (or code simplicity?).  It seems like the
whole point of referring to things by name is to _not_ force the index
number.

I'm imagining a future compatible string that adds yet another address
range.  Presumably we'd refer to this by name too.  In that case both
of these would be fine:

reg = <0xa x>, <0xb x>, <0xc x>;
reg-names = "reg-base", "dp_com", "new_range"

reg = <0xa x>, <0xc x>, <0xb x>;
reg-names = "reg-base", "new_range", "dp_com"


> For the driver, it's not the driver's job to enforce any of this.

Sure, but anything that the driver doesn't enforce people will get
wrong.  In other words if we say that the name of the first register
ought to be "reg-base" but don't enforce it then someone will later
come in and say it's stupid that one of the names uses a dash and the
other an underscore.  They'll change "reg-base" and it will work.
Someone else will decide that "reg-base" is a dumb name and will
change it to "serdes".  It will still work.  Now we have a bindings
that claims "reg-base" and lots of different device trees in practice.

If the whole "keep things compatible" is important then what matters
more is what's happening in practice, not what's should happen in
theory.

IMO if the driver isn't enforcing that the first field be called
"reg-base" then it shouldn't be in the bindings doc.


BTW: I use the name "reg-base" in my example because that's what the
register was named in downstream device trees that I found.  Even if
the name isn't terribly appealing, if it's not terribly objectionable
I'd rather pick something that's closer to what people used in
practice.

---

How about this?

- reg:
  - For "qcom,sdm845-qmp-usb3-phy" (names mapped by reg-names):
    - "reg-base": address and length of register set for PHY's common serdes
      block.  MUST BE THE FIRST RANGE LISTED IN THE LIST (AKA index 0).  Note
      that the name of "reg-base" is suggested but not enforced.
    - "dp-com": address and length of the DP_COM control block.
  - For all others (only one range--don't use reg-names)
    - offset and length of register set for PHY's common serdes block.



-Doug
