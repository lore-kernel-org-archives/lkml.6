Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE3FC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D077120833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FieFp1Zy";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GTk5qUOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D077120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeKDDE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48762 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbeKDDE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:28 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3HpfYg029589;
        Sat, 3 Nov 2018 10:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DWGMdfW+jHapWJamc2ksRtfunpmYuJ1SBQVUyRWYHHs=;
 b=FieFp1ZywTfke1VD+tKBqIRDRIFDOJVX3iRgAyn8w+4eN85PGUZDY/eQ4o09ZPg7PHk2
 ryv/nk8Ls613mlkS+dTYtWiLkpSg8vQGtWiFmdV0u6OtyvJbzWEpQg/ddUP6T4rdJa3Q
 c2Gj4Udqy+u4RHpVRD2/BMoVXH1mHq+V6haMMqthmRUlscMZp2ckbfi7ghlcWvD38IZp
 wZb5teCTjIm7+lfJhdv108HLWP9xrcVJ3UX6ST5eBNocD4Otl+shmMoHVknnoGiCACn3
 icCeNXACuzuQDuNHoU4xVVHLdr/aUAiRcNiL4X3RaBfmTp8UBr2cg19uxYihTYTuCZuV CA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0023.outbound.protection.outlook.com [207.46.163.23])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rhmuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWGMdfW+jHapWJamc2ksRtfunpmYuJ1SBQVUyRWYHHs=;
 b=GTk5qUOeLEwSAKObkbxgqy/PMJBOQA2XBe3zKLKQkPySCmh/X9VsuojUOYfnnaAcL1ToBIR7EWQlUzBmPXyeT/iXL0UdXhe7Qlvkad4gHwrr/SfgrAbG6wE0zUQhfPSJUOC9WPi9usbIVVT5J+yoQBx99ZM2YMWFrmRtINpOtWQ=
