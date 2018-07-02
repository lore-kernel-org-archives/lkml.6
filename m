Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3CCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D3025766
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XCzTO6Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D3025766
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeGBVg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:36:28 -0400
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:54786
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753421AbeGBVfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF62zmAYg0bpuhfkEt+ki8C92NQY4vHxCI+/iyzQ2wk=;
 b=XCzTO6EbUB6NLuYd6PpKRPuF3CX5dgaoskXlY6mJNusGeqqyQ/AFhjxC1rsG5Wsme/9fdsRaJX+CVlGADsULeTTQySZ8cPA5rg8+FmoB8RQxgNzke8MC4w0UFBeAOcy0KM9PNtbc6K2agSABxlGpy3LJhFV8DVBJz3iDlYy2BeY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from tlendack-t1.amdoffice.net (165.204.77.1) by
 DM2PR12MB0172.namprd12.prod.outlook.com (2a01:111:e400:50ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Mon, 2 Jul
 2018 21:35:47 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 0/2] x86/bugs: Updates to SSBD support on AMD
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Date:   Mon, 02 Jul 2018 16:35:43 -0500
Message-ID: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) To DM2PR12MB0172.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b817be8-2497-4fa7-1321-08d5e063c675
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0172;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;3:UuXOKi+RZoEiKnKOEE+Dt0twX5cFtDPtJP5rPoAr2b5YcsAGzkHorgKvUdvCvZYujh08HZquYgjo1K37BVfJSfpHaKnDx0pmFb1q4OUBJDK2yYVIFnY1FS161caV9vei1W+5aTqdruZn708cpZlrukbYRi7kki1JmUpYWhXt5Ml7YMFWG3XKUHhavsOspE9dOlpOTPA3gqTOTIb3eccIAjVcfcX8EkUvDmjGAG9Mv0EF1uW+FxkVYKKYBDx3FhUk;25:wSBY8elMs64xM/BwSfadshLtUCVlvpvSABErinZuxcJ9gHZ3nF0xv6YhGoi+7hh97TzZNiDSJXjlvFRK414HnYpZ2jDP6pORjTCxnHBqBEsNHXvNq9g3eCW3k2Egm0oYEnpGXHJFqqOnchcv/LeK8bp2fEBgJroWyCJLTd9WyhZy2kYbavP39BoLluu4dYK82GYCIiVYCTqgWZmXDsaJcz9rnQq0AunblvCjY2S/c85BCIlK2QGx2anhdiF63zyFZzAjOnSD9kIDH9RIGRLxbj9c3h9CpKrxwjioDMldGYET7hknwiqkrsAVVVgIW+r/6OdJGmc8+/wFg+l10OZ8sA==;31:eQAhLbN7UFWukXxrLXrkjXKRyjlix9k1utyH8dnYSVI8KvMbZvk+l/IWgD628J6Scn2UKo0J2gRN2wWtM8QZlJivGDMS0cnMRLblWJQOfsgHPBI33S71U53l+WZ24YT0IyG/N/QggockbHvFFHPBtHSswxuEf7q8fuyOTPSKZhqVrbWAOtu6boPkbfbbCjd/xLqWFq2K5uzKNbccjZBRibFsh59QhKLOq1ZBDgnvlDc=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0172:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;20:KH5iTW3xUOL6cx60fT8HOXf+6rmeT1Y9yRFe1NGuTrm2FOBjKTW4SVjTakwlOCPM90ceIRigBSlfyTBRPFppxikvXrV/gsEzSOW7k/onTz9x92g0YS10AP/uLswjCdb/dlPV9aDwrmjNw4I1j+0otkBHukfU2nOsS8nkXjHmhK0vAEqxeqLjrRe3/37lyDGoEbCHkQTV6OG40ICf4lrHPkcusOHw4p4LUbFE6JmVgGwU9UneQaT/lMzBmn2tAHNz/fO8kwUoFhEHK9IWUb+Clzy3kzy0eouWZA9SBijHWab5+U/5SudQ5TkCqqyt5oU/WbmS1hanRZ2O0ma8LtOwCWjObobOlqj2f/c+2cL6imIcZKLfuCxSWH+fYsoWI6Qb5j6Iv7ec50Akai7w48Mkv12G2Yrf2lUpaGljDR5zFlGf+nXdhrP7rc22g0awNR+sPpPE2GVZsiS53EM4wh3IMYpjqFeEUQRzt08sRo8wmlWCZm3h0MwNucUXunMaXXyv;4:qwLcvbnifPeU871LHSeEzDdINQjOxPmG1qPoAf6ruTWXKkVyMDZeo7rcpjYpcKhsk/uKqeE+P65F2sMEdCtAwBNnt9304sI2LCuDpDnzBhJ59vaGtmj7L9ruzsElils0H/yudZzPDpS2E9ptobsMR/TgS/Z5N06irKr4BNCmZpQsDqA59w2+qThdv4r/CuWty6kNf+kSnIMi58o5XXU2H/CfAiqTizBFVmfcobk6wH2vH/lRMmx2Kmu/nuLeYKCgFN7NPFu0A0tfHrgOaCqhAw==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01723897B299F863F7B44F79EC430@DM2PR12MB0172.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0172;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(189003)(199004)(25786009)(386003)(956004)(23676004)(72206003)(6666003)(6506007)(54906003)(7696005)(50466002)(2486003)(52116002)(476003)(69596002)(478600001)(58126008)(7736002)(103116003)(316002)(26005)(486006)(305945005)(186003)(16526019)(66066001)(230700001)(86362001)(68736007)(9686003)(14444005)(81166006)(81156014)(1076002)(97746001)(4326008)(8676002)(2906002)(5660300001)(47776003)(97736004)(15650500001)(53936002)(8936002)(53416004)(105586002)(106356001)(3846002)(55016002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0172;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTcyOzIzOkNOV0dIdWlXbG1jRERBMDVFZ1UxT0Q3dXpP?=
 =?utf-8?B?WlNxc2s4cmw2VmpZUmNieUJxTW9aSWFGeHlORWtPOGtGRkxLTU8yT0xObFVT?=
 =?utf-8?B?aHc5a0ZhQzRVOXV0SU5Pa201aTFGb2FyN1RkcnJtem1SRE01ZExWN083S2NQ?=
 =?utf-8?B?d2ErekZpa0Yyako1R1A0M0o2ZTZjM0lrek1JODN3a0lmaWt5cEk3VTkzcWwx?=
 =?utf-8?B?NG1uRC9zMkJmTk9ZNXE0cmw4RjM5STNqS2p1UTZWWlkrbE16TzBoOVhCc0tY?=
 =?utf-8?B?d0gvVEJTMTYzUzRETmJIK1JCRng3KzdIMG9sYVZnMGszemIvR3FSck9KU0ZF?=
 =?utf-8?B?RTM4eGhib0pSejdIVXJVNTBsVDl3NWluS2M3WWdRUTVRSkJhOVFrTzlLUWhu?=
 =?utf-8?B?NlQ5c1dQVDIxOU1XdnBER2JVOGNKcWhHZ1d4c1YvYlZ6ZDlqZW9CNC9WRXla?=
 =?utf-8?B?M1l4bjB4YVNscmVORyt5L29YTHVMYXdLSVpvcHl2K3pIY0hMYlhZeWUyQ1hQ?=
 =?utf-8?B?a0cwODd5MThCMEpXTEcraEVaU1BpOTFpS0p2Y01OVlh2M1RpbGlZOVp3cWU0?=
 =?utf-8?B?WEZ3VGNoS3BhMldxd2Vkd2VxcmNxOExxT0ZVRDN3TmhQTEJZUXFsSThsNTBq?=
 =?utf-8?B?NWlWdVgzK01jQ2RwNTN5NmtEZHZDalhUZ01VUTlxRWtnbkVxZTlYU29ncTM0?=
 =?utf-8?B?THJoeGYrbTlOWENNdkhvWFdMR2puTDVjVkhNbXFGdmt5UWdGOVZ6Q3B4S29r?=
 =?utf-8?B?YXpXT2hhMGU4MDZ4RmVTRVkwdHQwU0ZHcXNrM3ZwVEN5VENTdmRWK2NjY1pG?=
 =?utf-8?B?aEpubFhBbjUyS3lUeUU0Rmc4VSsvWEkzMlc2UzBWNnplc2RTSHFHeXlEemRC?=
 =?utf-8?B?MGs3QkF0WUluNnF2MmVqR05QSDZaZnREUzhwSk9MekgwejAvaklySWE1Ukt5?=
 =?utf-8?B?N2czd3E4eWQzS1pRZ0Z6VTVVOVlqOHlJZkJEaitVY1NwamIxdTVhUHBnQmZj?=
 =?utf-8?B?Q1ByenpjZ1loOEdodDBpd2JhMUl4WGV3eldPNnVzN2hua2owVEh5cENGMTlo?=
 =?utf-8?B?UDBCV2ZvNUJ3TThocStqVVN1WTd3TFdwQllObTdCVDhUQmlLM0FZL1BiSjZW?=
 =?utf-8?B?UHdWbnpjc20vVnJSSUJadVdYNlU4SXhDQzZiUWJaR09Bc082YlhaY0RQejEz?=
 =?utf-8?B?N2J2ejNUbnN6VUp4bGZsWlk1aDUvb2VvZ0dtNzRuZVppdkllaU1zVU82OWVj?=
 =?utf-8?B?aTNCbUtJSkVpOXNlSXA2VVdoOU90aVEvWDR4UVlyMWdmN0IxOFVBV2xMRG1V?=
 =?utf-8?B?L2p3bkZEMC9RYkVUemRNTEdPY2VacHFsUGRTYWFIMm1zOUFBSXFYU0dpeGZt?=
 =?utf-8?B?TFFmK3ZWVU5WREF3djcvQkJDZGNJeGQ5ZnJoUm9NU3FsdTNhL3hmM01GSHBB?=
 =?utf-8?B?ZDlzVldzcHdMdGhxZmEzRXczRXFlaEtBc0RZMlhtQUdLUkhaSUxIb3FHUG04?=
 =?utf-8?B?RjZ2VHMrWEFTR2o5SGtMQ2dpZmFPVm1ZaU9mUXcvVnRMVkJxMzM4YjkyVjJw?=
 =?utf-8?B?RERUalFtKytPRzJVcWtKSytqbjUyNXYydzRuR2c0WXdvV2lLb3hSYXlLYWJw?=
 =?utf-8?B?UG1CSWlHdU1abUJXazdFN3BCMmFjalh5d010S29oZC83VWIwQmtrS05menJC?=
 =?utf-8?Q?HUUeFRmUiojSf3EcDLE/HJK0uzROJw9EJIL7O8E?=
X-Microsoft-Antispam-Message-Info: inI7C17E6Cw/AtwQ3tb8GQtbRYvA1aiTy8Ct94h+ZvB/FpmGsE3r4MCDnef/iHSNggJU7Cei+6rCtTUZpylMo40nv68ElRuEzdu+/3K0EBXVqY2vgUgdrwfd/rhENpknMYsY7Ma+KRWrThKVO9EALyjsNeWrhPzHnoo2w1nV9NHL/ePl+kB8uSMuL8ubVst87DVbv/kLqRVaFcytUc/wuv+o7MY2LP+oLz0QvKW6Ykl5qMaXEyq3MsiN/4cfdYCOUSbLYfDAr2zZgYda91cJqvi+UnsHbvNTp4qFEn971dzoKvYwVT8SfM3vFn1ipYbjXuSLqhWkwNr7c5TJcrNBFC5BUuWNMH0ZnKFI2z+XyTw=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;6:HjjAV51s163ULnZ+XnzefpT3fHRYTMMmqHImzv1zDzoWX/KkqHOZzhvq6v4mMlbMTav56ZmLD5pdFjYqBG/c2Te6a7EolOzdhGqOCEbZPJw+HQ/CLvM0R4s3A377m5y1ymBE3tLD7FutOPEZOlNnL1Dqw9Z2k7xGvDltA5ETwcLCSdESEckJ6C7D422+D6MjN0SBePCfDEg5TyZ7db6pOPPfYYgKX3qkMUBqtbSqdRJ0J1V6/Zlx90u6K1Ix116YWlfHYk8yXJmfFeIrXSecAFAK8CzDTYN2VADnAQd6Uu4i1aSCOqFlUMHx4nMNpFH2DN0v/3j+wQ5VIIwlduFneni1NDhl2LJvHYTpTGzil4KU4GCA225bEEfUud+6a+XvMm7Jp2OP17gnrw1b9heSwpqzXuSPxyIAytE03xSck9XJskZeO3tmCQnwnOCvj+PisW6h2mj5BxL3ymZ80pmbHQ==;5:YxtwNUzB30XXP8KBme00YDdzoUGVcUeS7t+NphJDEuTQq/MwfNzCmWC73RQcWj6F2h/qg1UrY4RXegr4kcGxJyjCn/M9jBabjULay2A3AXJ0arpvvLdyo8fWzYNuQPqhdM/P2AoZ0fYAD64AdwyOV3fg6si/KKRC0OEiwtqe/Zk=;24:xqn+YRD9rOTiy/dxXqQ4y/cJJBF6O1CE59QMEPYa74aAXtWgyG9lYZN+d8rPZScOX00c93edUv4nEa2LhQnXmz3k+b/ceOTI99izj5gKQGM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;7:QzuuFe+0agkcrmYbgzTIZpodYdxX+q83WKVrh3FQcNQP778AUXmkKBYrC5uEnmPw6wBLKv1iknRYjuL59Pd6EO06M4xZ+c7Gv/kBKFt5DjkVa9eCO6PCXnzcQhyrulf2mKti9g81v8dmD4mu7M5IiR7mRn7+ZRCXn38+y4AWHf9A2W8fd1EvL+bc9HT9dFoPAAiMk37II+O5RAf/Tr38dAnTGIvAo956nEFxZri7cojhqFl4oh3e/MwAGxIUwOqe;20:d1omiXzpB1ISFVXFOikESBD+ZGdb+lYZV7inoOasuDXG/4oRYYEIw54unYGV5M7jacM/hHUFur1sZGyZwI1ju9Bzbh757avkEMc0zQuAs8f5cnrfJMg+0uLZs61A0uYgIBkz/xpqfJvyE++sXs/w9btmc6+kL6aS2rFcvuR4pQhtevasD5x9tJGbCRxTNn01eDsZAwVuCa5brZP/yTzZjhcOA8OzD9IUVjZXD5trZ1E0+dP9RK6EhfSGsWuIN4En
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 21:35:47.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b817be8-2497-4fa7-1321-08d5e063c675
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches update the SSBD support on AMD processors.

The following patches are included in this series:
- In addition to checking the family, the check for the LS_CFG_SSBD
  feature only needs to done if both the AMD_SSBD and VIRT_SSBD features
  are not present.
- Since AMD can support more than one SSBD mitigation method, the check
  for when to use the SPEC_CTRL MSR for SSBD support needs to be more
  specific.  Explicitly check for the features that use the SPEC_CTRL MSR.

This patch series is based on tip:master.

---

Tom Lendacky (2):
      x86/bugs: Update when to check for the LS_CFG SSBD mitigation
      x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR


 arch/x86/kernel/cpu/amd.c  |    4 +++-
 arch/x86/kernel/cpu/bugs.c |    8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
Tom Lendacky
