Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F224C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFallG3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4036020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeIFXv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:51:27 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33234 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIFXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:51:27 -0400
Received: by mail-lj1-f179.google.com with SMTP id s12-v6so10288456ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QJeKU0S0xddUXcuZvKNAcHxq6Oz8YnxqMuAEw9Ww3Fs=;
        b=JFallG3Z03iqy4wVE2M1/TtKKUvRkeu8nkeHspaF9pMGX4g2woWdDhoW0ug+dPLJhV
         hJRJhLdm9iUf5RDqKEgx76q4pK/Smd7OIz4BlJX+nVTuvtFhXbyhsiCyM1jIXwHOBPyF
         JI55yjeq3Cq0wgAkTsHK+fUS6/oGkDBoJCr3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QJeKU0S0xddUXcuZvKNAcHxq6Oz8YnxqMuAEw9Ww3Fs=;
        b=LfDuxbNWaYbRjHTvz6LjpnpQi8yoZnpYtHcZXyGDQvbjzMrAh9hSD+NpXcotwQfFSL
         fk1P41c30ZItCrduBUVCO4o16ZG3uaysEEMG4w0BcKJSVAz/0mWiBazj2YNU50vH8Nrh
         /1EuEhLKJF7DOwnsUN8oEAzOpv5bFS9WAQCKlOQ/YCpow4eKTo+hqL8nQ9XrbCmfzl9z
         fOJbOrGqk4GjDaXBiEgF2YLP3wJOBo8QKTBls6i6vusLZiZTIR0Z7CiNV4xTgNbR6oNb
         DToPNZE+C1rcMl5Zn0cmJZPEYvU8H57zXcNbS6dSsEE8DEo2kLHj7SaT99INorqBm2FD
         XagQ==
X-Gm-Message-State: APzg51AxovDDBPIDwZbJzAlFXzMIomR+7CPqOg0QSOyoo+1l5cUFJlkC
        GwtuzSTAh0HqGjLsAqsIgmRqkyzJhr84oAUO1Qg1Ag==
X-Google-Smtp-Source: ANB0VdbVG6x0u7UXQr3IcwP5dP9WFoYXJx+Ou5B08qPMHWZaLroemOxAAby2SvBQtzy7VEewv8g13DUU6UQfCa4ftKQ=
X-Received: by 2002:a2e:7a08:: with SMTP id v8-v6mr2660736ljc.121.1536261274055;
 Thu, 06 Sep 2018 12:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:8fd3:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 12:14:13 -0700 (PDT)
In-Reply-To: <20180906152357.GA13389@roeck-us.net>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
 <20180906140413.GA5098@thunk.org> <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
 <20180906152357.GA13389@roeck-us.net>
From:   Matt Hart <matthew.hart@linaro.org>
Date:   Thu, 6 Sep 2018 20:14:13 +0100
Message-ID: <CAH+k93G4BZPrdEToJ2PaUjYsAbp9ftxEvYu3r7BE=Db50jDPwA@mail.gmail.com>
Subject: Re: Widespread crashes in next-20180906
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 16:23, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Sep 06, 2018 at 03:13:23PM +0100, Matt Hart wrote:
>> On 6 September 2018 at 15:04, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> > On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
>> >> Build results:
>> >>       total: 134 pass: 133 fail: 1
>>
>> Do you build arm64? Because KernelCI is seeing build failures in arm64
>> defconfig for next-20180906
>> Clearly it's a module build problem for sunxi but I'm not sure who to
>> CC about this.
>>
> I do, but as part of the boot tests, not as explicit build test,
> to save a bit of time. Maybe I should run a build test as well.
>
>> https://kernelci.org/build/next/branch/master/kernel/next-20180906/
>> https://storage.kernelci.org/next/master/next-20180906/arm64/defconfig/build.log
>>
>> ERROR: "sun8i_tcon_top_de_config"
>> [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> ERROR: "sun8i_tcon_top_set_hdmi_src"
>> [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko]
>> undefined!
>
> Same error here, in the boot tests. Sorry, there are just too many
> failures there, and I didn't go through all the logs.
>
> Do you have bisect results ? Otherwise I can run bisect later today;
> that should hopefully identify the culprit.

Bisecting it now, though it might finish after I'm done for the night.

>
> Thanks,
> Guenter
