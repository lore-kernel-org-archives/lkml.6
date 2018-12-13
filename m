Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A691C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AAF20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="URlOwKen";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pFGOFgUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AAF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeLMMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:04 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54242 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729315AbeLMMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:49:58 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBDClA9Y016634;
        Thu, 13 Dec 2018 04:49:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XTldVszy6fPZyy2zl2CRKt95xR3zPhnZb9W+RO/xbRM=;
 b=URlOwKenEYvxAkg26If18xgAwsJyo0CQEfyFLMWGk+zr+VmIH7r1ZPit+ebU+CCEg3QI
 D7SoZZfE3rCCHgzS6F2BZIqWWvWOo4yf01j/XY05Ahb2/gwIVyxJALkK/coVFbyZ+LxS
 Z0cQ8ZZCUyuNhgg8/sot3T5X2m/B8hIaoP25tD6SCKdI2qHUCTka7kGioCSwtr8104bR
 30ysV4Q9wRpJuir3N9zkg1v1Dc6P3c/nYdH5pRkPwipjVoiUwO02twPLDGda6fTro0V+
 GuvFqh8eqZGNPzttqDD7wUh6ohskDIN1aorZNhAIdsQDNZoLJDBmo9jHHpBn1cmgrIdV TQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pbf1ujfbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 04:49:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTldVszy6fPZyy2zl2CRKt95xR3zPhnZb9W+RO/xbRM=;
 b=pFGOFgUcT9VQ8GwsPNwxKw/gutO3qhxVeFv/BFvDZ3Mf6auYCbJ+Lbw15mpp//bWeJlk4MYQzZQH3Eg3bA1bwT8CTEi6P4QWy+CKer2DohTuVO6bqjyWHxTvhtTNSMFkQ91gCk06UeFts6S7NaX/EKFlSDJ3S0qLZdigdY5keBY=
