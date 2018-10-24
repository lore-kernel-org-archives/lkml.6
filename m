Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A463EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5938420831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBMS4ilO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5938420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeJYBle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:41:34 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34768 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYBle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:41:34 -0400
Received: by mail-lf1-f54.google.com with SMTP id n26-v6so4588378lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7yUY77C0jAs4L9+3hSK/VTgERS3wvUpIXuNI8wU/t6A=;
        b=SBMS4ilOuNhJv9zkuMa9XS0Vl1qpMnY3U6zrJl96Kzymick6v1C/z7l2WPc2P/qQnA
         Oc6g3gRdwtCMpA3dw7bCRr7zX25t/tXXr1i1YabuWLzX/WTBARVNfDt1Fo8ibXR/0YNK
         yyzc6so+ofBRSnotl2Nahllj0TVh9I8nPB8H0+GpsdOFyU/PAutNta1jgMBlSCfb5TB9
         GYbivY4wI9DLG16b7CXi4PiPKRZF/ILk+hEaCnp/6bY3kwR4+n6ThmG6/UblzxPQwww2
         CkkB/1VRrVT4YugbFxqdj7zhSx3F6OpoVYiZVNvB893moldVjgo6X4mlbwhJgml2Ti99
         XREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=7yUY77C0jAs4L9+3hSK/VTgERS3wvUpIXuNI8wU/t6A=;
        b=eQIUfc3ZJJGhVAJZRDUjuT0ML5L/CCsjEU5wCuqaXRcIyqea6/Levpizn04c53t6Sf
         7vc2z9kFi/HOU90KymqoiuqX+jmM3iMsfvxeo9mX3uuIBVDb6AJ7rD7ErQ1NpzQkZMci
         p5FoEFxaIhHWZuLYgqMxKSkjx+58GRazKopbUg2SVyJKoaNbQqC8C9IHGTfYTOxV480r
         lJOC/zCrspcZMatSj4jDuoetlBRLINEz/0oW3ixKOnX2LFNBoo4V+SgnAcDifY+wvvUH
         duLO1elMS7TIqVuIqKgL5V71ztw1pMmboKlWXddG7jb+n9C78hGAPMt8w9wdaF1NV7QM
         gQqw==
X-Gm-Message-State: ABuFfog7J9U97s5EoswUgOJLIn3hV8QEvxubOWz2kM+oEEl9Y1OjudrN
        /50m3fHSnj46p5F9wbowEJRumuJH
X-Google-Smtp-Source: ACcGV60jP4fvtbS/0u3zgovawHNTIa1rFC2ca9p1bkw7u3OXyEfxRz1W4birh0C/vlU0IK/VCX58Sg==
X-Received: by 2002:a19:7112:: with SMTP id m18-v6mr15509626lfc.64.1540401160878;
        Wed, 24 Oct 2018 10:12:40 -0700 (PDT)
Received: from [192.168.1.158] ([77.47.204.16])
        by smtp.gmail.com with ESMTPSA id h203-v6sm808547lfg.7.2018.10.24.10.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 10:12:40 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   vladislav <vlad.dalechin@gmail.com>
Subject: i2c_hid module bug
Message-ID: <e643a163-d5f8-5ca0-c9ba-c6099e35838a@gmail.com>
Date:   Wed, 24 Oct 2018 20:12:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I've catched a bug in Asus FX553VD laptop.

I am really sorry for sending this message to you, but i can't find 
maintainers of this module.

I have ELAN1200 Touchpad, and it's not well managed with hid_multitouch 
module.

So, here are the bugs:

     - Touchpad freezes randomly, which means it dies.

     - When you use two-finger scroll and stop scrolling, module thinks 
that you are still in a scrolling mode. Even if you stop scrolling at 
all and move your fingers away, and try to point mouse anywhere, it 
still thinks that you are in a scrolling mode.

     - Five finger tap kills module. We call it "five finger tap freeze".

     - journalctl is being spammed with i2c_hid errors (3 times per 
second), and it actually influencing on battery life. The message being 
spammed is:

i2c_hid i2c-ELAN1200:00: i2c_hid_get_input: incomplete report (16/65535)

Here's link to bugzilla thread 
https://bugzilla.redhat.com/show_bug.cgi?id=1543769

Hope you will find out where the bug is.

Sincerely, Vladislav.

