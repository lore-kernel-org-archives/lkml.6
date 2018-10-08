Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE41C67806
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B4C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SixeDohU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RAlVeYHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B4C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIE6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:58:00 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39832 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbeJIE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:57:59 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98LgDjj007404;
        Mon, 8 Oct 2018 14:43:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=yC/3+D1W2arVb3JWaxT+v/5WTLOF5Mwj99d1ZxIxkzI=;
 b=SixeDohUjuysNh018/pwLY0Vfi/hbYpw2ZhNCmfs7iMmyXpkKh3gVDpYd0LwCHxvJTV/
 sXHDHQtEcoMplyd23OTrEiXX5i7V48CacYbJILxV5m2MQXaq0DYK72MlR/glPNdtxNr8
 BlCPgsTFbYI77BNkMOX+6hcG+AhTU5d0+QW4Tzy5rcxsNFwFmCCqlxu4Fl1y6IretTjN
 7I+Jki5OS4Oeijej9BkXN8yZfBysqlFQY+RW8zARsuwCkMtZIzYNkBtiBSouAr644DkT
 0L4VkqWw2jjI8+ItZb4q3wKofvfX8Y7+0rhc73HbYEKmK19T0VnT9t1JECfIq7solAR8 NQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0020.outbound.protection.outlook.com [216.32.181.20])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mxuwwt02e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:43:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC/3+D1W2arVb3JWaxT+v/5WTLOF5Mwj99d1ZxIxkzI=;
 b=RAlVeYHXG1KhIKvpcbuNb3h0im8AF3hnSB0w3AaI1PwC7NAkMHBO3/n3HTRYEu/enIOQwM5IrOYXF+QxQU4Em50CYvy2x17KDw11Cj7aQD2FBckJXin5jlf8qbINZim+FKb4QXXvWOfjIz/zP1+y5p/Gvb+bTUxQSVlgyA9oQfI=
