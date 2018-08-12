Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCADBC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 08:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D38219E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 08:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D38219E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHLLDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 07:03:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36535 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeHLLDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 07:03:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id n21-v6so22540778oig.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 01:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7i1j7O6qmQ7or3w6cWNllTlSS45IBMn9tDu9T4/wfA=;
        b=mwtyUypgjxlSLxuRULWcIXRVfqrebU//qWV615/KWDlbkw4vHM9snSLlLnVbBRomi9
         mlLfitG/sLhGZLiItrBJReMX80l1eJcb0w5kw21Y5kpaGgJiyjoXDTFuK+O6spXqwr0G
         +9T23/ofLHFCxb7hjwh/0tmQRQm0XSyOCduMLcyRVNkYi9gyecLFVLPQNSduI5tXbxsc
         IrU/FxUcFsc2C9J82XmRA2FE7HxyzelL1tYOg46kj4M4FLcCztryUttuo0KgyNXJdp+U
         RZhJ3300UB0qvdgcS6HkBenL0/lXiFcf/Lv0k8raYgUtQDAZrcU1M69ACeaRktWjLDtA
         2hKg==
X-Gm-Message-State: AOUpUlG/Ayw9zpzOxVxy63NzaMbYMg7wAIjSPUCktpcNqD2zsC0JDeFa
        G0Snp8bY8iW4zhW4mGTXaHWVDoFouk8qdT3loLm9OA==
X-Google-Smtp-Source: AA+uWPyW8Z6l9VFdVSg87uIWu3Al0ANsUawSijBnpDd2CwBXIbQHQHKu4hFKdiiVFS6grQmRB+Fd96YmVBRj3TBjhWo=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr12697785oib.120.1534062377374;
 Sun, 12 Aug 2018 01:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <1533937924-6774-1-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1533937924-6774-1-git-send-email-rishabhb@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Aug 2018 10:26:02 +0200
Message-ID: <CAJZ5v0hRw-bkOZPLtKohW6aPYnFFsVGNQbYo9yvZPcUFzioOGQ@mail.gmail.com>
Subject: Re: [PATCH v1] dd: Invoke one probe retry cycle after some initcall levels
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:52 PM Rishabh Bhatnagar
<rishabhb@codeaurora.org> wrote:
>
> Drivers that are registered at an initcall level may have to
> wait until late_init before the probe deferral mechanism can
> retry their probe functions. It is possible that their
> dependencies were resolved much earlier, in some cases even
> before the next initcall level. Invoke one probe retry cycle
> at every _sync initcall level after subsys initcall, allowing
> these drivers to be probed earlier.
>
> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>
> To give an example many Qualcomm drivers are dependent on the regulator and
> bus driver. Both the regulator and bus driver are probed in the
> subsys_initcall level. Now the probe of bus driver requires regulator to be
> working. If the probe of bus driver happens before regulator, then bus
> driver's probe will be deferred and all other device's probes which depend
> on bus driver will also be deferred.
> The impact of this problem is reduced if we have this patch.

Please move the above to the changelog proper (ie. above the tags) and
resend the patch with CCs to linux-pm@vger.kernel.org and LKML.

Thanks,
Rafael
