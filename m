Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856B820882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WrYa70Rq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CV4qykW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfA3LFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:05:06 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729299AbfA3LFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:05:05 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UB1xMV017316;
        Wed, 30 Jan 2019 03:04:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=NS+Djnbls55K7scJ8ayM505mmeKsuOJuEa6P4pPjvlw=;
 b=WrYa70RqTAy0+OwMxHfmlp9vQqpZTJPJrYpZOQzNpVZRVK+Kz0dGenNGahaVT0m/e2zm
 Qe2ASruWXYbrEeXnEYBfGwdyrV9EF1Q6BFGKNx29WuEVQLTksf0B4apVY4XtTKtEuNFd
 Sbt8TqYm9ZWN43/PiDq5rwOb+auCJ2caXp2oaWpuAE45CZkjHSxPvMxVJ2jzwccpN7QN
 AVwk2kNc9yMbvqosip6BjytLjBRUFpewYlNpx5x+uA2HdBVYVCj6e2pyTawu9R0lWmRw
 rMiY8zhV9Iyu/1SSHZn6cBJbaVLTTvRSkweRXeEvXQWL6CsA4WSHg20y8tUfA+rWaaHr Xw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2q8n008ba7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 03:04:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS+Djnbls55K7scJ8ayM505mmeKsuOJuEa6P4pPjvlw=;
 b=CV4qykW90kdbIlm1q5Syz3r63VKKXDCEQcJbAfbwrEvQvuJ/vdha9Wu+sATcdJnQRFhAODUa3JTFqWjbZ9AaCrvdAreL+s6Zi+lYJUER2AZMbvV5EnjaEIz4/KhLpMbqjNxCPumMg8JgK6Z7te+GdM8iOOX1YyoHqhIsDSGOQOo=
