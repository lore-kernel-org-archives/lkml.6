Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8642C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C72089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QjWfVqKx";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="k98yczP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602C72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJCWwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:52:04 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44386 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbeJCWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:52:03 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93G2EW0028497;
        Wed, 3 Oct 2018 09:02:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=UgSM1xp5b8k6Ev1JJVYY7BK2XyShSf2yzhBcqdmhX3A=;
 b=QjWfVqKxIhPbYjg+CyUSuh5pO8S8q6Kj7A2mXROiELj1mOeLgap8W+uLWBFV7eGIWONs
 TIzp9whN+psSJMslunTiUEkCSPhOmDpgQ+ZX1w0mvloLrdKqp5mgx1ubQZRzGrc8ldzR
 PdpiFGBmeOXU+GdIgwjLkx7OV+u9JpNm/iCvSSpC7mlUIu7gOKiX/szUQKatyus3uTCO
 AFwBBu3uVH7Ex2v3mAmRqZ5P/47AH/VpgSOdv834nn+4lF4y/w6RoEQlZoZldN7IFICk
 1w3KfAhW0DhKoGMaYRGfRaWrrY9sPgBDttsaxVUa+UhUaTqKgRZW/7luiDqDiCP1084w 1Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0179.outbound.protection.outlook.com [216.32.180.179])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mvw32s0uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Oct 2018 09:02:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgSM1xp5b8k6Ev1JJVYY7BK2XyShSf2yzhBcqdmhX3A=;
 b=k98yczP9wdF/cRdgBxqQQwYJqyWoBhAYjkUiYTIueWLLZy+dFOnOGJDrQXg9njlWcrWOmkAGAh0CnXSPqKq6bXMaNoQ/mfMy43U8kO09TEN3jRzu9dC/IIQBRXR2OcLFLbj5oFoPrCaH59wPwWsf+iI0PP7WF9zdk/Z57xbKRiQ=
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 DM5PR07MB2955.namprd07.prod.outlook.com (2603:10b6:3:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Wed, 3 Oct 2018 16:02:49 +0000
Received: from BY2NAM05FT035.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.20 via Frontend
 Transport; Wed, 3 Oct 2018 16:02:49 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT035.mail.protection.outlook.com (10.152.100.172) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1207.13 via
 Frontend Transport; Wed, 3 Oct 2018 16:02:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w93G2kUE008700
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Oct 2018 09:02:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 3 Oct 2018 18:02:52 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 3 Oct 2018 18:02:52 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w93G2jxp022665;
        Wed, 3 Oct 2018 17:02:45 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w93G2j6h022660;
        Wed, 3 Oct 2018 17:02:45 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 2/2] phy: cadence: Add driver for Sierra PHY
