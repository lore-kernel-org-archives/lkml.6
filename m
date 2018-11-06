Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE76DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0F2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SzyhGLcP";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MhMRiHSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbeKGAOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:14:36 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54166 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388428AbeKGAOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:14:35 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA6EhoY4023014;
        Tue, 6 Nov 2018 06:48:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=+q5NRUmpOmD6gGJ9A77PJFKYMy68xM/3gj6x2a/UJEs=;
 b=SzyhGLcP0f9FpHFoXWxFIGJRmretY0DI9rhS2KVY7ixFm0oLWuUYYhIzrUUFv6b4SS+2
 f8D0lVPD/+hhT2BAkZlXtWu0bucIDSXJkx1u1M3Fj7aag1Ben/MI6bavrBoj038osvr7
 QRGNoLPx4pfSIjlgSafcr/gVNLy3UHE7SxwYDmCB7XfE1NlGGU9qkc77EcZh/f5yVsd+
 J7c5EdXWkAQYkHcd8B2uRrtuH3UNNQPoKmSHb5UXBpWB3jByhWdP66EnMLlEG6atqHo7
 31AXUTrhwc2mF4KKONveU+A1tucyvHAjXRVcWkyPvzluytSTW3ca3bzjbh11aaGVF8R3 IA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp0048.outbound.protection.outlook.com [216.32.180.48])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9edpspf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 06:48:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q5NRUmpOmD6gGJ9A77PJFKYMy68xM/3gj6x2a/UJEs=;
 b=MhMRiHSe1np+zqPzeVKyUJc+nEqgzdWWECiifZxuRGWTPmHmZVt6cBddyHsDIxtPl1heWU9WODiuGMgdD5Pf9YVKro+37fmOJl/lO/ooS406/6AfHTFLKB5oCKygHcTXaYq2ZMCCaPlE2roytZy7EBScZhXyEWgFyEmbeFI7bj0=