Received: from SN4PR0701CA0010.namprd07.prod.outlook.com
 (2603:10b6:803:28::20) by MWHPR07MB3103.namprd07.prod.outlook.com
 (2603:10b6:300:de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Wed, 30 Jan
 2019 11:04:18 +0000
Received: from DM3NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by SN4PR0701CA0010.outlook.office365.com
 (2603:10b6:803:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Wed, 30 Jan 2019 11:04:17 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT039.mail.protection.outlook.com (10.152.98.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Wed, 30 Jan 2019 11:04:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4CHI028030
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Jan 2019 03:04:13 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Jan 2019 12:04:11 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Jan 2019 12:04:10 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4BIW017599;
        Wed, 30 Jan 2019 11:04:11 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0UB42Of017398;
        Wed, 30 Jan 2019 11:04:02 GMT
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <rafalc@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v7 0/4] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Wed, 30 Jan 2019 11:03:17 +0000
Message-ID: <1548846209-16406-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(3190300001)(189003)(199004)(36092001)(246002)(47776003)(48376002)(14444005)(110136005)(54906003)(316002)(42186006)(16586007)(486006)(7416002)(50226002)(6666004)(336012)(36756003)(186003)(2616005)(478600001)(106466001)(126002)(476003)(426003)(305945005)(2906002)(105596002)(26005)(50466002)(4326008)(356004)(51416003)(86362001)(7636002)(87636003)(8936002)(2201001)(26826003)(8676002)(21314003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3103;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT039;1:DcfqyPPYONaK9YBt5pFQpY2+jjdLdDgvgEe3+HAjrGmK/hoFzQntqmDjWaukQ+tgGaP0UgYGSpJ9RlEr8zhDheVDAXjYvdc38/IWjrijPyXLTSlUdDfxeGMoN50NZ+810O6FRV/W+HoOynpfSj0SQmX0rNysSsusXo1KuYTsi6c=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d13c7d40-db4e-44f8-fce9-08d686a2ad62
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:MWHPR07MB3103;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3103;3:fKt5Enlh8BxccMAR8t0+NXYrUwr71+/NeUuHXuFrU7c9aupZQbcOtun9BBwVp30+P8pw9opGTzz7YY9ZOqOBbNZ/4LnmugmWYeJIxrPKqZZe74hgA2Y5/u5/V4LHfeKmJMwe6qmtMgmg/mtv795+B69aKq2e5cfEaZUUZm+oMLUr8UOFTxSKW+HIkh6FN5hlLBQb8N6XZB6Vtkw3gIwWstcepaZ+TmvhKA3K8uq1U1Mz8LxkNgRJA9VYphDAxMttJ3jKSE9xsA6PFh6MWWMPWaScJH+fyy0PF+OVBZPj/C39PUTEEo955W4P9gKxaq5ZtKoExA4dCMTq4gPPvPPe6RJsRz+NS57dWE/WidQBKbwTOOHnPwcaiyz8WvDTpkye;25:ImiCoiefC/xDi9f10ZIzRx59pK87SDcUvLFGlSLXfpFCh2fClO58A1U+ZdvxBpxXe48kJAYhgDhmyrrOdRCAJDASEvp25Ahhs9aIfq7DTFMAin7qq2qPPLZh/6jkvP5XW4FaCV4+3yB68SFpuS3qUnj2v+hS7m+3toi6TFCKvGSsgBrfKGz1bPAPAa0SHr5HoABf8IcEZJbYv/ORP+XsU52aQov1msmIt5uD/vG4EZkDKhIJN8x1+9JlZhVoRsBufMiA9Ys3GIPpNQPe6fCypMjRFRiLbzuOKwqHgzpfgt6xcEt0mOTpBGRA9JmTEcEg316hyzFNOqiccnMSm7cWww==
X-MS-TrafficTypeDiagnostic: MWHPR07MB3103:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3103;31:/vuv4YZMiYHUeGbGf71lR+/vcYg38CHqZGSaYl9FutkuMhOzWGGiz8JeD2dwGC8yMP/JBVASBftMOYxkfKwZNZlqmm/i+GqhBrRugoEX+ky0JyouJs5q3ghF/bqGZIYxrnUlTu0nemI/6k027XdurKHkKyYL5A2Mk7Wkd6YUW8emeuMJN7bR20WU2mC7x0XkY1UlpY0h0G77qpRFNaj/FInIDrK6iOGN9q5XGDBuVrI=;20:MZebNxOvslECfNiOHjeAOwwznzaKoLf7gJrhde8HQnir9hvGkufNUrSG4xOznchXrRKdJViNM7qLeJcOJDq72OZm7epyetb6h5/Bw7IuLTImOJqAXyTxMgq77R7fenfuBEFZ7q/pJCWFAVb05v7yJB8wj3U7npHXbpXLNWF1GXnSQeSs13p3uYcvZ145lA8PHbA/sT+Lw1t5BNAyyslMxUPfTIRgWWd9jsRxwwkwy8SVqPozKm7q2c23sIsXNs1ee8cOEr9ObOMZrltq2ZMTHzW4O7ulqXU6EMpiuMne9xiwp1HDUHsfghe2wg4MIg8y/Uf3B0pKaWtssYpPzIlTkT/I1ZvCVvRb5/Fp2mQeS0UkOtIEO/d1tZ5wdtHtpKNlmVL+4q7KWvGjjk0gTzGTtIThP4d0hMQAmKwdsz5m7WXYPa4gX3NDft5bYEVLRzeiPTIiuvmBPk+IyFvHAQU1b3W02QL34ARRkEu2Bvhbwcc/nWjgrOR32y4cLk55QwtP
X-Microsoft-Antispam-PRVS: <MWHPR07MB31037F3AC9F81D862E7B07EBCD900@MWHPR07MB3103.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3103;4:fT7bge30a1Xu2oJeu0qtgsbhBndUDbFz7Sja27bs2H2ZQ2WxGm6aoTUF6gL14rI+IcG1h9PEpmrgKliuIvA/ysQfsb2t17vJ2+a9iJ/8LdmlRlkPFzCSupgqhiYqjTaR5+pJuL4/BuQpjuQstbsdaDAN8IhssDMvQN8RPc9Vc/u1j8noB4SAICxDdnY2MZXyhuxHGKmKrCm16/2qIcACPnRLl29T6tdHrB1C22nnkB4DPUcSPQb5QQpIb0k8BbW2eOgsF176LiprTdZdNg9Kew525C45OQ8qgsCqcm74dFc=
X-Forefront-PRVS: 0933E9FD8D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3103;23:cbezB8d/Zg6y4ApVZWVcHvsMREK3DlLIocLcSB74J?=
 =?us-ascii?Q?AwoJsRp0jE/KgBgcEInh7DYzgQo/+pDHncXTSKVzP2q+xaHiNpjmWeX3BSfr?=
 =?us-ascii?Q?jE2LVh8Vmb/nXyVBb6rJTIC2k+4gG5WivhIOC8C8v3Jq/UbwHkxMjn+vjhRD?=
 =?us-ascii?Q?9KoXwg4K1M0w3TeGWfoXsEQpyupFcG3SHYuvJNfM2Fx/oaMp+rwaovcQvIwI?=
 =?us-ascii?Q?D9RDH5IGEvKAFHGS3BriNs97xLTMitmXVTSvlWhCMlJiWbHincfHAXJsT7V3?=
 =?us-ascii?Q?HWFkrnWOfqBqysC2fGqg4dqcKv3PM5+fVDkdbXvOjuGoCaDhtArIGjqMEOU7?=
 =?us-ascii?Q?GXCY0eMuzCfhwea7p8SHalQ8mXYUF5CyXZ3+WM0Cw82q1IC16/lBdV+1w6C4?=
 =?us-ascii?Q?xtzt2nW7ZigqRBnVG4B15zhw7RhGt9I8qAvRaCoSf2Cfd/ZaKxh0YUqsV0pZ?=
 =?us-ascii?Q?FOAU0M3J+q8yDQEDkADNiU05IXXMNCvR6UhPY6esG0W78Li203ktFPRmRW2R?=
 =?us-ascii?Q?Cty4kLZaH4jI552Ik99vfkX0d6BYK+X79/Lhw4SwR2Hqim+mL5aWEdjlIZ5r?=
 =?us-ascii?Q?ZuF3udINgPd6jgyv6q5SN4oiBjLzrzf98r7K4Qfc+ArmSoK5GeMA91YNj3kh?=
 =?us-ascii?Q?EvAO63+f0RUzWQTXNHlcEX1SzrCz2JXgJbIGZUBxkGdcnRwwS0YrRB2wFh9H?=
 =?us-ascii?Q?NnPLLHCtY2yegjDc2/UaMhWL1MwjYhrUYPPliBB7pm6+VMEAXVFB9GErMJ11?=
 =?us-ascii?Q?2YzHqkHKoAx+fPueyiesSB75+9nh/IW0PLqNPw+6x8QMZ3uDEYQ3aiSwQx12?=
 =?us-ascii?Q?iaf4KiDRlMV7JeOj5Fgn5kY+P3wZypRgBb1537F00qouDk8VgbB6JlXPlLkg?=
 =?us-ascii?Q?8sr2ipJZSQKyxCmUMn27baWrfWGqMXFRGs4ittJpjya0jHD7TDJ15ZV35s/E?=
 =?us-ascii?Q?PpCWw1Vd/cdRiLbKOCxXRloeA31bo+zdRd2Qpr0TBPF6rzSa+QVrmTCAHzIS?=
 =?us-ascii?Q?qj+gg0oxtyv3sg4ai8sHfYFjS958uTYsx/dcSUkhuFImdFXpcHHy6HBwYOrs?=
 =?us-ascii?Q?TLaJ5KnY2DLFb1dOQzxfnJnoerI4MO5vmyvXiT5apyp6Z2yQpm+JRvspshBI?=
 =?us-ascii?Q?M+iB2ES8mwrMfHJGVhAhRAol/baqRqZ?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3jvO/GcblnZ5EIEn2vzgaisLCS621Wpb7lvJnRah1of/nzG9OniG22J+nPrdOkjMlCDSXiVEF7RUTmaFkt5tjA+fFIpA47NMjIo+MGAPid/YXcRiakBR8U/QUf9v6w7AvkeCzptnGS1R5yclXw7Opf5oAFZz1tEHm0jwGHdc4vuzoAxEWV/IKwuIRSGqNWEezbj+KJA3XVOO1nHBM5GIg6vgVQ8uovL2VIax+M7LhTcsgz+Y6VzNwvxrVvhLit5UrIbSc89FN5PAaPkKTRds8r43EM3D1BhP5m8TsJNDZWzbM3pttx8lWF6fwO55oaSUSQNGI1pt3aTu+qdcNxCK/2bZZ3DIT+6TaMhe8nC9kyBXO9sOUfg2pk7DkmUZk3ZTuLqXvdJ4S98vesE8jxcByC9pSKZOedNnDH2Rjr+C+N4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3103;6:ZmjU3y/SPmcDhg/9cBkux/QR5NER6yhsKa3M0lfjJvhEVgrVuHURE4/a88yki2OujSxQ3PElFiQqslfzaeYzWobUewYLHgNzzM4i830N1nlpU0n7MN2ShKyGRqRbEHeFdXxSCvrt2IOM9x+Omp5zM9bLwBPcw9KV40uVZkyZ9gcmUuvDZOPvsot4jG3J8yy61m2D5ck1901aMM/MJktprVs+nYDOUUfaPW4k81fd4Up1n74KOMfgzsqoAb69z4cTer/zsN9CTiu1Wfu1BBQWttRRg2cGL1hLglJvVatj94zxJSrrxcL+2kiEzkIX6sqNXTAhfHSqK3YF7IeZO2/W/xPye1GbPww5hg83UBtsTSaqabDu9NnGYY6mR5RgrCKphwJW0JPnIIXyAXM6nr8s5ezwH2PrgNMNKfxQGYb/kdEV4HOK63wehioliPQ/ivmd/UF6I5ezpt5PBzO0STsSTw==;5:c7rfZByahthh8Cr0ju678Chq9ifUa9LfxU8xFk2acztUJXuCNHAAgA5AMJzVIMkdgLdWQtAVn2MhuUljDffQ3YSgROjN3Nnuy9UBozjpxwaotWCQGFmXL490w3DRoHgnAk1QG6eqOBrUqTcjSWIfir7wwQAPB+N4lKtbODPIewDV6lbdNR20Rw3WRNZ0RceeChOZWrbzb+kg9/tPo459UA==;7:lSee5RW6JaqomvfwdYsE7D7UVCm9+YQ7xh6Rtt++Oi28hJ21QHS24GgRjDXoRamER9Vpzk/aldFc5VGbEFc7B8P2d8Ia3A+7LsSltYM0ZQsfgyPtupU0DSkKd+oz2b8KqGQSgbHH4sZZhOIRmUDHoA==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3103;20:lziBX/1VK/O5eJgQsZoAhkPA51QIzarVbviK3Gl4irDzOJgIDJTY++coL4B4lzyehNPSstM5Ll4CNFALZrZQwtNiaHI5DToUr4FdpHtJ7k2eRLC2iM+VIhVTiobNucDuAfOSrYvcfmCvxk7I3PTWeBY849Hw88SKnkRJxP2bffQiazZH7lEn62FwRj2jUyUY3bzK3Qp0PVp/C4vbrSJH+wPFy6F+YgR5Wqj9Iofjdn399rugFojleDyfP+YnZzgM
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2019 11:04:16.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13c7d40-db4e-44f8-fce9-08d686a2ad62
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3103
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300089
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


Changes in v7:
- Overal code cleanup
- Patched memory leak after EDID read
- Fixed SPDX-License-Identifier tags
- Sorted includes
- In patch 4/6:
  Cleanup and fix in mhdp_transfer
  Replaced byteshifts with {put|get}_unaligned_be{32|24|16} (added 24bit one)
- In patch 5/6:
  Removed cdns_mhdp_mst_set_threshold (not needed anymore as HW does that)
  Updated cdns_mhdp_mst_set_rate_governing
  Replaced request_irq with devm_request_irq
  And then merged with 4/6 (as many changes in this patch altered the SST part)
- In patch 6/6:
  Fix in checking devm_phy_get result
  Updated bindings doc
  And then merged with 4/6 (as this should be in the driver in the first place)

Changes in v6:
- Added Reviewed-bys for already reviewed patches
- Dropped patch v5-0003 (that made dp_get_lane_status helper public)
- Added patch with MST support
- Added patch with Cadence SD0801 PHY init

Changes in v5:
- Fixed Kconfig in drm/rockchip again
- Moved cdn-dp-reg.h (cdns-mhdp-common.h) to include/drm/bridge instead of
    drivers/gpu/drm/bridge/
- Updated the mhdp_validate_cr function

Changes in v4:
- Fixed Kconfig in drm/rockchip
- Fixed Signed-offs
- dp_link_status() is no longer public since it's used only in drm_dp_helper.c
- Replaced EXTRA_CFLAGS with ccflags-y in drm/rockchip Makefile

Changes in v3:
- Corrected dt-bindings document
- Enabled some clocks at startup (since FW doesn't do that anymore).
- Changed Firmware file name to match the file on Linux Firmware repo.
- Added SST audio support
- Made common functions (in cdns-mhdp-common.*) public.

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.


Damian Kos (1):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver

Quentin Schulz (3):
  drm/dp: fix link probing for devices supporting DP 1.4+
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm: bridge: add support for Cadence MHDP DPI/DP bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   47 +
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1103 ++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp-mst.c        |  549 +++++++
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1349 +++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.h            |  209 +++
 drivers/gpu/drm/drm_dp_helper.c               |   30 +-
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  234 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   43 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 ------------
 include/drm/bridge/cdns-mhdp-cbs.h            |   29 +
 .../drm/bridge/cdns-mhdp-common.h             |  176 ++-
 15 files changed, 3606 insertions(+), 1150 deletions(-)
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

