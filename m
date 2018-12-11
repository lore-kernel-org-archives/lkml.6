Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDEC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DC20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544565626;
	bh=x3qB1vAd4Chp0p+bPPRtDoufq4L5WgbC8McB13MZ/JE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IEJgdA1Ye6CyakLVdG9ZQaTjkiOZMP2desZKpBV7UnfBZujXchNcviWR238hZAsfw
	 CdYluKnDGofG3boG22nMUn1oUjMZKyTLH2Nn8HsBMA0XAPCrC/VuD/+Ew8Fy+FxpOv
	 AJMWnBkIiDkxnbDiNoApWpDxcek3KiKkfWhjqbd0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0DC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLKWAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLKWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:00:24 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D19F20672;
        Tue, 11 Dec 2018 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544565623;
        bh=x3qB1vAd4Chp0p+bPPRtDoufq4L5WgbC8McB13MZ/JE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LaiRSY7d3uypMCPJNPF/wsLAoliRO4dUWcjGa0oUW90TDGedGiFRFHgSurQ9O4wwl
         7q72ArHPfOEBlIPaza171JzsxO6uL55h8igP0mf5q3FBx6gYy5iZ79H2mjfJ2h/fF3
         9X2svRJaOBYiVXIBCp9TwRzUBZG+jLslIk6OmnCs=
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181208214644.5374-1-okaya@kernel.org>
 <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
 <4aa65942-bf97-c957-7f77-38bfdf7d1d3a@kernel.org>
 <CAJZ5v0gsq4-pzMrqrKuiUysXbnjc5AfVnY3=2OxQRZPsma=ZMA@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <620b7955-de9c-a273-bf1c-5521834e16a6@kernel.org>
Date:   Tue, 11 Dec 2018 17:00:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gsq4-pzMrqrKuiUysXbnjc5AfVnY3=2OxQRZPsma=ZMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 4:49 PM, Rafael J. Wysocki wrote:
>> I struggled between break and return. Existing code seems to return on failure
>> when bus0 is NULL. I assumed it would be more logical to return as someone could
>> put some code after here that assumes everything is in order.
> Well, there's no such code ATM, so there's no practical difference
> between the two and you don't really need the #else branch at all, do
> you?
> 

OK. I'll go with break.
