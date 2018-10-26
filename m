Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453DECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ED3207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="W+mlhna5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ED3207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeJ0E6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:58:55 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:34512 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJ0E6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:58:55 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Oct 2018 00:58:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540585228;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Cc:Message-Id:Date:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Zbz8mYIUZx3lzdjEJRHXLvFJO4WJ+IW7WstDz6YMsdM=;
        b=W+mlhna5JDh7aEwh7pz+liDMZ2eukuZaEEVB1j0U/9Zd4yj2ge/wnaH0ZVYVYlzG/G
        hy+cMBoVA/kOa2wOwNDS49BpU5PEnauUM7jLYLbGARLk4wGKNibfVjstS1Y8rwOvqC70
        o1bNVkBJghmQPhc7GjvpMY0hq6Xc+tzJ8bVMN/IS92R+i3ejWfn8eBOO3OVNvICdJQAy
        MStPvJK4d4DYxD5ljQ4YNxZtgvnJ19+bc8jVfo/2NrkXtibezJ1uvBu6cBBV3qPZUrQe
        4n/nFCY9jLAO2DMwYtMC9cmSzQ0BEOiduFXTS4aLTBm/TlHekX1BlYwoBEQZD5WJiwrX
        xkqA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PvwDOtBEA="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.3 DYNA|AUTH)
        with ESMTPSA id J0aaadu9QKEDtFl
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 26 Oct 2018 22:14:13 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: bluetooth serdev driver for wi2wi w2cbw003?
Date:   Fri, 26 Oct 2018 22:14:13 +0200
Message-Id: <A82238EF-4EAE-4B6D-94A7-A098622B57E5@goldelico.com>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
what is the best strategy to support the above mentioned
bluetooth (+ wlan combo) chip by a serdev driver?

We have the chip up and running for long time with using
hciattach on the serial port (and no vendor specific
functions like firmware download). And our own out-of-tree
driver to control the power on/off.

But we now want to be able to use hcicontrol hci0 up/down
to control a regulator like the hci_ll.c driver is doing
with a gpio.

Which means we would like to use this DT:

&uart1 {
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&uart1_pins>;

	bluetooth: bluetooth {
		compatible =3D "wi2wi,w2cbw003-bt";
		vdd-supply =3D <&vaux4>;
	};
};

Does such a driver already exist so that we just have to add
.compatible =3D "wi2wi,w2cbw003-bt" or should we start to
make one based on by hci_ll.c by removing firmware download
and special ti protocol handling?

Other maybe relevant information from the w2cbw003 data sheet:
- Bluetooth technology based on CSR BC04-ROM
- Data rate up to 3 Mbps for Bluetooth EDR
- It uses a standard HCI interface =E2=80=93 any commercial stack or =
profile supporting the standard interface will work with W2CBW003.

Any directions are welcome.

BR and thanks,
Nikolaus

