Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFE4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975772083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F3MUvgXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975772083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030455AbeFSSBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:01:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41037 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030437AbeFSSBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:01:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so214173pgl.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sS5qOlhMoy0XHSM5M3fpB4OpvhHpm+y23kadqfUiZfQ=;
        b=F3MUvgXBcTnfvN08VK1kk628tG0L08CSBupnXV2fsqxDqKzk0qYVeoEuDOq0j3fyar
         FKZHtS3GNqJXY6xhwUxcSyFALCBKov1VvR0fHe3NrLkxPoWP7zMhZT8tsh5OoLz3k1Nj
         dI/F2/g15xb5EFac50pHMDYhVSk6JkQs+oACA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sS5qOlhMoy0XHSM5M3fpB4OpvhHpm+y23kadqfUiZfQ=;
        b=GTO2al2XksX5LYaKPCA8PKtzWZdSALSCR5UFXYYMP5p7Zncd8omN8X/FDLP4xLeGiC
         4DWFHVkfL6uXIHgWdD72LlcuA/gHw/P7k7QP1Kjzkm9iBCqdxXmlZKyt5ecOzbMYvfyW
         dBV7OjwDH/AsHSjt0ZMsiZZOrBfq6o7fPWLWfWvNZaFie+2I+swDWPbP43yI08Wc298b
         Pu0DRu/W1bM0AgUcdehmjC1j3XhtkV8i8wPHqrFo08gE9gS3xH2O253yEj2fJEwckaj9
         59pTIn5q49BDRTlzEywx0AigBWDaKWtW8LilTzwUz5NNO21u5tu8pgZAfUOYP3NKEYFG
         XlWA==
X-Gm-Message-State: APt69E0nU6lwsOwAQnywS4Kbd4F9sTFNhh6w1yDx9LGfm2tOmQoM3UWC
        s1o5rrtPlbk84ugpVYNIMbYCPWQemRo=
X-Google-Smtp-Source: ADUXVKLRB8VzOJGAd6Z2CTdwr8ou6hE3Ch8DiG3/pNqrdFftyUWIVvazVicVPPZdUNDRP1RtG0bIWQ==
X-Received: by 2002:a62:8552:: with SMTP id u79-v6mr19336003pfd.201.1529431301320;
        Tue, 19 Jun 2018 11:01:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id i7-v6sm778106pfa.34.2018.06.19.11.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:01:40 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:01:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Add machine_real_restart() to the noreturn list
Message-ID: <20180619180140.GA169030@google.com>
References: <791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:47:50AM -0500, Josh Poimboeuf wrote:
> machine_real_restart() is annotated as '__noreturn", so add it to the
> objtool noreturn list.  This fixes the following warning with clang and
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y:
> 
>   arch/x86/kernel/reboot.o: warning: objtool: native_machine_emergency_restart() falls through to next function machine_power_off()
> 
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks!
