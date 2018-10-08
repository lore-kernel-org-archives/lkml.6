Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02997C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B5B20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HccqJP5i";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mXNFglXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B5B20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJIE57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:57:59 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39834 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeJIE56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:57:58 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98LgB7a007396;
        Mon, 8 Oct 2018 14:43:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=qnfa+CAqtaxkmkHTxKFj1AflM6nxmky9xcuSi7gv/SQ=;
 b=HccqJP5iSGhWHugz9hGBas1NvYK3BWsRNf80d/jH8fkYFkD17AaRRJ11S9TuOt3BapkQ
 UOlZ0PmjcgWQWzEsR9jRg2qDdYtNHBT7w1qHHsEtLHnqau+W4ja4e5rZ/RPz8eJiGTkO
 EliTBfoR7G+ZZbvCNgZaBSR4shjTclDRM0tdf2mIOnb7VE1KzWcIT8+UqqaD0BnFUgXL
 PHpK/HSAHbyHe9C7p/RV666vB/yiQo+ayb/bhbCj/ldfGkfJh97EhdnJSGLX2Zi5kvLf
 nWwBz7aLk3eXzhFOOtN9ZBXVlCDJfTVvDvIaEsX1Xbrxa6Q3JVlCWnfxJFR6myf8jHDf Bw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0088.outbound.protection.outlook.com [216.32.181.88])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mxuwwt023-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:43:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnfa+CAqtaxkmkHTxKFj1AflM6nxmky9xcuSi7gv/SQ=;
 b=mXNFglXMP/CTwhfD1ARC/HuykvBn7HP0I/PJP8QfDMgwnu3pLQROdwbYGKmSObfjnnOD4jKGaPGUeu9sDHqBaXDUwiamCZNH/DT2rruHAlI9WCyLYAnQof/7N7aAwFmuEAgiSpUnHe7wLxDibrzyy19NsxOd/pceU2JfyHu782w=
