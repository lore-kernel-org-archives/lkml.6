Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B532C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF153206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF153206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbeKVJDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:03:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46114 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbeKVJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:03:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so7405253ply.13;
        Wed, 21 Nov 2018 14:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/mmPtPKqrsZS371CzVCZIeQCBycbWbaT7BE+fZVnK8=;
        b=bsRT8YrI4JasIplQ3IRkl9rt7gJJ6qTzlfA3U8I8Q6zPhY9w14SchAIDZ9+c8RTStN
         litwBsYAIbMnNL77GOfn0yYdc/z2yDg7IKRNpHGn7hUl9gkaekJXGTVlMpAT1Tcp0vae
         Ehp6NQCVoAs0ZiLnWO3gHfR9hkGoId8hZid9m83/Fri3v8i/BshY/7Dp66vlirX3DNQ+
         MiTpcfGrLc7hgzPdOM4fqZZWNQNAgKzyeZgmvN80oll3B8YqX5pASUtzT/lFGWoGkoUK
         a0I9ZcE2T7lMgXFM5komTyMM038Cty5dM+0QmYq/2CQqAZVxF0oSllSCexupmLeyeRN6
         4+nA==
X-Gm-Message-State: AA+aEWZoIOp5sNx9Jz7xX71Hkj7zIU3da+9Z5OsYG1a+Ua2o/8R4nN/X
        I1Bxy9Sr5p16a5XJOXYo0d0=
X-Google-Smtp-Source: AFSGD/U+eknWhPZ5oKCPbPEKJesYw3O9+DeGzYB5Zp67JcjavN5yMARdd7n7e86TQ+HE5KK1FxB66w==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr8606578pln.340.1542839254376;
        Wed, 21 Nov 2018 14:27:34 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id b2sm73540386pfm.3.2018.11.21.14.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 14:27:33 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 21 Nov 2018 14:27:30 -0800
Date:   Wed, 21 Nov 2018 14:27:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lei Yang <Lei.Yang@windriver.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: kselftests: fix test_modprobe issue
Message-ID: <20181121222730.GA4922@garbanzo.do-not-panic.com>
References: <1536229374-25699-1-git-send-email-Lei.Yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536229374-25699-1-git-send-email-Lei.Yang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:22:54PM +0800, Lei Yang wrote:
> when CONFIG_TEST_SYSCTL=y, there is no "/sys/module/test_sysctl/"
> when CONFIG_TEST_SYSCTL=m, checking /sys/module/test_sysctl/ is
> before kernel module loading
> 
> you'll get below error message
> root@intel-x86-64:/tmp/sysctl# ./sysctl.sh
> Checking production write strict setting ... ok
> ./sysctl.sh: /sys/module/test_sysctl/ not present
> You must have the following enabled in your kernel:
> 
> This patch will fix this issue.
> when CONFIG_TEST_SYSCTL=y, it has no chance to check "/sys/module/test_sysctl/"
> when CONFIG_TEST_SYSCTL=m, it will load kernel module first before checking sys
> interface.
> 
> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index 584eb8e..08dc995 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -120,6 +120,7 @@ test_reqs()
>  
>  function load_req_mod()
>  {
> +        trap "test_modprobe" EXIT
>  	if [ ! -d $DIR ]; then
>  		if ! modprobe -q -n $TEST_DRIVER; then
>  			echo "$0: module $TEST_DRIVER not found [SKIP]"
> @@ -770,7 +771,6 @@ function parse_args()
>  test_reqs
>  allow_user_defaults
>  check_production_sysctl_writes_strict
> -test_modprobe

Better yet, we can just depend on /proc/config stuff for test modules,
refer to check_mods() on tools/testing/selftests/firmware/fw_lib.sh.
Feel free to make helpers if you can come up with a generic directory,
otherwise just duplicate the effort for now.

  Luis
