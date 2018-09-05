Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED42077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N5k8ZxQM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hpN+V78z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ED42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIEFkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:40:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbeIEFkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:40:13 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8519rlP003376;
        Tue, 4 Sep 2018 18:12:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=BDneJ44loy/WHiSxSREAsFoAWLUHvFYOfKEsm3n+8zY=;
 b=N5k8ZxQMjNlzAeV/Ij30mNIYcQUMpLgUKx2CEShs4A2orKSlB39m73FF28XFa2W9F+n6
 LzLVL4kCODoq2fsFrbKGuzVG+EJqTXJaSdm9L1VVGFHxmIs9xFGvHaA6RQ7uc4NEiRfp
 57xIkEplZYr1kkobpiwhXDez966ca9RsppA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ma2jngfqd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Sep 2018 18:12:31 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 4 Sep 2018 21:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDneJ44loy/WHiSxSREAsFoAWLUHvFYOfKEsm3n+8zY=;
 b=hpN+V78zbWlgiuxuHy2Zjs1i73i43kWTgFyaZREBQfEvvdBIGV+oVo8EIX8k6Q0l8yF6lE7lAEb8GFN9uMfJGq70qECZnWULxhYTxuPBUs+olsU8lBxucbeP5ePOeKN7s89H/cxQbJ1/j3L10FF6Oik2iwXwJ0oEglcEMg3pCR8=
