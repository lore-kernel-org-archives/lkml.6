Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895AEC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A6823D82
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicroFocusInternational.onmicrosoft.com header.i=@MicroFocusInternational.onmicrosoft.com header.b="jAe0Qfi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A6823D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeFVMDg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:03:36 -0400
Received: from prvmx01.microfocus.com ([130.57.1.216]:11693 "EHLO
        prvmx01.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:03:33 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jun 2018 08:03:33 EDT
Received: from prvxcaht03.microfocus.com (Not Verified[137.65.248.137]) by prvmx01.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5b2ce58b0000>; Fri, 22 Jun 2018 06:03:23 -0600
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (137.65.224.20)
 by mail.microfocus.com (137.65.248.137) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Fri, 22 Jun 2018 06:03:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-suse-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPVo4WxGA8E0qorChjSpmR+8mj7wuVjcb9c5szOD+g0=;
 b=jAe0Qfi5mO9ZK4+VKZJVvuaCz+FqhAjQ28WZyRAAHPSbpxqybG50GhPQVystlKzbEQFeCc96b25WxWmEmnHjUj/Xo19+HwM0cGrLd/4CtOIDZSqdwrp2CsZHhJUTYZVY1uek01/kHuMYjjB90ihOnGsReIY3tqIwOjkjicJg3uk=
Received: from linux-6dga.apac.novell.com (45.122.156.254) by
 BL0PR18MB2129.namprd18.prod.outlook.com (2603:10b6:207:41::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 12:03:23 +0000
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
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/1] resource: Fixed iomem resource release failed on release_mem_region_adjustable() when memory node or cpu node hot-remove.
Date:   Fri, 22 Jun 2018 20:01:38 +0800
Message-ID: <20180622120138.5411-1-guomin.chen@suse.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [45.122.156.254]
X-ClientProxiedBy: SY3PR01CA0149.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::34) To BL0PR18MB2129.namprd18.prod.outlook.com
 (2603:10b6:207:41::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88e7db1-23d9-491f-3da9-08d5d8382b4c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR18MB2129;3:An18NCFYgKcGa6oJZuG7R1G+u6csxqOGnx+vfgehV5jV/pwTxDkC07HCCnH//17Y2n2jv7xm5Ey7HnDRG6KvLfhW9+aIswn2ZE8+wgN3dGDLrgixp9ishHMWCE60nfv5hsHsNtf/7ut3ysph2WIkkPf+bOlzL37FzfVmUrdICGO0GlPwMI+4ipC6QbOoR88lYA3+yYSObwLGYtYJtHsn3mrlWiXFvGhKNPGampmxJZcU59ZJNmGW0F+HStWz4iYr;25:+qf36tE1X+cfIqiaGBO3VSTOnMStnBrLoFGM+CrzzXAP2TAJCGcSjdKABnoeaifH6PmBugEF+542+gHtsFBC/5jo5WvpC6aJB7lhleAkBDL46lMWnOhqrL5O/GvNMF7hdS7vHUz1X1c/U3J0En+vYF1UKumfmU6gKZJHXQyeqPoMCqW7v68LuYBcdAfvDYkezxM+itiCUeKrwEpOPi0lGiydqMx4RJ5haGzVAPqOZmM6NV5ePkKQn/wwNr0PhfnbAjEEG1Cxf8t9I3Q7AssJYv+Gluey8yEAasFPPbs5kzVTY2TX0RG7j49gHGEVHDKEY97u3cGNf5tPBiIe2kWntQ==;31:lq2bAJtJJ/kXtWc0A1rjFQ9wYDKT6Ct0h+rTy+BX979fmoczcaaoWpko28z1dOc6f5xYMhKhyM17DkjDHAv37JTYsCWW/LwbPrrhEqZEdSbUAQvlDWh5OcCauCqjYCtaEuyJbTk/P5Gk2QT6zEIdps748I/RIoj4vMpc6h0uw1vWMGUZSeoFgV3mG5Z5YfXBpEkc1eueGuJ4r9S9oRoHlzxGJzBjcvIUAnBQDCwSYwU=
X-MS-TrafficTypeDiagnostic: BL0PR18MB2129:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=guomin.chen@suse.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR18MB2129;20:LP0GGOUeiw2msMVJPI14exxZ50B1hNz98jFgcChota75tAESyJeacyZPjB0I6ILYdBznwJTKEa7LG8rrde30OMoHR5TntytsAbJD9P3T135QMak/gvhQZbyIphPDSgEIBPihX5hdvjqotHpU3bQ/6G4gWbiNFw47mWxGxFuKYJrDT53Cra6qM6mWvsfFFivpcvKxohluUMKYxcOzZMpa4IVoyn39hDiycjpPqcaYs8wgP8Nd9YeYg0n4oTEXqfHH/lZyhmB7COCveUbmYFB5QymRcUleI7DlqnHluDu/XYbecnYHmpBcHlDl80dLmJh+cuS1H8He10IL7eqOh2rJKR/DWgWPea8yxkRpOxI7GeiMezEflGakEVGXjwx472n1XGrQoFnXQLtdHtLf7OTFxve+Dy2mWqnQcl3VeACKiuDR9WxvC9PDzZrm4LzOjWxUWI2w/WWrcAamisLuGF1sRL9neLivlsiPd3bbYtwYjSrOKZerDek0YALLEI/jYmqV
X-Microsoft-Antispam-PRVS: <BL0PR18MB21295073A33BE7163EEA7F099C750@BL0PR18MB2129.namprd18.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(173505980823694)(9452136761055)(767451399110)(211936372134217)(153496737603132)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR18MB2129;BCL:0;PCL:0;RULEID:;SRVR:BL0PR18MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR18MB2129;4:VTpdtaLPwSPdXCcGwL5swEAha/vqH/JAcu/lIi2BpXwwxIrx3uFJuXSKXKjyaU5BgIkoCLTEOcMJk2D8w5FpL8MtyVhg8FSvBuJ2ZTzumkRWvC4EprlhfgC737UDI+lHXCV7JJHkBoSPEO3fJb7GxB57PcZhsDyT9ZCWZjDy/IcN7xYISrf5urQpjnkdduPFeskocxzI5wzTrD67gonMWHorHJmP9R+YTlufyTN4ZVdUhMpIWHibcQQoNNyZs7/xHH9vlVSz0gzK2U0437ibDF7oA5FplltBkFnzZkL/jH2Em7EE4uqrwUzHDwvkXfw0oKbNPgLdzbVZMhhnc4oW20P3HhMIzC2d+GJY6QGDYaPgyJRIGS8VWQCaaBX6fyV2a+Ew9TGbara/JGGg2VCmMhwPeWagYHUkgdywuPE/4gTwk1phrkALxe9prMuf7HH8Naj2/nmUoZievI19kENTUjcWLS/yTaFBaCEtAxjR45M=
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(189003)(199004)(106356001)(8936002)(66066001)(6506007)(386003)(47776003)(26005)(105586002)(52116002)(51416003)(4326008)(478600001)(5660300001)(6666003)(97736004)(25786009)(1076002)(3846002)(305945005)(6116002)(53936002)(7416002)(7736002)(81166006)(36756003)(48376002)(6512007)(8666007)(956004)(476003)(2616005)(86152003)(486006)(50226002)(16586007)(2906002)(6486002)(68736007)(86362001)(50466002)(316002)(575784001)(16526019)(110136005)(186003)(8676002)(81156014)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR18MB2129;H:linux-6dga.apac.novell.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR18MB2129;23:07ksok0BK7qrEj1hoVpv+tPVpgkAdn3Wdn0zMbhVu?=
 =?us-ascii?Q?ZZE3Rmnxo/ckovfPHXdz9Ml+eK0Uc43vs4vdGhz49Fh6/wGWSIKdOEAeSHlL?=
 =?us-ascii?Q?eKG5KK45YtYtmxzxQ+w/9j9pShk69MRq00KP50hWGqTV/NSbVlKIExLeQ92L?=
 =?us-ascii?Q?JPq9s4S5bD0H45V43ZEsZVKaRtvj1icwSroxbrtuWVyvNffoyYfdxU4XtGQi?=
 =?us-ascii?Q?ayrkdfggko0bZWuVMtO4MD7z29LDnSWeC/okHHuLXODms35P+6BBLy96hhXo?=
 =?us-ascii?Q?olDpVsQXIq/iu2GUYIDZ6HDFJvEQBRl1Sri5vU0yh56zVkSczf2BFIkLWRsw?=
 =?us-ascii?Q?jSBhssnhX15lIZAQasM+mlEn4iObrfxgghTv72koFBmDOgCuTmU8yxONq0QO?=
 =?us-ascii?Q?tn3BAMew7WJwmtsaI1/3gwmvLPyFJn8hBP/OXP2p/2rOzZyLsThDgLHwBaym?=
 =?us-ascii?Q?gVLY8+hoOgwR/kAqKRFiEwjvi8UyaRAaC42wi/eC+txylux3kFQ2Lqg3pQoe?=
 =?us-ascii?Q?gNFZhe/l5PPOpIMxnTSst84PZ+5T9U5abWpKdXJ8SZdEjZEqfj6FUCin1REa?=
 =?us-ascii?Q?E71tRnvTOL3v5yd/tUkgek+58MKKA7NQadqjclCi42hC1khq6O9nklBQZNQN?=
 =?us-ascii?Q?yS47Jh8Nh+zEUEOB1qA3FPo5LiCNa/YmRHRpxd3ACGK9ldtqHulKM5CY7TFO?=
 =?us-ascii?Q?fjGZrmt/4Gh/9VmeIOnX0Fjhnn4p3iPeObv4WlItJXhfD/dkUogXdqbxIJpa?=
 =?us-ascii?Q?dFBsEvxzNUy0z8RBfLbIH/jG5gTc2nbSisXwZXD/msF76PbiEMrOSkCvSRUq?=
 =?us-ascii?Q?BttJx1qMOtdyEJWPTfPwFjzaZwAR5eSx2g+IdAybpKM20m5/wdrHCtDKiGnZ?=
 =?us-ascii?Q?pkCd6Jwm5h1Xaq+H16l5vD+gHLI8YOmDYgRfYV27FhHir5rKsk5I0fl5p1+f?=
 =?us-ascii?Q?7G3nvqq+lNaqcZqlRhKpYuIONS91M/k6BIbHocNOUh3Dpe8DYtQsde9E04lf?=
 =?us-ascii?Q?OQoM7d8AUnPv1qHO9bKTy0txUK54RmCHzPMUO+ghMlpRt7us5IKkUWZImmld?=
 =?us-ascii?Q?iHgRAGlu5uDCKgnE3ZbonLX64OAHXOAAtPcaGSK23lzJVuBovMjmRkjxXT8i?=
 =?us-ascii?Q?5fDX6vntgTAEUczZhLF3nJTAFGEo0ETVDbSK+llY2zgzI+6Db+vlFqKq6H4c?=
 =?us-ascii?Q?QTfYpW0LbyikoMZJLEkOPRnSP3kbXEqmGM80p0hgx/+PlKrAOh85uPBctQL7?=
 =?us-ascii?Q?EfsrETpq/sbgkZFUAY=3D?=
X-Microsoft-Antispam-Message-Info: NknJDFAx4t6op9wz995aOGkZ+/C9VWAbd9f/NeWF4Uc23TR4c5X4KyVuvc9Hhcyg59grvOzRqtB9a3tqhuJBF2ES6UOpo0Jc2bCgHc5TugLrO6+NDSWaK4wGQEMUaMccbxOcCp5kCEUlvk3UDRfJFR5N4XWoJqkxQ1M4M6SBn2pAyOSCqH2moE0TDWDO7bPBl70Ezq+RxBp45hifR/wdxRdt16fE3ALQ9tYSF+JFIGJ1i8uIkG0kb6cVuohqjNXlFrMYPuhj4IugMZ1f2QDQwUdZ7w2/MFTn3jtzt1AnmWnSuWZ2jV1A8gDVEBLtcq6tRYM4ekw3Aur0+NGUcNsM6A==
X-Microsoft-Exchange-Diagnostics: 1;BL0PR18MB2129;6:e0ste+N/92VxJo1Iypu9D6WJDKE7fLvmV4lra9rqUOrkMfKkGVkXUOSfYoUiUBSOmHe8fDgbvKtVTq77mmoPLLgtRTKdzUkKNWLlmjzT8bxgZYatafSyjYRW+3OI+UQuvd3fMdQEXJU2VP7KLn6UUfjyH0yjD84CPaTN86YESwRUUwG4q96xmq2QhCqEOTiP//2yJONlVfM/tinBsc5n2BvDB5CuUiCUgkpq6ye30yPhGnL4Prneu6VuWXORS4GHJNZI/DfCb4IE2BBG/FB8tANEAGLmkykyHF3at02V5zfaMwRUx8ULzXBwXnCHdCQvFIUvXlCXEZgexvnPqUA3hHEBDHJSZ00OTPoLY4V/XiTMbo1qETeLj2CxuXnCU2RZpODaAQL3x/AKukF7fg3Iba3+YA0MFFegX9ktAfZoRs5ektm8uIkvbpeCP7Scu3HMhEqr3qhFQ6wJvQd9svl0Rg==;5:bmvHhNvEpDHDTVQn2a4lUCqEP9F91dld9e7V+g3gAdMtMSFUoH0m5EY//xFN+Vd9d87+pl/e6e5FnZ58/PX+rU5rI+hqUua7av2TKzgXnQvr4EMS+v39B3jpWRSyFkAESkfmPPoslPyF++XT+Id+uHxrdp8DWyjC79adkhdTlzw=;24:Nc6NN71/yx0enSn8c7rJe6N9eYPUgJn0iMS0Q6Uz6MLzx2wJp/xysFi8Kl5fCdW2hcsjM9pXRkqWMQNi5fH7VxLVCHD2KfyJoDT/4WyQYtU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR18MB2129;7:hHP2EvfZMT/kIY3HvgTCJTzSa5EI4kj/m84bB1KKnvyG/ABGTi7v1hgt+wds701qXos2OUKkHRAO9RQZPKIpZAbzvLW1mJxyv4itcfnuUl1ztovFF+8zjfCSE2MSCYMluHehbt/6gNydcsCFoY64Uyb9WhsIGSVaReO54UweolH/96BsFhF7ddWcLUdq/BN1p48VxRBbLRAzEUyVzM13f1iSm/6O1pF4Mq2sNU4RxS6AZAZL59BbowEGp6OzWQ8q
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 12:03:23.7215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88e7db1-23d9-491f-3da9-08d5d8382b4c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2129
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
Cc: linux-kernel@vger.kernel.org
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

