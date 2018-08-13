Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDDEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEE421798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MD7T8Mkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEE421798
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeHMVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:12:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45113 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:12:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so15051282wrv.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Jj7TWu+ur3hZSp4uZCj96BbjM7riG4FoxlOnloCMLqU=;
        b=MD7T8Mkmo6CEM6VLAejQAhA6N2+0ArP0B/Ht6GJLzoZfcy0vYaNVP4l4dCFIdCec1C
         CoE+0HZ6e7j49nFSCO8+UJae0yFuVTWU5l4SqIwvg0cD+VLxcBsapWJIB9vsO+CeACgA
         izQv1OXJiDJYEqs95wgzPcu77Z0yqPxI62Uw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Jj7TWu+ur3hZSp4uZCj96BbjM7riG4FoxlOnloCMLqU=;
        b=JkfXBcXRM2t1JBZMPKBz5nACJ+pg13xj1bDUcmMuqQHUw/0QBWMb4/q9br8OvtDgTp
         JrLkNx1NUT5va1WV7+nDHPZYtj5so+5pQlqYv8JNuBLA8ZGOdVdxOUyvNstGF2JlS42x
         cnXz8dsiw4nYnpFI1cLspuUc3QyW1XNPW9COA2ucx/BAZwfscbRkXEN7kMDf5gdJ/leb
         h2TBxjZJT8AgT19tvV7su7CRazW44fOCrNYsWRhVyDchPYkON3cWC0sGa3QShEw/Rzcg
         8d51O02lcdPx1d9fA+qXGtkGVKGO3x86dP5xR7NKcAfPKlgf0zYtqboX3Ctk+tPq41JG
         5HAQ==
X-Gm-Message-State: AOUpUlEJbIjR44FwwN2ImxUfFAmHeTTHAyPd84OQeRY9fRaOdgYPRnj6
        0BctqgRcAJHogynyNXCAZpZaA8iy54N5HA==
X-Google-Smtp-Source: AA+uWPxTFAha8gAw4bYIVh9stiiuGGZTbmEfh40tpeWeZTlpg4or4VT5fv3MkwEYWWEQMJp/En/Mog==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr11817149wrb.127.1534184956787;
        Mon, 13 Aug 2018 11:29:16 -0700 (PDT)
Received: from [10.177.251.3] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id j133-v6sm23214559wmd.12.2018.08.13.11.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 11:29:16 -0700 (PDT)
Subject: Re: [PATCH] ath10k: retrieve MAC address from firmware if provided
To:     Brian Norris <briannorris@chromium.org>
References: <20180810233948.144792-1-briannorris@chromium.org>
 <5B6F2A47.7070502@broadcom.com>
 <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, govinds@codeaurora.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B71CDFB.60408@broadcom.com>
Date:   Mon, 13 Aug 2018 20:29:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXOeybJAsWJtVBdLdQ=6xThJja5MaEoa3dERKZ-shkbDkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2018 7:14 PM, Brian Norris wrote:
> On Sat, Aug 11, 2018 at 11:26 AM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On 8/11/2018 1:39 AM, Brian Norris wrote:
>>> Devices may provide their own MAC address via system firmware (e.g.,
>>
>> You got me confused by using just "firmware" in the subject.
>
> Yeah...I started by writing this patch with device tree specifically
> (of_get_mac_address()), and then later found that there were generic
> "device" helpers for this, which can assist with other sorts of
> firmware nodes. It was easier to put a name on a device tree patch
> than on a "device" patch. I suppose "system firmware" might be a
> better description?
>
>>> device tree), especially in the case where the device doesn't have a
>>> useful EEPROM on which to store its MAC address (e.g., for integrated
>>> Wifi).
>>>
>>> Use the generic device helper to retrieve the MAC address, and (if
>>> present) honor it above the MAC address advertised by the card.
>>
>> But this put me back on track ;-)
>
> Let me know if you have a better way to clarify. I can resend with a
> slightly modified subject (s/firmware/system firmware/), or let Kalle
> do it, if that's the only thing to change.

"system firmware" substitution works for me.

Regards,
Arend

