Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1620824
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGLpA6m4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD1620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeJ3LjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:39:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61216 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeJ3LjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:39:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B7EF11B445;
        Mon, 29 Oct 2018 22:47:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:from
        :subject:cc:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3tFtdqHipzPQk2Hp6/cXOjfaO
        Fc=; b=FGLpA6m4Sll/7DjKpC09DVeHaaIbFcZ2WM09U0JwV77yAcPxyQ+luHP7W
        bW5WKcfTpdGf0FkLDiXAl+zndtWDhHIt9TeiLeXUnueaDiJFSOH8UDZuHxoZG7g1
        1CKODCMnuTHpxylWFeTyVKKm8Vz/MPZ1BsSCQVYAjojqvqmi8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:from:subject
        :cc:message-id:date:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=LkW3QB8D5MXdPUZSAWE
        lFWBxpMV0CbdnaLy8jW/SGVWUZM8idCJ2oBdv+Tq/D6/x5rF1uuhZu2mTQOqGQav
        ut3/gFfN4RwTKJydOuhCHrk1Q2SP5h86ClKz/6DUp3GODTy83yCDruRKWRCKM4g4
        nLyBl6CsA3pXhfp9hRgoi23A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93F8111B444;
        Mon, 29 Oct 2018 22:47:47 -0400 (EDT)
Received: from [192.168.1.128] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3C4E11B443;
        Mon, 29 Oct 2018 22:47:46 -0400 (EDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>
From:   Daniel Santos <daniel.santos@pobox.com>
Subject: How to implement "#interrupt-cells = <2>" for a gpiochip?
Cc:     John Crispin <blogic@openwrt.org>
Message-ID: <00e9b968-814e-d7e8-9d8e-1983090df4b0@pobox.com>
Date:   Mon, 29 Oct 2018 21:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 2EF6C6AA-DBEE-11E8-8AB9-BFB3E64BB12D-06139138!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to use a GPIO as an interrupt on an mt7620 (using OpenWRT
drivers) and I can't seem to figure out how to glue my two-celled
interrupt description (including the trigger) to the device tree code.=C2=
=A0
This is the gpio driver I'm using:=C2=A0
https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/patche=
s-4.14/0027-GPIO-MIPS-ralink-add-gpio-driver-for-ralink-SoC.patch

And this is the gpio chip in the device tree:

		gpio0: gpio@600 {
			compatible =3D "ralink,mt7620a-gpio", "ralink,rt2880-gpio";
			reg =3D <0x600 0x34>;

			resets =3D <&rstctrl 13>;
			reset-names =3D "pio";

			interrupt-parent =3D <&intc>;
			interrupts =3D <6>;

			interrupt-controller;
			#interrupt-cells =3D <2>;

			gpio-controller;
			#gpio-cells =3D <2>;

			ralink,gpio-base =3D <0>;
			ralink,num-gpios =3D <24>;
			ralink,register-map =3D [ 00 04 08 0c
						20 24 28 2c
						30 34 ];
		};


I've added the "interrupt-controller;" and "#interrupt-cells" myself.=C2=A0
This is my i2c device:

&i2c {
	status =3D "okay";

	imu: lsm6ds3@6b {
		compatible =3D "st,lsm6ds3";
		reg =3D <0x6b>;
		interrupt-parent =3D <&gpio0>;
		interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>;
	};
};


The problem is that when the driver probes and asks what the trigger for
the irq is, it returns zero instead of 2 (IRQ_TYPE_EDGE_FALLING).=C2=A0 I
presume this is because the two-celled interrupts aren't implemented by
the gpio driver?=C2=A0
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt say=
s:

A device is marked as an interrupt controller with the
"interrupt-controller"
property. This is a empty, boolean property. An additional
"#interrupt-cells"
property defines the number of cells needed to specify a single interrupt=
.

It is the responsibility of the interrupt controller's binding to define =
the
length and format of the interrupt specifier. The following two variants =
are
commonly used:
...

However, I'm having great trouble finding documentation on how to write
these bindings. Can anybody give me a pointer please?

Thanks,
Daniel