Received: from vall.thefacebook.com (2620:10d:c090:180::1:e8b3) by
 MWHPR15MB1229.namprd15.prod.outlook.com (2603:10b6:320:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 01:12:24 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: kselftests for memory.oom.group
Date:   Tue, 4 Sep 2018 18:08:25 -0700
Message-ID: <20180905010827.27743-1-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:180::1:e8b3]
X-ClientProxiedBy: DM5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:3:93::21) To MWHPR15MB1229.namprd15.prod.outlook.com
 (2603:10b6:320:23::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa08cec-5584-4010-4bc2-08d612cca47d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1229;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;3:NRa9GBORoR4UxTP1i8H9o/+1tSZSnZfr3rQW5Lgf5H2mj4WjZLeW7gDcY9rmGYY97h/MQ6nk0Sx4IFD/ozktFW7G5gHUvPgBBCUNhyjol+0PJIL4PZgU/fz2435p5DGtSWhtDFVnwtKwOKua8QtCk6Cn4MDPvHRCdlX9b5xAANfqEpI0Qa/o4eiwYRrIjoe1gwdntzwCKn7zlsX5DSorZ2jZvvjQabX2W6eDoqveGG5IAp90pW+sohDcla8IO+CU;25:smXsKLqa5/9mq1n1DGuGLhGi6s57cbU3ZiV+VOImCzuXKxvHrVTV+7BlYBfHJhyVmd4c54rO+2jwQaklfeA9OWwgugIxe1ZRRbs0aDIc/A8lDMrOOYrk5vRi37rhTDuXpNex4woGnZdeoywNoQNIUFYX0elbP752Es7tPNnSq/Kr4GMkf2zATLYnagIgzUiX+ULH5EwckUIgq5vkZsLiikG1RGJRdiJpNnhnX3agdZCAlvEIYoKvFuwlmyYfXuLXS2FbFvuLgP6buPbSlGkIWNXONz2715YN+vj3shYi4lxp0k6gNZ66RhFvd5ggsS7SvrNT+8iH7ftAnmQbLlmWnQ==;31:dhPp/IECJ22I/M8O4ENEDMPd7mFt8WbvpzSMLFlkewsvpR/mvME47ZvrbxMI43aLz/0U4HclKbJPiqMFAJxJWjAFPfGo8mRCcf8ff1JxZSkMYpFn8gj23lF5d6Z/sPVyAJQwHCxvBWaxz0xmNrFcqeI+IhRuGHYDNKlUVXCmB5IL/vK0B5Nq5BTPMSxAGEh+S7U0JViwj/xPbI8YJkjX1pmco0YrDczL3Z62lh34axo=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1229:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;20:amZd9k7G2h2zcaW+ha3IRHbdbW7VLD25rvK3LHYy0hnk/pITqnrZnmSIrreNhgwRjpvnXjWNLaumVtbb6paleWs1dcGl5sC0hEqf6ZojsS7+I9m3K5PQq+lgORQ7n1vMH4oDQakgjN8RImi2NFifBEX5Hb82ckNJFsoxTvMYr3YDbLtl9/mK3ITJxyYyu9kgQX7YPXJHLH7Z0EC8tZh2ibr+mdBakM1qpxotURruC37t4a8w2yKqnnvJrcPBo79ZQkIe0PmoIS++cXniyvFvniSnRir2iY4zOHygGHPwsF7LOMoxg4zQOKVSIttjq1rM3dZNBcObF65BZYAAwx/F95z8hvw3NOh09AsJ0T5FnYmI8x8O+11jE3tJfxvn2OaI8p9LaL86XfSF4zzwZo4RRTZTK3KKap0o/SYMxG89dnTz6+1gM12hrqwSwRH2/QZPydgBiV+6iA9jNptoXCThRbb1OEzWZLTtEzyQRm8mPFXnPChCeEph6DmNSgafiKGW;4:UhyNWYamNuU8jMkPUq8FPeANXqnZAV7WyZ/vpKjG2vgmxR816nFpwoQjS0g50i/gqDegRc0AFT217eq371tlx9YdK+BQYM3eBLe6kJFw528JooyZ4T5zXd6uH+MOP+kQYOo6hXcSjcqB1ipLMSRxzh44RyLFzNAcen3nJ/N4w0/DiskFQSM/ohiolsCH8TNxRvvjYbt2cvq8mEa02fwtLcjlrtlRToLtS5uklOd/QMVfDgXTF/0fv6JZBfLpFCGsIUSiDoa6Bej1X3EbXEAU8w==
X-Microsoft-Antispam-PRVS: <MWHPR15MB1229D0C131EEACFBA0F7C23FCE020@MWHPR15MB1229.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR15MB1229;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1229;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(69224002)(189003)(199004)(33896004)(6916009)(86362001)(8936002)(25786009)(54906003)(16586007)(316002)(6506007)(386003)(5660300001)(69596002)(53936002)(85782001)(53416004)(50226002)(68736007)(81156014)(6512007)(81166006)(16526019)(48376002)(46003)(36756003)(47776003)(9686003)(186003)(97736004)(105586002)(8676002)(4326008)(51416003)(39060400002)(1076002)(106356001)(476003)(2906002)(478600001)(52116002)(6486002)(305945005)(7736002)(2616005)(2351001)(52396003)(486006)(2361001)(50466002)(6116002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1229;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1229;23:4AbhDer3XvFQFplxU1RFjWpq/DQmO/0hxQwLaPvjl?=
 =?us-ascii?Q?exTvFmuvrX8BDYGC+B6eS1nl1lMT2dC3iqAz/LkyWVvt9arcl4/kLmQDn4or?=
 =?us-ascii?Q?Wu3yYUe0boyTNIjlxMdjD9TkVm3L0+FRRRBFScjwMJd9vIGdHNEuf/Hd8xyR?=
 =?us-ascii?Q?X4cB0Cdsak13bblflS/z9xyzOwMjDbXEGwQ4IbQhOjLBl0jwzEt7o1WBnVw4?=
 =?us-ascii?Q?bQbhyvY8eD6S1l/FO8CkwyHwXlTTQurApK3S421I1JhB5LE/s6tk2JVxvCaS?=
 =?us-ascii?Q?oeyPUhIfCDAd3aXRA9KFcuFbO06Hh0VPnyqdkUimiGmP8wql6LuTsB+7EfeL?=
 =?us-ascii?Q?GQ+EapupSIgE2JhWoBDkOKRyhT7eSfgZSKJC+p+0gP+7PlzWQ9Z88Um+gecj?=
 =?us-ascii?Q?iNvyZR/MmYpM1YPjq0hqlV4PgSNLVjCF8O1sxkv5Rn/LrHC7mpCnM8VK1ObW?=
 =?us-ascii?Q?kDw8kQE4XuMaYmXnwhR23Kx4pCsmXGGMFfv6BDxVyg+uLrKFb8bSDZV5h5GJ?=
 =?us-ascii?Q?+w8gIyutdOjFVWMhzeyRFxjLdB9XY28jHyGiI6TJqbcdQDgBOn/ctqVgdHvg?=
 =?us-ascii?Q?KtM2WCiJxV38RJHVySUqQMz/VD8Wscw5Gfa9lmqq2khag8OE+MxPKR7qGZhI?=
 =?us-ascii?Q?OyXOuW7BVC8f0VBSdHGLUwfcyinLGhnJ9Dv9Co3YtjC7vGhrmDgBoVp21Ptb?=
 =?us-ascii?Q?KdRYEqbI1OVcD4EMwOm3X54t9aZXam2uvo5drAFZSXKFmgA85LtTDwPJg4nZ?=
 =?us-ascii?Q?NGlqE8fPv8nCHkpQzqrPdSZu01e1aM7io8EPIArgEdFqOop3mVFRrrpDD7xc?=
 =?us-ascii?Q?+qk+HwsfOh4V+K0jhpPcf45ENEh0Lb5qydLq3WgFzlzKIglNmT8kLy1r5gHS?=
 =?us-ascii?Q?/EcbsgrYwHDt6oqWsF0amjhoIwk4UL19PMM1DqHDpE0EUQG5lEcDLMZjzFg5?=
 =?us-ascii?Q?/YWHIiwP71kv+UPY6cD+dWQzBzP3x2X1JNi7flJKOWxi8JdC++cMmmUQ78e/?=
 =?us-ascii?Q?OGDEcE1OpSSfF1K5BvNIkgjEaQiwH7vs4nrB7XS/opKzui0C8P1e5T6NdsF3?=
 =?us-ascii?Q?SWSbcIcbq+xngM/wFg2maOlTVbU4NBfpOaVjzvbiJYNm3sgiU0QiDD3TiaeZ?=
 =?us-ascii?Q?w3iyoG6zIz/CA1Jb7uQDMbE4VuNDe9wCjvsM7dghHX5j6eneQOR70FpLS/b6?=
 =?us-ascii?Q?mrS0G6RRw60jCMrEaEnODn6U9ZNeiuIq+xYEspBTIS8mcu2vaOvGPUiKUjbi?=
 =?us-ascii?Q?GwV8M5xkSMP45tQOhTipGc/HT753NohX70edZbq5mM46OCutaXUKFI4erp9D?=
 =?us-ascii?Q?EQJiY8EVy8++YOaDVECYxU=3D?=
X-Microsoft-Antispam-Message-Info: p+lBmvNtIlvHTt7mHkkC3wOfcgfx2fM7Rkr9hynqJa0rYeeQhnv1yB16GMTv9DzzBHp810BoOTUPPcEC283IqvDTmZvCVj+On7MxDcEcU88gZcYpOdRoiFAYN0UaEkjH9XCiTVsjeCqS9len4hmshtS/s0yWbUA/sNpHS67ZNLAaco3xpj1GCyN3NZoVvKZf9Lu2USx8WRvxRjjHWtQj+8PuI1aL9leXLWZfbOGr53OzDPd95NfLT5JRZH8uLLAqeiqlEYQ24IBeJ1/1sIoPhsLMrwLN1UKJvfKMdvhGpjoEHALy0Ir961RngWqOks6DSMWnVRoc64SfPmcLBYuG8f5OPfaFFg2V2NaW+lRwXHE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;6:I4l0qZBiKvp2t/Ys17i8HMVkAVGDK/GnHwYYof4VE0V8LLm0+3vWI/xhIBt6XhXh8DN3oB16aUCe8Z64qYkZjMJYMyWU1KlmDCHKekxTvU9qtHd8NlK/Q1SikFgC9qcgiUUS3rAc52NU5NhGP2Y/7S2SqCsXMTXDYvweSfnJJJHf6AFNuDdWC2mFSzP2qq0hYw0PDiBBD3sawViVPbmCus/F6J3enWlNO3lAcMFQSXynWshYpo6d+oxFt6v8YP/VmEQD8OSJRQFgjGDEbv8BdT0HL5kIT+3BKcafII71Ta86vMFxJ1xpX6heKgdojgPbQwOFOMcUFOS26DmpfR8bz7NYP12nWJxuSu/yo7n7VIK5iyVTv5OPrvejthh8Bx4mPoJX88iZ5j3e31og74L35OZmHNosPJ1sMBpVeuz/xIk3XI5ZneRKgSkYhnI7f9tC+ir29SqKWjk++Rb7OSZkDw==;5:NJl3BiNPUy3zZ6aSPt8xTBxNl5xbCFHvOo19hiYZOj8FiPDSFg27AxiKJ8X9FPcV/i0ewZAq6gUdXBPu9pJU9caFRV5O8z6bX8u/DxVgf1DIbQDP6juiqRJ06OlzZ2RE4HXmAJWmnMVW7+TFn1vL2jUNbQqt4j6cSGv4Lw8aPlo=;7:PB2h1U8ADAvG8BC3zDS91Rs3DCnIjBGrGCYc3yaPYPj1+W1uNhKRElMoTG6rCy1rwTTtBGB8dcuGtf88FBjzvKp7fzLG8sRpSWgrvdekPrm3lZfLNv75ZuA32wNUUHakHdjFAVkBG07gbAjs0ucZ9ARh6FMzKw67p4LLSqa33sz4RV8Kmi49dh3xTwCkCz8s8eimV6FgYKSqhlBITydW3p0IhMc0qrlxKvlYsVxzOrFCVOfsiP9avSJm+zofOHBz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;20:JjcVnoBp8nhI9/+OUvXj2so5GMPD9hh3XRbGGA6c1DAvhReExzQqlLJwJ2vNgAHyfn24Bzdhm203YDctRI68XdRGZRSbeUyqF2CBqs2OXJ7+sc6VeGubTACpkO7iZ5DI+c3A/hDYs8Dcab1dSOqdUf9iwHIl8zxUSxxST9pH8OY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 01:12:24.5869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa08cec-5584-4010-4bc2-08d612cca47d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1229
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

I wrote some tests for the new memory.oom.group feature in cgroups 2.

In the process, I discovered a few small bugs in the cgroups tests, which
I have fixed as well in a separate commit.

This is my first ever patch to Linux, so let me know if you see any issues or
improvements that can be made.

Thanks for all your amazing work on Linux!
-Jay



