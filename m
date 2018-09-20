Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D92FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A9321532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VjUn5UFV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="PChwyQpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A9321532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbeITUnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:43:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13018 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732640AbeITUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:43:35 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KEss4C031677;
        Thu, 20 Sep 2018 07:56:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=fDWwy3Eoi4AMUfoY4dNWREojLk8RaLobC0XsWom0UGE=;
 b=VjUn5UFVmCN3NAg8uyU92RmtQVhQQ7dqbguwQykLO6YG6p3V0cXNwtmnGJJwyvB4J7i2
 t9ZOwPNgPsfXlLyLv8zVXDy/zHYHH2ibHnWUCLru91ckmXTWQhjjIt0snnvIvWku2d1z
 BPvuTF9EBI/iSGWD1S3I3iDcLa/xbdOLlDoKNNIrae5rApYh7F6afYJKLitKhN1QC4MJ
 3WFI5cx8lVLPMXBSrc1FpkbaV4pPsS9qkaKFba2r0efx7iUX2P+K+uXf/1xZzWDLkaM4
 zx9ZafLDvhfJ/zyxiVGoacCgL9XouRx2ASBACcPhSyYJaOtYXTlET2L5nLSbVzaVgUAL Lg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0180.outbound.protection.outlook.com [216.32.181.180])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnvk5sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 07:56:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDWwy3Eoi4AMUfoY4dNWREojLk8RaLobC0XsWom0UGE=;
 b=PChwyQpdyiqUvfjvzPs4hu1KGCal5kjzpuVCMRLlA1nOesPRu6djO0s0+5Y+eybrsBQY83ZAmvdj6Hm2c3JxOVtQBNHtCPPm2T8g3fH+LeAso6occNMYlp8NWGfo0ENxzjBG2UA3z1+Lg8wJHEDd1Is/czzlLRkVngC+Y1Xg7EQ=
