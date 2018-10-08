Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF22204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c4yLI8Q/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="kApqr/4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF22204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJIE67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:58:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46130 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725749AbeJIE66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:58:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98Lhx1G023948;
        Mon, 8 Oct 2018 14:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VIa5ZCCpKwnF7b/XcmwUkEonjuplMQNyObj/TTGUIH0=;
 b=c4yLI8Q/0ndR6L8IQoZ/BVkpG7cJFT3d0qS2ij5dQEge3f9O+Q6loUTd8hHFrHL1z8nX
 yGh+WTtZ+tE9U9tgCFCEDJIP3RTOduOCsGJEGLmE+ksEHmRDe12JRTxoEC7VlHJUrj+t
 Aw+3PcBO4tbUW8PXDIQlU4vLzoRK/OnYYr/KIuYBHfzH6H+RipdySObBchQkz79hUfzj
 xC2nxLw3hEneBq533ePz3b7z/EmXWF/Bv/itR89x51G1cb546uAxVurOubBJKZZTdAby
 eZMneCYkdT6G/J3CJeMhF2Vw3IFzCWX+QDYrfJHSTbaNBqp9yNq3SFYO9LIR7LATMIsP Bw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0016.outbound.protection.outlook.com [216.32.181.16])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mxtts2y3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIa5ZCCpKwnF7b/XcmwUkEonjuplMQNyObj/TTGUIH0=;
 b=kApqr/4IMa7sLFTVxDFHMstOL8wasqdf3kKaDRg5MPk59Px6eZObGrkxvdUMfUEhfwQtQtrsAmsphmJJYXRz4R0390BLseSEExe+vKdhlMRA8iU3Q4dxYKT7eXQS725kCtlP9mEpBCaEHPAnDLsY/oqAIdq6IYZs5K9wQ4/QZlY=
