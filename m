Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13BFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CB3208E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3k2vpDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CB3208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeHWWcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:32:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37841 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeHWWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:32:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so3274654pfd.4;
        Thu, 23 Aug 2018 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fZbwdL+Qr3KphgCDmmOMwVoqlFpwtTWpE0Rq0Vhe+7U=;
        b=W3k2vpDd2OA8g7lxevypINH4ZsfBeRysX7avByYGxp19rAKqn/RG3nAg50ZplaQvDN
         8aed0xdc0WM04QvHb4aa+/dUEC+nMuHP+KJmMAE/QcQsN7U26WJcyd8bsptPKJnm274O
         AWIv3azcx8JvuBhTW2n1QzGXDTHjOEJj7IvG8kpUR3AQenkcOrMIS7K+E2LF16znhZur
         VAdq98ggvlo0xNipQjz4igAO6OZf/QZ2WGi6+dIPk/0k+q79B4tVQ6eLa8rB+mIl7iOW
         lZKBsAjg1jV+Vw8ku/uf3rT7O42uoxSZbew3lGIPFHzXZLsu0huzvgWcfqt/TtzWz14q
         u4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fZbwdL+Qr3KphgCDmmOMwVoqlFpwtTWpE0Rq0Vhe+7U=;
        b=o8bpHK247Whzykx+2bjehQnfPQixpinZIfqZjKRSFrHOqAP2tw8ghpcJUnQunOuwP+
         QabprV7c+jmYh8Yb329yrMlaVfX/3bCE/qVRKjDE/AcwRGC05uXkJapXBl634wFLmDHr
         Zhahcyl9/rIwA2d0zyjaSbPA0Al55dw7WGyiwQVbiEwOeX6K5+KM7qCMMcGvRL7ogJ8C
         xR30M/xCHVWsF54O/ouHn3AdhGfQHzHLulzwhU+5io14oBJBFxKRztJZzTmzU5TtN3c2
         g8VvJYOZep6IEt8SeHUWItTMJWNFKwU5k9YcJLv5k6LWd4WKfRNYwfwSJUGfLVGAD4kd
         JOog==
X-Gm-Message-State: AOUpUlHMj88KRfCacquGZDzCnllxnDhmUl1mWWxUAx6fMFRRXfdnN32l
        PlM+YDexo7FCCSVK5LCdeXgdXdJF
X-Google-Smtp-Source: AA+uWPw/SZiwpW776dNJ5X8Z5a/dSZeoRrQ/YX8s/6vZEe0ejONscTjmofnzEIaZtej/esAP0rkrWA==
X-Received: by 2002:a63:fc5a:: with SMTP id r26-v6mr25617133pgk.377.1535050887633;
        Thu, 23 Aug 2018 12:01:27 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u17-v6sm11951421pfa.176.2018.08.23.12.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 12:01:26 -0700 (PDT)
Date:   Thu, 23 Aug 2018 12:01:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Harry Cutts <hcutts@chromium.org>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jiri.kosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Message-ID: <20180823190124.GB53155@dtor-ws>
References: <20180823183057.247630-1-hcutts@chromium.org>
 <20180823183057.247630-2-hcutts@chromium.org>
 <20180823185722.GA24777@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823185722.GA24777@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:57:22AM -0700, Matthew Wilcox wrote:
> On Thu, Aug 23, 2018 at 11:30:55AM -0700, Harry Cutts wrote:
> > +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> > +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> > +    distance travelled by the user's finger, in 256ths of a millimeter.
> 
> Is it too late to change this to an actual unit like micrometres?

No love for imperial roots? Sure, micrometers would work too I think.

-- 
Dmitry
