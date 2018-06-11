Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B4C8C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ADF208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PD2CaoWL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="R2A52cjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12ADF208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeFKRzK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:55:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933823AbeFKRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:55:04 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BHoIu3025814;
        Mon, 11 Jun 2018 10:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=IsK84teagy1JwU2DnLBsN+ZfCew2D7xs6/y6eB8V224=;
 b=PD2CaoWLZN0MIxmYlkY4dgTyym0jPFhRLTfIHpor4qhQ26tHxSIkNyCDdJz9OpGAQ1Kx
 E6t/BsnvVLv4J5HSfzDhkbBVPk70Q4kqoZ/g8NcNLKUfboCV6+LB/AW5UNFdJL68q+jM
 sRY5DHm1VA6/ne+Z59HCfG1bjI2iBTun+QU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jhsau8t4q-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 10:54:50 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 11 Jun 2018 13:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsK84teagy1JwU2DnLBsN+ZfCew2D7xs6/y6eB8V224=;
 b=R2A52cjX3JZgLceMJsWHmbxDyUHlMMOqxPhLTRtEsi2+zNuO1A8WP8RaTiHdmgYDM0MFBiVm7OPhpK1R9BViIprEmWKCKpiPdgNH6hip1lvsGhYMi/bQxqcGqA4sAb6kxsRt1Jvpr9xiBoQOZ/YTBfuZpQG7UqwTujXJcoeoQp0=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:49ec) by
 DM3PR15MB1083.namprd15.prod.outlook.com (2603:10b6:0:12::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 17:54:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: [PATCH v2 3/3] mm, memcg: don't skip memory guarantee calculations
Date:   Mon, 11 Jun 2018 10:54:18 -0700
Message-ID: <20180611175418.7007-4-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180611175418.7007-1-guro@fb.com>
References: <20180611175418.7007-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:49ec]
X-ClientProxiedBy: MWHPR0201CA0080.namprd02.prod.outlook.com
 (2603:10b6:301:75::21) To DM3PR15MB1083.namprd15.prod.outlook.com
 (2603:10b6:0:12::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;3:ThobRJa5kH7rEMYDVqeMlgszyG5V/F1IiIgg5mLNJXp4U2Hz5sza0glWrmdnmSlPAm9Qm/7Aq3tIjMmQcKICQXd4Wi9xk1LowbfdHq/gl7yWuARoHspK6pqcAGBqzl7gIGAkTQdLomPrF9SHCOKOxaeImc7kNMqnSYxdGwSAKjjsxK9SvtAlf1vt8NToEEUttJpZWR66QnwWaFvkqzXr6x9hGtPDmVTpTm39GswTjAXNxKw2yRBXaUtaogVZSAFt;25:1LxbpSC6wsZc9eTvttuBa9XkPb97SvAyS7U3P5ps9mKW9QsY4cErtlRRUWbmME419ivbxMLW20t2L4ZU9o2Wi3fBpdVQR5TfIJvY4fK/4pu11UEQXLogw9qeqkCmvDHif4Ow+vhBQmddO3F6KB/WhllQ+nkicqpzTWRZ0dB81KeWesrzCdolxHpuIDCjklQ1JfeWMA1daIy58fGFT4hvhrUyVZHWqGM5LdHZXgJe49MyLHu8bve9wKLukV+sa3MWBvm2dBKoqNI2OPotmEk2EoN/Fl06MEHVCoC86N2iPyvr8vDmY/NfJs4JKeGDsm8DdKDEGD6IdWSs+Xgf79sRfg==;31:r9gQX4poovGSAdLkiS8qBGM14kxJAPGO7aWgQ8Eu9anB6nDqILUQTyCQo1FpoPYtLUS90zKe9NaB4ELGSQILgjOV8ZDyKOGAfdAgnbZVhW+TN3tbfag9sBp17A3eg5Do5M2bEu26D/JoGkybmcIVG6NWUfevJ5dOiPFp/hag7kiisnMx+z/TFIckCrfasltXr6lyiJ1qax7tGEokXvDuGf3h2VlJi9Yp954jR8aRFaQ=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1083:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;20:ZEs8W9ObLJxaK2V5zA1EkNM6CeTGUW/OxlWDvf3/xiTk69uMHwknewue8YyfUgyCWS5/2BxJOjvx5ypIJNb5ftEm7imUjJ4C/cDlJ9m/NTStyTojqTKIo3t3UPXHJO+DshD3JKcW1Ri/ZiHqD8SYvjMO4OoOKk1Bjb5WQZNqoyRb0Lx/zUydqcuxuGe4B03AHtDsgz04MyPUg3Z2bYKT5ENqF2ARxjnV+hysdR2aQcmy72chCNKd//kqc5OBoFBW5AnbhnZLvotxNPHt7DD82skIk7RVqt7tnm3kHHuYtxtARU3zOFhfdGkn5vOIfeHtTB+zkA2QQbAaX3RZNRikgj/RQUeoF6nj1xomZQ+qywS6p8PQUgyCjw8Ora3f9XlkG0fem5Pahf99VX+TWOdrMVJ4gdarzdcovoSUoDe7gQ0wSpZfEedzjgFJFHfhwH0uPyu/JCHBiN6aa8crDO5RNDurjo1i87c3d4fNPXf5C/ujf3HcJS84PFFH56KoNrIg
X-Microsoft-Antispam-PRVS: <DM3PR15MB1083CE4943423A69A525905ABE780@DM3PR15MB1083.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1083;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;4:h/YCbe/UMzhP8Yx+18q/ac08RjJ1ZdB1h+bYQXvZZmjPULWcv+sfYATG5dxDQRutUITyev00xPF/TZ0XHhArPfj/JS2o9uVg+L30bO3UPGjxKlqRi2xWwsVl/BIUHPQDY6ieLFdXVcoHXW/YtW30dWJ8O0PVSB8/raWYB54OhF73kznunj/WoYZnPKYimLFiiwzXXJJ4QjDSFOy1nYYzYj+//X5/+bDDwAGefAtDiTtmCA1YLshCG7XGR81UbuGYY3ip+yN6DqA7eOSVqHmmn7pRvLa0qujaaC9rlnENPGtLisLrrWzpKmPASG1ZybLcxKiPMipSOKcaLfGS3FmBO5LMWGAdDgnG+djyuYOmHEWnqOIh/BVpLDKz8wCr/Tr2AuUQGGUt8ct6crfsslF375ZkXI0PpdNrnuPkZoY/STAdeJmz9+apWQ1DIFsDqfHARS5jviso+l4f6yrPHAaWRg==
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(7416002)(316002)(53416004)(25786009)(50466002)(39060400002)(68736007)(2906002)(6116002)(48376002)(6916009)(6666003)(1076002)(6306002)(86362001)(50226002)(6512007)(53936002)(7736002)(305945005)(8936002)(81166006)(81156014)(4326008)(47776003)(97736004)(6506007)(46003)(11346002)(105586002)(486006)(446003)(2616005)(476003)(106356001)(52396003)(52116002)(59450400001)(69596002)(5660300001)(8676002)(16526019)(186003)(386003)(54906003)(76176011)(966005)(16586007)(478600001)(36756003)(6486002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1083;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1083;23:4NiF8CQt7Onfn2TZU70aLBXs0hLMM5+4GsDuZdz4n?=
 =?us-ascii?Q?aWXXUnm+6WO1JOUrOfr/OkLj8YjobenB2RfsahdfH2+8lq/tBcPAWqkj7bHf?=
 =?us-ascii?Q?D7Hux2BI1qJGazey9ekUfYWr9p+rDG9coyyMp621WpM5R832+u+FysecgoqK?=
 =?us-ascii?Q?OCu2TxM0Krh+L6g2F4D9de0XWXcZTICAolQP/Dm1r7mEq3TkOF5mcOYX2Q2H?=
 =?us-ascii?Q?wWcTuMH98UqtfXtE7AvKkaMklGWRrqAq6kH+mIKk65sZ7LP7gl4s4k6HkHB1?=
 =?us-ascii?Q?+B2Gt/7T7XLs//sLsURQE7PhYRGiABmHPR9Yb+Z78qzgnhLAqscazHax40Fw?=
 =?us-ascii?Q?Wi1vFMIzIw3CBebgdG8klwuNDaCwBQb2d6G95djvpT8IjstYXWFPjnISMRS/?=
 =?us-ascii?Q?NKIdYxpky0hDoLalcLLwgPdNW1UpKSGdZVmG3Kd0kXAsoPSwwz/+i1DTW22R?=
 =?us-ascii?Q?iQtmAtedJhQ49LEf8a4w5QOCmaBeSMZ7+Qy6jOIjB3nnupnZ6rND3oomDlTy?=
 =?us-ascii?Q?/7OHiq9Op3ch668c2yh4Df8BSfMUXIEZnhSlFK5RuDeBdKXo+qWjxSELlyAe?=
 =?us-ascii?Q?CD/8hfDjKo/LwhxIdrCnRgqGYg6TOPcwnElcFq7wa/WnDl5om6iFsUm6riiC?=
 =?us-ascii?Q?xeh/ppQXgTmubYpa7vYcHLs3GBQXNLBIi+9bDwiHyRTyGsp+v5MmE8Zvxy/V?=
 =?us-ascii?Q?0kCi3e5Tpa4qkcZElJQlsW12mMnnBC/pWM+XdeVKGGEPvFp75azpCOr7rGel?=
 =?us-ascii?Q?z70DDm16neoPLKbUvqJ2i05mOjrjsLCp1yxvhgL1zCK7EoehyPdCXC/xObF9?=
 =?us-ascii?Q?dnH8aMLAoUCCizUol+y4Hha3FsVC5ES9NXJuRUg/+tHusLxHnjfUUbggkazi?=
 =?us-ascii?Q?BtJcsYrwlBAacBF7h7Mmsi8tUHq7RUoKceqEOYPNqCUXu2uImP3RKnUIgOGt?=
 =?us-ascii?Q?a2e9Akw0Nd1CpZ+zTNdDVuyXFz37cSjZYWVDxIxiamiAEj+AaEMQrJ1iNqlp?=
 =?us-ascii?Q?HyHRIEnX8HVrIsrnMfjwJoxaMxOr2hve/bnCHJqlR6COVE1AvQ5pJgz1Iigr?=
 =?us-ascii?Q?JFx991NzHyJA9u3TXvN3klCcR4o1RUneApNxKGC/alLZA8nf56mszB10vm3B?=
 =?us-ascii?Q?/9FvRQV3zWBnMACZOlLfh5Fq15PU6/jaioJXynX8TuICIiC0oSKj7woQkx15?=
 =?us-ascii?Q?fP1uVde+XOLffjhiD17D2dMbad0y/x6L8T1BH67UaQuQFTxe6WzKbrvw1O6e?=
 =?us-ascii?Q?dzyqH+o6sYUV2izbwIiBITj3icjGOjLUTmfQe2CCbktzMxoUwh1QaSnEVqlh?=
 =?us-ascii?Q?YN5WDQNGHTkqg7ZNdSo0sTGvOqBsoUvJwUO0kU8v6uNg/X9EUORlC+WPF2U0?=
 =?us-ascii?Q?8zrfA=3D=3D?=
X-Microsoft-Antispam-Message-Info: fFkI05KQ/DTF8fdv4JxtFAExA22GgZ1h3fEQyGyKYF6B0mIYm3hiV6ewy0cykBoAgWNX9CDjaL0hc8QA79F9m93oE/Abnjxo49dGxmonQ4vF71i2eZyQlvlNH3k2TyccelNykhbpRWyU9+TVMEaEYn/8GbunQsBQVyDmQTg94weW8DN3BvW41dkrLza5W3vB
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;6:l6mpicnrywdQIYKSrMRy5VLliqZ7ope2eCcMzvvovR9nz5P6YZWPmL++v1K7Iz5H5V8SGQQA+7oZBR3dA4FF3aRhwP+uszTfm+U2UOKvmXREVYwXDi+KLBlh4qVLTd4AEjrVx7WmCyxv33blgHTIc9fJpMq3KX5Ggc81FgCufZrxgv5xszK2fm7D16WrMhUX+ZKtgVbnp82uI07vSBfaTMk3R7qweYiYG95bb+Wm7uIPlE03N2TEyYkHPaYkvmrN7FatRFJQ7SlOC9dyJg1qF3CmF6rwC6l8cp49jyfNKi+Q60sSeY34+romsQS9LvDTjftWFZJGarxx9qFtUiA+YTHUAH1KeqV2D4+7UsX3iOhoKOjkBjo8k0iw0crkljT0gyvWtW8LJUWOThdElJoTlGldw9r2Cer22SFVxFWj1rUrrUS5U+FYh5/OB/FqHdsNKv2iiUULL6DUwB8F5kM7oQ==;5:PYjQ57i/HPXnp9sffgMZuv6diRre0l4GeBsyOORZ2mSNBg8ZXeE5yt+GWZo2th35RCK6ERs0hYHEw7TGAXZudEUT4iepadSKcE3f+6M2HVq2X3CKHzNz4j3Wo3ZxghFIaDg4H1o3c2+s9FuJ1866oPZk/o64ItD5Q8JU3UC2ydQ=;24:2yWA4b2g1jESJ3JsQFhozkhnUQ4p9EtcHgFq3BP1+exCpTpGpuQCFqHGkO0LS3FlkT/84KavL5LNIHIfYtkfz+sjcZ30CuVwy0WaiFHx0sQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;7:nqpjHiGV1OV8jEDleJPVf1L9pvXpDYUfYrieFXhvwCqp6c5G9jLbC0xw6E2tyGZPO+9QFUr3mV9Rdk3xlRba6xKpSfOPMnbIVTjiKfxaVrDMLPGUOvyIEa1g5Y6VQfBpDgRvHk5w7jUBBkqZaAm2oKHW5kuIgiIIdxMJYNkG9R4hiGAPoPu9rH844GU4IVcqjOzz0C2sbku/RlNSmkPmIZIp9FfcDOC1PHEyGYh3M7Eyf0IrDq2txMo/XsFa3Lp3;20:n1U3GtC4+l8n4AkIC7RvoAg9Kwm3YqlvxgbhqhNrO33umvadh0eQTwp9XzBJa0KqnHgGV6aMiUmL8YOXwT5wT+WAeajyFnyWkH8iBoL+N/RMerlqx5/Bqis8J7hD/vV4jI1+nxuaUnpDCzJNVehMq6GqKaGFBra9IqksmEc0qkA=
X-MS-Office365-Filtering-Correlation-Id: a3ab04ea-edf8-403e-4008-08d5cfc46ab9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 17:54:44.2629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ab04ea-edf8-403e-4008-08d5cfc46ab9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1083
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases when effective memory guarantee calculation is
mistakenly skipped:

1) If memcg is a child of the root cgroup, and the root cgroup is not
   root_mem_cgroup (in other words, if the reclaim is targeted).
   Top-level memory cgroups are handled specially in
   mem_cgroup_protected(), because the root memory cgroup doesn't have
   memory guarantee and can't limit its children guarantees.  So, all
   effective guarantee calculation is skipped.  But in case of targeted
   reclaim things are different: cgroups, which parent exceeded its memory
   limit aren't special.

2) If memcg has no charged memory (memory usage is 0).  In this case
   mem_cgroup_protected() always returns MEMCG_PROT_NONE, which is correct
   and prevents to generate fake memory low events for empty cgroups.  But
   skipping memory emin/elow calculation is wrong: if there is no global
   memory pressure there might be no good chance again, so we can end up
   with effective guarantees set to 0 without any reason.

