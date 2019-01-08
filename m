Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F36C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5A320652
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+p74kZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAHTNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:13:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37016 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfAHTNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:13:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so5564565wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=W0jk43LKKxiqTWyU6hctU/5US90Tnup3gAMXXM9pdnE=;
        b=a+p74kZOTwm+dhcdBSm/TSmGzualb+b/K11vlfc8aZbBHDFZpUIByXMuIWWkH1tzFj
         ZoTFN4kiqQVTr7BAe3P15Hdjxqg7VytENTv7y0y71/iYqDi+5Hd5m2H7nvXqSkuLTp4G
         mJTMuzpVWvA6svdMPd+GuPImSTfLDhy97tZ/4jwqx2UTyO6xD4VYaUN+ScsERtQm+sMn
         z1cw4CmNrUZhB8SnVh1ZeC5FWs4xwKDAbwxKZmC9naHdH4U6zew+4esat31+s05zaUg2
         C0jf83ytTngSxFvMvoh0IauJ1QwCmsxLbSOwbnZrRXjoKkGonKHpw322x/LiyWFw9IFm
         BU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=W0jk43LKKxiqTWyU6hctU/5US90Tnup3gAMXXM9pdnE=;
        b=LtHsbBpKm6njhe0LVbJDQ72L9rHfYOHB+pPLts3k8rfAeHSvCeugUZ7cJICTqAMaSq
         6sgPrQjMjvNXvl0uzhLZfLZiLXdvjX6QFoz+TIVyl30QlQQJIzYSGe8qKudoe+Qro6xs
         L33DYA01ZNHOZ7rxjEtfqizKG4pU5ujxGJbVIyepHUhJkuhUupv1TMWSgLpG22PuxxTz
         Zh7EdwfIGv361JSutm8FwUCgjx60q1C8i/OWgJL+Zshe8TDyLZYWNbSe3u70EvAfGfoo
         tsmS7XgOM28HWWPGqiSgj0NVKSK7JJ4Pmf1Qp0klFUJPfqa7RbRLMFkXKV0PYsNAeZxm
         Wjuw==
X-Gm-Message-State: AJcUukcJpPkqxAQoWNtFc34myOqZ2AXnGcfOLkFR6KlhIEhQt8HKpHR1
        WO9/KdKZySWtwnTXx856Crc=
X-Google-Smtp-Source: ALg8bN7jkf54ex9MA+IzO2TSkghOM8TTAFzRFlEQPD57slW1Bpie3h+0Umw2bjtEeDclVdTc1jDPog==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr2552442wme.28.1546974796377;
        Tue, 08 Jan 2019 11:13:16 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t70sm15340579wmd.36.2019.01.08.11.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 11:13:15 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:13:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Manasi Navare <manasi.d.navare@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Clang warning in drivers/gpu/drm/i915/i915_debugfs.c
Message-ID: <20190108191314.GA25250@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit e845f099f1c6 ("drm/i915/dsc: Add Per connector debugfs node for
DSC support/enable") causes a Clang warning:

drivers/gpu/drm/i915/i915_debugfs.c:4961:17: warning: address of array 'intel_dp->dsc_dpcd' will always evaluate to 'true' [-Wpointer-bool-conversion]
                if (intel_dp->dsc_dpcd)
                ~~  ~~~~~~~~~~^~~~~~~~
1 warning generated.

Did you mean to dereference it or should that print statement just
always show? I normally would send a patch myself but since I'm not
familiar with this code, I'd rather not shoot in the dark :) especially
since it's for a trivial logging statement.

Thanks,
Nathan