Received: from DM6PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:94::25) by
 DM6PR07MB5180.namprd07.prod.outlook.com (2603:10b6:5:4e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.33; Tue, 6 Nov 2018 14:48:41 +0000
Received: from CO1NAM05FT046.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by DM6PR07CA0012.outlook.office365.com
 (2603:10b6:5:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20 via Frontend
 Transport; Tue, 6 Nov 2018 14:48:41 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT046.mail.protection.outlook.com (10.152.96.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Tue, 6 Nov 2018 14:48:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA6Emb94019925
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 6 Nov 2018 06:48:39 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 6 Nov 2018 15:48:41 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 6 Nov 2018 15:48:41 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wA6Emapf011268;
        Tue, 6 Nov 2018 14:48:36 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wA6EmXPJ011210;
        Tue, 6 Nov 2018 14:48:33 GMT
From:   Damian Kos <dkos@cadence.com>
To:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <dkos@cadence.com>, <rafalc@cadence.com>, <piotrs@cadence.com>,
        <pgaj@cadence.com>, <quentin.schulz@bootlin.com>,
        <jbergsagel@ti.com>
Subject: [RFC PATCH] drm/bridge: add support for FEC in mhdp8546 driver
Date:   Tue, 6 Nov 2018 14:47:20 +0000
Message-ID: <1541515642-9603-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(36092001)(189003)(199004)(6666004)(51416003)(246002)(50466002)(478600001)(87636003)(8676002)(50226002)(4326008)(8936002)(26005)(48376002)(26826003)(110136005)(54906003)(16586007)(42186006)(316002)(14444005)(106466001)(486006)(476003)(126002)(336012)(426003)(2616005)(186003)(5660300001)(2201001)(86362001)(47776003)(36756003)(305945005)(356004)(7636002)(2906002)(105596002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5180;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT046;1:istlpLkPApYAw4dJAtDDp+Ui0F3LbgV/LZMPLXXvIts5hQ/BmiFvfNcUB/gngSb+yMJv4BPiIDhrCGspfUj0JWdKrmJShnQohbmfnexByOKGhClOYwhSflO7BHXWUonm
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb44b044-bc5b-45fd-780e-08d643f6f15f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR07MB5180;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;3:xxTPBsB7G8X0lOYrSOmXxtFbbwB2oUpLaD0thetK82Oi7mzk3pPDbMXOUevtaqeLee1HNA2/jczqX05IOp46ci4PWRuumNQnhlU7/gHVZmsA/NUkQ9pRLjtRA3OEp/mRENflAx8PG5aGX0CAPj7dtaxS9lpsiTjofRoaEwDg5r+PzH+/h/ahjoBBtE32biouJ+E86UyQGVye7cMCc70Dnc2xhRBwLKvTVh0LiNlCm/gcfHsicXi+iVUduukwZLbxQRaUORjxG26cbYeh9BM54K/+aIM9LBgY+KJf+PZvrnd6FVaAGUqKN1HawsWlNiD5L3lMiWhRhQ2IjFOGWYn9tEVXmT001E99l01p5GjamII=;25:i53o3HWEaegU6M9l73WoKI3kKTKIUpTXE2sE+nfew9HGMg8IIvBUfjNu4qt5kMlHpZEnPygFdEBTJ7JjB0qHaK92+q4Snca1uP0i1AnDk80n004DpD07K0shC0Kk7lbXzFpGK/mgakPXrXpIv2sak4wJsuUKPqcSQ1fqiAR3fzgo30PvwKIj3xJnPrKg2HIClmq+qmBtaxj4oH7YaYoGYPAcCDP4P26vnzmfJI0NXXi0aDRKsQ2eJoVctvK6aYgF25TNpgdVZxet0mRau5TA02bTWKEn/2sOod8NyXzaOQJZHaO+l0xekVPXykSr9Muc147091h1mRiZjV9W/QZssw==
X-MS-TrafficTypeDiagnostic: DM6PR07MB5180:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;31:y6gTSOmlm8L2+qhChiWgPcm6ndC62l7qBIxARLyhZv56uzeWffS78IUT8Qc2XUDRUi/+U/VPz89r4GpDV+04kcmBsjemx3Cpw9EyhD1CRBHzwTCUkj/yB7Cm4HkyDuqvM0mlaXJFKNZyXSK3kYi3OKnKxReEqKJpt6pbXJC8NRu2YNBS7q9ZwfNB2eHXmplpGuseBRe2W3BpJQtlnj9IwIzEWvtksbi5tuqyqb2vLQ0=;20:w8+yM9UsHWmfE3O7Ci24+nAEpd5t/GtsKmHhu0yjEhrtc9iD3XdmoHojPId+CF8Kv9MR5Cv+lFlGoWv7yUgFgphwfAqqy/Q6LLq0QNmAeTsau8HRFfWK7Q0o7tQTmKRsQkA5RDjMMqAX4ZCYm/Of+lbYUejlZH+SDRGumJMO8WW47NLIpztJw4u+zdl5rR157XDjPkpunov1Y/J3Hef9UagqEODbpMinHnizxOsnduhuPVncKV1G3Tjq19YA9JudaOVYbk62+M3G0uEUyLAg9r9+cewZM0LC34yejkprulGpuIm1frRs/o94RVkbgfrqFKjk/GwhCxSQ058s+31oSncNzbYO82bSXdiO+gFgCxaHWZ/QrwgxWb+0zXKLfIvmMVgb7+jl/X5RN0EUURrt5VN9Xpe2l/BB7DNe538ejkcx9VbrFPCxOsSIzpj2aSuNpN3OvDtXRJ20zLmOQZpC3+HBpItKbbb/di2O4fK0aIMkjINlhhKaToHpaIVraCSW
X-Microsoft-Antispam-PRVS: <DM6PR07MB518082532D07D031D0AE4DF4CDCB0@DM6PR07MB5180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM6PR07MB5180;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5180;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;4:Hsx1kgyU4Crj5Hx7lJFaBqhxcHZs96doHMd2OS3Ds3B59uoTaq5I2XJwwbob4Am3bogvExaTxtVPzMvUp1iSqSMGnWEwv4kqw97cNCenrGbOI4mlpuTIEDpK2tuwf3CanXtXBCNqE9wWLGWCdBYF4D+/+Bvz5bht8HAPpiXEG0lvVsgXH0pOYNQTRy11HfIh7Ivx15s4iMJIkKBygNVxFvqZnifm0HomNW7z2gczoOK2oTlCBqETR2oKbtXgXVBsCr1KyUeu0T/yxCi5XE3j6ldHpTgfEObPkhcuNq6SQAEkvatz88x6RiRaRaWOQtxz
X-Forefront-PRVS: 0848C1A6AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB5180;23:NANxIKEP9xauv+J7cwfxEsSSYGOcmqDPFcJ5N47y3?=
 =?us-ascii?Q?0GuOM7S/DH+jX1qfxiu6daKnXNqMQlOuIcuoEKTw7VJsssNC4zuqf9GbV3mN?=
 =?us-ascii?Q?6RLTXIM8siuHwxRilh5wmkVzACQRNWWYJEcTF1f4lssuG1wu9AHyMmngPqP/?=
 =?us-ascii?Q?E/LZ8exGFZZQtou5g6I62jtV+4jfirNSI4kAcx8opZMegRagmuLkisGe5RF/?=
 =?us-ascii?Q?mCmYQe/3uaI6E4GY6QLBIdFo3oeWQt5mBHXymGKeQVWj6L1xonCS4/ZI3sqj?=
 =?us-ascii?Q?LTpUVjFvTpiF6UmanamTvmJJ6EVfWkCCTHpEvoYFxknQ1GBJEats53y33XMY?=
 =?us-ascii?Q?qteMGOSPh7Dr7CEysgwxWisT7K9lWtWaEqHgCoMOSB6Iy711tvRS0KJtSDae?=
 =?us-ascii?Q?uhEoWP9al0m7ggRhBNiVQlqNhSeRoRE/vla289lGH7/CAkpjSQfaqBWoZBgW?=
 =?us-ascii?Q?sn1ruejB3HGGWCn12nrzsEQER2h6DA8crxu491+3cKfOg3uYyQOnncU2cn+Q?=
 =?us-ascii?Q?J+mpqXlSktDYX8w8qNj+KUaDMQVrPLOHZPB/LzwvZ1Ay1Noo4R+oUTkEfbxu?=
 =?us-ascii?Q?arH8ZjjB11zn40S9MnMPCkglkTpUuMi5Kk7QPrEf48oF+nkUX6HP/x+N9WDM?=
 =?us-ascii?Q?EKOs9F9Ry6PJcVvkQVQM5Jvjai1QcLXYHs+j0UXMoWkU31v1cBPQO+Lf/CLZ?=
 =?us-ascii?Q?yn81XKLv80d3ddW4QGVxMbPeqPs/pwSMxWFHweeHzIv/WhMn6QHEIB5OLjaw?=
 =?us-ascii?Q?usOQCBNmJ82wXx8hbU1bHRy1viqZP7CDv92S1ac4z6TwWxzXWNLST+E6Oa3G?=
 =?us-ascii?Q?Iz+iL6n7mGji1rzYvZ1f18NaPBmCf1zIq3R88uHdRLpUot6PZSAuwjCf3W/M?=
 =?us-ascii?Q?cGNpEkOofnXTZ2RAdoq4FXZSPK/2bte2cl2PmCs9u2Otnr3ue9zYGBr7PF3c?=
 =?us-ascii?Q?qc5QU4HXgZu5TDYevwDrqXdsF2I1OfEYby06ViF3g/26lyEJ6CXLP40dC32u?=
 =?us-ascii?Q?1p7dMNVC3VQWFiAx07Fg4kx79EIBoh+Tb3V2AU+eUjvrw=3D=3D?=
X-Microsoft-Antispam-Message-Info: +uR+yzocDLlgRE8pIw83mPNgxJiOP5U24sZrGsvRvsAPKXfH3DiWn45VaRRyynvlkFEITa83Ll+X6638YaS3pznNvbD5xGbU1EXoN0jFfNN9dWkSpfB4VTDGgHHYUgnIvJ1juflbWxMsm96V9b0VuEwHP4zFTYgOFO2SwuN0g6jZRjR/u29tVO97PzxJgrOm1PiqIDj4Q6Vlxrwc9ufvX8JvX4hYi6wr5oxNAWhuHFdbdI/2JKyWR5B6NkH8jY/H8j5ntxdyOxzX7rJ5N6U5Aj4a4kcaQK6+UMaAUinIivgWTEmCskMyn0vL2oh0LOgX14tdYm1KN+8tSEgttlxINpD2Bu5+4TcMDFd2Wuo4A90=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;6:wVPIy1Lg3clzS3yUX0HZf1rrOD6UHouUBiOFi9ql2tgR9c/N9UkJfbBhFgoK4lIyiM0UDPra3c0NBWnw0ptrTQsiGm9wAIJ1tdOhh+n2hOMcGjVERUtRhtWPFDZ0C2JkznjY/VunFkeIAoJGqtgemnyGTU5xY5G4FpdvSZPpBh0OkOKFDwvkldNKWXLzo0sNMnnauibSuTaOqdIDXA8WYncTeCvavrQqJ+c1WVbfNCFqWjTEbOPcRyuShhj5gBKLtu+yRJ+0YHmxb+0qgIixCL1JyvMy9GyRYWaV3HCTejd2fKjMm5NUCmk+wl0c16kSLt1qpomx7Qc5NJm9Eq1avj0QSl3wqjoiUyGnt9YDwLnVyEsC4Vq2yPJn+mzNtsqabKEgcq1YtDmklBCcHfl26z8P4s3u1oJN4LrY4QOboDzw7oEqoN1lpKHg3mZov6HiEXFly6/jim1q4CkgQTGVRA==;5:OA4QYOfSxUC1rInMaYCTs59qZyPytA6Z5+jXaTpd+F2qGEQikmijx/s1IEGwLJgjAHuz8yZmtkqAV1POLPRFZrBLCYcifRo1RHGwDsw1Mj2lbm5dnlzYPUNmDBaBbZZBIext79k3zBkRtDpCjt8K0odwC3HSo/XyzEPW05vMwKY=;7:cuv+Hzu76j1Aq6YaG/X+U9MPjrhrFlFYVUz9nkHhjzyWsMYek73NL3H6QUxhQbDhIJs2KDum1RFc+V40nWa0pFdZWSpy3g40XZe7GjuUsjnEczZdzac1oN2rGW+0qfrJQbSRSF9hdsPVmBNkrWKbaA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;20:Cu79iuUQdIk99T91/cAxrrJDr9o5ux28mqDnIajWb4zlSINesgaRAVlUnMB9KXWfUAYAMLQ1gYbG2cb4o/klyjYjLgdyFPZ6rs7Ic5cJIxIbhF1pPruKuS4viOhQOp5wvIfLm/I0j94/9Ob5jhmHINnvLBE46zNnXiYTN0YxmGWig6TQoLxQt3/0Oxhiq36A0+2MX/enFmnDlpn1vxfWL4Hqj0Qb9+NqeFPmPBltIkWKqelepN6/WVPn+VNk2n1G
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2018 14:48:40.7272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb44b044-bc5b-45fd-780e-08d643f6f15f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5180
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Przemyslaw Gaj <pgaj@cadence.com>

This patch enables FEC (Forward Error Correction) on Cadence DisplayPort
controller if it's supported by the Sink.

This patch is an addition to patch with mhdp8546 driver @
patchwork.kernel.org/cover/10632065/

Signed-off-by: Przemyslaw Gaj <pgaj@cadence.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/cdns-mhdp.c    | 138 ++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.h    |   4 +-
 include/drm/bridge/cdns-mhdp-common.h |   2 +
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
index caaf3c17d74f..3bfe1eda1468 100644
--- a/drivers/gpu/drm/bridge/cdns-mhdp.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -392,6 +392,127 @@ static void mhdp_adjust_requested_eq(struct cdns_mhdp_device *mhdp,
 	}
 }
 
+static int cdns_mhdp_wait_for_fec(struct cdns_mhdp_device *mhdp,
+				  bool expected_status)
+{
+	u32 fec_status;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FEC_STATUS, &fec_status);
+	while (((fec_status & CDNS_DP_FEC_BUSY) != expected_status) &&
+		 time_before(jiffies, timeout)) {
+		cdns_mhdp_reg_read(mhdp, CDNS_DP_FEC_STATUS, &fec_status);
+		cpu_relax();
+	}
+
+	if (time_after_eq(jiffies, timeout)) {
+		DRM_DEV_ERROR(mhdp->dev, "Timeout while waiting for FEC\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cdns_mhdp_fec_sink_support(struct cdns_mhdp_device *mhdp)
+{
+	int ret;
+	u16 dpcd_buffer;
+
+	ret = drm_dp_dpcd_read(&mhdp->aux, DP_FEC_CAPABILITY, &dpcd_buffer, 1);
+	if (ret)
+		return ret;
+
+	if (!(dpcd_buffer & DP_FEC_CAPABLE)) {
+		ret = -ENOTSUPP;
+		DRM_DEV_ERROR(mhdp->dev, "sink does not support FEC: %d\n",
+			      ret);
+		goto err;
+	}
+
+	ret = 0;
+
+err:
+	return ret;
+}
+
+static int cdns_mhdp_fec_sink_set_ready(struct cdns_mhdp_device *mhdp,
+					bool enable)
+{
+	int ret;
+	u16 dpcd_buffer;
+
+	ret = drm_dp_dpcd_read(&mhdp->aux, DP_FEC_CONFIGURATION,
+			       &dpcd_buffer, 1);
+	if (ret)
+		goto err;
+
+	if (enable)
+		dpcd_buffer |= DP_FEC_READY;
+	else
+		dpcd_buffer &= ~DP_FEC_READY;
+
+	ret = drm_dp_dpcd_write(&mhdp->aux, DP_FEC_CONFIGURATION,
+				&dpcd_buffer, 1);
+	if (ret)
+		return 0;
+
+err:
+	DRM_DEV_ERROR(mhdp->dev, "cannot set sink FEC ready: %d\n", ret);
+	return -EIO;
+}
+
+static int cdns_mhdp_fec_set_ready(struct cdns_mhdp_device *mhdp, bool enable)
+{
+	int ret;
+
+	ret = cdns_mhdp_fec_sink_support(mhdp);
+	if (ret)
+		goto err;
+
+	ret = cdns_mhdp_fec_sink_set_ready(mhdp, enable);
+	if (ret)
+		goto err;
+
+	ret = cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_FEC_CTRL, 1, 1, enable);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	return ret;
+}
+
+static int cdns_mhdp_fec_enable(struct cdns_mhdp_device *mhdp, bool enable)
+{
+	int ret;
+	u32 resp;
+	unsigned int dp_framer_global_config;
+
+	if (mhdp->fec_enabled == enable) {
+		ret = -EEXIST;
+		goto err;
+	}
+
+	ret = cdns_mhdp_reg_read(mhdp, DP_FRAMER_GLOBAL_CONFIG, &resp);
+	if (ret)
+		goto err;
+
+	dp_framer_global_config = be32_to_cpu(resp);
+	pr_err("0x%.8x\n", dp_framer_global_config);
+	if (!(dp_framer_global_config & CDNS_DP_NO_VIDEO_MODE)) {
+		ret = -EIO;
+		goto err;
+	}
+
+	ret = cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_FEC_CTRL, 0, 1, enable);
+
+	return cdns_mhdp_wait_for_fec(mhdp, enable);
+err:
+	DRM_DEV_ERROR(mhdp->dev, "set fec enable failed: %d\n", ret);
+	return ret;
+}
+
+
 static bool mhdp_link_training_channel_eq(struct cdns_mhdp_device *mhdp,
 					  u8 eq_tps,
 					  unsigned int training_interval)
@@ -769,6 +890,13 @@ static int cdns_mhdp_link_up(struct cdns_mhdp_device *mhdp)
 	amp[1] = DP_SET_ANSI_8B10B;
 	drm_dp_dpcd_write(&mhdp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
 
+	if (cdns_mhdp_fec_set_ready(mhdp, true)) {
+		mhdp->fec_enabled = false;
+		dev_info(mhdp->dev, "Cannot set FEC ready.\n");
+	} else {
+		mhdp->fec_enabled = true;
+	}
+
 	if (mhdp->host.fast_link & mhdp->sink.fast_link) {
 		/* FIXME: implement fastlink */
 		dev_dbg(mhdp->dev, "fastlink\n");
@@ -807,6 +935,14 @@ static int cdns_mhdp_sst_enable(struct drm_bridge *bridge)
 	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
 	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
 
+	if (mhdp->fec_enabled && cdns_mhdp_fec_enable(mhdp, true)) {
+		mhdp->fec_enabled = false;
+		dev_info(mhdp->dev, "Cannot enable FEC.\n");
+	} else {
+		mhdp->fec_enabled = true;
+	}
+
+
 	/* find optimal tu_size */
 	required_bandwidth = pxlclock * bpp / 8;
 	available_bandwidth = mhdp->link.num_lanes * rate;
@@ -814,6 +950,8 @@ static int cdns_mhdp_sst_enable(struct drm_bridge *bridge)
 		tu_size += 2;
 
 		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		if (mhdp->fec_enabled)
+			vs_f = (vs_f * 1024) / 1000; // 102.4 percent
 		vs = vs_f / 1000;
 		vs_f = vs_f % 1000;
 		/*
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.h b/drivers/gpu/drm/bridge/cdns-mhdp.h
index abc1fa3f51a6..ba233adf9fe7 100644
--- a/drivers/gpu/drm/bridge/cdns-mhdp.h
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.h
@@ -179,7 +179,9 @@
 #define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
 #define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
 #define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
-
+#define CDNS_DP_FEC_CTRL			(CDNS_DPTX_GLOBAL + 0x10)
+#define CDNS_DP_FEC_STATUS			(CDNS_DPTX_GLOBAL + 0x14)
+#define CDNS_DP_FEC_BUSY			BIT(0)
 
 #define to_mhdp_connector(x) container_of(x, struct cdns_mhdp_connector, base)
 #define to_mhdp_bridge(x) container_of(x, struct cdns_mhdp_bridge, base)
diff --git a/include/drm/bridge/cdns-mhdp-common.h b/include/drm/bridge/cdns-mhdp-common.h
index 1e8a44138ce2..52feeca3a914 100644
--- a/include/drm/bridge/cdns-mhdp-common.h
+++ b/include/drm/bridge/cdns-mhdp-common.h
@@ -566,6 +566,8 @@ struct cdns_mhdp_device {
 	bool can_mst;
 	bool link_up;
 	bool plugged;
+
+	bool fec_enabled;
 };
 
 void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp);
-- 
2.17.1