Received: from SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) by BN6PR07MB2945.namprd07.prod.outlook.com
 (2603:10b6:404:42::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 21:43:16 +0000
Received: from DM3NAM05FT028.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by SN4PR0701CA0004.outlook.office365.com
 (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Mon, 8 Oct 2018 21:43:16 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT028.mail.protection.outlook.com (10.152.98.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Mon, 8 Oct 2018 21:43:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w98Lh9OS017190
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 8 Oct 2018 14:43:10 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 8 Oct 2018 23:42:54 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 8 Oct 2018 23:42:54 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w98LglHW012131;
        Mon, 8 Oct 2018 22:42:47 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w98LgcIj011933;
        Mon, 8 Oct 2018 22:42:38 +0100
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
Subject: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Mon, 8 Oct 2018 22:42:06 +0100
Message-ID: <1539034953-11274-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(36092001)(356003)(2906002)(2616005)(110136005)(476003)(7636002)(36756003)(7416002)(246002)(42186006)(316002)(105596002)(336012)(16586007)(426003)(48376002)(6666003)(5660300001)(86362001)(50226002)(186003)(51416003)(106466001)(305945005)(8936002)(4326008)(8676002)(87636003)(2201001)(486006)(126002)(54906003)(47776003)(478600001)(26826003)(14444005)(26005)(50466002)(21314002)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2945;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT028;1:FKY+1B+XdE+xWQdqVOTXXN8EYTA6rc55IDt5ErrURZHPMpGRv1YRgaQLR+rorjqyB1aswG26ewPBFPxf3yTQFfBHMt1B7wHTtCrHRUjYnAq57CMV4j/J1737jZ3A+yCG
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe54f24-23ce-4575-f36d-08d62d670e2e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN6PR07MB2945;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2945;3:T5bqdW3wLNtYyRp/rDKNXhScsMRT9uGTQm50Ifas6yTKt5fZekW4pnG+No+tQc0Fx7t6hyctVHpbrNaN1vL06ZpljiPbqufy3dhoDYmH4VwePwhVX3GgKkhyXeVZEjjyVAmnaLurIYwdYtsp1Cb+gCyDFWxkQMgImJJQ6hO7ACUDdYnxM1MsnLLX7yZirPy0E5G6urzxjq3s/VotdOaDxmFt25uwiiNUq2j/zOR321y0s3M28yImf+y9n2iACkUhOHYIkW8gZLNgv7OjgkAmm+YySn0EsQiA4Ve+ydxMCnGW/5SOcw4RvezdhswQC6CkKJ52DZ368M1V9XAGL1mdcEl7pwtwtH2X9mBlgVde13k=;25:guoIKeyY4g+1U7DA8u8LA9dG91J/WQfKEfPpUD7Z5+UMjJDz9UyJ/hILo3l5+vgCdykKHNH2hGQhpbd02nL0qVQgYYJ8/yCRpOFo75wYMqmUfVnxiKN8+czkYAnx57q0blJLRVGjQKJS+4TMAXGRRIsEjS65xBByGqyfqyej8oCSf81m0M5HTwMrFiUWf3KV7jzl3wJwXVr/EsGwDiRPmlAn04k4YUKH8t+/CSnsUPQfUVg27acL/LvbMShe+5QrUqvOrTguOwtUKruhgkohJi4JGBfuRySqQmpllzLZUrHEDIUUTRUrj+FNtwf7UUuBpp1BpcWSTjYjgd1ZLNdaaw==
X-MS-TrafficTypeDiagnostic: BN6PR07MB2945:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2945;31:nBzNs/83IsfCJFw6Eo8e0drxMoeVokYVp+yzgRSbN8qN3tt1oQ0z9nv/OrUSkqPA9RsaK3k9yXFvzj7QDmYuuplo36crjqqNt4kpAXSCmBh3edGJwIQmR67fqC1wu7YPh/WgAb0WYr+cFuC+JTfEB1tomLOqdp+KteC0ODcxY0hxdG6Kgwgvl8TpaL1c2N+HEo2Y+L/ua1Wzy3AD3HWCU6cGbiaRRHzZZ6Y3fKfIYQg=;20:tWqjEpD8ZrPbZCW8YAXbOHlcntrk5rimcu+hn+NpZftzxD3bEhhbdUkY3uqcwnaJUgNDe6AI2Wpy4C10MQSb+T7qMmxIakvhA3Fa5TQL34bhy/qrAFxpcTqe9BhdJLtZT/Y1yxZ2SfOyxTWx8oQ9sh5NuH2jS4YZ1eMG+Sa3XS+RNXD8+imABEEh/QlZlu6X1afrbUTIa8mxglk9G8jxoslYhMSYcO4+nW7EXASCXbjrWCrGhFZTGf9JcmCZFlFS5bPnU+q/3tdP7c5B7HvANAmZjkTZMXUkcGML7+S0LLQB2yOiNt10D3Jj71+NGhSgB7IdXPngzFXHGFIoehtwrUz15yhZOw7OS2VadidrKVDz1o17uZEO4FTO6R9h4WysTaAshU+XliYxmHi8uSlq9bwUfKXb3UfWD3JSTS1Qr05s4G5InmHF9VIg1H6a3HBmBmt1CUoGNmcKtkLKH6bYlZ978D87VLanWQx9xtSr9QRtOPRiYw6M1jLgXPlbOFwr
X-Microsoft-Antispam-PRVS: <BN6PR07MB2945E818516B39110E3DFB98CDE60@BN6PR07MB2945.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BN6PR07MB2945;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2945;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2945;4:fAC3DaM9mfpPEPGwGs8ATUIMcU4IngUCfSK2JaydkHCkB2W4EjeUsnRclPa225sQciEsn/17pfQfvAYRGVQtdMDXV5wla0G5ISXNQkDxm0WcFkPWxTVvSosSSxDLCNasbjI0/EWKkLkRaVy+KP8974JBwI9jmB5Cl+inmWtvSEd0nEzFl0P0VTjspJGwDFKn9FL73RQQ8dq50Jju+fSVRbaRMTHfUbd59QUsMh0bWEdMzNgzShpTZ4ffex9NKnW8ZOwzGIpugBKhJ3P2F2e5XA==
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2945;23:Fj2lrKhHiE0m2Htz+cO+t+e//iZaDAhAJWbPY97gv?=
 =?us-ascii?Q?xXHp1CRRRyP/es9vUEhBR53cIn1SYu6aAZ2mOsE4RDZtird5ZEUDxQiQw4s4?=
 =?us-ascii?Q?kkZCgjLMKgOeX2AXVQZhj5l4u9gTKbD6h8NGl5PAIR3vNZJn/HbTzJVVFtJP?=
 =?us-ascii?Q?ScQyt/D7fhBkS+QagdpNY/zw+23zDeV4rZ46yQFQ8npSmqcXE9OKV6tC9nxt?=
 =?us-ascii?Q?GJwM0qa0kPWy/RsBbMsyWpwrhpZxWG/0c9/SlzVZSX7qhFbDEQdSBWSFOUuP?=
 =?us-ascii?Q?TWFXALHpALYwQAyaYXWOMxv3dF0Br8T9oriM8QelXEBjiSgC+sTCOnH9/el1?=
 =?us-ascii?Q?fZLrE4/0CT5AT+mx+AwTaGVN4LaTSot6OTiDI4G8moxopaCKb37LY1rs8moc?=
 =?us-ascii?Q?n4CmY6H6GRv/ZyYM/vHp5KfsuWUYJ3/Ixc9NG9Ym/SUztZMiGBxDZ6lpVpcx?=
 =?us-ascii?Q?ul9gkefrhiyrhhbFvAEFbnzU3mVG0N4TwsorlAjCfwwEB/4iWHvNsFLev4Hf?=
 =?us-ascii?Q?A5TFHxmRTLHsPa2trLO8TObWHDdENG8/e1Yns4Ys/KaxWqaDAG3tGJzP5ZIr?=
 =?us-ascii?Q?qNz1RIlGR8qqfRuy0SGLddTa4yp9FEk8Yi0n7zczJbT5tKNs7AsUICPPVf6T?=
 =?us-ascii?Q?ZzITXtgVJcPQh/YKHmIHZ5U2qNHvHSeTVXjmhbqU6mkjQuL9FxKKJKSitp2N?=
 =?us-ascii?Q?mlpq5dU9NdaFu1ir041IdCrPcXjVJzUWM1TjBe7AV70MSDDqXa1o6EoDkrUH?=
 =?us-ascii?Q?zE4VYSJ0Ixebgy/eFkBkYUiR42ioi2pSScuYnFBgXW4B7wDVWuw3jPvBSweB?=
 =?us-ascii?Q?scsjDCjQP4t0qxiajHJUJ7cfvcrC+qL21d6PdDRTVfvZxFzAgThR+VX3FD4E?=
 =?us-ascii?Q?tlQaKwMgR7rf3cH+2VaxUpfFGG/SWVxnBRl8XTbiJpZu4xDzJYAleSLU259L?=
 =?us-ascii?Q?Osn+J5mKd+fKYFT9vlfsVzCYu/H0E4GaIf1smNJRwOMBuvJaFgFF8hmnz+Xo?=
 =?us-ascii?Q?uu2kmR5eb0dY1sAcfkYfLYR1eLmildA4Tw6nuVX1xx12KoFozPQZul3+pv/W?=
 =?us-ascii?Q?mJE1iXhFQZ3vub6QGcASNf2RUcNUDMAcw04aGCN7KLJySTtfV7IQCc0Sr99p?=
 =?us-ascii?Q?OsL9+6G2Kf7GllPgyjxtZZCyfm8b6dh?=
X-Microsoft-Antispam-Message-Info: 9FOM5rnts69IaeDEn0zPuYawdaahxjlaaXS4JtO1Yd6hbj+t+Fps6FAsSwh89uNOAInnkDmv9RDUKJIG+5mQiRzVibYkoWTkXWMKlG1KQoFRERYnGYecV2sJECNi0AJIHDmpe8nszl2t3AgKGUx741ZJLAiQJeut43UMhpNZd5MTWtwwkI1J7d4mRF5dqST7CH/gDkIXtKnVJwjpGRCqN/olDxgfnaRzDoL/h+VeWj+gf0YqG2fWLREJkKUVbBUJiy2DnTRo4wQbssATP7nEtJyongr8IYGJ54hQStyBR0HSR9tFJrkjl4S42G4xHmoLyMBsYbKmuBtzKKl2iK/XK4T5fwPyUPXpcgsY8iCyaNStVS0TDYGOhxPaCod0gG/7ARWb/vi4xuZfiTFZ+WjwzQ==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2945;6:VL6/yYoqQt1dR2ZAvHaHE9z3S+95dyr06L6XsmtRUNCGLKV45Ex8GFLs9cUyHTb3u6FVdrXe+v6EpXRKiT1bxTJbTPf9su8qoClLmhQLe8ydI64rATVrSl7Fqn7n53oXD/Q7nqaQmobSCxlsURCmP8b9pLVUzniWQrxY/HxPraVbjzSLAqXoYuhjPp3ltQdpJlefDDWxlKF2MCIp+0SUDftq1Xsrh7slxqiy4QipOGg1M0KJeCXQjV/YpasasL+0aL8Sn2Brlv727wZrqeOUg5qA1mptYVCT27AjgJYK9dQwlXqDKE8WjF1jo/Vtl6ydHiAbGA/EY9L8uOjF02kKU6fFuhXI//iPIy/LQd8KV7vS3hxdooMuMCjbv5nZbNBJ7lBxF9gvn0wUFLdM1XmAqyZNuFJTsn450wFdQCd8l3c+BVr21pmHGuQyKsXKdzxDbWPsbp/nIZ9CzxlBK1OuPw==;5:FhSIIHRVwJ5jq7nySTcDnrBa1gZRzSZWGOIAZqiVNpTzzIKImg+t2zUY8IqnIhjKX6H3Mg+9OmvXV8KCUY7gvnBXP9GjDmbMUiB+n9gLMULlnrBBDZbmix+4sVePEVOGK6RmNNHQSrHSQGtK2dSlTchor7lNToLlXbLltaUbqv4=;7:iEY7stCBTSbw8hl+qfajT1KfmnjtZ1MQBYnBbTIbV6xZYNVxoWa3nD8WjldrqlXt+FX7DFg2Aq7Lni/kHGeUck1fgkh0cok1nk9v4h8rB0y0KolPTOuvhr/6stHTs90wGYkZc1fqcVm0OirzDxjXbbSWugHEIjuMYKF9ivWncImDH9AUM9qMRGro1Lg9071incjkSTAxrtSxWt6sqhCh9XV3QZeZKBbP6tYUL86LAPc6nM+yIDeOl+ZTKGCr5eMx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2945;20:mAz1kgY+RE3DV44TYFPy7w2iVVuIzOMOwtmHSWqAjrEQnJC7lD6imNZN9xlkkEBh4wH3e4aq+enk4sI41rfVRhg3K/W8g3Lk1JTSGNCOLTRY/Z0cmAXpYAb2c78MxyYUBcMbkL0a9MpSjfAbNnqpCybiB9KP0FxhJ3t6u/UitsO+HtYOdndBIeYrD+m+y6pu8+9JzPRHM9XMe/1Wsb+p/HCwGIF5963FZbONBF0WPO9wykTtaz08K0R26pgtP63G
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 21:43:15.3436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe54f24-23ce-4575-f36d-08d62d670e2e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2945
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is the series of patches that will add support for the Cadence's DPI/DP
bridge. Please note that this is a preliminary version of the driver and there
will be more patches in the future with updates, fixes and improvements.
Please keep that in mind when looking at FIXME/TODO/XXX comments.

Initially, MHDP driver was developed as a DRM bridge driver and was planed to
be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
a driver for Cadence's DP controller developed by RockChip, but that driver
uses the different DRM framework and looks like a part of a bigger system.
Both controllers (including firmware) are quite different internally
(MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
etc.) but they have similar register map, except for Framer/Streamer (which is
noticeably different), so they appear similar.

The following patches contain:
- Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
  modifying it a bit (mostly new prefixes for functions and data types) so it
  can be used by two, higher level, drivers.
- Modifying existing RockChip's DP driver to use the common code after changes
  made to it (use the new cdns_mhdp_device structure and new function names).
- Modifying DRM helpers a bit. Some are required for new driver, some are
  updates from DP 1.2 to 1.3 or 1.4.
- Adding documentation for device tree bindings.
- Adding preliminary Cadence DPI/DP bridge driver.

Some of the things that will be added later on include (but are not limited
to):
- DSC support
- FEC support
- HDCP support

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.

Changes in v3:
- Corrected dt-bindings document
- Enabled some clocks at startup (since FW doesn't do that anymore).
- Changed Firmware file name to match the file on Linux Firmware repo.
- Added SST audio support
- Made common functions (in cdns-mhdp-common.*) public.

Changes in v4:
- Fixed Kconfig in drm/rockchip
- Fixed Signed-offs
- dp_link_status() is no longer public since it's used only in drm_dp_helper.c
- Replaced EXTRA_CFLAGS with ccflags-y in drm/rockchip Makefile

Changes in v5:
- Fixed Kconfig in drm/rockchip again
- Moved cdn-dp-reg.h (cdns-mhdp-common.h) to include/drm/bridge instead of
    drivers/gpu/drm/bridge/
- Updated the mhdp_validate_cr function

Changes in v6:
- Added Reviewed-bys for already reviewed patches
- Dropped patch v5-0003 (that made dp_get_lane_status helper public)
- Added patch with MST support
- Added patch with Cadence SD0801 PHY init


Damian Kos (2):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver
  drm/bridge: add PHY initialization in mhdp8546 driver.

Piotr Sroka (1):
  drm/bridge: add support for MST in mhdp8546 driver

Quentin Schulz (3):
  drm/dp: fix link probing for devices supporting DP 1.4+
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm: bridge: add support for Cadence MHDP DPI/DP bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   43 +
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1107 +++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp-mst.c        |  594 +++++++
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1371 +++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.h            |  209 +++
 drivers/gpu/drm/drm_dp_helper.c               |   30 +-
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  234 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   43 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 ------------
 include/drm/bridge/cdns-mhdp-cbs.h            |   27 +
 .../drm/bridge/cdns-mhdp-common.h             |  174 ++-
 15 files changed, 3669 insertions(+), 1150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-common.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-mst.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.h
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 create mode 100644 include/drm/bridge/cdns-mhdp-cbs.h
 rename drivers/gpu/drm/rockchip/cdn-dp-reg.h => include/drm/bridge/cdns-mhdp-common.h (77%)

-- 
2.17.1

