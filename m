Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48B21756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED48B21756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeHMPTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:19:36 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:52626 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbeHMPTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:19:36 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w7DCa1iG010017;
        Mon, 13 Aug 2018 13:36:01 +0100
Date:   Mon, 13 Aug 2018 13:36:00 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc:     Jian-Hong Pan <starnight@g.ncu.edu.tw>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?UTF-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Konstantin =?UTF-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        Michal =?UTF-8?B?S3ViZcSNZWs=?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Message-ID: <20180813133600.180abc03@alans-desktop>
In-Reply-To: <11276f7d-0175-05e9-a9bd-c72868067081@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
        <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
        <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
        <20180808213640.10a1d76f@alans-desktop>
        <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
        <20180809125939.39ac2cc9@alans-desktop>
        <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
        <20180810165711.59bf26f7@alans-desktop>
        <CAC=mGzhaLiSj5-+euM-YTRLwNDi8QJY0fAbiZbUadkPhZGRh_Q@mail.gmail.com>
        <11276f7d-0175-05e9-a9bd-c72868067081@suse.de>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The simple answer is that, inspired by CAN, it uses an ifindex to select
> the interface the user asked to use. That then also answers Alan's next
> question: This ifindex determines which interface it goes out to.
> 
> sockaddr_lora was in patch 02/15, latest code here:
> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/include/uapi/linux/lora.h?h=lora-next

And any loopback just becomes an ifindex, likewise any virtual lorawan
device (eg when testing in a cloud or simulating radio properties).

> I still think the user will need to explicitly say which interface they
> want to bind their socket to. AFAIU the device EUI is more comparable to

It does make it very hard for any vaguely complex environment because if
for example you have two interfaces enumerated via USB they will appear
in random order each boot.

CANbus is a bit of a mess in this sense but it's so statically configured
and embedded into industrial devices it's less of a problem.

I just wonder if the name would be a better binding (so you can sort the
order out), or a local physical identifier of some kind so that your
enumeration is consistent.

> Loopback mode would require a separate virtual device driver such as
> fakelr or vlora.

And a tunnel device, which is easy enough if you've got tap support or
similar.

Alan
