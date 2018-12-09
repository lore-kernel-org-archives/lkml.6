Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rmd5GnSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8722220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeLIW2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:28:06 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37808 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbeLIW17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:27:59 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0AB798365A;
        Mon, 10 Dec 2018 11:27:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1544394477;
        bh=an88u2PtLlBV+ahRtZCzfPKmogU4tbRDLJ4DsaAi0rc=;
        h=From:To:Cc:Subject:Date;
        b=rmd5GnSoX8TX9QUiF75qDJ9PAmGIR9DTWCbdFV2FfXAmYzAy//Zia8x3hJ4kCMKkP
         ruyisznB+qHafrP5yfTKUpbyrOr20Qw9OVaPM0TaUMoabns3mcq8TBAN0QzO/pJaU1
         9SANyDVrJgLtT7TwPdds6T05G7sUhbT1+thO57aP19/rlENFYsVbm163RooXuf2Qp1
         iz8/ixTgwERl+5bb4a+6b9CorMba7AQql70ujaCaAfEm9M2wYA75/oC+80vG6FM4K/
         uHHLrO2NcrKTgYBD/PC497KTjfWu2XSUjVDTMvwiPXJyq0xvexbFmkHVdOKbAeVbxc
         ICgaPQNxwAufA==
Received-SPF: Fail (domain alliedtelesis.co.nz does not designate 10.32.16.33 as a permitted sender),
        client-ip=<10.32.16.33>; identity=<darwind@alliedtelesis.co.nz>; helo=<smtp>;
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c0d96ec0000>; Mon, 10 Dec 2018 11:27:56 +1300
Received: from darwind-dl.ws.atlnz.lc (darwind-dl.ws.atlnz.lc [10.33.23.22])
        by smtp (Postfix) with ESMTP id 6DD5B13EED3;
        Mon, 10 Dec 2018 11:28:02 +1300 (NZDT)
Received: by darwind-dl.ws.atlnz.lc (Postfix, from userid 1665)
        id C1D9B3409B1; Mon, 10 Dec 2018 11:27:56 +1300 (NZDT)
From:   Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     chris.packham@alliedtelesis.co.nz, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] dt-bindings: serial: 8250: Add rate limit for serial port input overruns
Date:   Mon, 10 Dec 2018 11:27:39 +1300
Message-Id: <20181209222739.15866-1-darwin.dingel@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a serial port continuously experiences input overrun from
(1) continuous receive characters from remote and or (2) hardware
issues, its interrupt handler can preempt other tasks especially
when the system is busy (ie. boot up period). This can cause other
tasks to get starved of processing time from the CPU.

When this dts binding is enabled and input overrun on the serial port
is detected, serial port receive will be throttled to give some breathing=

room for processing other tasks. Value provided will be in milliseconds.

&serial0{
=09overrun-throttle-ms =3D <500>;
};

Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
---

Notes:
=20   Changelog
=20   v1->v2:
=20   - Separated dts binding to another patch
=20  =20
=20   v2->v3:
=20   - Fixed commit message and reviewed-by fields

=20Documentation/devicetree/bindings/serial/8250.txt | 1 +
=201 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Document=
ation/devicetree/bindings/serial/8250.txt
index aeb6db4e35c3..da50321da34d 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -51,6 +51,7 @@ Optional properties:
=20- tx-threshold: Specify the TX FIFO low water indication for parts wit=
h
=20  programmable TX FIFO thresholds.
=20- resets : phandle + reset specifier pairs
+- overrun-throttle-ms : how long to pause uart rx when input overrun is =
encountered.
=20
=20Note:
=20* fsl,ns16550:
--=20
2.19.2
