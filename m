Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92BEC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807732084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807732084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeKFMR2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:17:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53578 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeKFMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:17:28 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1gJrVf-0001Es-NS
        for linux-kernel@vger.kernel.org; Tue, 06 Nov 2018 02:54:31 +0000
Received: by mail-wm1-f72.google.com with SMTP id h67-v6so9526773wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 18:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xNOsWxgn4zw7OJBbph1j4tCIxnQJdW3RPTNLp9mD2LY=;
        b=cI+/PS7yehldsDYhjsrKJUbEAUw24SU7BjjoNN2loVU+4IS9VEtGV1jgKJc+XIdoM3
         EdN1CQWV8nnWIvj/QjSofe16+kqehlO9bnlo5BIWZyyXKMd39panY69xI8iD16gpbzR5
         3n6EFwdRaJjKl4IC9tnHgFLw0dYQorhMeI2JH4bDbj3ZlHgGx6u19ARgqm1d1Ai4yJHK
         qP+7357Yvoqm+mRcWMsWPv1JwlAnnPHKBMNxAu2RwJbqYM8/5UbkoMzsffP3iBBqIDRf
         UGwRUVQgS3TsvjErEdwt6giJ6f1VybwK/F4RTzFftX6Y/9NIadtBOj5/czQwGTlJyZM/
         y6sQ==
X-Gm-Message-State: AGRZ1gKxH7zAP3ObfmLCmnL/K1z+0LcmWcWLq83GUFcIv6POR1AX/6TQ
        trurtsXTNuCEmNuzzI2s/noRSSSYgpwKZUiMy7ss/nUZaKGzGcwdtWKI8FQrvh3JK9cu3ABThJr
        TbMEmJ8CgU5EZRXM3M1rtSO9s7YsidpVQRwNee2+OHcjC8E07GMk8N09owA==
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr20460189wrw.53.1541472871359;
        Mon, 05 Nov 2018 18:54:31 -0800 (PST)
X-Google-Smtp-Source: AJdET5eiYFU3pSmIs2QfY9hakAGEnNfW2xuqIJn+ML+ruevMsJnxkmz7AGv7JZuK/cMJoblBhKMDoXBUjD7Z5MfJHkw=
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr20460178wrw.53.1541472871067;
 Mon, 05 Nov 2018 18:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106020402.21120-2-acelan.kao@canonical.com> <733fc135-dfef-f70e-b854-3ad553c67e9b@kernel.org>
In-Reply-To: <733fc135-dfef-f70e-b854-3ad553c67e9b@kernel.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 6 Nov 2018 10:54:19 +0800
Message-ID: <CAFv23QnZcwgfKX-i-_ekB=0XbCQ5uNkdFXupNC=-DQwKJP5B9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: add quirk to not call disable function when suspending
To:     okaya@kernel.org
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right, should replace it with SK_HYNIX.
I'll prepare v2 patch for that.
Sinan Kaya <okaya@kernel.org> 於 2018年11月6日 週二 上午10:24寫道：
>
> On 11/5/2018 6:04 PM, AceLan Kao wrote:
> > +     { PCI_DEVICE(0x1c5c, 0x1527),   /* Sk Hynix */
> > +             .driver_data = NVME_QUIRK_NO_DISABLE, },
>
> Now that you added PCI_VENDOR_ID_SK_HYNIX to pci_ids.h, you
> could use PCI_VENDOR_ID_SK_HYNIX above instead of 0x1c5c.
