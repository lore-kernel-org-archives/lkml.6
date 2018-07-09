Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D458C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F087C20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAqmKgie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F087C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933111AbeGIORO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:17:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33490 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932727AbeGIORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:17:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id l10-v6so15501733qtj.0;
        Mon, 09 Jul 2018 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6aWSF+qLnawmOv80Q9Y8vJ1wazabeubctq+EcKo0Us=;
        b=hAqmKgieHjwmIgUjrI3Ocb679ynb/qWMn9HrH9z92tCBKdka/fQP7bj0i83YhK2v2P
         P6etdgpVFdDpC9cEkdWgFW2PgEZgFydmyk0+/tpWf/cyizF2BZqPLILAGUg+32mdHYD/
         /wvQyTHPPZxglfoW+bS2M6TJjiSl9jIi5b7WHkHW+X2+o1S8heKgWPQxgenhpBh7vLv4
         VpwEkgE6T3YqGQGA0YkNa69USNji1kfT1+heZwpg4rfrYjP0FiRvIseZDq+EPpo7qTd3
         J1v2GcKnzUhgpIdeAmqItG6uihfCEV8WyS6nhdbB2/ca/33QWBWURk8g8rOSEG6oPR1S
         OR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6aWSF+qLnawmOv80Q9Y8vJ1wazabeubctq+EcKo0Us=;
        b=XVbQPL+BFmRz35SYiTPfa57jmc7+NwKdhYL9VN0L5JbOvTd6Q/9fmAMDQvsmWGO5uS
         gI9FDqmYqkz9FGDSz6e0C0W/cFyceSdYYjYFA3JkfXj7zxtwrK1ZnuMzGUUROtAGQGJ2
         lqMasjKlnsrdnZbDSq8OLi3WBgnWBjeQeRlA00lGEPSWWuu/AAu+2elHxrrwhkSgbZG5
         GkEg5FcWmSwR/xMqFR3ZPXQ5Epzq9YUVURSQFCYNV/sOWYdbFieu/1hIyvM97V7q6fLH
         amVT5YrnE6Ol3N8uuaatCC0Mt1NViazvPWav6Fwpy4TnsCYzCFMLPHxPzCANUuIPH1+c
         FhgQ==
X-Gm-Message-State: APt69E1IrqzlEwiDHH5LmzWIB5aMr/qO4uYXaJKomampcTPZQD2w11rt
        LQUclw2bv7FUjowmzLiAnvckuOi24fNXIyxE7as=
X-Google-Smtp-Source: AAOMgpcsDgEEPKlKlrP7pmwXYoVi8yDREB8qF7yA7B9yLbLQx8F3K1qRShkVhJ/7RW29veAqXD25WLzTNYJOdExkKWE=
X-Received: by 2002:aed:35f8:: with SMTP id d53-v6mr19132419qte.239.1531145831827;
 Mon, 09 Jul 2018 07:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180706060158.24155-1-luaraneda@gmail.com> <20180706060158.24155-3-luaraneda@gmail.com>
 <1088d908-eaa1-78a8-f1a5-1a7d82eb5afb@xilinx.com>
In-Reply-To: <1088d908-eaa1-78a8-f1a5-1a7d82eb5afb@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Mon, 9 Jul 2018 10:17:00 -0400
Message-ID: <CAHbBuxr4GFsmGWoaLJDwxMHL1H_wtgw8Wj+p17=hA7rMhSDcvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: xilinx: Add missing zynq boards and
 sort entries
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Mon, Jul 9, 2018 at 4:18 AM Michal Simek <michal.simek@xilinx.com> wrote:
> Please do it with more patches. There are 3 changes in one patch.

Ok, I'll split it into 3 different patches on v3.

Thanks,

Luis Araneda.
