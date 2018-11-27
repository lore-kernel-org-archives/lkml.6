Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD9FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CB520659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=p23q.org header.i=@p23q.org header.b="Se1Lk2M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CB520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=p23q.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbeK1Edk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:33:40 -0500
Received: from mail.gnuzifer.de ([78.46.242.17]:33559 "EHLO mail.gnuzifer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Edk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:33:40 -0500
X-Greylist: delayed 2250 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 23:33:40 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=p23q.org; s=20170531;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=q3ShGQRrcLYQDw1yoaBzzaX7fDg8ziVu5hJqMtjtfPo=;
        b=Se1Lk2M3qCWMkYk1AlKWiIvvqyAe2D1Rtp09CrPlUv4Jso9yP4LAxuYHsMq9rf6GB55ybi3tvAplW9Rz5Ldy0OJnbJcz3JAxNSvccD0LJn2wOsU4Ztga3LjkEg3l09e57pgEC1EbBhTRX3Ajg4ZqDgM/zQMeLv/f9rtJivPN3tizF92rKVnR0San7mjh+yBhsq/jsurgCTsw6AO3o+tESRpq495NnpTwJO79hubWJxEcP3jfL0bdK1aYpkb2H5SsPXzkkSwQqlH0LadUSLp6Cs/88rbpsNA9m2Op62qxZ+NQ5OR982NkukmCdY89HJnafhxqZ+L4CKUUFBZESBmqWBcUhI/+WefIyJ+47JhR0V1OdFZVUTL+gmxeQ+q0iFhcwtAuaxS0RqmNbZB25uVVqlJls2lU9850OyhMDm81wDTejCIDRFlgE/sIGK2KSMbxt2+PzEWneamGYD0i+IISwFZ0uIamouRvsPJLkYSBa1fp6Hy+k5N/ZnwqoEScx3iQ3uWOgMm3az8UrrzT5OmAuwbErDBmrCRk2dTAghrsCnJwfDYRXLWGW40p/JMHP6/p6u0ujlwc35za7aq7FzQ7B/2pVmcts9nC7Vmlah/b95B2/poFTVas3xWG4x1JU4an28Lw81Yq5Upy+5uPxog0441q1u1Jk19jFv6jNUUL+6w=;
Received: from authenticated user
        by mail.gnuzifer.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <lkml@p23q.org>)
        id 1gRggX-0000HB-Iy; Tue, 27 Nov 2018 17:58:05 +0100
Date:   Tue, 27 Nov 2018 16:57:58 +0000
From:   "David R. Piegdon" <lkml@p23q.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Kay Sievers <kay@vrfy.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: [RFC PATCH 2/2] dt-bindings: allow suggesting usb bus number for usb
 platform busses
Message-ID: <20181127165758.GA13892@lagavulin.indurad.x>
References: <cover.1543332368.git.lkml@p23q.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543332368.git.lkml@p23q.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "David R. Piegdon" <lkml@p23q.org>

systemd allows use of predictable netdev names. these currently do
not work for netdevs connected to USB platform busses, as the id
of the platform bus is not necessarily consistent across kernel
versions. this patch allows setting a suggested bus id for platform
busses. in combination with a suggested systemd-patch, see
https://github.com/systemd/systemd/pull/7273 , this allows persistent
netdev names for such devices.

NOTE: this patch might change ordering of busses on devices that use
platform-busses, if aliases for these busses have already been defined!
---
 Documentation/devicetree/bindings/usb/usb-hcd.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.txt b/Documentation/devicetree/bindings/usb/usb-hcd.txt
index 50529b838c9c..79afbcf3b5de 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.txt
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.txt
@@ -2,8 +2,17 @@ Generic USB HCD (Host Controller Device) Properties
 
 Optional properties:
 - phys: a list of all USB PHYs on this HCD
+- an alias of the form "usbN" may be defined to suggest the use of
+  busnumer "N" for this platform bus.
 
 Example:
+
+	aliases {
+		usb1 = "/usb@c5000000";
+		usb2 = "/usb@c5004000";
+		usb3 = "/usb@c5008000";
+	}
+
 	&usb1 {
 		phys = <&usb2_phy1>, <&usb3_phy1>;
 	};
-- 
2.11.0