Received: from CY1PR07CA0018.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::28) by BN7PR07MB4402.namprd07.prod.outlook.com
 (2603:10b6:406:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Mon, 8 Oct
 2018 21:44:27 +0000
Received: from BY2NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by CY1PR07CA0018.outlook.office365.com
 (2a01:111:e400:c60a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.23 via Frontend
 Transport; Mon, 8 Oct 2018 21:44:26 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT016.mail.protection.outlook.com (10.152.100.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Mon, 8 Oct 2018 21:44:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w98LiOlu003563
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 8 Oct 2018 14:44:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 8 Oct 2018 23:44:30 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 8 Oct 2018 23:44:30 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w98LiNIW015130;
        Mon, 8 Oct 2018 22:44:23 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w98LiNW4015129;
        Mon, 8 Oct 2018 22:44:23 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>,
        "Piotr Sroka" <piotrs@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <rafalc@cadence.com>, <quentin.schulz@bootlin.com>,
        <jbergsagel@ti.com>
Subject: [PATCH v6 6/6] drm/bridge: add PHY initialization in mhdp8546 driver.
Date:   Mon, 8 Oct 2018 22:42:12 +0100
Message-ID: <1539034953-11274-7-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1539034953-11274-1-git-send-email-dkos@cadence.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(36092001)(189003)(48376002)(14444005)(316002)(42186006)(50466002)(36756003)(7416002)(486006)(4326008)(6666003)(246002)(11346002)(8676002)(2616005)(47776003)(7636002)(478600001)(26826003)(106466001)(76176011)(51416003)(186003)(336012)(86362001)(426003)(446003)(50226002)(8936002)(26005)(305945005)(2906002)(126002)(356003)(87636003)(5660300001)(16586007)(105596002)(54906003)(110136005)(2201001)(476003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4402;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT016;1:LY80JDMPq+8LGcp49x/pbHz7pFVd8Ay5xlApEzz/JOUg58zdoISYygrcfdVAhI783S+JUAKfhEBo0nWf5EYLXP7ELH0mxcMdffQIAeWDC98RouUu9molTKbOOAndwhtT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af71a06-3b7e-4a67-45e0-08d62d67381c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN7PR07MB4402;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4402;3:q9zdmq+h43gXKWZBE1N+R9SCodS6QDA8/EwsTGqnoU3N8CY8NHD0c+SjnSl1wfEydOuJ8z9dZIrutFrgZKE9sXabv67im7qj+9P0LMgeao45W7lzBoxVpvXwvqgrb0qDacl7bjiQTQMB43w/ICU5fwWQKnqJQABS3fag06H8AVxTmBOth2R6anubn/5yxYAcdopXGIDLpaa/JBvBCcN8606WZS6SDEmozfexKizM5NjHb5PvzkvZQyPDnehFLNPMHYbUKHczQqzaOJkAOvKsi78hzACTkpar044vwCeUEIcwdYpN93o7HcCjsS0fa8xm35Bzww/Oo38sPERTdJa3FQ4p1/1cz1aqNHDMio3MtuM=;25:8gZeHLjjYTf0EOYLoiV5Hpp29PAmGXSW0HlOZk3hDD6aV5H+0tE2ouY1cXoFJQ2cccLqGC8b8cjZvp3A80WoevrXxozDgXr50kiCS3k/1B2NXW7EYVI+xWEsSwnC3Pev7G/eFrmZMdgSDbPFoA2uu+GGEQMNohW4hXnjmbj3bWO9JxeXlDWB+5CYh6N/RyeWRtl+8Ral5Gb6JZMbxG4FDq+LHk/2PNxyspNQODlUIw6EmpcgBqUlCqRwtOTr5xZ8EBtlzQNTCgbh9gGvG6xcElhTKdctBrpKuS9W3tj2HloS84/vwpYd/0T6TW3+TrKh3Ss1NgkiDD8sKt41g43URw==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4402:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4402;31:QhDq19cZWFR/om+EPUfsNhDHr8eA0plOgYk/gIVip4pQBCEEB6YGKP5YxI9zvby0Uuxz71mB4+g9T3LkyQvrmcgOGE89y7SbXzwCCKmOX30jvVo6dBPwoiuzu/hxQp+g0H6UNlzd/m/YRiUGoFad4viL6KiXVj7rQr7Pm6Ya8eEJSbRrFIRwNdlneMJymptvGp2G5jwzKPJNnaWOsev5RCIRnUlLGYya6/U56Q3JHL8=;20:uVdQJy2FRfJ+8+BwA/J5gInc8hju0D/qjXcf+y11lIo52EPoaJIJReALl0PY2Wd+hYc4UuFmfmx2LXgF8FbOXPSaCjNbDad1kQ7dnbgclr6dDrR40B43G9XeV1ObG9BfPlB2MzMjfhhMSYjVVEd+keN4uJGmEgD3EB462S/eBgxzEgeGGdjtrG2i7n+biOuwlfcQnTtcGLVWpdiXQ1ZzUWIOmqAwnnY81kCxB0gKPilY/JE5keNLFDoilLQBXtpCLFtXQwb5ZYd7+6uLLGphyB+lGQUUu1UG/jlG7D35Rx6oa/3IFwxNVgDlRBcCfYl9pVtS6XK/4KSQa6BarjbFAt7hw5odGK6ce1K7tioMq6xXvKgwor8JDMQyObroElpC7gi/xXTGM4tam+58JM48CfPVr2JHD60N2DF+GU18wkD+Vqsd/eMh/9QNXZm4GHRyukJpBizVH2/0mYOjfUyktuCHgKsWUopTY2o0wco8qCnYVoWC/5Uu4ZXpEmkyXWQ0
X-Microsoft-Antispam-PRVS: <BN7PR07MB4402C7B32A5EA9A9A3EFB50ACDE60@BN7PR07MB4402.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:BN7PR07MB4402;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4402;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4402;4:/lQ8RdPgfQzWAy3xWQKwp81pAR/vOvTKT8sxIxyFfyGqX3NvvitE0Hi2WNn5YoAns1lxHnP29KlfUc+ShRBAObDph8UIyboHefJuW6PJq/Lo+Z5UxyCpmLNzto37+kGWwfIdHPOHzX1DbQc2fgXwasfYZQBWFLijr5frnhXNgXcaP1KoM0VMWcJh7BH7B+tm6qQ4ph+9NxjTF/s/eugMRW8CMRkm0VKfldWX+/QD3rGvFuX/GKleVRD1wCc3BTvfyTWxV0I+lzCgn0d2T8o5SdmDQVmlVb+pIWJFDGRIuUYoUDkYlcSZm+lfo5yO9MW9
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4402;23:AWlBL1RW6gGpsGhnmtIbD16ZwSTONIYMoNlei8Uve?=
 =?us-ascii?Q?Zu0cAxzQwFwt/yzQgcYlNcAyDxw7JsfgbFSATlNblwG+W7Fzt0CdQ3lop6uA?=
 =?us-ascii?Q?nkKuFT9Zg4Suxj6uuTR1QGpPnt1TUoORWkACsSxtpzRgFPBbR0KgJYEAgcxc?=
 =?us-ascii?Q?e9afK52DIcOdAiqACVLe91GGgXV0Yu83TA16ofCls+q0HYk+LzrRR/DEBbe+?=
 =?us-ascii?Q?9S//jDOOEM5jSqp3DOJ9fr4vYtb/AZ4Vc3qoKw578/vAfmqrnRXc8PaKqj1j?=
 =?us-ascii?Q?fFhBwP/8f2d9FvyMaq55zNZamS+Ek02wH+Uh7BZiJjDyuCNdt1o56JrWtCWM?=
 =?us-ascii?Q?U5sg/eZzj3wT7EtmGixvvlMj68+tG6ukDRtdunfskp49ZIBHB4iVZgimTzfx?=
 =?us-ascii?Q?mlgD3f8T7eZfJjEpg5h1DxWg87VJXTSO1IFWypwAVdlCzwFa45SRA5ViRLfG?=
 =?us-ascii?Q?BVr/cU7VzfSmPeE8uiud7G23/Ue7OxDY5kg/3kc+UhaXU2eV/0b/WRfbXAeA?=
 =?us-ascii?Q?fKTikmqwGXKn79pgdkFFg3qyyINuGikrATydlfDbYw8qNwl62cJ9bAY6gKMF?=
 =?us-ascii?Q?pVDptzv2uFUN7T74C9v+dmTC0y/gvF4/oe6CBCkLeTM8hyysx4poGo4Xv2fs?=
 =?us-ascii?Q?mZlkFoXYU99x4NYs6usfG6wNrmWKHO1TyCRLqqCjYeXeLe69ji3aYgkgLstX?=
 =?us-ascii?Q?c+er1GH8Oyt5YD1bJ0FGDpiOaGF6SADJ1T2BKyasf80Wv8qNvQBmh9eNhNKg?=
 =?us-ascii?Q?ALSw3VvhAsqfFMiCAXVErTXAG4+hjzbLBvYTZ2r1MhEA69ajV0rAfQSC4pLe?=
 =?us-ascii?Q?it2OQrhIIOVmAPOQRe/Jx4AOllZ9c1fxN/0IUSMwQV6NT0rmo+EvS5lFyzMG?=
 =?us-ascii?Q?HEZBvGh08g+B91/6fSTn2+GSCbOpvaiXL/YM3wjm05Tb8UZ1DLg2DfESwecq?=
 =?us-ascii?Q?djbQqO5WBc08q3fLaxEPFrMdY1PpRfBTtOng1VVJDMqB0GL+UcDSjpl2Lqds?=
 =?us-ascii?Q?8UL4y36howQhZJTU7fvDtu+2P0AZWnzUk/ttF/m3slZYldptt/Ti3RufFv9n?=
 =?us-ascii?Q?63kCRzLqxIWHqDm8Yww4GdrV3i48ZRFe+C4ZNcX9YkpUMP2zPq7yvkmjC6Ey?=
 =?us-ascii?Q?zUb0NjzA7nZeaQHDn24RkS84Im7pmeGT6COhXTGdngAVvDmx+ramG9Cdnt3/?=
 =?us-ascii?Q?gMk7UHrdtcyJUc=3D?=
X-Microsoft-Antispam-Message-Info: pRtlBwcx5Wto/WVx0kzeMPBfr0L9i2EYApyP/aEs1doWaLGY/UaIml71E5XfGgUjeuO67YsvSZ/OH52WRb3rBUw1I3y2i5tMwwTAy7wTMuZ0+NIXCZ9ihEWhYAPYHcjg3zccMX1BaKNBII9LnOB8gFBmjJ21UUN9xUvYwUqVx3Qyk+KnlvOF/URlqOLdDRp+p9Uy4YomXB3vctH7hGTGIWA1BldJjn9nCUFA73iwY7yOz4FmSDwIeKMrJS/8j1wgD8JvKnNOj5i7TSZ4LxIUStfTexEd/fDzPOJKZBlRDgH4tH5hYLVmWoefNNrU+VzAxbd8e8q/Swj2FIS0OLD6dQW9hjJkG2loGVqqTqpisPhRLZYqUZkZT8pbuptTTbLeQW3KEg+Wo+DutCmbJiaTaQ==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4402;6:7VmzWcVrbhdP9a0oVTBwhqbuS13cDwLJg7UvJm8P8m37Oz5DzfLU4ycbAMkyuk+FgDEkTt49iOsq4dZkWSz69oSADOFSsfnpJuaAV5wNkfmcV1oaKf1Uvaa5mDQkGVfOQBzHnQGlra40MD3pCuY4T66hz/nYCvW2LQVxqVN/m9Am85NQmPQIRYudURVMy5+QCaO6yKOb0UNVugvZZHixbdbb51cP6wHD/FXhKuXvXyapmlDLimbf/1FORPonLOAqgovqOeYPLX6z1TuZcjZRskp1cwpMCBvwsEPNLmdWXH0XelIsrjOGp04TaeOe9YXBGzgS+231LiS18C7SNJHkcid0hB+fufkkU9h6BlOz0fBlLV1CR8+PpLbGNNcmr123SApZpZiZs0Z13R/0/KsL1LxDLl3MhKJuPfrn+ohFlTPwWEseys4HZ02rWPDG+OvI1bY9M/ECRC5oVZE/6ivvZg==;5:3ZcBDusHHVffpintASySWXKILLr2ggIaX3iI3db83qIOP1LZjx03pcBk3NRw2hs+cVCdSrovcMjdrQvvAo+ZRubPOB2uEuiwZ+o/oVuYcN9YEIcoz4pdjtm2kravj6kKOkvihuSag49m7cH0kuOh9P+CKzuEi9clIIIr49+61lk=;7:etLQaa2l9MWWudPcJE+JoCO319r7PfRYtmwvofuwgFjHdgZMbziaknrsXrI5Ee1OccFICH5b2kXbL1IDewEMZs0Q9/o5tq774wjU0teey6if+vv24HaubFH6RD+tcU4UEwKx4TOTMxSKA7SYAyvWANofUPElH6v2Pwbmr46RrCgMqNL7c8orouxkA3S4nPZePBw6mX1zsQMzFnRsvl+PQB/Dmp2MIAuCWGLdCdLYS9CiCNK0iDZBGr4DT7LwrXd4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4402;20:4ABgk5h9RPGgdbSrTFs7jDvomV2VfbtSx2QrhNtKtGMJP921qF31DyCAcShkFbvWV4pHFjpmBxgkujN0zby94gSDDCnAl3JniUz9woIYtCKaHv+/XaT943WFtEacWSQtoFKAfW6X3XobSSruPrGv4NRX3uhSAs27rE6xOkxM0dwhGcwXb/o+rXAHadO4j/VLAoOAcQadvXKW4ZOR2PuzFB2TQ7A/ObK1KMLV8Iu3T0B+4T/WdNKtlffWfVNcpsCM
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 21:44:26.4980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af71a06-3b7e-4a67-45e0-08d62d67381c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4402
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the mhdp8546 driver to initialize sd0801 "Torrent" PHY.

And removes the dbg_regs field from cdns_mhdp_device structure.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/cdns-mhdp.c    | 9 +++++++++
 include/drm/bridge/cdns-mhdp-common.h | 1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
index 48ac5cf1e031..caaf3c17d74f 100644
--- a/drivers/gpu/drm/bridge/cdns-mhdp.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/phy/phy.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -1220,6 +1221,12 @@ static int mhdp_probe(struct platform_device *pdev)
 	if (IS_ERR(mhdp->regs))
 		return PTR_ERR(mhdp->regs);
 
+	mhdp->phy = devm_phy_get(&pdev->dev, "dpphy");
+	if (IS_ERR(mhdp->phy)) {
+		dev_err(&pdev->dev, "no PHY configured\n");
+		return PTR_ERR(mhdp->phy);
+	}
+
 	platform_set_drvdata(pdev, mhdp);
 
 	ret = load_firmware(mhdp, FW_NAME, CDNS_MHDP_IMEM);
@@ -1291,6 +1298,8 @@ static int mhdp_probe(struct platform_device *pdev)
 			   mhdp->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
 			   &codec_data, sizeof(codec_data));
 
+	phy_init(mhdp->phy);
+
 	/* Enable VIF clock for stream 0 */
 	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
 	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
diff --git a/include/drm/bridge/cdns-mhdp-common.h b/include/drm/bridge/cdns-mhdp-common.h
index d4711091ff2b..1e8a44138ce2 100644
--- a/include/drm/bridge/cdns-mhdp-common.h
+++ b/include/drm/bridge/cdns-mhdp-common.h
@@ -553,7 +553,6 @@ struct cdns_mhdp_device {
 	struct cdns_mhdp_sink	sink;
 	struct cdns_mhdp_bridge	bridge;
 	struct phy		*phy;
-	void __iomem		*dbg_regs;
 
 	struct video_info	video_info;
 	struct drm_display_mode	mode;
-- 
2.17.1