Received: from CY1PR07CA0011.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::21) by DM5PR07MB4101.namprd07.prod.outlook.com
 (2603:10b6:4:b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Sat, 3 Nov
 2018 17:52:20 +0000
Received: from CO1NAM05FT030.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by CY1PR07CA0011.outlook.office365.com
 (2a01:111:e400:c60a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:20 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT030.mail.protection.outlook.com (10.152.96.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sat, 3 Nov 2018 17:52:19 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqH5Z027363
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:18 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:22 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:22 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x2000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:16 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:15 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:15 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqAIv006384;
        Sat, 3 Nov 2018 17:52:10 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqAfu006382;
        Sat, 3 Nov 2018 17:52:10 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 04/14] usb:cdns3: Added DRD support
Date:   Sat, 3 Nov 2018 17:51:17 +0000
Message-ID: <1541267487-3664-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(36092001)(50466002)(48376002)(336012)(4744004)(4720700003)(11346002)(107886003)(6916009)(217873002)(26826003)(86362001)(446003)(486006)(478600001)(87636003)(246002)(50226002)(8676002)(8936002)(105596002)(2616005)(2906002)(14444005)(36756003)(356004)(106466001)(4326008)(186003)(76176011)(5660300001)(54906003)(51416003)(316002)(16586007)(47776003)(476003)(2351001)(42186006)(26005)(7636002)(305945005)(426003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4101;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT030;1:ZTQrhT9FxO7t04W0N8Mt2MtHcEmC7M/JT5mXq0tmcTvlq4oHW8jnpy/nfob0TWaqlqGEELxz9og5imKXdeojKlEe8XLOm9vpaa3I7TY5ml4dLVe2HDsietwrW+BRmgUM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde0173f-07b8-46e0-24c9-08d641b519de
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR07MB4101;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;3:o4XfpyHzfN4gLsqsg75YrTyAj9of2zx5LfNKVXU4XTO6yCyCgUBVSL53mdGFNfX+lPq17hIm+ESY5nOJLPtQh+gszhRASYBSH8ORGAg7iR2mLXQTQJKMcbrRBTk2Yw4PTHTcDgqBW6uebsjt4Nh/YQ4Ih23qni3gTISov81IcbjtOiOvbxcCL4k3FFK/yPMpvm2zA4ItS0oL7/3643aoCPjxAV7AlzUTFXN4qLZXD8kbSsYq3jlR9Yt6RTy4ki2lYMwKC1L6rg3eeO2aXwA9vJYUyX0ZoaPpTymAaRorf/XGdhbCe4DmW6wMRvKh7f4QTR5VUHgVL2Jkz0hJkIpKRewAd1+fpM3gsu0TO0etSNA=;25:EJH95c1GSGP7HV79lhI5SFiB/5gQWERIQCGM2HsT11Cdpv6CqoWzQZvCE3IIQPrgjfvqYkX5fSvPRaoqyeEOeE2uxEZUwFmtGrIRBvFM9Il46fPV6E7YF4JI8BbOr9LWcI+tDhBMK0oNExQ4hXFOUL7T6hd5qKmmkSdfb2k9+R9ZsZ5IO4QBGkJzdqIZXGksr06xHucLLsfM+MNSWKnqJIcOOe2fUYOapD175zY4fmiQmHUOJuCmYRdiIDkRi1ZizXBU1AcpA56/zuKlXo1Uu75pygxVBW4JGO+60khc7h8HuX8uOe/WuQuYaxWrbjBn4yrvCqIoIcwxXGWBnJV/Eg==
X-MS-TrafficTypeDiagnostic: DM5PR07MB4101:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;31:k33/XnYkzy1cR42AkJIECASFFUh5X9DWJtlrhSgrMO3Nu2toRV4nKMP3CJ/eh5ehLLJgf+H+oJwFMLuDSFoS75OGpGTVx8x5sD/aTeo0lYgiVKdnIjobkq5KHmWjktu+osGDcnRaStMjrHsrf/1+4ysBxrYKROpN1d608ZONu7MQBK83L4QdDcLTHqvt0aLZObZJEFkFiWwTtdXeZnSXCVF1Bpx3wzqIs1uM5Hbybxg=;20:bdIxz3dDy+EgGiVvM2E5ElvGMug8IaGV2N1guBVZbO8gY5SiXp8mPb1IckIEETQ2GAW80rbx350JEoTpTaX33+iUmIyJ7NH1iiGFd4gWPmnAiw2K0D4j3BBDwVNGjg+lEXycmg0UbEetA5vISKkgxshu7eiKTUfwwwdHy5cMStIWg/qSAkQF0lyeFryxBHBpd5j5LAZ97r4zU1KL+csW0PGQgQi1wE4hKE9nVnyIsL3ed82bPb8ucHrfag8cAyNRVMpJYKs/5fzzjB7e1WL7YCRWTcqamwiD84UlKVTFY2yWrncK5UhvlOMkGR7POzP36qBTKh+H71vzApGvncFO3pEc7jE1vmGfP1vPiBEFl1j10J/gCxw6GksGcvAwYIWO07BxEAjA+SB75PevDWJJrZ63ihcGyrIN0x/Hn8LzXkBZoF026KZ+RoezruJI9DWEREnnZSdF6O5GCAv29MFuhqHZ3yV/xpacXOuihjlDuYdfvgIck1IXqIJlXOmQYdCO
X-Microsoft-Antispam-PRVS: <DM5PR07MB41013CD3E0DC08F1A2AE8E08DDC80@DM5PR07MB4101.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR07MB4101;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB4101;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;4:xvDjG8CAcfVsyYtn5HbVaKB5RyEAder/Kmhx91u8dAfvpa8z27N3tPbiK1KKJvVg5Hex8aytZFVRas+57IoAgCZ+yam/pp11PsyjSWBAhRj5p+SLkaSbNgYq8ILBwcuxhhrZ5Rc1crtTFhPrGLmTFDsIpAkV7M490HWJvil/sDZevz8g6gX++ikSuDBmrZpur8859QlBf5s+hOJmWXq4I15+4va4bXhbZ36KE8kdxZAm6lV4vYj78S+bvvkOqHzn8xQpOemITWSgVbASjfTJNS0rsi93KXZZn0AKWOoz4uuV9Urvy/jpbgdbQW07DqqV
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB4101;23:yqRAbM/rzSRJ4w0LFFTrY6vQwH9B3p7whZrMcvyFd?=
 =?us-ascii?Q?FCnrZIggL8hL+kHUYdrzr/Qg4GRdS6STbN/NRtpX7OrJsTfCmAZaitqEdbTP?=
 =?us-ascii?Q?yuQDS+lmDIB3QW4yTxTUqCBxrm0+2o3laydOvvGBREQazkeDcsH9l4eThq46?=
 =?us-ascii?Q?+4asWltKbuzX197qQp4DdP7lG4aTHJhmma+GQs2Uxp7UptYb5XRPoMHTUG7o?=
 =?us-ascii?Q?XPrDC4d1BCinCAkrRqB03zkfVD5JXFd4RLqgCFA1zWSeyZODBc+b6KVwljOW?=
 =?us-ascii?Q?mXWklh18QTfhtVMn+lIOM54ASodZE4PkLprgdMoGownokoGzrLD2Y5X/t+na?=
 =?us-ascii?Q?i6GU+tBV+3Gp53M9HBH7ancOXoFA5Rde1F0kT2An5sQeJ9RmBrJinVF+wYJf?=
 =?us-ascii?Q?znfnqtpSepQcVUSM0IsmCQGejciI0xrYxTVT3IMAUp4ZM/4iWQblJTBAWAK0?=
 =?us-ascii?Q?pPT6AX40z/pBLec4Rafh4x82d6+Nmf5w9qiMwXEwhhrSfBvH0I7sskLxVHrr?=
 =?us-ascii?Q?ZJ4NpcF1J98njh6WAWaQa9pH5H/9KX6Y27unGBcOSBnxUUYcQ6EUEtwcq7gz?=
 =?us-ascii?Q?Pbvf6PBEsErR6rc7smwXIHx+1fIz+adbwP8UpJazGgGfJqmSs7oAFe2wEvPV?=
 =?us-ascii?Q?94OSconL/SuSz9DPldfVN9FEl7x/KSUYrWspp2g06lz4fyH2+p7l+LDQ0Hbn?=
 =?us-ascii?Q?BfawgRG/WhLsHGfAo1zTogvo8ppBRClhXb5dsegQaMV5H/ZOix7jN/U8eKHA?=
 =?us-ascii?Q?4AiUZmxUH7fiqVke+GXDJRgoEqTdBXNaXqxGb4VN1/XUc6r+olz1hNOm3rSQ?=
 =?us-ascii?Q?dXNOshn9AzqnPnkc4QuPutUw1FrPyK549QmDRz4YNy9vlv+PvBRxuqBltMYc?=
 =?us-ascii?Q?VDGpbvu8BXAoQkDbkfeWf7+NN3rom/gQ7oD5l3H2n0yNsKmvumq77vYIOcZE?=
 =?us-ascii?Q?CgMbqAZyjNmIa2gvCLLAVfDxhYk7iYGntlv+K+8wlgbq8Slitiimhz1baFTK?=
 =?us-ascii?Q?8Z1l0Acs/n0ZO8Q9nlGox7OooSa0jm35JDZ7ehUzP3Y+sf592UQA91Q4GNpK?=
 =?us-ascii?Q?cHbuhhmKn1a09Q+9916Ak8X6rxhBkqqz+srGt5+mMWZ6WVjneQ4Plt2ViGbP?=
 =?us-ascii?Q?k5Ngb+Js8r0sVoN0FuSfINRt7dO6DuUCButD5Iz4zkQeinA7tVYpg=3D=3D?=
X-Microsoft-Antispam-Message-Info: F7mZNhFHGQfRArr6NYtof+OezITMsT0q93hVCqtCGu7JsivUauq5LVOhgqkaxyNuO2nLo7jwCTriAeYod5WxYBzCOgeV+2ESrBsf0jS88Ro56wwL0JvLW16QruH1zeV3mnQgC1nfxwzx4roYhFXXJFKa1JKlni2nZElrpvmmBPp9yLwH8soy9+VDtJsyqgXLrQtY+KPx58E4zLJre67v3xX/VXOE4FO3g1zmP9DA9vFp0FPn3bgfas5x7qwk5Chtgs9ROqxx1I5ak6j53tunSJyVfafZPbtv0ZowDRb8XbJNXfoGIw18XVq3jQM7SunUv0jgyh9Hbl+idr1dvAtu3SaYFvPcGignpFAwKzATN/k=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;6:YJE5GXBMgxdqzwW58GXuiv90m9fKJ4dVCDD8hEXn9xOXPvOpQESicsXQ4KCgbaq1Txzvi2NEvyPgelFHraVghkFHxKFqXRWrTxyivBNKLGUTStAZLzZN60AsqdwAVOnPDITYug11akTpYMul7d497VqiBjROUNwV4ZGup6dmxmTSNTdSOEMfQwUOh0i/eGL2Lf+L7J0adpQSTJOlrIXkE+K9rdAmj/b2+dBExtDgOKOFS49mFNS2u8My+4GUQrvktSvfNQ0EutqgIczh3fMFCdKpcMBgYGTpAYU6GK1+pkJG60YX3Y0+N6xZwIQdEbI6sb6nkAkTDj9FQHWf7PvdFiTdBZKnYdYNyAlMhzaKH3i+8bM5mXUyaUjZWKImV454Xt43nKxR4kKGos8/4fDOlVMtkF6/tE35gZQ5NikbQ2GDhMoOZ1mI9deEF58ILW4QnPPZFaoguOvbti3EyRipaA==;5:xgSm40Wb1jAS6BVOGhHfpmHc1R6fE7+tKLWE/A6YAfeglyW+bVzzCebElB2Ll5usovmgd5hFKJ4Q3r9ElISTMUpfnA7g2Gk/ku27UPu9S5Vr/Na8S89RiIHaWLgS5NjQxbQBVYD0Y6BH87D3kw+KYVMB8J9UDz5XXXvH6kZe/0U=;7:gD/KJ6mNlaZAx+IDAl2y0s4TPbipNZTuDPhbWCl2JegoHf7p0TvBZDrMfy47Q+/mGHMk688PJ6eb4G8QZv2Lz/5L15VoY152iqXBAcQUcWSuMmRqKKMWUGnfemlnBSUqRjsxbUM3vahukKiSoj+bDw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;20:hZb5ovpK12PSx9fTSN+6kJNp3jc6U58oI51AtXt588hcMM4Saciq+P6CQCLIh6t2Xk93cNNrtR0OQYQL8OU/wwP+QIFyYRYEEoA0Z0vvd3CaJ6zJlkouxUte8MTCqBydjcYwJtmHZFXyleeSk8Lt5hUgZxJv1HW1laa18n91gwfH4buG6WQ46AHbTxveKQnZ28NmPojv/Kw0WWUBUbhUaXSRQkGoRt3JFwtEXqxGz9p+hQ/NPKHWShYXKOXuGuBS
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:19.5722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde0173f-07b8-46e0-24c9-08d641b519de
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4101
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds supports for detecting Host/Device mode.
Controller has additional OTG register that allow
implement even whole OTG functionality.
At this moment patch adds support only for detecting
the appropriate mode based on strap pins and ID pin.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Makefile |   2 +-
 drivers/usb/cdns3/core.c   |  22 ++--
 drivers/usb/cdns3/drd.c    | 219 +++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/drd.h    | 122 +++++++++++++++++++++
 4 files changed, 356 insertions(+), 9 deletions(-)
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 083676c7748f..d4ccfb49d844 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
 
-cdns3-y					:= core.o
+cdns3-y					:= core.o drd.o
 cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o
 cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
 cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 727136235957..20ae9e76940e 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -18,6 +18,7 @@
 #include "core.h"
 #include "host-export.h"
 #include "gadget-export.h"
+#include "drd.h"
 
 static inline struct cdns3_role_driver *cdns3_role(struct cdns3 *cdns)
 {
@@ -70,8 +71,10 @@ static void cdns3_set_role(struct cdns3 *cdns, enum cdns3_roles role)
 static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
 {
 	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
-		//TODO: implements selecting device/host mode
-		return CDNS3_ROLE_HOST;
+		if (cdns3_is_host(cdns))
+			return CDNS3_ROLE_HOST;
+		if (cdns3_is_device(cdns))
+			return CDNS3_ROLE_GADGET;
 	}
 	return cdns->roles[CDNS3_ROLE_HOST]
 		? CDNS3_ROLE_HOST
@@ -141,6 +144,12 @@ static irqreturn_t cdns3_irq(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
+	if (cdns->dr_mode == USB_DR_MODE_OTG) {
+		ret = cdns3_drd_irq(cdns);
+		if (ret == IRQ_HANDLED)
+			return ret;
+	}
+
 	/* Handle device/host interrupt */
 	if (cdns->role != CDNS3_ROLE_END)
 		ret = cdns3_role(cdns)->irq(cdns);
@@ -202,12 +211,8 @@ static void cdns3_role_switch(struct work_struct *work)
 	bool device, host;
 
 	cdns = container_of(work, struct cdns3, role_switch_wq);
-
-	//TODO: implements this functions.
-	//host = cdns3_is_host(cdns);
-	//device = cdns3_is_device(cdns);
-	host = 1;
-	device = 0;
+	host = cdns3_is_host(cdns);
+	device = cdns3_is_device(cdns);
 
 	if (host) {
 		if (cdns->roles[CDNS3_ROLE_HOST])
@@ -286,6 +291,7 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (ret)
 		goto err3;
 
+	ret = cdns3_drd_probe(cdns);
 	if (ret)
 		goto err3;
 
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
new file mode 100644
index 000000000000..5d988432edb8
--- /dev/null
+++ b/drivers/usb/cdns3/drd.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver.
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/usb/otg.h>
+
+#include "gadget.h"
+#include "drd.h"
+
+/**
+ * cdns3_set_mode - change mode of OTG Core
+ * @cdns: pointer to context structure
+ * @mode: selected mode from cdns_role
+ */
+void cdns3_set_mode(struct cdns3 *cdns, u32 mode)
+{
+	u32 reg;
+
+	switch (mode) {
+	case CDNS3_ROLE_GADGET:
+		dev_info(cdns->dev, "Set controller to Gadget mode\n");
+		writel(OTGCMD_DEV_BUS_REQ | OTGCMD_OTG_DIS,
+		       &cdns->otg_regs->cmd);
+		break;
+	case CDNS3_ROLE_HOST:
+		dev_info(cdns->dev, "Set controller to Host mode\n");
+		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
+		       &cdns->otg_regs->cmd);
+		break;
+	case CDNS3_ROLE_OTG:
+		dev_info(cdns->dev, "Set controller to OTG mode\n");
+		reg = readl(&cdns->otg_regs->ctrl1);
+		reg |= OTGCTRL1_IDPULLUP;
+		writel(reg, &cdns->otg_regs->ctrl1);
+
+		/* wait until valid ID (ID_VALUE) can be sampled (50ms). */
+		mdelay(50);
+		break;
+	default:
+		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
+		return;
+	}
+}
+
+static int cdns3_otg_get_id(struct cdns3 *cdns)
+{
+	int id;
+
+	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
+	dev_dbg(cdns->dev, "OTG ID: %d", id);
+	return id;
+}
+
+int cdns3_is_host(struct cdns3 *cdns)
+{
+	if (cdns->dr_mode == USB_DR_MODE_HOST)
+		return 1;
+
+	return 0;
+}
+
+int cdns3_is_device(struct cdns3 *cdns)
+{
+	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * cdns3_otg_disable_irq - Disable all OTG interrupts
+ * @cdns: Pointer to controller context structure
+ */
+static void cdns3_otg_disable_irq(struct cdns3 *cdns)
+{
+	writel(0, &cdns->otg_regs->ien);
+}
+
+/**
+ * cdns3_otg_enable_irq - enable id and sess_valid interrupts
+ * @cdns: Pointer to controller context structure
+ */
+static void cdns3_otg_enable_irq(struct cdns3 *cdns)
+{
+	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
+	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
+}
+
+/**
+ * cdns3_drd_init - initialize drd controller
+ * @cdns: Pointer to controller context structure
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static void cdns3_drd_init(struct cdns3 *cdns)
+{
+	cdns3_otg_disable_irq(cdns);
+	/* clear all interrupts */
+	writel(~0, &cdns->otg_regs->ivect);
+
+	cdns3_set_mode(cdns, CDNS3_ROLE_OTG);
+
+	cdns3_otg_enable_irq(cdns);
+}
+
+/**
+ * cdns3_core_init_mode - initialize mode of operation
+ * @cdns: Pointer to controller context structure
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_core_init_mode(struct cdns3 *cdns)
+{
+	int ret = 0;
+
+	switch (cdns->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		cdns3_set_mode(cdns, CDNS3_ROLE_GADGET);
+		break;
+	case USB_DR_MODE_HOST:
+		cdns3_set_mode(cdns, CDNS3_ROLE_HOST);
+		break;
+	case USB_DR_MODE_OTG:
+		cdns3_drd_init(cdns);
+		break;
+	default:
+		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
+			cdns->dr_mode);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+irqreturn_t cdns3_drd_irq(struct cdns3 *cdns)
+{
+	irqreturn_t ret = IRQ_NONE;
+	u32 reg;
+
+	if (cdns->dr_mode != USB_DR_MODE_OTG)
+		return ret;
+
+	reg = readl(&cdns->otg_regs->ivect);
+	if (!reg)
+		return ret;
+
+	if (reg & OTGIEN_ID_CHANGE_INT) {
+		int id = cdns3_otg_get_id(cdns);
+
+		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
+			cdns3_otg_get_id(cdns));
+
+		if (id)
+			cdns->desired_role = CDNS3_ROLE_GADGET;
+		else
+			cdns->desired_role = CDNS3_ROLE_GADGET;
+
+		queue_work(system_freezable_wq, &cdns->role_switch_wq);
+
+		ret = IRQ_HANDLED;
+	}
+
+	writel(~0, &cdns->otg_regs->ivect);
+	return IRQ_HANDLED;
+}
+
+int cdns3_drd_probe(struct cdns3 *cdns)
+{
+	enum usb_dr_mode dr_mode;
+	int ret = 0;
+	u32 state;
+
+	state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
+
+	dr_mode = cdns->dr_mode;
+	if (state == OTGSTS_STRAP_HOST) {
+		dev_info(cdns->dev, "Controller strapped to HOST\n");
+		dr_mode = USB_DR_MODE_HOST;
+		if (cdns->dr_mode != USB_DR_MODE_HOST &&
+		    cdns->dr_mode != USB_DR_MODE_OTG)
+			ret = -EINVAL;
+	} else if (state == OTGSTS_STRAP_GADGET) {
+		dev_info(cdns->dev, "Controller strapped to HOST\n");
+		dr_mode = USB_DR_MODE_PERIPHERAL;
+		if (cdns->dr_mode != USB_DR_MODE_PERIPHERAL &&
+		    cdns->dr_mode != USB_DR_MODE_OTG)
+			ret = -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(cdns->dev, "Incorrect DRD configuration\n");
+		return ret;
+	}
+
+	//Updating DR mode according to strap.
+	cdns->dr_mode = dr_mode;
+
+	dev_info(cdns->dev, "Controller Device ID: %08lx, Revision ID: %08lx\n",
+		 CDNS_RID(readl(&cdns->otg_regs->rid)),
+		 CDNS_DID(readl(&cdns->otg_regs->did)));
+
+	state = readl(&cdns->otg_regs->sts);
+	if (OTGSTS_OTG_NRDY(state) != 0) {
+		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
+		return -ENODEV;
+	}
+
+	ret = cdns3_core_init_mode(cdns);
+
+	return ret;
+}
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
new file mode 100644
index 000000000000..85731f3b693c
--- /dev/null
+++ b/drivers/usb/cdns3/drd.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence USB3 DRD part of USBSS driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ */
+#ifndef __LINUX_CDNS3_DRD
+#define __LINUX_CDNS3_DRD
+
+#include <linux/usb/otg.h>
+#include <linux/phy/phy.h>
+#include "core.h"
+
+/*  DRD register interface. */
+struct cdns3_otg_regs {
+	__le32 did;
+	__le32 rid;
+	__le32 capabilities;
+	__le32 reserved1;
+	__le32 cmd;
+	__le32 sts;
+	__le32 state;
+	__le32 reserved2;
+	__le32 ien;
+	__le32 ivect;
+	__le32 refclk;
+	__le32 tmr;
+	__le32 reserved3[4];
+	__le32 simulate;
+	__le32 override;
+	__le32 susp_ctrl;
+	__le32 reserved4;
+	__le32 anasts;
+	__le32 adp_ramp_time;
+	__le32 ctrl1;
+	__le32 ctrl2;
+};
+
+/* CDNS_RID - bitmasks */
+#define CDNS_RID(p)			((p) & GENMASK(15, 0))
+
+/* CDNS_VID - bitmasks */
+#define CDNS_DID(p)			((p) & GENMASK(31, 0))
+
+/* OTGCMD - bitmasks */
+/* "Request the bus for Device mode. */
+#define OTGCMD_DEV_BUS_REQ	BIT(0)
+/* Request the bus for Host mode */
+#define OTGCMD_HOST_BUS_REQ		BIT(1)
+/* Enable OTG mode. */
+#define OTGCMD_OTG_EN			BIT(2)
+/* Disable OTG mode */
+#define OTGCMD_OTG_DIS			BIT(3)
+/*"Configure OTG as A-Device. */
+#define OTGCMD_A_DEV_EN			BIT(4)
+/*"Configure OTG as A-Device. */
+#define OTGCMD_A_DEV_DIS		BIT(5)
+/* Drop the bus for Device mod	e. */
+#define OTGCMD_DEV_BUS_DROP		BIT(8)
+/* Drop the bus for Host mode*/
+#define OTGCMD_HOST_BUS_DROP		BIT(9)
+/* Power Down USBSS-DEV. */
+#define OTGCMD_DEV_POWER_OFF		BIT(11)
+/* Power Down CDNSXHCI. */
+#define OTGCMD_HOST_POWER_OFF		BIT(12)
+
+/* OTGIEN - bitmasks */
+/* ID change interrupt enable */
+#define OTGIEN_ID_CHANGE_INT		BIT(0)
+/* Vbusvalid fall detected interrupt enable.*/
+#define OTGIEN_VBUSVALID_RISE_INT	BIT(4)
+/* Vbusvalid fall detected interrupt enable */
+#define OTGIEN_VBUSVALID_FALL_INT	BIT(5)
+
+/* OTGSTS - bitmasks */
+/*
+ * Current value of the ID pin. It is only valid when idpullup in
+ *  OTGCTRL1_TYPE register is set to '1'.
+ */
+#define OTGSTS_ID_VALUE			BIT(0)
+/* Current value of the vbus_valid */
+#define OTGSTS_VBUS_VALID		BIT(1)
+/* Current value of the b_sess_vld */
+#define OTGSTS_SESSION_VALID		BIT(2)
+/*Device mode is active*/
+#define OTGSTS_DEV_ACTIVE		BIT(3)
+/* Host mode is active. */
+#define OTGSTS_HOST_ACTIVE		BIT(4)
+/* OTG Controller not ready. */
+#define OTGSTS_OTG_NRDY_MASK		BIT(11)
+#define OTGSTS_OTG_NRDY(p)		((p) & OTGSTS_OTG_NRDY_MASK)
+/*
+ * Value of the strap pins.
+ * 000 - no default configuration
+ * 010 - Controller initiall configured as Host
+ * 100 - Controller initially configured as Device
+ */
+#define OTGSTS_STRAP(p)			(((p) & GENMASK(14, 12)) >> 12)
+#define OTGSTS_STRAP_NO_DEFAULT_CFG	0x00
+#define OTGSTS_STRAP_HOST_OTG		0x01
+#define OTGSTS_STRAP_HOST		0x02
+#define OTGSTS_STRAP_GADGET		0x04
+/* Host mode is turned on. */
+#define OTGSTSE_XHCI_READYF		BIT(26)
+/* "Device mode is turned on .*/
+#define OTGSTS_DEV_READY		BIT(27)
+
+/* OTGREFCLK - bitmasks */
+#define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
+
+/* OTGCTRL1 - bitmasks */
+#define OTGCTRL1_IDPULLUP		BIT(24)
+
+int cdns3_is_host(struct cdns3 *cdns);
+int cdns3_is_device(struct cdns3 *cdns);
+int cdns3_drd_probe(struct cdns3 *cdns);
+void cdns3_set_hw_mode(struct cdns3 *cdns, u32 mode);
+irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
+
+#endif /* __LINUX_CDNS3_DRD */
-- 
2.17.1