Date:   Wed, 3 Oct 2018 17:02:43 +0100
Message-ID: <1538582563-22570-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(36092001)(189003)(199004)(8936002)(486006)(336012)(126002)(42186006)(186003)(4326008)(2201001)(8676002)(316002)(575784001)(356003)(50466002)(305945005)(36756003)(7636002)(2906002)(105596002)(50226002)(16586007)(5660300001)(476003)(26826003)(2616005)(106466001)(110136005)(107886003)(51416003)(14444005)(47776003)(87636003)(48376002)(426003)(26005)(246002)(4744004)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2955;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT035;1:wHa3IBt2PTA+5YNZJdmAEZo0ze+BT0MipCaNwZL6Jeni4ICr7UPIgPtPkszixM/KI8QUnuzPik+NCXKMdj4kuYybWY7fZNAHro9wpQF50PB1XqnVvAOiMr1ttKjyd6BP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c352dd2e-c9ac-4b98-77cb-08d62949aa67
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR07MB2955;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;3:iEhtvBb68kgGO1ApYuP76OMTDrJILbs68Au8d7+/uYjkHsm3Ozf3NcxpIw1fRSWuDNy4qjxZ2VN6DtSCfVx38TkNcoj6ePQWNxbSbaEDNjje/ZyH4TcrixRL4TqNfzXnGFFPVZnP5QFgbVro1lkHic6khZjySnh360NZ7PzsUF2EpjFTo6hns3ohMnvLVGloBLHLcGWbPNDjg6zHjrxQZfVFnCzzWDLx4so0MXIFV0BdtgzVHsZNyWtqIIAkg1nlY3RPdrNfPJpVM/pA1WlrEC/vDioRzLJ7b/njdJaCZFCH6VGDXDuFPr9HhJKmxBZIPjs0904VmU1GfdA63gZIZZ/dXoRJt3rTLZhmX0KLfEk=;25:ueRCg+WluACjTjOBa9XFO4oMAIVeeXhb4gmbZUaMT1j5mM9sNJoS3aYcTGpe6bFDjYZRfKYimtKCjGfMlbDLZEbLyw1mR2ZWpPvXXvKEzsvUUPOyo7z+dEWequbmU6p2qyyaFPKzd9R+GY3R809jcnvWSIvaCXdQbZrLLhA8Ft28YJK0SEJFd22sXzLJxjSxQG5FPd/K1LwHz7hgZV+CMm1Ij1gvZJl+701BBthCPcD7ElAOd2qqmuZDK62qX2S3XnMXHEgu8uE9mPpKJsO4a1vcghr8kcL3gF0oG9V80emEN4TgDjg3MItIx4rAXqUndsSS65p+CTiVbfamSpEp7Q==
X-MS-TrafficTypeDiagnostic: DM5PR07MB2955:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;31:w7/nAKDJNadlkv5JgZB1trNycmrRV4z2E/mXEYFICrnOjs5f6xV5/US8B+DC72K74H8upOeJTh9u/Mj0fLUriSsVxi1woRj7pV9OxOUjqEY05efIN3Ye/JshiIh8Vls89admZjCMqhYHzEPh55BSKFU9PrdXkMYZUFg1zRTWDLk9N6Balfu+mGgTZyDQA8/DVaiiMRmCZTXtrurjMOAEJgXrNO97A8Io5yC+pqAs7U4=;20:G1wQzwFo1aySZAb/iHQVO9wVt1cR7GImA9ChTp/5GVUnO3TI2Uvj7HI+tiWkTuNeZLzF2KuZXOIJop9ebe6PplF1Wej4g7pZZW9U1snVR64aeuxASxhHWmvCtgHOfLGTsdEZNl2fmOYL5yhv+xVQZc3JSaUEG0VMgklgSIPV7sQMeiq4KB/6N0PUCaFVyx04QuMsFrdpdvvcAKkhZcDj5sfK8pb9L1UZmx8tvYVrKCs1i35HFC8PmtC/61DzP8wD8Fgj0/yh3H/A0glLxXTrCAlEkpfn9VMT+2jKcNksPTYRQlwlSiBGuuHh+a+UsVsMiaHGPXatPpWur144Ceirhn1d7fFxI3lgh3G/dPJ9bU40OYmfidNLzuqifZnxIBMwLvWU4TMQaZC/lR7UgW+gvWr7L58OSU3yq3S0CNjvtvaLfn45QmfkgIdFnoZv48e5fTdNpy0Hcnn+2JQqESx7RVrdH9aNgAaGFuXi+K3wm6QIcMRCNk4N1POf8k9ij+d4
X-Microsoft-Antispam-PRVS: <DM5PR07MB2955EA188399A479EAEA8532D8E90@DM5PR07MB2955.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93003095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:DM5PR07MB2955;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2955;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;4:2ntUb3oYohbwclM4f7d/AWqMYKPCAB2WMlQutDIRD/GxX5rSFsZ7LUulQg4o2Kq19p8uPvcdjIPpIlBvxb+3FnoKZuBTF6Bt4HdLGIMxwOVlwFtUUVP1D5miXpC/7AbNDBB3dgUDZjNgjuP5mpHSsk0Eh48VkfAx7iUqKFsXazESfVCOITmMTWR6U56JE0j4e9ENHEZ8mTz3wdgGIgz6mV7LMucR+YwnkYu5MJ5FAkEfa0ZyWssgNKVRMl15g4G8pWlBsh8RWiKQEqeUEC4DIzqaXwF8QSTraQRi1QH8i6x78eOoCzxbwgeL0TkJgV8N
X-Forefront-PRVS: 0814A2C7A3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2955;23:XtJH2yHA7MK09WwiZMm2Zw5ZAQsJn10vQvQWRItzn?=
 =?us-ascii?Q?rf/3A9Si21KTgP7tL+gsJTar1R4rGBgSKK/ym/lvej/eDGulDH9CDJXWZnck?=
 =?us-ascii?Q?GkU6L8ntlFlF30W4YfWXyyhTTuVjhtQs5UVV8AdJYcteT46zwNSN90DBl+oe?=
 =?us-ascii?Q?WcZz6ZJFvAD9J1kPz6Xdu5XM0d1MXU7Rkdlmnq3sPS6RcCrTc1/4b8XtOzjD?=
 =?us-ascii?Q?tzWy4+Bj8kSrT5M0IAsg4geW51Z09yq5JJ50qjU6YbQ4tfa5/PrDSseeabGj?=
 =?us-ascii?Q?7c7KUoPsrwjEn4O2MThWo5uqf2gvxv3MpU06cwtkIkJQWiaa89r3phrW6K9d?=
 =?us-ascii?Q?rjtES9OW9Y3J2Wvj2BxlNSCW0IIGs1bSQerdu7zC+tqdLgCCbTVuDmMc4ckR?=
 =?us-ascii?Q?7ol4FPq+0cc9PvpVGjKVvopYFkyvD054sJuNk658+78Fz01aPX75ejDnLau3?=
 =?us-ascii?Q?ma57L9FuNxOHmReTkQIvchbp8hpjnPQ1rh6wwc0wfiyniHDThDvUt19mkOJD?=
 =?us-ascii?Q?o7aDEsj1b/Lgp0/pARv9CsSgE7UCd8I63nry1FRTSXU2M9Ws/RlkJ5JZb6t3?=
 =?us-ascii?Q?q22iiYSq9+dHIbae/wO+YS1QpqMxFaLOMUNTucarjwkndnfJeQl4dxD60VZX?=
 =?us-ascii?Q?r40q1YpPWVDWmlTLh5iI00GrsYswNsRKNnTjHlcV65pOzKqJB1iQFJFxCwKJ?=
 =?us-ascii?Q?mZsGm9K0+co3HFqiECYm1XHLH55n9/s8EBVnUgX9XBuUd8Y68x/xqHf4xjMU?=
 =?us-ascii?Q?Nrh1Ld4wX5obe3vX/Wo2kG/rsmWGTSSzAu1FCQVZ28Ni+tO9Hc4NWWkBc5Ci?=
 =?us-ascii?Q?12OHkGm6NvFnusdbZAr9N4f5wGE+XsU6RcNrppXU7EZLoxmmC9chKUuiwZp7?=
 =?us-ascii?Q?nYRXHAI0zwbHZJbntSpMokpCnnTb630z4EW6fAmyCQChngi+7PYkClTpLthu?=
 =?us-ascii?Q?w+qaJFAIEF5FMPk/oLW03ftbD08XHdXnvMMoRqRn+QyltVPLLk2d4xb82DfD?=
 =?us-ascii?Q?g0dVnh9YrNdLJThcsLZ0a6+rX4MP1XGdxQTTjqQkfwqdQXN5OudfkjzJDLSs?=
 =?us-ascii?Q?R1GSNc=3D?=
