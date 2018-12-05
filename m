Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PXKPTWBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB2320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeLEAvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:51:09 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58685 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLEAvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:51:09 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9D724806AC;
        Wed,  5 Dec 2018 13:51:06 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1543971066;
        bh=t9lXcbMsUeis+vIfqG4BB6lnrtkDV5lgIqqre7ehy+E=;
        h=From:To:Cc:Subject:Date;
        b=PXKPTWBGCdIdpro8oKomLsuXEtOe0OGBE+sNBwxujb3DkMU2I+w6+k0s9h7aP1uN3
         Gtq/TmgTNLUgaz28baWpyYFn1Q3krvRVZ+eJAzFmD0Z8vdUnDO9MPs1sx2VouuWr5+
         DgHanSzZeS79kc25HjClr/0C2HgnuHcKf+lffPHArpAwDZCjL/RkqOuR8rfWwCN0qb
         qHz2hEyL1kDxBQUqIAoz4X4Y5G/ZqoWwGbKF6iAsJX8830PQYCSjaXhl9TBpNpf8cu
         rNGqya2Hk12MhOH1IrZWFP7OeadE608a/5d4ny/rpSu7x3ZgT27idiL6bJ4lpDJVcl
         FUf0VYfOtkqiQ==
Received-SPF: Fail (domain alliedtelesis.co.nz does not designate 10.32.16.33 as a permitted sender),
        client-ip=<10.32.16.33>; identity=<darwind@alliedtelesis.co.nz>; helo=<smtp>;
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c0720fa0000>; Wed, 05 Dec 2018 13:51:06 +1300
Received: from darwind-dl.ws.atlnz.lc (darwind-dl.ws.atlnz.lc [10.33.23.22])
        by smtp (Postfix) with ESMTP id F3CD813EF01;
        Wed,  5 Dec 2018 13:51:11 +1300 (NZDT)
Received: by darwind-dl.ws.atlnz.lc (Postfix, from userid 1665)
        id 629C43422D0; Wed,  5 Dec 2018 13:51:06 +1300 (NZDT)
From:   Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] serial: 8250: Add dts binding to rate limit serial port during overruns
Date:   Wed,  5 Dec 2018 13:50:57 +1300
Message-Id: <20181205005058.14095-1-darwin.dingel@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this dts binding is enabled and input overrun on the serial port is
detected, serial port receive will be throttled to give some breathing ro=
om
for processing other tasks. This is particularly useful to avoid situatio=
ns
where serial port HW malfunctions triggering input overruns and then othe=
r
processes get starved of processing time. Value provided will be in
milliseconds.

&serial0{
=09overrun-throttle-ms =3D <500>;
};

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
---
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

changes in v2:
- separated dts binding to another patch
