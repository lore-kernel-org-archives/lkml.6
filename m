Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CCB20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CCB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeK3IFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:05:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40501 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeK3IFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:05:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so3115669oth.7;
        Thu, 29 Nov 2018 12:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIfkGqZ7BKpNas6DkOSB390sCeyboYqmwC5zJEylEPM=;
        b=LlDxRykCjqGOHyRVyB/KJOOUD6vYa5IiOXIaoBfAogIV7nBtjym9mcvoKwqWbazXl7
         PVyp3sBE/ntN2NEnIYgMPS6Y0TkiO6quMNLJrOMKZ7ZEaanBTR1z3OE0918srnZlmSQ8
         8uG6rOb8nmR4C2Z4OMyoogfFXt2FL2T8zacNfWqrxrWac/inZJKaHweZ5K6vmS1He9Sy
         gToQJS8GntPRtQMuNL5CaZMNmrB5FordVxnQIw6Of25FIEIJ82Q7e5qdy1OZQCHvuFSU
         EQ4USi0F/ImIC6yNbYD7q4dzfqE/Lu7NJRnZPCkA3PjwVVW8Tu04eGWevJ8chmtO+eJw
         53mg==
X-Gm-Message-State: AA+aEWaTrPmBChx0i1SJLRWnbk0KiyDbHVbQR8KseE7tDM1LpooI0BFH
        NQ+EU2IyLEAIRFnGrELjN71T6qoaGUbhnvP+uoY=
X-Google-Smtp-Source: AFSGD/WgSbZB1qCsB3A/mCv7hF02JDNnzU5njkCUtbEetKICb58Uow7amLvFhvB2Xhg9vLTUtnp9foZYbcXTPU8Yxuk=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr1969788otg.139.1543525143034;
 Thu, 29 Nov 2018 12:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com> <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Nov 2018 21:58:51 +0100
Message-ID: <CAJZ5v0gCyvS+VkGadYBSy34AzAQ4-20Rjeigc3eV7GZ1x79cfQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] ACPI / scan: Create platform device for INT3515
 ACPI nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        jic23@kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The ACPI device with INT3515 _HID is representing a complex USB PD
> hardware infrastructure which includes several I2C slave ICs.
>
> We add an ID to the I2C multi instantiate list to enumerate
> all I2C slaves correctly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that you will route the whole series through the
platform/x86 drivers tree.