X-Microsoft-Antispam-Message-Info: 8P7nYSO7ToKFv06Vdd6DqevNBEi1iurXgRTRTHxnP9WU4IKiU0/IqF7bGYW+NCexAVaZdV+9Ovizt5fCBChja+MzK98hy1mAPyE03OE9LIUKyj2TgY9gQkeVZHf3R93SdwURT9XkEyi4kkD4RGTWB1CNEbmcKFUzSk0bLrfA56mz/D7SZEONCblEmf5Y3kGLGL3Jxt57CMPUBr67VSAjkFqONz1+TqWamQ7beT8ltHlFXL4Xux90DI1EjXg8l6LxajBQNpgZCvBLP70ZC1xhJNDTI0KfcYky1+AhqQK3CzQ+2o3cblMuTFA16eTzBNLo4Es1M7dF86/sowP2IW0THKg754n4fY/tRXrZiS8PXdN1cW1mi2FHqGpVJ2aOCyzKEJ6LJ0By03Gu+Suavyd3mA==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;6:n80lww6HmuQ2x22sjTAOdL2rGM+V9iNRu2KOoycGsBahH6rUqgLCdz00f1NwdX4tBfOWzfZPlez/BnavyVJdatufAUB9Ezvg2ag6kw4JzBf6Vr/UryDSkEtjj6xkP3SHkpyNnF6R1epXblmgDjjGB8DxWmUix4TQtEiX93TWTGvVxRFh37I7I3ly9qX3wR+4/PymGeXe2MdDE87l17hWlJUczUPhfnVZMTfVMiwgdpNkGgqMVH3qwlyQX1+/DgF77vne+ADyBKQxqHwmW3Vf0qxHe9Nfr0oLci7NtD4jQrOarfcLJyDVmOcNcPKN8Ksar28eQldKYFiim4092Gk9MIXtXkPuzr4w2HTRqS7S6JKA/I9WsLCyoI6r+97sBgRj7mWIZPsrvqBPBUWDEcVmlzgTDeS/Jv7+tjHu7bTEuh5OJ1qFG0P7Qf04COSMcL3HQw1oGP7jVR1jWmF2OmLDiA==;5:cllSgFKbr+e3UxCkphxM4kWfSH/qfrEweSAq/aOptTWqsjnBDc6e7Jl5ezfBhsAyVSLxYOOYh1xGqCRCG0l+Jkwd/Y+RnE23iISQx4vxkHuIgg4SYcytS0j3uxuii1abHZFBvhuTzH/Ct/DH7mgptWIQ523pgO1Mts2iuVZh220=;7:gb8sXs6r7xm6wbgi+fwOncyrJvd2S24zF3lEn75+K+ouTR33QUIOYBRZYFqaoMW4CY33zUQ64x3Ieu0lEuqkIRpS+H1iJs/LTsoG3OyBixT8aJ75hsp+GVu9vajFxCfEzD1FdvKf5Kigf8CTWT99S7JiKzPNurWcfy0zrzetUlDVH8QrGNeA11olYXF4NC+mVUAHEBuAsVz1yl4vl9gYI0uVM049zVg1Vomd6mdt5GguYznUHjA8tv89L3U+GAck
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2955;20:Y0PuYVcRuGpEn5KBNIaGhe/J61bNFLBGzcNERVE/N8XfR5geBsjNdVl5h5VgpVpOeUvta5T7NZg5Z1ZITFpjO8EXTCJJZNsRkdDcgsXGoBve2Fz1KGeh3EAV6UiYLs6QNSDZo5F1ZkuAjqHdS3mSugOqV3fCUd5tbTdgpFSCTkpmMA9kBhB9p7BWFRAoX1qUncf+NgniqvEUcDUBdnFZoMf7BS++fnHff4I/GENTQBhxsFck5YlWcPwK1SBO+k7B
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2018 16:02:48.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c352dd2e-c9ac-4b98-77cb-08d62949aa67
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2955
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810030154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Sierra PHY driver with PCIe and USB support.