Received: from SN4PR0701CA0010.namprd07.prod.outlook.com
 (2603:10b6:803:28::20) by DM5PR0701MB3720.namprd07.prod.outlook.com
 (2603:10b6:4:7e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19; Thu, 13 Dec
 2018 12:49:49 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by SN4PR0701CA0010.outlook.office365.com
 (2603:10b6:803:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.19 via Frontend
 Transport; Thu, 13 Dec 2018 12:49:49 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1446.5 via Frontend Transport; Thu, 13 Dec 2018 12:49:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBDCnk3B020136
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:49:47 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 13 Dec 2018 13:49:47 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 13 Dec 2018 13:49:47 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wBDCnjer000760;
        Thu, 13 Dec 2018 12:49:45 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wBDCnijK000749;
        Thu, 13 Dec 2018 12:49:44 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v2 1/2] dt-bindings: clk: Add bindings for Fixed MMIO clock
Date:   Thu, 13 Dec 2018 12:49:28 +0000
Message-ID: <20181213124929.32736-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181213124929.32736-1-jank@cadence.com>
References: <20181213124929.32736-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(199004)(189003)(36092001)(336012)(426003)(316002)(8936002)(50226002)(8676002)(51416003)(42186006)(16586007)(54906003)(110136005)(246002)(11346002)(26005)(76176011)(86362001)(356004)(186003)(486006)(6666004)(7636002)(48376002)(47776003)(305945005)(50466002)(446003)(126002)(2906002)(4326008)(107886003)(476003)(2616005)(1076002)(87636003)(5660300001)(106466001)(105596002)(478600001)(26826003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3720;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT045;1:rN6vixrh3BEJk/OTdQNUEcRXT/QIGvwd/1QLvjx2dswEG/PfPz80S/OqC9+y2Bju9xxSkkCSfagl0yvqr+fGJSX6kRFBHBMci2hOcWTlqTfPsNqko2RoF2EO0493+nwP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4985c7-8a94-4c51-26d1-08d660f977f9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR0701MB3720;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3720;3:DY4E6af6j5pWGUaW2KdKdp8OYf2qINhGHWDJVZ8BksdvfuegrGAXwRHCwUOtpmcvfqcMsckMY6ZUyTlW+jAEWBPErR994b7iO92+v6Ega5qFiv+RxaOdavvGijCmupdJeLcIYn1kxQFjvnRbIj0s1AsXGJPTBIW4BborF/+3BtiJVCcC37aax+hhrekQYkAt/vvjlK/rzeEad4Q2XGXDwZzS4Fjzx8nJTOVDm6pzk4azyjzGjcacigW6IO3AL8SV2Bp4CVCClqv2OK1RjIWuIe/l4HZYevKhQ9oQl3ObIT330V82jdNs076kmLA6iQ+lnZwhvnV3FE3ywZBCkVw7g8Ufpllo+1OtQYr83L3D7rA=;25:sDStFDJkv748EyoNRMhN9yjCz81Ikdi/aOkAZ6VQMrfaD2veQy/XIB+he+VScQuHlM67mysl2IuuqGFKLQDKJN5ejD8DQxk2FYA/kHW3jTlDpV2OV3nsUlIm9ZICHn779e4Lv5+QT/Y7J+1OqXQrXZVX4l//kvLITstQ6xqK1Vf6qdHTdlHqVUn2SWMvaoyaMxEDhJ3F2BcMuD2jgDFvjrIc48knUvzyWqr+liR4vjuLGZPDXkK+Qse8Mi8FOgcHL+SJF1Xq+6ms5aizT/OeUOL+ZDW4ZMBwmfmFvec+E5tK+xfNfaWQKEqrpAUod9uJp/hOvdbV801hqb6G4vpHrA==
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3720:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3720;31:uOltKjmcqIBjoxNYUepKnhaEG+PuapRIq+viOVnv1JYd2qC3Ai7jrC8f3wUXk4ebahkjmIjg2jryxozOC7xv/0OKmN/8DZ8bhgtFEl8g7LBISuig/nokuO7iGzlGNjdMPHtpcdzS134XlsPG3X3Rutt6OR59DD/HtCzs3TlhNxGMCrbo/m9Qdp8xHdk9rqWHDzPz9cCUfun5fJuzAsAr1qg0xxUWMkDrZ49RD2o3e1I=;20:CdH3UO+Z1hwDBDZLfy2bGxyQ2jqix/1rqn5Ius27x+G1lb3eH12dXVqWli+ZnEGOuj38Hp9Tma2OdSwJ8E1rKbZOVs9FZZqjMglAXpXz37zER8jOPbXetNL/nc5klyhb9yf3qJUpBQD15A3hku9pWbhPQ3mQaXgepA33aeVQdBTUn11zw3QSsnC1Cefcf1l22cyTQb6Aoq4WI1T9sChPnklTw6TMIMOuJEkd9DuLDeHisCEJj4Z6fZhkZ33TIZ+K/tZd3PHEsdDUOzgMpR6zmsqQ+Y3VGtkeJyyvnzAFB4GpgBexZBAOv/Da7EdTlaKO0B92gG6cqdVI0us8tVYeyPMO1EGYXymDoAbLvFXF2d7Ir9RGR9M9fLgKnXl2HMSxnar/KMnG9U4rBHFry8wIBFlNS8aLINNsQv6+dkC6M+4x112MymHj86CjPS4z/T9XV/p7GrYw+jScPojX4YdP+t3ICQ9X/0Fc2CMooz2ajprsRmkptEBcK1SxefjzrmlI
X-Microsoft-Antispam-PRVS: <DM5PR0701MB37208DC656ED1237DB1826D9D0A00@DM5PR0701MB3720.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(93006095)(93003095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0701MB3720;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0701MB3720;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3720;4:WvVLWCzBr8hf2Pe8bz1r0AbpH0goEtCCPFwfO0KCHrwgT8DgjmUJiYZwoo2v7XreBfPKXENoH3aaY/T2WM0QLuxc+MoLaqvJRDfNY48HhSl56V2/K4t91TUA/RCXgE/sSfx6pgudL44/3+uaJcqsluzAvD0yjNiykoK3HTOibY5v1x1o2TBmCUNdXys5ECKHo6cav3WRd5GxagF41FiUJ5O6S5qgO5TLoLmisd9g1MjDs0gsCrdOfzYvZr4wbBrqSKIWz8Pc5xJjFJkh1lR8wg==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3720;23:qSzYljyreToeeuIpUWxaWki0kzLfKp7aVgRPVir?=
 =?us-ascii?Q?EVTQhk/9GdCMMx5XiJvBe/0iM0dnNx1IliS1Rj85i2T0ObyUanTXHouGYy1l?=
 =?us-ascii?Q?qBwY4aoo0hdYOtSK6soUJrAiGK0Dh4TAgUkg/DXoDEsIBKYRF7w38s5Ng4wt?=
 =?us-ascii?Q?BMv4qrTYBRA/fdOtv8Hmu1qOlS7MkG18dq/dib4Qad/zFeOr6jREfj9MPyWF?=
 =?us-ascii?Q?q0zNkjiC3B7r4zSdYXZ7/R4A7SBg69DlsKcGKgLXu56YVx/H06+RPfsxGQUL?=
 =?us-ascii?Q?NuvW/OmkRVMmqAR5oE71ClPJmqOWEq50yhl1hw22NDBgn5t68G+gDDa1NA0Z?=
 =?us-ascii?Q?RuJSMTdJL0WSFdwX675g5NdpBz0QQLjI0arSEQmHnY/fwFPk+gT/x1H9MudW?=
 =?us-ascii?Q?1Dl1CeqcOeQfaz2aegIzPFO1pmZePbJpxgtVlVHameGHGfg+ExjJYLFJuNbm?=
 =?us-ascii?Q?PCDPKEGKhAkrj7u3D0vQS/dyb2xZ/8GXkBzW/pLLZiq7DGn8xFMymzl5USRn?=
 =?us-ascii?Q?/I9HUHTKzFJmvBpsvG0bA7bmdKTVzu6tYF7DpS6k9K46JNDvO4qCTKCVZIq4?=
 =?us-ascii?Q?+MEdTQnX5w/7a0p9Ci9CYDcRDRR92TrGSRQa25yU4ccQgKo50ESLsiQ44bdQ?=
 =?us-ascii?Q?EoTCvp8bGK6V3XIHj+hTFZ6i7+iRH19udhYR1wblsiWrwFBax4tjTFAdb9Rz?=
 =?us-ascii?Q?lJUgH6/NCxqs3TOEaCjt9aOTtW8qDtOwXAsEOoZhZAYtFR3f+JikUbOQMh8f?=
 =?us-ascii?Q?VtsoCuJ06iugQEpjp6tQQFgSRdQlo3LJL4JWYHr8L3Iy85jgUcSCDI2NOH35?=
 =?us-ascii?Q?nqgOz3qN9SkEUNoQywHJgQ1qDwD3MN+yorAqb/lV5/L5yYBTtyvMOc2LG4Ys?=
 =?us-ascii?Q?x6DAKuJEubCIJmnTPjnMOGWbGNlnXswftV0mwT+kAdt1NwZBJFyU684tG8zc?=
 =?us-ascii?Q?eH4d7ltxfcTf9yzv8FJWizsBoE63n41Vi7Ot0/lCXi/VEpvAmklVNKTFnPNB?=
 =?us-ascii?Q?VxOC046TOHli/NR+9Pt2wjVEK5yIzZTRbj4FyItOhKutJAeWbWf47XIPk9aT?=
 =?us-ascii?Q?MOjAAy3luHn2W7nmQ57I9VyL3sAMZvt9evlsy6WRH+IAuMbZT+Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: p9B4NzRUNg5Nfs8CCu3/+nLsO2cfZUaJiDlHB3dp3vZtwpZ4PleJS4P/Fs7972KD/TpOLCZ0Lx5iHfOP4mt4Id5uPT0YzQ8hs6Bb0n8PBiGq62kNErBd9SEqzxGNeYrSyeIQPY5pWUmMoo154x8U/JTkzzF3ZG3W+CzftBLxWFnRmgL3cwJJkuSXUG5mSbonIAfbJU2McIMCqfkMql9fGNUIfBFr71wd97lCMnM4mnSbdHWiQ9tWJKyxgzpAvam96rbYeL0q+jBtS9CguWEC/rf/rzzCsdqmpVqSZGJupv34dvKJ1MPO6AiOwM1fKbbH
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3720;6:YenoNQdrsZilRhfmXdcqPYaHqpf5zfqnoaJYzJLio5BQnEjt5EK10ajpywgGLS8x4x37BXk5K4+mYv+Ex8Oqls9E5TQ8SsHmPDe4B699FnCkJMaO2kP61iuxSEHkViSNB1ZGK7YC91A0QLSRvCG6WdNfvvEssxEZfIrYQKQ8S1lwir6o+pMVy5BUoEPgX7OFVNwpW4TwP/0kT2UkwGUFkQ2zj/CkK42h8RVymO3oT8j9bWdiPsAzcE9GSUrkvr2Xxdo2N5kr1bmMy/TtrHmj/lVRAiTt0gpLnach8RkSES8+SOa66VfS7scqxOMuwo0NHiV4q4B8BtMrk27uWIjt/5s66ONUlhFwh9P8R1ac9P85bCG0t2FBZDeyJf5gwOTYz5La2VzWsWWXP3lMCflIyu5hxfqjZhS6Xr8BASbWvlExjLcFC2JKd2wk8SnAJIeHWkt3K6j9MFWsNW5O6/Efig==;5:9c4tIk6UUoOpv2HEa2ABcZpradjZBcrZfhk49TxnIk1qjebOtSw2rcG193FdPyhjSlfJsvMLrDTUZ4r8Fu3W9kgWqnaL3q/s35LYS+5jduJR1MYRRP98ori6UI9PRwh6VOREX8D/x6b+QS2049pOc0tAOUM6lHS2KujFcR6tzVM=;7:TFHl8lxagwdZkkSZHsGFzNDkHqodGC6xshLSYt/c03ezZdjCaImeJ6T5sZHUblXtqDIulpZL/ICdgqD7PmydhbP+HLDd4B2jn/PBciBw/mfCvzt7qZQszTGBpwDw8R19uAOeijlO4zlSiAri5BTDYw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3720;20:5rOAMSM9ZaEnPQ0lRNPUuemqcjLZE5u055pWQjowgfT0+zUQVANmyxsC82vjzJCkewHXMDImhjito1aCqVk9usf6rsFeGHtHW2TXTJSroMJpEJXMjl5jj19vcCsUj5NZntJDLeBE63nJlpnkRuB7l7X00xf6BDC4mKp7MfD0Bv1lcnwI0uuDh9NcmEPxl4FqZAMyTAPdjzxrjj0IVoB2qqbob4CogAVpOep+1tTANM5CwZfI+xfqjr8Ll0Wk9pL8
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:49:49.2944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4985c7-8a94-4c51-26d1-08d660f977f9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3720
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for Fixed
Memory Mapped IO clocks.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/clock/fixed-mmio-clock.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt b/Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt
new file mode 100644
index 000000000..c359367fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fixed-mmio-clock.txt
@@ -0,0 +1,24 @@
+Binding for simple memory mapped io fixed-rate clock sources.
+The driver reads a clock frequency value from a single 32-bit memory mapped
+I/O register and registers it as a fixed rate clock.
+
+It was designed for test systems, like FPGA, not for complete, finished SoCs.
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "fixed-mmio-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- reg : Address and length of the clock value register set.
+
+Optional properties:
+- clock-output-names : From common clock binding.
+
+Example:
+sysclock: sysclock@fd020004 {
+	#clock-cells = <0>;
+	compatible = "fixed-mmio-clock";
+	reg = <0xfd020004 0x4>;
+};
-- 
2.15.0

