Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D2C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AA42145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JNwz99Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AA42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeLAE2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:47 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46422 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLAE2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:47 -0500
Received: by mail-pf1-f178.google.com with SMTP id c73so3103793pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0XiIgNN5g8m0ASixQgc70B8VnwScjACFWrnXhl1VGDw=;
        b=JNwz99XqEwXtIMdWbLnvpSEUZkwNFoXIB1C7Zm/kZK92JZc1cRZyIt1z78uu5fpVuG
         IV/uiALs7fJ+3mOuF0LH5op48Sfe5dbFhi2LfM5BYhuiatSN9KzDKVVcRWTbxJmPs4Pr
         ItS5/E6o1rJ84HX+OoS1OlEOZ+hpTyvkWZc2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0XiIgNN5g8m0ASixQgc70B8VnwScjACFWrnXhl1VGDw=;
        b=VShaKau4FLXoEmV8MGYDS1kZXHueH7K3gYOXa+iqw8Sb8CG0sl2Uapomr0YuEOwpMR
         P53kmQHsdV7h1ZNimFymH6nthZNWHco8I2b6DL8GdZqQmHFvocd1XwNkBRU81YiV8nEN
         mN5zuLFAX019Okd8VWyEzjVLsk5r+4X06ByE8QIR5x8HAhuF59KBUUztdLJT3kVvxDa8
         BHnv1jNjdi1pzvDx+X8ZQM1IOH80+HzzxkTkxnwNQRwExb1QS9eMECKrYPLrI9WDzuR/
         /EUsN4YjcN5tSsd8hMymkEMSdtX29sgI/JQJA3qgN5B3MdAZQvkZjbW5q09oKqSrOzkY
         6Hmw==
X-Gm-Message-State: AA+aEWb/hEed5SN1+wBebUudE0OGBwjOTUhw7Ekp4LQbzNSuLz4rWitd
        m40jXIHwjSrOpI5Eq+bxhPQg/pkhut8J/A==
X-Google-Smtp-Source: AFSGD/W1fBYDXbAFY4FaWsWGk7lg+QJSgoM6r3K/oZ6+aXAzNEHjdDzHK8Q35IzN8sLI9imBjN63Uw==
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr5554129pgi.258.1543598327890;
        Fri, 30 Nov 2018 09:18:47 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a9sm5672487pgq.20.2018.11.30.09.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:18:47 -0800 (PST)
Date:   Fri, 30 Nov 2018 09:18:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] gcc-plugins fix for v4.20-rc5
Message-ID: <20181130171846.GA48303@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this gcc-plugin fix for v4.20-rc5.

Thanks!

-Kees

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.20-rc5

for you to fetch changes up to ef1a8409348966f0b25ff97a170d6d0367710ea9:

  stackleak: Disable function tracing and kprobes for stackleak_erase() (2018-11-30 09:05:07 -0800)

----------------------------------------------------------------
stackleak plugin fix

- Fix crash by not allowing kprobing of stackleak_erase() (Alexander Popov)

----------------------------------------------------------------
Alexander Popov (1):
      stackleak: Disable function tracing and kprobes for stackleak_erase()

 kernel/stackleak.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Kees Cook
