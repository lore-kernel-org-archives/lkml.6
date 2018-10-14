Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C858C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E4620659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 12:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E4620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeJNUaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 16:30:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42766 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeJNUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 16:30:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id b7-v6so15333002edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 05:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GZ/UfyKw0BiVGC5SeE4sezlFl5zGrRoQIznbWmpbi2A=;
        b=QmTmNiOEwOrtfHxmHZQjwXMScIFIgqAhNp5HSC9m0Gy5TMsc6+d5nf9ISrR7SI1vA/
         dk39LZgZJkCjks0q7OULA/r02qed1Ot+O2RQib8Grq3luIAw3XG35ZhXUfWljoWCSmXb
         vU2b50yIIDkmiUNEwLRvUkA9iGGM/cpEG8CuDBQWIgfmKNtXTjzZ5uDf25mVXOacvTUr
         hkkblmZ1/qpNgqvsDElxAhTwJqWqhzVLOrs0x1HI7NQluqQD+iw/SAT+Ju5wFvh2WMjN
         06me+U9eEjEVHsXffrtDIIcliArc6kI6Gdi7swT/NPqYF7vMmXe15r6OKQdQSrlRC7ud
         0Xiw==
X-Gm-Message-State: ABuFfoh2NQiczAj7ruD/aJvSVkaLZiyzTi9KHoUNVzpz7g+5qwmyaa7G
        nyIzOT1YJSO6w6g2umqYykH+oL8jc4k=
X-Google-Smtp-Source: ACcGV60w1IUDVkxdjq3vQN/tTwb0a2wAW5vLq7JMkt1YRJ4nnpJrLfitVS/7wC+WpmzYmlBm9cqCDA==
X-Received: by 2002:a17:906:6944:: with SMTP id c4-v6mr15157685ejs.103.1539521359422;
        Sun, 14 Oct 2018 05:49:19 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w56-v6sm3008930edw.79.2018.10.14.05.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 05:49:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] ACPI / PMIC: xpower: Block P-Unit I2C access
 during read-modify-write
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011102627.7418-3-hdegoede@redhat.com>
 <201810140336.mWbfDBaj%fengguang.wu@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69000721-79f7-aee7-6aff-0fca4bd0d533@redhat.com>
Date:   Sun, 14 Oct 2018 14:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201810140336.mWbfDBaj%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 13-10-18 21:05, kbuild test robot wrote:
> Hi Hans,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on wsa/i2c/for-next]
> [also build test ERROR on v4.19-rc7]
> [cannot apply to next-20181012]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/x86-baytrail-cherrytrail-Rework-and-move-P-Unit-PMIC-semaphore-handling/20181013-230503
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: ia64-allyesconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=8.1.0 make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/acpi/pmic/intel_pmic_xpower.c:21:10: fatal error: asm/iosf_mbi.h: No such file or directory
>      #include <asm/iosf_mbi.h>

I've a fix for this in my personal tree now. As mentioned in the
cover letter, patches 2 + 3 are really more of a RFC for now, the
goal for now is just to get patch 1 merged.

I will send out a new version of this patch after patch 1 is merged
(or when patch 1 needs a new revision).

Regards,

Hans
