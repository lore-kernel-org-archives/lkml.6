Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D010C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F5720989
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="hxCRjWfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F5720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeLJLEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:04:42 -0500
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:61255
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727263AbeLJLEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G53qNPhHOpC9W2p2iuirg6O5LMe8ADwvCBVXFmujrg=;
 b=hxCRjWfyqMX1z/lBXDnHsn6RGZCHH0NriR+UMUbWog398NF2s68pVP79y665BmqOpdzSFS3Yul/Y8o2GbNh7rWP+mawXfTLJ11ZqqAutSGOnrx02zPmxYh1nL9ZrmifrkhaQ7Tk52qCYaJTnX9mrUAXirr4yjDsyuRaioqWX6WE=
Received: from BN3PR03CA0080.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::40) by SN2PR03MB2269.namprd03.prod.outlook.com
 (2603:10b6:804:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Mon, 10 Dec
 2018 11:04:37 +0000
Received: from BL2FFO11FD011.protection.gbl (2a01:111:f400:7c09::120) by
 BN3PR03CA0080.outlook.office365.com (2a01:111:e400:7a4d::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17 via Frontend Transport; Mon, 10 Dec 2018 11:04:37 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD011.mail.protection.outlook.com (10.173.161.17) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.13
 via Frontend Transport; Mon, 10 Dec 2018 11:04:37 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wBAB4aqb020432
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Dec 2018 03:04:36 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 10 Dec 2018 06:04:36 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v4 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date:   Mon, 10 Dec 2018 13:04:25 +0200
Message-ID: <1544439865-22967-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(3190300001)(189003)(199004)(2906002)(6666004)(305945005)(356004)(50466002)(106466001)(4326008)(2870700001)(107886003)(7636002)(72206003)(478600001)(966005)(5820100001)(316002)(106002)(6306002)(54906003)(110136005)(47776003)(36756003)(5660300001)(50226002)(26005)(8676002)(77096007)(186003)(426003)(486006)(2616005)(116002)(126002)(44832011)(7696005)(23676004)(476003)(336012)(8936002)(246002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2269;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD011;1:1kgCX6KlQs8+fiJu/xSCkAenapKTYZdC+rFzOOCbsr6to6HOquWs62hpwTMDkk8gRwDH5ehgtRHOFPATYDQUTSKmHeo2vmVQldUL44OGPooCljypcuptBY3/mf7ix9N3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c3b1697-b8c1-4773-ff4a-08d65e8f464d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN2PR03MB2269;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2269;3:yQcdPOn55yNiURuEnnlbhUwK1Na/l3lhddJsKNPCntxTOOoBNI3Kko4eiiajBt8V8jSyXyzh8oIIjHkTiUTs+Fv5YH8r1D3AKk1F0mGBIPegACa/is5fbdgmYJ8Tb2CWSGfoCwdJ5XrGB4U2oKOci+0mzwn26khWWKmf5sKKPpVgj8JFa5xARNbsBI/T5C2Vu5021F7oOiH4NqwNU1nzru1VgUJquxZhZHjHsgQr04bhRi7BcCv2Ilt/rfbsV2Ih65b4vEg3krzyYDqzap/Q03ChG5eIzSN6byiWCY8GJ9w/28KaAQP5vylpDbuCV0SGClH9IHzR2beBMXR668FZV067et1INLzJNIDWPP9vRYk=;25:/NN+Yj+oY4NiXAj1txVKbchqBl/epdzylmQqQMMO0B00vc1WG7M18wXd40iGLV1v+3EQ6lM0p9iIvd8/YJxeg+GKkQMWhZwkEYOwdW6ZjVqISt+nW/42QzAUOW0FQzoq7QAiVyP6XJD9gxe+Vollt3KbprABGDAKcFOt5KKuo3AtpcIEZDy08u65WzVmBqVRyQ4i3nzNpqy734j0glB0HSxn84+geTn0DzgbF8XcvZ8U0s0qRfYNwJjZH8mS1LUh6xfM6W6sFr8qIS6T9OKvkvLXFTzjcwhQ9/6oliVD4ewmBUyMyTUSHWVJkNNy5yWiZyyumu6WukhXFjP2yc4zFg==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2269:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2269;31:G0VLd+k0dazQqSByvxcRnW+nYOdKGf7ru8P2UPWascIzvRU9nH6BzfPv/xc+J65iqJY+pJ5BXMk5sq3cOweZ2aO50CW9HcOJTFc8VT6R7je450p6d3mOSSwsPSBuB/A60zi2yU6bRP9FDlPwBXxS/duOILqpleJSgsl9m/Qnu8C1xeMNe7BYNHjixtQ/YUXSibLdMVjiqhJ4yMHvJ+VeiETTLeCoJBJ0EnwaDSkSHAM=;20:KzT3n5PzeYcWxQK/yztrfkOOmrBSFSxMJwHt+/6NdUa6RypwKKKPaQ4q4hc55Ni0jJhDMI8C18bzBjrRt6RPOtlEO699cGLHDS9o2CUVGcBHUch631R8wOhvJH/lfRN2XM6p7pVG1uaalZxw4ifDBKLflss93i6JTAtzFEt20fNmqhDZa5FTYSDdqsBRIwk3C4OuNySIHdK64adrZHHpSy45SRy1BTbzdkmDVbPdxwaxM+cHU/ox+KG3Ppeb6rpOpyf9IirR+tEJ4oxN/nDpp0i4KXqS/GJJ9SmNm2jmEFns3/jz3izjf7n+42+hpfNwd5mznx8cYOLNFxBNPqnmEn7PwwbmRUKgkuHWBs6QBGpHPFllL9frt58ZSaU0JimyV1CIUYUNL1r5XdMTNosqAMJoozYJXGekh9/0JUTMQ0sEK2CZw1XNX1uNUkCjFaUtaLfAWKe3LmCNRrCP/mr6/7QqAWeqt0zgMs2YMHkyhU90stOcf9P21vWdzQ1kXYBA
X-Microsoft-Antispam-PRVS: <SN2PR03MB22697CB219BB5855FA6981999DA50@SN2PR03MB2269.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(4982022)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2269;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2269;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2269;4:ns4s4JMM3U4Bx4yihaG2YEQFwmAmD8y8NYCd4LnSrihWZeFRYf1cx9TzIQEBh8TGu8d20/atYZ/49CAjiJzNbZ5/0fStLbrMsreDIl6oaR+gGrBxBcK3mV6WwWR3Y6wWPrYVhVMv3WWAvjLUhgRthMZgMWnH76rO/P4m25fuSc4l9IcN1S99ZFG7b0pK19mfoZ5mVvpwMtuH0mIYFjTwV92TaqOyXpyCHViFLgZwgaWwVxNm0UYFzP9kbRY05LMQrDyO/Ux9sy2Nv2WSEiTJTg==
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjJQUjAzTUIyMjY5OzIzOlIveW15d3FValZKb1FxeHEvRjJmZzN4NU5l?=
 =?utf-8?B?UkhROUtCSktMTEJOUzRPM09TcmhVbTJWaloxTlllREY4RzVTQ1hOUU5vaUQw?=
 =?utf-8?B?U1JEVmpLblR3REQzQ1hORXlFSm5pb1dVdHhkZExVSGFvSGNyVkJWZ0VnZVJh?=
 =?utf-8?B?am80WC9YUG1DalRxOGdYRndSL0llQkRTRkpvSGRsY2dNRXlHNWVIOUhlMENm?=
 =?utf-8?B?clJJMFNSZVdCMFZTYlY4OTlUM3RtV2svQXZYTzAxTFMyazBEOXlYbFpDUnlz?=
 =?utf-8?B?RkRTQmEzQkJVNGpNY2xPQkxReWV1dkdONFpKcnc2SEE4a3BOVG1KWVhUNWs4?=
 =?utf-8?B?Nks4TUNCc21ydjN0eFFWTmdITmt4ZnpZdS9DVmhpNC91NU8yTmE1K2ZBVHpW?=
 =?utf-8?B?Zmw2VXA0WTV4UXNoQzgrYzVlQlNUMjgxc1gzQU4rQkJWTkxidEgwRTJFN3lN?=
 =?utf-8?B?Q29CV2pjQXJFKzZDbTV2V2VRUE9wbnhlcXIxWGcvVytlVlNrYmQ2K1dWQjRl?=
 =?utf-8?B?dm1wRnNTcFB3Q001TWlXaWtmSkhmQmg3czJKU0x4QVFiL3RSaXpqVmNlUlhM?=
 =?utf-8?B?MFV2Ym1CWndtblBhTEZFaUxaZ1BBWDV3Q3FwZUVQWDVlWUlSRUh1cEhUM250?=
 =?utf-8?B?RjdQSTkvTHFleTJIWVRVTE83cGc5LzAxcGNsd1lxOHVBK2haekRVR2VFamQ2?=
 =?utf-8?B?SUwyRFEvQlFSeE9zZ3hnNjNUY1pZeVBVei94bG9nZjNZQXM0V05HbXJjeXpW?=
 =?utf-8?B?TzM5VUtWTXYzVUh3THNZWHpQeldNVEprajZMU1YyS0dvV1FucmI0T0J3d2FV?=
 =?utf-8?B?VDBNTUlZMWZuRm43YUQ3N0hJSXdJQlRYa1FoMjBqV3J1N0UrbTVXUDgvcytW?=
 =?utf-8?B?aExzdDhRbVVEd09ZZGNGRDY3ZTRnVGVNL0FiN1FhZm5BYmozcUJCeFRHUlVI?=
 =?utf-8?B?cTJ2bHhwY0N4bTk1YUd3V0JOempnZkcxaHJ0cVRhKzNMWTJFVEw4c3RETHgv?=
 =?utf-8?B?c2lCeDBXQUpkU0tvSzhNYmVUdThUUHNPTmt5WFM3K2FiaWRLRjJpaEVQRyt4?=
 =?utf-8?B?ZXVaQXZESlBmUGxHK1Q5V2pTZlYvd0VBZUViYXIrTXUyMFhrRElvZmJPenM2?=
 =?utf-8?B?Q2t0bGx1em9mQmlnVEtrNldnZ0tzSW56VTk4R1VhbmM3K1VjM0VjQXNpVVN2?=
 =?utf-8?B?aWxyMEpPSFZCNlE3a0hPWWU0OC9oQXZsN2FSbFJDUmNMWEl0T2s2cS80Y2di?=
 =?utf-8?B?ckpMamo0ZFZCRmZJdGZET293L0lrQmI4empERGJWajlCdlc3cldpc2VocjRq?=
 =?utf-8?B?b0N6ZGIrbFd6eURXOEJkeUpMZ28rOU5lU2t5Z2NuUit5a2xLdTNrdkVaSjcr?=
 =?utf-8?B?VEVQejJoOEdsS0IyZHhpU3BOQXh6WTlnRXNWL2ZZZTA5aFJqRHpWdm1hK2U5?=
 =?utf-8?B?SkxUZ2IyV3pUcCtIYXVOYTY0VWR3RHh1bi9QdFFobWI5amRZdklOSXhqdm9T?=
 =?utf-8?B?M0w3dz09?=
X-Microsoft-Antispam-Message-Info: 43x7BESoN9g3KI5Fl4Prdq1mJAw9IufFNEaq+RehNePOsAWw1/plADkaz21kK8mFFJC/0hu/aybdg3JXIapQARra6ss8CM3f1dRbH1pXp8tPRItCpfDSUGpmqrBojDQc6QEwiObZBJ4Uitw+LMMpkibWCq85sYbCudMbslPCbRmmiACT3QqPeDPyW/UhB89R4cx9LxkLVs3FgsZ4NUOcej8Epi6GtMO+fT0CO9K+M5KAEJMS5Lp6e+/veQFeZldrCyGCHK9lLU3ZPOrVWhFzQVA/A55J0gXbT/fHGWI/VLbY+zIpKtjb0166kHJP682g
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2269;6:Dwjg4pqG9hfmB9QUl7wZdMf2ZNrTGe+v27uaHjLzSa8drvxn1tvnxyjd5mmpflAlMgqAHPq0iCL2miTUvbJ5HEVJznJ1YEAzXxCcWHwRmVGRPivn+NmMd/VHdQGvLu+EluTIWNv8h84fb0jHTOFTMZ6YVlhWv8Zw2WZI4NWZrgwFlwNzfQuJgDxKifMT/ti+YN2JElM0BckrUbBtRLd4nY+MedWR8CBTBVtX0HJxfvqdLH0UADawICm2/nSuV9KUgaMVUUwWSA2xNTohuwgmUP9QTqeZ34ApgX6cXlHcTptQPN8IQD8DxBkO8IzzVmtOacal8/2gckwWvjJKUg+2uZQzXpxBcobSbQocnABD3ZTUW4Y1HosH3Y4JHk8cDwYwHmnrcgdMwb4U4E+pcCmd5ZBvVmAkjdGShKsZhcJyuKbxC1KoN5kd37noSAkGz/Gto9iTO2QSiKfxEGHqauGDMw==;5:KlpxPxU+jSgWZgCno0+WnHVM6v3cmKgAKju5xkfHtyevHe7bs5mN5IWDweP6n6bT3bFsqZmK5c+v2bIHGw5eOYpzz5uQTbJc+WZXn77WRnNZexlHxsg6R0ZoRXu4cMa/ueRuocGvTAeUwMqfgP9fN8vnnS8bXY3R12M0CbmFI4I=;7:3N0zRaIL470gjnoyYieQg8N5V3eSblIa+AuZ1vXyqZ2a1M4YOc+hNPQZCX+1+wiQPrPRDoiMspBTcf/DhJJ/XKnskkEuBS3HtytDZdczMIs06OXMYVh0semOwdRXDznzzLGQM+7ALePRVsvN6r8/bg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 11:04:37.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3b1697-b8c1-4773-ff4a-08d65e8f464d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7606 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- fixed indentation issues.
	- used gpios instead of gpio.
	- added vendor prefix for conversion-start-gpios, first-data-gpios,
	and range-gpios.
Changes in v3:
	- Added adi,oversampling-ratio-gpios.
Changes in v4:
	- Specified if the gpios are active high or low and set the flag
	appropriately.

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
new file mode 100644
index 0000000..d7b6241
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -0,0 +1,65 @@
+Analog Devices AD7606 Simultaneous Sampling ADC
+
+Required properties for the AD7606:
+
+- compatible: Must be one of
+	* "adi,ad7605-4"
+	* "adi,ad7606-8"
+	* "adi,ad7606-6"
+	* "adi,ad7606-4"
+- reg: SPI chip select number for the device
+- spi-max-frequency: Max SPI frequency to use
+	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
+- avcc-supply: phandle to the Avcc power supply
+- interrupts: IRQ line for the ADC
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+- adi,conversion-start-gpios: must be the device tree identifier of the CONVST pin.
+		  This logic input is used to initiate conversions on the analog
+		  input channels. As the line is active high, it should be marked
+		  GPIO_ACTIVE_HIGH.
+
+Optional properties:
+
+- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
+	       it will be asserted during driver probe. As the line is active high,
+	       it should be marked GPIO_ACTIVE_HIGH.
+- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
+		to place the AD7606 into one of two power-down modes, Standby mode or
+		Shutdown mode. As the line is active low, it should be marked
+		GPIO_ACTIVE_LOW.
+- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
+		    The FRSTDATA output indicates when the first channel, V1, is
+		    being read back on either the parallel, byte or serial interface.
+		    As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
+- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
+	      this pin determines the input range of the analog input channels. If
+	      this pin is tied to a logic high, the analog input range is ±10V for
+	      all channels. If this pin is tied to a logic low, the analog input range
+	      is ±5V for all channels. As the line is active high, it should be marked
+	      GPIO_ACTIVE_HIGH.
+- adi,oversampling-ratio-gpios: must be the device tree identifier of the over-sampling
+				mode pins. As the line is active high, it should be marked
+				GPIO_ACTIVE_HIGH.
+
+Example:
+
+	adc@0 {
+		compatible = "adi,ad7606-8";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+
+		avcc-supply = <&adc_vref>;
+
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio>;
+
+		adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+		adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+		adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
+						&gpio 23 GPIO_ACTIVE_HIGH
+						&gpio 26 GPIO_ACTIVE_HIGH>;
+		standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 843545d..6d63db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