The PHY has multiple lanes, which can be configured into
groups, and a generic PHY device is created for each group.

There are two resets controlling the overall PHY block, one
to enable the APB interface for programming registers, and
another to enable the PHY itself.  Additionally there are
resets for each PHY lane.

The PHY can be configured in hardware to read register
settings from ROM, or they can be written by the driver.

The sequence of operation on startup is to enable the APB
bus, write the PHY registers (if required)  for each lane
group, and then enable the PHY.  Each group of lanes
can then be individually controlled using the power_on()/
power_off() function for that generic PHY

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/phy/Kconfig               |   1 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/cadence/Kconfig       |   9 +
 drivers/phy/cadence/Makefile      |   2 +
 drivers/phy/cadence/cdns-sierra.c | 380 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 393 insertions(+)
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-sierra.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..cc47f85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -43,6 +43,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..ba48acd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
+					   cadence/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
new file mode 100644
index 0000000..098df0f
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,9 @@
+#
+# Phy drivers for Cadence PHYs
+#
+config CDNS_SIERRA_PHY
+	tristate "Cadence Sierra PHY Driver"
+	depends on OF && HAS_IOMEM && RESET_CONTROLLER
+	select GENERIC_PHY
+	help
+	  Enable this to support the Cadence Sierra PHY driver
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..c396c69
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CDNS_SIERRA_PHY)		+= cdns-sierra.o
diff --git a/drivers/phy/cadence/cdns-sierra.c b/drivers/phy/cadence/cdns-sierra.c
new file mode 100644
index 0000000..598e512
--- /dev/null
+++ b/drivers/phy/cadence/cdns-sierra.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Sierra PHY Driver
+ *
+ * Copyright (c) 2018 Cadence Design Systems
+ * Author: Alan Douglas <adouglas@cadence.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/phy/phy.h>
+
+/* PHY register offsets */
+#define SIERRA_PHY_PLL_CFG		(0xc00e << 2)
+#define SIERRA_DET_STANDEC_A		(0x4000 << 2)
+#define SIERRA_DET_STANDEC_B		(0x4001 << 2)
+#define SIERRA_DET_STANDEC_C		(0x4002 << 2)
+#define SIERRA_DET_STANDEC_D		(0x4003 << 2)
+#define SIERRA_DET_STANDEC_E		(0x4004 << 2)
+#define SIERRA_PSM_LANECAL		(0x4008 << 2)
+#define SIERRA_PSM_DIAG			(0x4015 << 2)
+#define SIERRA_PSC_TX_A0		(0x4028 << 2)
+#define SIERRA_PSC_TX_A1		(0x4029 << 2)
+#define SIERRA_PSC_TX_A2		(0x402A << 2)
+#define SIERRA_PSC_TX_A3		(0x402B << 2)
+#define SIERRA_PSC_RX_A0		(0x4030 << 2)
+#define SIERRA_PSC_RX_A1		(0x4031 << 2)
+#define SIERRA_PSC_RX_A2		(0x4032 << 2)
+#define SIERRA_PSC_RX_A3		(0x4033 << 2)
+#define SIERRA_PLLCTRL_SUBRATE		(0x403A << 2)
+#define SIERRA_PLLCTRL_GEN_D		(0x403E << 2)
+#define SIERRA_DRVCTRL_ATTEN		(0x406A << 2)
+#define SIERRA_CLKPATHCTRL_TMR		(0x4081 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
+#define SIERRA_CREQ_CCLKDET_MODE01	(0x408E << 2)
+#define SIERRA_RX_CTLE_MAINTENANCE	(0x4091 << 2)
+#define SIERRA_CREQ_FSMCLK_SEL		(0x4092 << 2)
+#define SIERRA_CTLELUT_CTRL		(0x4098 << 2)
+#define SIERRA_DFE_ECMP_RATESEL		(0x40C0 << 2)
+#define SIERRA_DFE_SMP_RATESEL		(0x40C1 << 2)
+#define SIERRA_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
+#define SIERRA_TMRVAL_MODE3		(0x416E << 2)
+#define SIERRA_TMRVAL_MODE2		(0x416F << 2)
+#define SIERRA_TMRVAL_MODE1		(0x4170 << 2)
+#define SIERRA_TMRVAL_MODE0		(0x4171 << 2)
+#define SIERRA_PICNT_MODE1		(0x4174 << 2)
+#define SIERRA_CPI_OUTBUF_RATESEL	(0x417C << 2)
+#define SIERRA_LFPSFILT_NS		(0x418A << 2)
+#define SIERRA_LFPSFILT_RD		(0x418B << 2)
+#define SIERRA_LFPSFILT_MP		(0x418C << 2)
+#define SIERRA_SDFILT_H2L_A		(0x4191 << 2)
+
+#define SIERRA_MACRO_ID			0x00007364
+#define SIERRA_MAX_LANES		4
+
+struct cdns_sierra_inst {
+	struct phy *phy;
+	u32 phy_type;
+	u32 num_lanes;
+	u32 mlane;
+	struct reset_control *lnk_rst;
+};
+
+struct cdns_reg_pairs {
+	u16 val;
+	u32 off;
+};
+
+struct cdns_sierra_data {
+		u32 id_value;
+		u32 pcie_regs;
+		u32 usb_regs;
+		struct cdns_reg_pairs *pcie_vals;
+		struct cdns_reg_pairs  *usb_vals;
+};
+
+struct cdns_sierra_phy {
+	struct device *dev;
+	void __iomem *base;
+	struct cdns_sierra_data *init_data;
+	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
+	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
+	struct clk *clk;
+	bool autoconf;
+};
+
+static void cdns_sierra_phy_init(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	int i, j;
+	struct cdns_reg_pairs *vals;
+	u32 num_regs;
+
+	if (ins->phy_type == PHY_TYPE_PCIE) {
+		num_regs = phy->init_data->pcie_regs;
+		vals = phy->init_data->pcie_vals;
+	} else if (ins->phy_type == PHY_TYPE_USB3) {
+		num_regs = phy->init_data->usb_regs;
+		vals = phy->init_data->usb_vals;
+	} else {
+		return;
+	}
+	for (i = 0; i < ins->num_lanes; i++)
+		for (j = 0; j < num_regs ; j++)
+			writel(vals[j].val, phy->base +
+				vals[j].off + (i + ins->mlane) * 0x800);
+}
+
+static int cdns_sierra_phy_on(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	/* Take the PHY lane group out of reset */
+	return reset_control_deassert(ins->lnk_rst);
+}
+
+static int cdns_sierra_phy_off(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	return reset_control_assert(ins->lnk_rst);
+}
+
+static const struct phy_ops ops = {
+	.power_on	= cdns_sierra_phy_on,
+	.power_off	= cdns_sierra_phy_off,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
+				    struct device_node *child)
+{
+	if (of_property_read_u32(child, "reg", &inst->mlane))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id cdns_sierra_id_table[];
+
+static int cdns_sierra_phy_probe(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *sp;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct resource *res;
+	int ret, node = 0;
+	struct device_node *dn = dev->of_node, *child;
+
+	if (of_get_child_count(dn) == 0)
+		return -ENODEV;
+
+	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+	dev_set_drvdata(dev, sp);
+	sp->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sp->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sp->base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(sp->base);
+	}
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_sierra_id_table, dev);
+	if (!match)
+		return -EINVAL;
+	sp->init_data = (struct cdns_sierra_data *)match->data;
+
+	platform_set_drvdata(pdev, sp);
+
+	sp->clk = devm_clk_get(dev, "phy_clk");
+	if (IS_ERR(sp->clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(sp->clk);
+	}
+
+	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(sp->phy_rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(sp->phy_rst);
+	}
+
+	sp->apb_rst = devm_reset_control_get(dev, "sierra_apb");
+	if (IS_ERR(sp->apb_rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(sp->apb_rst);
+	}
+
+	ret = clk_prepare_enable(sp->clk);
+	if (ret)
+		return ret;
+
+	/* Enable APB */
+	reset_control_deassert(sp->apb_rst);
+
+	/* Check that PHY is present */
+	if  (sp->init_data->id_value != readl(sp->base)) {
+		ret = -EINVAL;
+		goto clk_disable;
+	}
+
+	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
+
+	for_each_available_child_of_node(dn, child) {
+		struct phy *gphy;
+
+		sp->phys[node].lnk_rst =
+				devm_reset_control_get(dev, child->full_name);
+
+		if (IS_ERR(sp->phys[node].lnk_rst)) {
+			dev_err(dev, "failed to get reset %s\n",
+				child->full_name);
+			ret = PTR_ERR(sp->phys[node].lnk_rst);
+			goto put_child;
+		}
+
+		if (!sp->autoconf) {
+			ret = cdns_sierra_get_optional(&sp->phys[node], child);
+			if (ret) {
+				dev_err(dev, "missing property in node %s\n",
+					child->name);
+				goto put_child;
+			}
+		}
+
+		gphy = devm_phy_create(dev, child, &ops);
+
+		if (IS_ERR(gphy)) {
+			ret = PTR_ERR(gphy);
+			goto put_child;
+		}
+		sp->phys[node].phy = gphy;
+		phy_set_drvdata(gphy, &sp->phys[node]);
+
+		/* Initialise the PHY registers, unless auto configured */
+		if (!sp->autoconf)
+			cdns_sierra_phy_init(gphy);
+
+		node++;
+	}
+
+	/* If more than one subnode, configure the PHY as multilink */
+	if (!sp->autoconf && of_get_child_count(dn) > 1)
+		writel(2, sp->base + SIERRA_PHY_PLL_CFG);
+
+	pm_runtime_enable(dev);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	reset_control_deassert(sp->phy_rst);
+	return PTR_ERR_OR_ZERO(phy_provider);
+
+put_child:
+	of_node_put(child);
+clk_disable:
+	clk_disable_unprepare(sp->clk);
+	reset_control_assert(sp->apb_rst);
+	return ret;
+}
+
+static int cdns_sierra_phy_remove(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
+
+	reset_control_assert(phy->phy_rst);
+	reset_control_assert(phy->apb_rst);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct cdns_reg_pairs cdns_usb_regs[] = {
+	/*
+	 * Write USB configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0xFE0A, SIERRA_DET_STANDEC_A},
+	{0x000F, SIERRA_DET_STANDEC_B},
+	{0x55A5, SIERRA_DET_STANDEC_C},
+	{0x69AD, SIERRA_DET_STANDEC_D},
+	{0x0241, SIERRA_DET_STANDEC_E},
+	{0x0110, SIERRA_PSM_LANECAL},
+	{0xCF00, SIERRA_PSM_DIAG},
+	{0x001F, SIERRA_PSC_TX_A0},
+	{0x0007, SIERRA_PSC_TX_A1},
+	{0x0003, SIERRA_PSC_TX_A2},
+	{0x0003, SIERRA_PSC_TX_A3},
+	{0x0FFF, SIERRA_PSC_RX_A0},
+	{0x0003, SIERRA_PSC_RX_A1},
+	{0x0003, SIERRA_PSC_RX_A2},
+	{0x0001, SIERRA_PSC_RX_A3},
+	{0x0001, SIERRA_PLLCTRL_SUBRATE},
+	{0x0406, SIERRA_PLLCTRL_GEN_D},
+	{0x0000, SIERRA_DRVCTRL_ATTEN},
+	{0x823E, SIERRA_CLKPATHCTRL_TMR},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0},
+	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01},
+	{0x023C, SIERRA_RX_CTLE_MAINTENANCE},
+	{0x3232, SIERRA_CREQ_FSMCLK_SEL},
+	{0x8452, SIERRA_CTLELUT_CTRL},
+	{0x4121, SIERRA_DFE_ECMP_RATESEL},
+	{0x4121, SIERRA_DFE_SMP_RATESEL},
+	{0x9999, SIERRA_DEQ_VGATUNE_CTRL},
+	{0x0330, SIERRA_TMRVAL_MODE0},
+	{0x01FF, SIERRA_PICNT_MODE1},
+	{0x0009, SIERRA_CPI_OUTBUF_RATESEL},
+	{0x000F, SIERRA_LFPSFILT_NS},
+	{0x0009, SIERRA_LFPSFILT_RD},
+	{0x0001, SIERRA_LFPSFILT_MP},
+	{0x8013, SIERRA_SDFILT_H2L_A},
+	{0x0400, SIERRA_TMRVAL_MODE1},
+};
+
+static struct cdns_reg_pairs cdns_pcie_regs[] = {
+	/*
+	 * Write PCIe configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0x891f, SIERRA_DET_STANDEC_D},
+	{0x0053, SIERRA_DET_STANDEC_E},
+	{0x0400, SIERRA_TMRVAL_MODE2},
+	{0x0200, SIERRA_TMRVAL_MODE3},
+};
+
+static const struct cdns_sierra_data cdns_map_sierra = {
+	SIERRA_MACRO_ID,
+	ARRAY_SIZE(cdns_pcie_regs),
+	ARRAY_SIZE(cdns_usb_regs),
+	cdns_pcie_regs,
+	cdns_usb_regs
+};
+
+static const struct of_device_id cdns_sierra_id_table[] = {
+	{
+		.compatible = "cdns,sierra-phy-t0",
+		.data = &cdns_map_sierra,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cdns_sierra_id_table);
+
+static struct platform_driver cdns_sierra_driver = {
+	.probe		= cdns_sierra_phy_probe,
+	.remove		= cdns_sierra_phy_remove,
+	.driver		= {
+		.name	= "cdns-sierra-phy",
+		.of_match_table = cdns_sierra_id_table,
+	},
+};
+module_platform_driver(cdns_sierra_driver);
+
+MODULE_ALIAS("platform:cdns_sierra");
+MODULE_AUTHOR("Cadence Design Systems");
+MODULE_DESCRIPTION("CDNS sierra phy driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