Link: http://lkml.kernel.org/r/20180522132528.23769-2-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linuxfoundation.org>
---
 mm/memcontrol.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 485df6f63d26..3220c992ee26 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5477,15 +5477,10 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (mem_cgroup_disabled())
 		return MEMCG_PROT_NONE;
 
-	if (!root)
-		root = root_mem_cgroup;
-	if (memcg == root)
+	if (memcg == root_mem_cgroup)
 		return MEMCG_PROT_NONE;
 
 	usage = page_counter_read(&memcg->memory);
-	if (!usage)
-		return MEMCG_PROT_NONE;
-
 	emin = memcg->memory.min;
 	elow = memcg->memory.low;
 
@@ -5494,7 +5489,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (!parent)
 		return MEMCG_PROT_NONE;
 
-	if (parent == root)
+	if (parent == root_mem_cgroup)
 		goto exit;
 
 	parent_emin = READ_ONCE(parent->memory.emin);
@@ -5529,6 +5524,12 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	memcg->memory.emin = emin;
 	memcg->memory.elow = elow;
 
+	if (root && memcg == root)
+		return MEMCG_PROT_NONE;
+
+	if (!usage)
+		return MEMCG_PROT_NONE;
+
 	if (usage <= emin)
 		return MEMCG_PROT_MIN;
 	else if (usage <= elow)
-- 
2.14.4

