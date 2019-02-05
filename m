Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86157C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8522083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549394064;
	bh=WxZFJp/y411GuoDKVtvbf5uf7Dt3xQPkTnd4JZcNh6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+Shg4s32iS3g4aNHyKdngzgqPOFH0+OoWyvs85oqaam+2N8ulIvPuSVSgzfGX336
	 iMtnAyoCfOAiaYoNnjMj2RsdNdKb1k267/DrjWbBSt5Ow9CbS4rEyKjFpH0FlDjono
	 ei7Gf4WNE/6g/4L69/mca4Kif3EqewZaeTe4ki1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfBETOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:14:22 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39400 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfBETOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:14:22 -0500
Received: by mail-yw1-f68.google.com with SMTP id k188so2135462ywa.6;
        Tue, 05 Feb 2019 11:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jLQc19A5eF7j+CkSBK440z0Zwb+xakXGoQozhf0Ob/c=;
        b=KKxPf1KjTkwPE+V+zSJwx9Og1/vR1CjSIuATt4iJmjVwMfIS9UqdoPhqkgXEUd50kL
         e+wMPuG3ZMkOOgypFYy6O9GEX3F55AIw+qASU4w0kArXo/yfq/xs1Ih9+fZVC6U9joGX
         2yv4fKgLs8+Ln8v1PWl4IkLemYIrn9KJ5VgSQlZskd1uv5jNkA2SbKeUjb/BMeDo3XH/
         aiy8sfPLTXdHyCvVtjmRuR5uHh/TVVPDL/+x+rDfhW2TK3mXaiyLAN38N8q/y1sOtaYt
         q/obuWgLCondQWoXt1vnanPWEQRKi8Y1lwbSciRg6Fo3pN9RWt5t5MyTgBc2YIRrfhpv
         FPgg==
X-Gm-Message-State: AHQUAubIVRnnMeho+9cHuPmthULPYc1A0KlWJlAPvulP7Zrd/DFT/Omk
        WKy/AHyLIK0FfbeCCPK+UCf+Qs7TqOQ=
X-Google-Smtp-Source: AHgI3IaSnJaiY2smP+lUzhkL6M0DffbDYI8i0sGUTadl1kBXqeSt0ePjWGZgV8WYWwgxwTu1f0LVcg==
X-Received: by 2002:a81:3607:: with SMTP id d7mr5342254ywa.427.1549394061143;
        Tue, 05 Feb 2019 11:14:21 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id d3sm1425599ywc.103.2019.02.05.11.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 11:14:20 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 05 Feb 2019 11:14:17 -0800
Date:   Tue, 5 Feb 2019 11:14:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Rue <dan.rue@linaro.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 2/2] selftests: firmware: add
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config
Message-ID: <20190205191417.GV11489@garbanzo.do-not-panic.com>
References: <20181127031218.24419-1-dan.rue@linaro.org>
 <20181127031218.24419-3-dan.rue@linaro.org>
 <20181130023115.GN4922@garbanzo.do-not-panic.com>
 <CAB=NE6Xxzee9+VeXWqe3o8Uf3Mb+jw=_-9C8RuqSSeWrVUXJng@mail.gmail.com>
 <20190205024150.4ntyl5gccvk7soux@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205024150.4ntyl5gccvk7soux@xps.therub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 08:41:50PM -0600, Dan Rue wrote:
> On Mon, Feb 04, 2019 at 05:39:57PM -0600, Luis Chamberlain wrote:
> > On Thu, Nov 29, 2018 at 8:31 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Nov 26, 2018 at 09:12:16PM -0600, Dan Rue wrote:
> > > > CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y is required for fw_fallback.sh.
> > > > Without it, fw_fallback.sh fails with 'usermode helper disabled so
> > > > ignoring test'. Enable the config in selftest so that it gets built by
> > > > default.
> > > >
> > > > Signed-off-by: Dan Rue <dan.rue@linaro.org>
> > > > ---
> > > >  tools/testing/selftests/firmware/config | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> > > > index bf634dda0720..913a25a4a32b 100644
> > > > --- a/tools/testing/selftests/firmware/config
> > > > +++ b/tools/testing/selftests/firmware/config
> > > > @@ -1,5 +1,6 @@
> > > >  CONFIG_TEST_FIRMWARE=y
> > > >  CONFIG_FW_LOADER=y
> > > >  CONFIG_FW_LOADER_USER_HELPER=y
> > > > +CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> > > >  CONFIG_IKCONFIG=y
> > > >  CONFIG_IKCONFIG_PROC=y
> > >
> > > NACK -- the point of the changes was to *allow* us to mimic such
> > > configuration through a proc sysctl knob.
> > >
> > > You aren forcing CONFIG_FW_LOADER_USER_HELPER_FALLBACK but just having
> > > CONFIG_FW_LOADER_USER_HELPER suffices to emulate the_FALLBACK
> > > functionality.
> > 
> > Dan, again, you broke the whole point to the amount of work that went
> > into emulating testing. As such anyone testing their changes would
> > yield incorrect results.
> > 
> > > The issue here seems to be that *all* tests fail once a configuration is
> > > found which is not suitable a tests. With the shiny new proc sysctls we
> > > can test all 3 kernel configurations in one shot. Since we test 3
> > > different kernel configurations naturally some of these won't have the
> > > features needed, so that failure should be treated as non-fatal to allow
> > > the chain of other tests to continue.
> > >
> > > This issue was a regression due to commit a6a9be9270c87 ("selftests:
> > > firmware: return Kselftest Skip code for skipped tests") by Shuah for
> > > the verify_reqs(). We need to treat this as a non-fatal / don't skip
> > > return value.
> > >
> > > The following would fix this chaining issue:
> > >
> > > diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> > > index 6c5f1b2ffb74..1cbb12e284a6 100755
> > > --- a/tools/testing/selftests/firmware/fw_lib.sh
> > > +++ b/tools/testing/selftests/firmware/fw_lib.sh
> > > @@ -91,7 +91,7 @@ verify_reqs()
> > >         if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
> > >                 if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> > >                         echo "usermode helper disabled so ignoring test"
> > > -                       exit $ksft_skip
> > > +                       exit 0
> > >                 fi
> > >         fi
> > >  }
> > >
> > > However its not clear to me if instead we want some new special return
> > > value for selftests so that the framework can detect an that an error
> > > is non-fatal, and can continue. This is a tricky situation given the
> > > script, existing upstream kernel module, are aware of such emulation
> > > hacks via sysctl, but knowledge of this is not obvious to selftests.
> > >
> > > Shuah, how do you suggest we handle this corner case? If you are OK
> > > with the above hunk for now I can send a fix for it. In either case
> > > this commit was added on v4.18, so the fix would be a stable fix.
> > 
> > In lieu of any suggestion I'm going to request we revert this commit
> > and send the above fix.
> 
> Sorry, I didn't realize this was waiting on me. I agree with all of your
> feedback. Please revert 7492902e8d22 ("selftests: firmware: add
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config") and add my Acked-by to
> the proposed fix above.
> 
> Shuah, do I need to send a patch for that revert?

I can send the revert and the subsequent fix.

  Luis