Received: from CY1PR07CA0004.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::14) by SN1PR07MB2175.namprd07.prod.outlook.com
 (2a01:111:e400:c455::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Thu, 20 Sep
 2018 14:56:01 +0000
Received: from CO1NAM05FT061.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by CY1PR07CA0004.outlook.office365.com
 (2a01:111:e400:c60a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 14:56:00 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT061.mail.protection.outlook.com (10.152.96.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Thu, 20 Sep 2018 14:56:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtsWQ002306
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 20 Sep 2018 07:55:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 20 Sep 2018 16:55:52 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 20 Sep 2018 16:55:52 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEthIK022077;
        Thu, 20 Sep 2018 15:55:43 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8KEth2o022069;
        Thu, 20 Sep 2018 15:55:43 +0100
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
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <pgaj@cadence.com>, <ltyrala@cadence.com>,
        <stelford@cadence.com>, <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v4 3/5] drm/dp: make dp_get_lane_status usable from outside of the core
Date:   Thu, 20 Sep 2018 15:54:38 +0100
Message-ID: <1537455288-20223-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537455288-20223-1-git-send-email-dkos@cadence.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(36092001)(189003)(199004)(47776003)(54906003)(2616005)(336012)(105596002)(478600001)(87636003)(486006)(26826003)(426003)(2201001)(26005)(11346002)(186003)(476003)(86362001)(446003)(126002)(106466001)(4326008)(316002)(50466002)(246002)(36756003)(16586007)(2906002)(356003)(7636002)(8936002)(305945005)(6666003)(7416002)(48376002)(5660300001)(51416003)(110136005)(8676002)(42186006)(50226002)(76176011)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2175;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT061;1:NbhBktPWzL00o48dGjhIZgyJXAvXGeWh8b+I3Z5/8XinwHL2nEWBliBDZ2bVV7JBHYthyFdJSjylB6OzEN2HN8+KTY4S5aTaUa18ATBcbBhWAmp8QORifLVUXiHwERCp
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6fa32b-1563-4c31-7225-08d61f092e07
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;3:SQhI1ks4uindT5KUg1QBbgPX2qvOysg0k6zdvAMsbsnZvrDtPWlXEoFhhIF7RWh9dDVWoHPj1sDCkYE3aOvR+WE1fpltJGa7NsYg22SKe6LGBaZe8FczqJsnu+QoSn98/cE1yg3CCP4+peTDpsCQCiBM7/KNAoqFTZL/Kq8RLsNREEYsVYAPH9tQ6P4oDI23x/K++HSNdaXPACzl3/RRbTTRYO23P8d/Ydy0tybrYvAXiMQf67lcAtQaQdvgWkpqxFhKCyAZqZSSp88XNgZ8EkqqRbrGpdpLMs8MCoAF5G6wDxtLzQAD8lvOqFFRWsUBt/bsPm7Jl6M9oWQpYvNAzWigyJJbcsJNoWR4cmFs/q8=;25:QmjSxjAG7WErDQGlcKK3Za04Q+IW+/npMkIqZg2k3DTxvz3+Tfk8EbSSMzqjabBp8UxLtWk04VfvSoMWwVJoFuAT3CfctEW1oMTATqGqz5G5Jwp+5/sX4HGgKvfzRtmuWdXxM00/FtvoOj2+WzfjlX2GGLpy0z6ef3O64juTUoW7zIensC/rB1BZpvSnOZPTS8q68uuYmed473NwW8cvuWFjMta7GONoNxYtn3w+LcAtyRFj8HRX8nglS9UgLLWMUqeDhd/qRXLJMpJGviLBzN/PVg5DXERMjxIaBqJyON03pLKNDvxhnooc4+qMPnar3cPeICHI6ve6geblwrYTFw==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;31:KRjOxVhhlZBaRSHCQiPyHVhiaVV9Lit8yi9+edBLv06WLNKcOHBMc7q4mZSLfZi7XODCqPaGRPz8IOa5v63HraWaAwZN70gaP8ZjkywJGFVQhshc92F/evVoH5JDb823Ne4cojyMFGyQ2VmBpqPdQdGC8vls3ZyLE/y44899W9fuXBEyRaa/pKpk+ny+GXEfGMq0FA20xr9yd03ozjsAMfoO6MHvMhbjKUQcW9zRNqo=;20:E4SXfzWqM8gotY3raRZD29NGmHzesW53b5nuOPRfi53yuVZyz+tgG2/6qUS/d7znzAQ6wYT4lEfTBTxnyi32KBm9CEiYEA4ZV9rGjEi/dYzkLYDKqyLOQ7Jz6f4UW0lcD9w6KRNLZIJJ6QOLTW9NMombEQQ9M7U/s39cf6ugCkecf7/J/PN8J04Hr+7joyK66rGTeNGbr1LZyOyH/VxvkvWTdcQSHrbbx4KNwrS/cpbBVNx7wPA8458x44ti6Ce8ogHgy3yT3XrFMRTLWo8U+QOCy5ybqAsV5+2to98tEKs0LjT3Sz1qTvytVt+Nmo6DNeB70SRIFKIEiX732vH/XBnLOmwzuRLGi3vDv4S6zP9fBvnAa7LUz5y9PcqRbbVKEvdfxbTfDAufqzHSpzp3oiS/PE3enQE7cgU7O7/aquDEhrwqx9KRCl1b3w/lemYaWn4eZiq7SUUmIDwZ/idnCGPEbh4Bs/McPsB1tH4zN56JqjtFC6PxREW+YKP4HIjl
X-Microsoft-Antispam-PRVS: <SN1PR07MB21755FD382E95ADA0D250779CD130@SN1PR07MB2175.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:SN1PR07MB2175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;4:gUg52CfBnUvGximJ23GHbxthT1908VQi+yZkVpWs/r3m/DDXQAc6tIbiZyFpcsCgR7dyqw4D7fFDYxfobT+r0eSzCJ9fe8162mQrla8HpHfhKjMGMKk021D0ZTrzfdAdKpoxZSF3nI60drLKn8tNmFH4GbfRdeTerjSFWU8prZltFjja6M9ahA/6e0NSxcg7xIk79WPlrSKoagAP716CwqCSaHKtyZkVrX/Y9LUpXJ23Y3xv/dATnbZeclp75IkMRoB2tEfP7yXa6aBBsBLIaBOozeZhQ1F/CCiODEPsNSOpfS10/CGD3iopBYKo4UNoWes5iRsRWbT37p5JkVJonlyGxuUk15gLU1Izq/HIkIE=
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2175;23:voENpw6UIXWGAy0DvXXLKRnWmX2lgq9/K7gIT4h+K?=
 =?us-ascii?Q?TX9GCZZT4cM8u5XDC5Je1TKlIN4bZvZbX1ZJHZ0x4Jdrzy3nQWnWEojug2Bj?=
 =?us-ascii?Q?0r9nQJv4NnekygTsUI7dr+bPX+wRpiL9RXaI60IaKmXjsYiuRLfDV01NuNEs?=
 =?us-ascii?Q?Btna9fGnj1TYVTXsbX9tM157QdSNDSysWH2AqzdRR4repqA6PsYCBYA24+cw?=
 =?us-ascii?Q?w2dXAinXdkapdBCT6iJQMm+4gbybM+VSUjz8FcbLxjY1TLIJTASc8wAvODq8?=
 =?us-ascii?Q?0lyYLN7W/XaJqS0Sjyexp3VIh9wPex1dM3uRr01LB9zV27IeqOS54u9u+JBf?=
 =?us-ascii?Q?qHcb1LAv1UVGpOt5ee1IamBallnG1xzWXUufgP6Y4JgrJrtNI/rSZGPW90rN?=
 =?us-ascii?Q?dDJ9WGU4c8eH0GPlVzKaZwjHlRWGGIEmir6Olw/FcucguvW9rc+12E8EVjxP?=
 =?us-ascii?Q?L4slFl7t2pVZdcNe9TaUwM7qD2N8gnLJjpYQJOtJn08Kr/fVw6Yq9uwEG//Y?=
 =?us-ascii?Q?Uwu2Q4oVf2ViVqjkvvPGZlZMMKEAD8W9d+l8lZ+LT/kPpdHYLzd6vab4qIVA?=
 =?us-ascii?Q?QHvic0FXpshRO5fQEm/yceXU73JtkFsv69IQpm3DyF3grRigOeHPFV18xar7?=
 =?us-ascii?Q?UDglVJwfZ40UYn0iSvXykcLoJZPDtymXZee30kTMTnlICdnPUbsiYXInTV+f?=
 =?us-ascii?Q?Q/ZUHpOdQSjSij/qAHAE5Fa+2+MOK6RXZxaO3zc0jbk0frynKfVIzTXa/lQU?=
 =?us-ascii?Q?5qWblEuFnUG+DPU3Uv69G+iIrPGAdQNCrcHNswHKCmhhJ1dAOGRVNsm4FFQa?=
 =?us-ascii?Q?DlzqZLAYyv/hRHfX5OY12qpBnom2IDUTwrhQmNrWRZRYOtqT1UsKu86oYUir?=
 =?us-ascii?Q?rA/e7tYHuN4voqVxyRC+agRPG76gHC8VJEGcd/0J8y9SeGzYIPDgCC+gLz7l?=
 =?us-ascii?Q?NlqM/iW9pPNkJJcXwFodrHFqY6/kyUbc92z9H9MRqs+tgico60ex7CFIVvJc?=
 =?us-ascii?Q?RZFMogshPBBBPVJzm8VrUFuJf1QYBdhqDFZ2hvbgKE23S58GNepZ5pRw8buw?=
 =?us-ascii?Q?Fe1kmWr/FGTlchxv32C6Jeo65El5JcieTY8KkdCPTPNkXVvs01Rk0IyzbTZM?=
 =?us-ascii?Q?e35LbktMGo86/eCzho2tNwz08qJP/jS+f2bEo23jvvjnnrPCc+FTw=3D=3D?=
X-Microsoft-Antispam-Message-Info: wPnAaANKdOJhXOK0oxCrQVvRKV3AJ8HODyKjuKTMgO16RhP6D9TO3OsdrGMKs000U7Nz90MKGudoHPInGN+DuhEgcYMbTpsJrcu0GWeer5PJONAm2gK+ADbChfYbQ3InBRi+aPbh2KQQLVdkAATSgArlzijyYLPcoeZ3g8KJJ3Bmzj5AcDuJqPpoXQpOHpRJipXUVTOw/SvlEHNxpKMnKgJeqdm4xicQ/9RDjN7fGPCOsds05RaL9YIcsNdJPeAeyuUStCQztMmai6O6sCPws37VOi92heemrm0bFhADYQNkmSeD281rQJ1n1O8IKcIuLQg4dRD5WuDj7CVxA1FwDpR+8MJLVBRcM9D+u81lsXDuIJ3mBxhCvJpnN8AUfe6N1PLM6j4GGO2Dk4bfwppSpQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;6:RcgmDmEbRAFpSJYhsfGHYRnJ3wQBpATL+etqgGGNrJ0qCC6Vha3fQwcCCPoK4hT/jMEjwCrZbD2/FS5M7+dSsgsBlESwooLQoBX03AUHyYAoOabFdfr13zsKALs2fJsri45zooVO/osS1onTihYZpHJ6+t7J6RwfdMDH6fVpL+DHD4rJba3meQYjzDpuQpTWXTNy/KTYGtg/kG+U8uHyHJkTiKf8SNXJ+EMnNWW3Wm4xr5WsgvXTMVURyfYOaTGJMIZ4+Zw0+izcc4VNBBeYgBI88kF8PFx+ZCcHAnKn2swjYwP9gPmhkSd90cUnZBwch1+/IcGeFb/wgYv4U24lLIfM4bhqvueZIEZVx13jRPrFAjONBFMr6dBDUrugB1dMMKk1ftpLhLzhTn1XHx9nuaX+a0jjulT04CPCMXiI98Lnn1GQMqy+jnHl/7K3SuZMQzsjoSDp8FiLbvzNKq7ZYw==;5:ajn1tzTO+bNLAb2atpKBhW1QKdo1Ekq2WgWH3FtgfYPS27AvV4iI7HK3QGUvJLQ3sAF+pcqgHqmzPvTTCO9lsPuHNq0JcB20fjScpPtQimTLm1ulQgBaBP3l5VB5+KcOCDJCoaFJUD378fFjuNaoUE6Dn+haFPlM8kZzYiXmPi4=;7:cOls2eHvoHHQ/LjD98+dRi/8p9Y5qAvCnkckhnU1DqIPWaqJxsFsrsyWXTl8pTRH0/AN9ECzcDlDY1efJwTHAxbNDWFkDWiimlORSDM4svsnpwb4IwJ56+XKxrTdU2z0yvfZPPyrJir82/0j3UkAr1fCjKLxPwtjbY0JgVOx2euFZZFzCtsZQi385r8yqtIUgdKYPnrHJ6dajQcPzf1p7/JYNH3veOtzhGGi+2Ra4eUR/MXld6DSXJTrECANRdGr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;20:6zniNDLsAFnxP8tw7ILqRJKFUjzFD0iIMvR7KY6V0EADmC3y2whQ6jI5MmWF4vMbuRUAegsbi1jSwo8AnQvafkhlFrngK7gzPxM12qcud1mBJuVq6wqO+4yYXlZgvtl3CEFqukDit8hjSO+v8X1MkNcUgK/d1IoyJlmCVCCXVwAdtrf7HOhTwoCgkLn+AkS52sAMGfVvHQJIV3UxXcdZEZqvp1jdQhpAd9KOd0AvPQBgfa944QAik+L2khkdxJ2w
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 14:56:00.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6fa32b-1563-4c31-7225-08d61f092e07
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2175
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=874 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809200148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

dp_get_lane_status is pretty generic and can be used for other means,
so let's make it "public".

This adds drm_dp_get_lane_status to the header file and add the appropriate
EXPORT_SYMBOL for it so that it can be used by other drivers, be they compiled
built-in or as modules.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 9 +++++----
 include/drm/drm_dp_helper.h     | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 735ebde5c2f0..169db52f92f5 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -48,14 +48,15 @@ static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
 	return link_status[r - DP_LANE0_1_STATUS];
 }
 
-static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
-			     int lane)
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
+			  int lane)
 {
 	int i = DP_LANE0_1_STATUS + (lane >> 1);
 	int s = (lane & 1) * 4;
 	u8 l = dp_link_status(link_status, i);
 	return (l >> s) & 0xf;
 }
+EXPORT_SYMBOL(drm_dp_get_lane_status);
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count)
@@ -69,7 +70,7 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
 		return false;
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
 			return false;
 	}
@@ -84,7 +85,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_LANE_CR_DONE) == 0)
 			return false;
 	}
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 698082a02b97..973d2fda9654 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -952,6 +952,8 @@
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_STATUS_SIZE	   6
+
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
2.17.1

