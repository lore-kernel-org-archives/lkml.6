Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD05C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92EB241A3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicroFocusInternational.onmicrosoft.com header.i=@MicroFocusInternational.onmicrosoft.com header.b="mHXD53Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92EB241A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeFVMJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:09:47 -0400
Received: from prvmx02.microfocus.com ([130.57.1.217]:17557 "EHLO
        prvmx02.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:09:44 -0400
Received: from prvxcaht03.microfocus.com (Not Verified[137.65.248.137]) by prvmx02.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5b2ce3940000>; Fri, 22 Jun 2018 05:55:00 -0600
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (137.65.224.20)
 by mail.microfocus.com (137.65.248.137) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Fri, 22 Jun 2018 05:54:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-suse-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sSI/o5/rt4K9tKRIZVFgJ5IP8lkHm5hYF4ZR54+2yQ=;
 b=mHXD53Y+SMoqLyPGB1P0KBJ2hfcXCbfD0SD6SrFyceKzzRHy+F+GYN8qHu6XIRYcb6L763/Y3VnGt8amVPK5djyy3qpcECQm0l03ryq13eQDkxrY4yV/moEKUexwjxTi9LNT+dqmJP6Eps+Kcl+F4kPlsq1CYUhOfEtknNQqpTM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=guomin.chen@suse.com; 
Received: from linux-6dga.apac.novell.com (45.122.156.254) by
 SN1PR18MB2143.namprd18.prod.outlook.com (2603:10b6:802:2a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Fri, 22 Jun 2018 11:54:35 +0000
From:   guomin chen <guomin.chen@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Takashi Iwai <tiwai@suse.de>, Lee Chun-Yi <JLee@suse.com>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        guomin chen <guomin.chen@suse.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.orgyour.patch>
Subject: [PATCH 1/1] resource: Fixed iomem resource release failed on release_mem_region_adjustable() when memory node or cpu node hot-remove.
Date:   Fri, 22 Jun 2018 19:52:52 +0800
Message-ID: <20180622115252.5174-1-guomin.chen@suse.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [45.122.156.254]
X-ClientProxiedBy: CO2PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:102:1::45) To SN1PR18MB2143.namprd18.prod.outlook.com
 (2603:10b6:802:2a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b34dc01-b306-4fea-3391-08d5d836ef4d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR18MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR18MB2143;3:oWzH2xslQimDphnMVFbEXFjBWG/3uq53MRPlyMGupybWa8xLymhS4wk19ncShJIyqWZzxoMgQ80WSoowftAjEK2NJICma6CsS3xAUjDK1S0q8cz7XFZTENM5a36OmD2zGIRAnujOSOnVC0qQDnEPlZ1CjV5R37dWxh0wWIAEz1YD6cbXFUzO8+V9a6naya3UPAw5RKHCgWG551P5Reb7XZ0n+vEDpYKeY8zLJt0x16i6KlsXUGtegoG51B0imyLy;25:HqX5+zReMy8i2sPqu+khWBY9Axmd0QRzyLJ3cpQjgDGYX7RTvIygy3rXQAUWzBqK06nw4LrtSEopJXzmklGzb9Mwxcr5uYQVdBGtRuPZ1Eu7UhcbrgKqtL1Nbsj5f6XEoZZyqL8V25wqvHqfY5E5W7mkPfS8CdN4AF9R+m3CZBmH+s5zj1rkG7tsQWFdOm+m3vMwYimUJd1B0/9IDqOxOH3vfXcX/NXNuOUC/i09ew4mY6OU7lmPe0larZGpcoUTXl75QM5ZZqP0JJHeTCODk/cLK5ln1FagRfaGLvFTccnOFHk4Bvrh4HEr54TRpHacnNTdieYIJKyXZvUyeHaC/Q==;31:tvEyAEdPCOjepcasbjNFlAFCReP1cQkA7wH9MucVYC9zin3gcfxHmOaPKIc79ThWiSzlgqxP62faJO9gb268Xs/P3gLBQSWHSLcVj/H0nHc0UikjdHA4bQLDGBVZ5WVEwsfRr1w8imRTBNQwTUBlF0e96Spq2ASgYgp6lYifoKmGeddIT83uZtYgJlIO2lufje0KyLrn0GUTWiumJaptBtm0IduVW6ayahPhQrq3XoU=
X-MS-TrafficTypeDiagnostic: SN1PR18MB2143:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN1PR18MB2143;20:H6KIhxvlREy+ycAQswYG21h10IGMBYjXqPdsE78DHWrIMZMleeYVaiJ1XllFI46gtbF1OvoDVb6wRkVylRTkMNj6hzsKt5Rhfe8Pc8ZpXrZpE8QwvpH/zb6+q6YFY3VxdxDyf6tX43/7H6Z6yOerF9CNlaxkJ+kiDR+3295tV9+AhUB0vqtY0KKRSorJqcvZNoRmh8RVEeDELRSTiJNA560lCLCe72Y8sA0nIqD3i5fqxMefQ+1ljaug+V1B5x33DLZO7xIDZxdRQF46bTecdxIGYvIrfV14BbT8aCdmjH0Nvs1UeU7zY723hp57YV1cNiOJQu5Mn4KT5UkwA+A0vtZ0PLcOMzmP/thpslDFTN2GDZG3/PXa17tVPQaYTRRiN2pyj4yP+ik1qwkHnDAJlYHHYb+tjlQoWHCeqtR1iR8qa6oYsUmzyVoPm39rom6bTEXw/br+ZlpXFWGjWSuMN+SG1OBqrv69U3QFXtRKfuiTf85RLle1Whzk+CIxXljE
X-Microsoft-Antispam-PRVS: <SN1PR18MB21437E739DF7FD502A1B5E789C750@SN1PR18MB2143.namprd18.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(173505980823694)(9452136761055)(767451399110)(211936372134217)(153496737603132)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR18MB2143;BCL:0;PCL:0;RULEID:;SRVR:SN1PR18MB2143;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR18MB2143;4:eFTUcPJoqn2Z6DA7ki4eoWtonHDK/V2jU5CiLpnksKfoIRbwrr32yPREG3EIE7G2H04Ho7cuAznyVjEA/35H6P4evs2dNEVnqMzn6fHEkBe9gpfBx98LSGw9ch9Kxof4DrSQHLmJthiR+hCrCh4yKwFgI15r2OikDLmWobtjvb4A3dXqdzRQ5BIL8tYxQQuOjhCl5bHNC4k1HWrcBeVnOWf1Usg4hJc5dJgk645qvSpg50zSmpaWEzC2uoGrFav06WCv2E1oIV+q0PKzlvlBaVtLMMMYWgs/pRdeHJQBUVbvNpjDRJ29hH1HmugT6i8iYr7sc6oCHWh5swiuI3vKoeu7JninBVFZgd5BbWFlayLk42zJ1o68jiqot9SlI1zmt0Hm+1tUl4lig7/5IuzipISEDTe8oJHYQYisKrMj2QoS5ZiAIEU36E8MeLbFUNumbmpT4vcrj9eXbyzuPQvp2DohY7QgkVmNayr48pLFLQE=
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(50466002)(25786009)(575784001)(6512007)(48376002)(106356001)(478600001)(86362001)(81166006)(8936002)(81156014)(36756003)(8666007)(16586007)(2906002)(6486002)(86152003)(4326008)(110136005)(54906003)(6666003)(316002)(1076002)(68736007)(53936002)(386003)(2616005)(8676002)(7416002)(6116002)(956004)(476003)(6506007)(305945005)(26005)(97736004)(186003)(3846002)(16526019)(52116002)(105586002)(47776003)(5660300001)(66066001)(486006)(7736002)(50226002)(51416003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2143;H:linux-6dga.apac.novell.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR18MB2143;23:z5Z6GJUhQ3J1k96+YeidAxyecqLNcX6iYA9ubCS1p?=
 =?us-ascii?Q?U+I4/M9/8Fn7f4pjHPUua+u9dfutiEkNd5mQ/l11FVAg/E/wec7j2W+pKLyd?=
 =?us-ascii?Q?YAUr4QONWEJna/eVcUWj/ICOeIUOReMzKOURcff19Gc+Ikk/YHrUChqyxDxF?=
 =?us-ascii?Q?moagZQUM7Bjm5f8eE5xi/PZiefxynj8Aal3IwPsJS+eCAH3aelwm4xMOOg3Z?=
 =?us-ascii?Q?CBueMwgxveBvFmB7oBYR6/vnQ2FY2ZlgkAiaZyxNKMfOlwffamOnRMU8QUmt?=
 =?us-ascii?Q?5H+7tFl8SAeulj97PY1X8cn/kCEJ5M6GxRgZzJs/RXDEPdAG2ihusb2z3d9o?=
 =?us-ascii?Q?k2CDNgrkf6wnEDJHpfe5KmpL5f/i+irAzKTi8ckMyzw313pJVUh6/hQWlsZL?=
 =?us-ascii?Q?q1j/YCqI4+xmK95VHSssXjdHux2Y/nOOCb0dBBqwVczQhhauIUGvSiTysl0x?=
 =?us-ascii?Q?FuPWhwlPdBC8m+k22NxXgPFkJ3PfFWLxrww7WW4apXCEUAuGiLNSefq9WIHc?=
 =?us-ascii?Q?jw9oOAuz8KYPqqtHjmvZPXCZ+99ChCLlvnBni7H1Wga31Hmr8Y+DjFDrn3Lf?=
 =?us-ascii?Q?OaEcorromrp9oG5ubLaizOlsVB+h2+T/7KB6VOPpvRh2a0wLOMUbrSbcM3r4?=
 =?us-ascii?Q?JNjk22HwL2Rxn8cFW9+qRmd6E96KPFJYszbQpepauNOUH0gQTKowaIGwkKEX?=
 =?us-ascii?Q?MsHBAigbVyN6NLy2mLAFn1bAAi6bDNsPa1CI1E740TjURpBE7R8YBxOVf6Wl?=
 =?us-ascii?Q?R5EfcyGJfouibz9AxMNsngKbJy5wL2Z2cH+J/QGi6vXaOB3YLGbectlVM3ls?=
 =?us-ascii?Q?XIjzY5hkLe0ipZ/wn13G/3FdN7qfaZXukYn79atNVKMMVDyTtNNE8jcuWt8T?=
 =?us-ascii?Q?M48N4PIVOyDj4JaOz3QiZEzx4MqoTZLXRGjl76TZPfziCjzuXu4aCBgqEsFv?=
 =?us-ascii?Q?45+xVD3Wa9g0PQ5T2iCh6zLoS1Dr/fpFcBfKYTkXTa/6I00xOHo2rkB33ri2?=
 =?us-ascii?Q?gYApyudA+Ow/AxXBFkZdg6tUIwOJs1PfL2xnPCTxumnEUibur3GMFbfaBmS6?=
 =?us-ascii?Q?jgjbLXRgo53RrYvQs255MKHuUxjvVMP3pPIRwRqcxUwBLxbweEDNXYrvh4DC?=
 =?us-ascii?Q?hEiguKXH2VvFt61Urqa8ftzJHol97034aPr6Yo3+7Jm/We2H7z0zexA9okLw?=
 =?us-ascii?Q?QL3CDFLghkNfeFB6HYoJ50LZfaSgzF10+h1MZUNFmruyisv1WDrx0qUvazki?=
 =?us-ascii?Q?thX2IdL1jymT/QQi6E=3D?=
X-Microsoft-Antispam-Message-Info: qkWNJUxcMSUH3cvmbxnVGdlK6CO4gj/LkoAYjUkzBdr8qZ1jE2qD3272ulS1+nGWnEmUJegaBWSPc9E2NlmmoCMUZ+XRD+M1+0VwS/h5j2J5rqhgiYFhqTu7gBkGS4Y0bdEnIVxzAuNZoydgRDfr+cDehAOcTf49j3+szczKddv26PhYOv3degSfMg/3D4+L6BHqXOZy91vRJBOT53v1mtzGFU+IegCtF3giN1uyV2qzvrdZq92YYhTQlA2X2EdVQZC4Aj6qT+8XOyRhHa/KvHRyBqsESnQRs6FOYyyMVE5Z1dn7ZGumbKk26XFjlBbEkO9V/kF7xpAHJ0Fxjj2kIxmaK5uVc/O3l2vZivoJ5Xo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR18MB2143;6:XTNJLxXU7iMVhIQDrGYoeor98yiLBARbuK6o5yvxf0UerxHKUWRE3u7R2qM/N6tpuc0hmjVeMRYIHmU4kNuEOwgzAMj6fKiJilYFGd7Hk0GU0FuhH+u055nD5jeEV2AzcjuwCigEac6zSg0UPXAz3U8I+nYMVMdKEwD/23Pm0L8YLKqzeNiSmM1/iUFV/64KGezYEaMZ9yaw4ehdxIuoRQFXtZttBnj/S+7wfjXccpJ8o5RFsA1M+0zC3vCkrhcWfp0XUju0QrR6yFzuYEJ3PS+Xd1ggEEZ3IbPZFZ5re5x/jCuMjyR01U6jGKn6mGW+SDuS+gOUhtp/B08CLoYmwSWshEsbbx2xQk8jfnowT9J3USfee+qvolsQUfMM5Zz6uXcb9qdeaUH/7DVN4g6S2owO8IZQvnyizRyCCuibji1n6NLMcyst3XQ5d/iT/FWWv4Qm53C8k0tCp7JpuToEVw==;5:7qV6Aqr1DPDRFfGUHwTVgobkfkF2adhOpNfmrC68+cv4LL4vtm4Po9zZP0LgCxrpZIjy5ORjN0RsxSCQmdiGb1XMknwqX9q4aCfTBw4bQMEWufzJCfpWFlXyNyy6NEILxfSG4pcDtp2zgtwfI/DwwJpS4OFXqNCRDJRl87qKC1k=;24:G4gxdsash6BT6II5XB2UxXlpxU3yZdCKYIBKuV/ZkLtbqpwId96Wyuh6+17ftnbI60rO+u2IFqz2GLXSfTc8of0aOpdZjuQttFThKUoI1Ac=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR18MB2143;7:bgD6gJ/GPiS87HVsjxNX9YsV4nF69OxieQ18qSQNLUzBpxrA3etyCmfeVWyKtGCsAYYO6v5A9NGz5rQrUNWdGExefpmpjscKwQlL6A6ZZdEAVXOFEDifP8XGO33uIKcDX4lsayDAexGBgempv1JPmaWSj4R9kmFpcvQxsjg3VxLt7wcgb+cdcnYfRtjArNZQ15bRqRHuT7XCP7xwPBvUrLq3CKKJhiHRFevautWLhnJol+fuyuI1fommS77MdfYb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 11:54:35.4941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b34dc01-b306-4fea-3391-08d5d836ef4d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2143
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a bug report indicating the hot-remove node resource
release failed,when the memory on this node is divided into
several sections.because the release_mem_region_adjustable()
can only release one resource that must be [start,end].

In my case, the BIOS supports faulty memory isolation. if BIOS
detected bad memory block, the BIOS will isolates this badblock.
And set this badblock memory to EfiUnusableMemory in EFI memory map
base on UEFI 2.7 spec.For example in my system, the memory range on
node2 is [mem 0x0000080000000000-0x00000807ffffffff].but the BIOS
detected the [8004e000000-8004e0fffff] is a badblock memory.
So the memory on node2 seem like this:
   		80000000000-8004dffffff : System RAM
		8004e000000-8004e0fffff : Unusable memory
		8004e100000-807ffffffff : System RAM

Now, when offline the cpu node2,the kernel will try to release
ioresource [mem 0x0000080000000000-0x00000807ffffffff]. at this
time, the kernel will release failed,and output error message:
"Unable to release resource <0x0000080000000000-0x00000807ffffffff>
(-22)".
Because the release_mem_region_adjustable() can only release one
resource that must be [0x0000080000000000 , 0x00000807ffffffff].
but now,the iomem resource on node2 [0x0000080000000000,
0x00000807ffffffff] are divided into three resources [80000000000-
8004dffffff],[8004e000000-8004e0fffff]and[8004e100000-807ffffffff].

This patch help to Release multiple iomem resources at once when
node hot-remove. Such as in above case, when hot-remove the cpu
node2,the kernel will try to release resource [0x0000080000000000-
0x00000807ffffffff].And this patch will release three resources
[80000000000-8004dffffff],[8004e000000-8004e0fffff] and
[8004e100000-807ffffffff].

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org your.patch
Cc: Lee Chun-Yi <JLee@suse.com>
Signed-off-by: guomin chen <guomin.chen@suse.com>
---
 kernel/resource.c | 73 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..959bcce4c405 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1240,6 +1240,7 @@ int release_mem_region_adjustable(struct resource *parent,
 	struct resource *res;
 	struct resource *new_res;
 	resource_size_t end;
+	resource_size_t new_start = start;
 	int ret = -EINVAL;
 
 	end = start + size - 1;
@@ -1257,7 +1258,7 @@ int release_mem_region_adjustable(struct resource *parent,
 			break;
 
 		/* look for the next resource if it does not fit into */
-		if (res->start > start || res->end < end) {
+		if (res->end < new_start) {
 			p = &res->sibling;
 			continue;
 		}
@@ -1271,42 +1272,54 @@ int release_mem_region_adjustable(struct resource *parent,
 		}
 
 		/* found the target resource; let's adjust accordingly */
-		if (res->start == start && res->end == end) {
+		if (res->start == new_start && res->end == end) {
 			/* free the whole entry */
 			*p = res->sibling;
 			free_resource(res);
 			ret = 0;
-		} else if (res->start == start && res->end != end) {
-			/* adjust the start */
-			ret = __adjust_resource(res, end + 1,
-						res->end - end);
-		} else if (res->start != start && res->end == end) {
-			/* adjust the end */
-			ret = __adjust_resource(res, res->start,
-						start - res->start);
+		} else if (res->end > end) {
+			if (res->start >= new_start) {
+				/* adjust the start */
+				ret = __adjust_resource(res, end + 1,
+							res->end - end);
+			} else {
+				/* split into two entries */
+				if (!new_res) {
+					ret = -ENOMEM;
+					break;
+				}
+				new_res->name = res->name;
+				new_res->start = end + 1;
+				new_res->end = res->end;
+				new_res->flags = res->flags;
+				new_res->desc = res->desc;
+				new_res->parent = res->parent;
+				new_res->sibling = res->sibling;
+				new_res->child = NULL;
+
+				ret = __adjust_resource(res, res->start,
+							new_start - res->start);
+				if (ret)
+					break;
+				res->sibling = new_res;
+				new_res = NULL;
+			}
 		} else {
-			/* split into two entries */
-			if (!new_res) {
-				ret = -ENOMEM;
-				break;
+			if (res->start < new_start) {
+				/* adjust the end */
+				ret = __adjust_resource(res, res->start,
+							new_start - res->start);
+				new_start = res->end+1;
+				p = &res->sibling;
+			} else {
+				new_start = res->end+1;
+				*p = res->sibling;
+				free_resource(res);
+				ret = 0;
 			}
-			new_res->name = res->name;
-			new_res->start = end + 1;
-			new_res->end = res->end;
-			new_res->flags = res->flags;
-			new_res->desc = res->desc;
-			new_res->parent = res->parent;
-			new_res->sibling = res->sibling;
-			new_res->child = NULL;
-
-			ret = __adjust_resource(res, res->start,
-						start - res->start);
-			if (ret)
-				break;
-			res->sibling = new_res;
-			new_res = NULL;
+			if (res->end < end)
+				continue;
 		}
-
 		break;
 	}
 
-- 
2.12.3