Received: from CY1PR07CA0004.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::14) by BN6PR07MB2946.namprd07.prod.outlook.com
 (2603:10b6:404:42::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 21:43:24 +0000
Received: from DM3NAM05FT017.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by CY1PR07CA0004.outlook.office365.com
 (2a01:111:e400:c60a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.23 via Frontend
 Transport; Mon, 8 Oct 2018 21:43:24 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT017.mail.protection.outlook.com (10.152.98.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.2 via Frontend Transport; Mon, 8 Oct 2018 21:43:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w98LhKTl017201
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 8 Oct 2018 14:43:22 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 8 Oct 2018 23:43:27 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 8 Oct 2018 23:43:27 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w98LhJHG013168;
        Mon, 8 Oct 2018 22:43:19 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w98LhJrT013166;
        Mon, 8 Oct 2018 22:43:19 +0100
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
Subject: [PATCH v6 2/6] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Mon, 8 Oct 2018 22:42:08 +0100
Message-ID: <1539034953-11274-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1539034953-11274-1-git-send-email-dkos@cadence.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(36092001)(189003)(199004)(126002)(305945005)(76176011)(26005)(87636003)(7636002)(14444005)(105596002)(2616005)(26826003)(486006)(186003)(8676002)(42186006)(16586007)(446003)(426003)(11346002)(476003)(356003)(51416003)(110136005)(54906003)(4326008)(336012)(478600001)(246002)(36756003)(2906002)(5660300001)(47776003)(7416002)(50466002)(106466001)(8936002)(316002)(48376002)(86362001)(2201001)(50226002)(6666003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2946;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT017;1:WAdt+lWKo/xOkaxGx8l5WuDyz1F+NqnlNwnEr+iu+3z1R39POicfDCjS8rb3vlEah95y0bvOsgyc88eRKOngEvdCeQx2abNg5WP538E/P+4L0/CvA3rMJmqp/Qy/bD9A
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c732a339-cc0e-4d35-ce79-08d62d671320
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN6PR07MB2946;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2946;3:WHsnLwcBRnG3eCXFpGUDoz+8PziDE+YGSVUNxFkiA96pCfITxoMp3WwWObihEYD/dHtJFEYFofIKs4ekPQ5srZ4fo0rLYa54N9EE/FNYRl/9HOuROqU7phBCF8CMHHbncXHsjWOVrf42nDba0syJK3YYuy7zB8TaCocMu6ZOx0gB7HPQBbJVhR8kQNRFj7m2ySNL7vwa2vpX4J1DRIZNRHQfB/iKbbzS6rC8N7HBnmA/vsNep7nMF2/SKGM4i8xOe3+Co9gwrQFGCSFOF50r2aInUv4GHD+byzz/oG6NQ0eXrDG0mYAjHEUddRUYvxl+FrOehMJxzZStQEjWbIY7BzdsHl2etap3Yt5aHRetxVg=;25:H7y9gO7kTyERbL4MuxJCRHMmUFgAzQlNT5IIEFYPLC1+aH0hCbLe44TpJq+ijRQbt59UGIk8w56WGeIFaf1mSYHoV6OtLmMVqY3wLc+yisjB3EgP4wiQ9v5QkGi5W+tn+q39myfpLeprWFpbx7INupdm+zXpusRCA7wf0W+nqVJNxi1fLdrm0NyOEKNvK56hy1xU1HKbF6bviMw7VXKO01V+BHtTASikIH2I1UCacYEEWAAQiEsv1LViZ4DxyY3J/phcG4gRtaT9RNmH/1KjUEZ5Hw45a+QCFBVrhrq76RYUyX2HxMQ/oK7dim5PZ2pJFURtWDiTXWYhwlJ57EXbCg==
X-MS-TrafficTypeDiagnostic: BN6PR07MB2946:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2946;31:xb/OXMyu+ZcSsOArNa3ssFL16xf1Nt6ebICLdeG4tRKoajv07e2RdU2dTXtIoizxAUb1qihu4ElTnHgPk0B0H/4R+xVvLhP16HGi74fcJyZxTKbl8ESMsz/0xjxBRn4nGI+83xd16/HQEi04ajdyvxL3qeHvHiPEt0kw/CL+b4HHh3QRzcgppPMYjixeAKueUijp2XYkpZEzMEkVH5P83ijrUS+Roqvfa+BAJxrswa0=;20:NMofH7pJhN+kAhRyQDBAKjQJKDpV0wdY6xS/tOY9NKnpyYTSlZxhjuzWyl0OAuq8sdIBMVdcoc+ZqDQZ7Rl3VoMQ6q251IRdvcevzoC4bPOcwKlGrMqxzBAUZ/0SmS1vi0OOnksMuz/0A6DQ1w5al+8OE5I4xcW985Xv4nGT5P0p5mWJOsgVCPxEhoW5h7jifatTiQMTlhkFak45fojJVXaX5Y9fM9WqunDycytPa6njMYB196DGDu3yy1kUhId6X+QAzeT68cbOczqhVqxLGOh5W1Moje5CiDmB43egchg/PpL64YZdDaozKEr+XTMrFQKA/8WHvjhpLsUguQMizr9yd0Whwqk2zNHZJ5Ij6sw2xbiks8YHurYvuhqmdWjmBsWtDwHJb3UZB5UvdA3DeDfEob6fzT1NpBYCR6hunG2n5cA+/40A6jpZg/UVN1mwiakAUcI+6f4nUeZ4ovPG6BfEaa77WjCL77HD6vJpXGUCJoJVK4rz1Mrk2xZm1Olf
X-Microsoft-Antispam-PRVS: <BN6PR07MB29462B92506B889D9CE22388CDE60@BN6PR07MB2946.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110)(7411616537696)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN6PR07MB2946;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2946;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2946;4:Cdt3Sf6DUxR/uwzmicsaBDmOLalBE6wJSNhhafu5Eva3ZSDzHGRFfQ0zXwItIhIdezBrweZ9BkycOAgVDnrniV8cYCOdd1SZ7kVgMwi1MtTzt49opMR8AMBYm3EGygw4FqkQ5QaA+NoRUR8uQ8fGdqD2AljsmlNkVefKE3bMH+wrvPUR7bUS044nYTSDLOmOJOrfbetcYg88KEUBIuWGK3j097g9jKQCd1isxjefwYxazuACiT9KMl4bGrbKhN/Fi65UQ19rJz2SyFfTUCoREUMj/PQ07MPbPQlD5iRWrKOB/9ubo3RRY6NQaIUlwkEcUcSvQhkKc2NPtX5AIn7U7KjC+W27bFgh8g0LSTuBT11Y3K6mera8cdCkBW6AtQqrsClF7xQjk7GDRlabNdiJynt3yeDW7fX68vLA4YZ8C7E=
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2946;23:ud+pFV4G9oCqcVFu2b9FfW6qSitT8RLc0p4dDkL/S?=
 =?us-ascii?Q?dHU0NNphuiEwuyJYWpwXgl3EYVnfPc656IbmEiJiYdTKYTMRipfObbOnBZ2d?=
 =?us-ascii?Q?bt33zuY+JU24qql/bx7XaoFwfTx7qkvvvO3UNZzcv75957yGetHdVEsou7qD?=
 =?us-ascii?Q?sOBvJ28mfGobfzQyCAyGJ/f4fWnKbcN8bY+JedFKZTHgNITrJeE+UDjpO0Er?=
 =?us-ascii?Q?9xOGWmC0MVht/1s7rCHghdtrgDhfLt0+Ba0M+68zwIFVVithHy6qmE/7AwI+?=
 =?us-ascii?Q?/E0q3F/cCZcg4pQ4QupUU8v1rxv2VVhslz9BDBU2XVuuFLsA5pzvsp1U0Doq?=
 =?us-ascii?Q?TzLok0a9Uyk+sdPWLnn8me2UqUnLmpgUiJwsUy/VtWXAm8PHr5iDg4freUTK?=
 =?us-ascii?Q?Ec8N024XQrWsfOav7AvfyI1IifXns0Oip5AQSXddSDbQSoX7inYDy09wQbiX?=
 =?us-ascii?Q?Jpkfzb1/UKm/GUMWdjsUVIJsYeUAzM4J+HF2E+monW7of2/WeHqbA/PUQI2l?=
 =?us-ascii?Q?ZGPyPp7xyPyrZ8BndNdmHJ9qpm8HyQyWsbIVeuP9N0qn4hWjd1HAGAY1Fapo?=
 =?us-ascii?Q?S8AU7KZ9ZhBqE7jkDi9+MgcdyKNZuGt5LyxiGcpfavIrSEz97R8uk/N9jwAn?=
 =?us-ascii?Q?ocmE6W4erux7ISgy2qilEnxLIzsQXSxEzasTLs5h/tn63RwB/ORSCOF0AzBY?=
 =?us-ascii?Q?TNvV4d/+p83iXjWL+FGUG1qiBCPnh0W4+XdQd8fpCL4M2ngrR4djxWsd2d5n?=
 =?us-ascii?Q?LNz6hFZa0u3w8vGXq/AYMzKB8B15ICAFtu0madqkLsciVGBgoIeaeE2F1RMS?=
 =?us-ascii?Q?a6aWxFeHrYg/b/apvsC/NIDhVCT5ZmZa1Qno/aejrm4m6a8RRwyCYXSo+tFT?=
 =?us-ascii?Q?pF2JHU76Rn7yHM6hlCf6RM63giTUCvB8Wi1PBlzVHRaToYpK9FTAKfytYJch?=
 =?us-ascii?Q?NiT+ICnlT6AHh1CDOQiNlVcivljj4Iq5sFzVOhaU5QSluPE9E+27FxRHqHUu?=
 =?us-ascii?Q?OA8fHH/2JHJspb3zBwMfDXCRwbZGYeVkRg9h+IegUHZNcvMEibFvWZEfX69U?=
 =?us-ascii?Q?DeClM/cUfTnWOMJS7XIKhxw6+7mgjVP18UeLrQI8qIAL1zQDy7NBJqz3OIRw?=
 =?us-ascii?Q?qPDWpZpAyGil75jViuPwc1shWH/saWn90ehdy4ndFUsYaffeRu7nLyHcSqjQ?=
 =?us-ascii?Q?s9dYaBpDOOz6s8=3D?=
X-Microsoft-Antispam-Message-Info: Lt4H0kenWruzFWGhgKwxDFnRctZgFc3OZzww3fCn6VwrNhWKCPFE5lFkfQ2IHMeBjjI+oLaVcMtOXxpZlPikF/LHs9nw7dIE8qOe/fbDev6szcEyXNB5y5zzD7biy7KnRLJ/NVi3vx3dMNNheQpkakwkLcRXlnmOiMD63APumZhPXj//Bs6H6gyylcNZJwzrJpsEyfi2MKDTX/RqJZfzs8j94omC+RPXGONnwFsXByLH7VcPA7LRMc8FJouzUlAYBlgeDGBcORRfYanHw5ng0D9UMSRiEk0gllGs1oQxZYR8UcdtX3QGWvJi4kiOnzFIunDwzdULyaGtWo86ag/YQpGPhngrWBa8sKl2q3I6ul/n0RyCtOGtK02ZadyvQ/b0lLHrJvtMavEFn6H9jrHV9A==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2946;6:J7asA6bifoPAJWa3nyng5jsfAJAGricNGnPujccrp+omWXN2jnbckhi+9R90SYIOdb1KcTlMrGnEkqRuMgqyCVH0zAt53CcYZVhSoeiWSPBvdHu2RaT9r3Emu341Sc8p3BWuyzes662i/baBG9aZ/E4h7QHVpw1C536qvLmJfH1f/xtHWwl0Pmqh+AhmTf+fSFLDt3ClT1FvpXMWWBHmx0mlty3NIjHn668uY9/2d5ylW20snv6irDgOVtrk/Itny1G9eqBK8MnklgZAe/LErjW1kTGneb4yAGdPCz+XxkMdcsYusF7goG4oIxxH8GwblMd+U2qRAZ1fvCi1jQB/gg3CluWDc8keiHOFLatA1ACziu+hm4swtGCcJAxbv+sGYzmHt8zii3+qIYmUYvRpswlCv5+eVfxsvHRikMITh6VHu8L5d1ofOZcbqRE+pgciADRZiop9f8kwDEaHIvsMjQ==;5:K4SFI7OXbt/Z8f4JVxZ6g5M+nUQbDcPN3L24SGuCf8MFHnJZbpWWKmZW1jXUV9b0biyMSD5koSxEqy7aLcdRRQY0Hz+P8kMYUec1yaCrTMuK0JQeHnpeF61WYmNMDdhZB6bsyOU+PmIEFsD4E1ym45yIZw53BAG/dZ7HZJdYbB0=;7:722AF94KD95+GeXJBH6OtJ1Fxa33GK0T6Tw97xYwa11oDZJU7QD2bZD4cVwRJaDUAKGRo7WkkHWzOSgWKoiAa+Rsk76i70hP+z6Hqa3lCA9q4WZs6YAdkawgitBxZZzNPiH9PC8/YLxDDsbJEZlhNkgbVRnTVfOQ/eZ/n5w5Hlip8HvhDyuursa18QjinAwBXiE8GSc1zE7JdcCAHT+fMz7e6WCrFI43wwIXu7umOUVadn5yWwZ6ZvWOGZb7R9aP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2946;20:a2+NeeK3ipAoSEkus0laPjSkl1CfY0KgYSeXZZnIOXdydpQvBbzsUaQNy52ysVUDAFeVmonYt+77mExHgODqu95ZUa5z4cyXEu/fkG2nHO5ZBtE4kQyvEz5FhV1v5UBDDjeanAUKo/vm1nKrxbVgX2Y/s9cgVWQjObmBPb1SPm2RStsq0pXuopDfRSvhUzvqCt+urUaCCbF+s3OQFJSewybzdWIiRX+IOYC5cE8k3eHlG0A8K1z9fX3o3Ui/PZAL
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 21:43:23.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c732a339-cc0e-4d35-ce79-08d62d671320
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2946
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
"true capabilities" of DPRX device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
might falsely return lower capabilities to "avoid interoperability
issues with some of the existing DP Source devices that malfunction
when they discover the higher capabilities within those three
registers.".

Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
and read 0 so it's safe to check against it even if DP revision is
<1.4

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 37c01b6076ec..d96ec74a87f5 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
-- 
2.17.1

